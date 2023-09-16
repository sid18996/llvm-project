#include "llvm/Transforms/LoopSplitting/LoopSplitting.h"
#include "llvm-c/Core.h"
#include "llvm-c/Types.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Scalar/LoopBoundSplit.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <cstddef>
#include <sstream>
#include <string>
#include <vector>

using namespace llvm;

static cl::opt<int> NumPartitions("loop-partitions",
                                  cl::desc("Partition count"),
                                  cl::value_desc("Partition count"));

void LoopSplitting::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<ScalarEvolutionWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
  // AU.addPreserved<LoopInfoWrapperPass>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.setPreservesAll();
}

Value *LoopSplitting::getStartVal(Loop *L, ScalarEvolution *SE) {

  auto *LoopHeader = L->getHeader();
  Value *StartVal = nullptr;
  if (!LoopHeader) {
    errs() << "LoopHeader is null\n";
    return nullptr;
  }
  for (auto &I : *LoopHeader) {
    if (PHINode *IndVar = dyn_cast<PHINode>(&I)) {
      StartVal = IndVar->getIncomingValue(0);
    }
  }
  return StartVal;
}

Value *LoopSplitting::getEndVal(Loop *L) {
  auto *LoopHeader = L->getHeader();
  for (auto &I : *LoopHeader) {
    if (BranchInst *BI = dyn_cast<BranchInst>(&I)) {
      if (BI->isConditional()) {
        auto *CompareInst = cast<Instruction>(BI->getCondition());
        // CompareInst->print(dbgs());
        Value *EndVal = CompareInst->getOperand(1);
        return EndVal;
      }
    }
  }
  return nullptr;
}

void LoopSplitting::setStartVal(Loop *L, Value *Val) {
  auto *LoopHeader = L->getHeader();
  PHINode *FinalIndVar = nullptr;
  for (auto &I : *LoopHeader) {
    if (PHINode *IndVar = dyn_cast<PHINode>(&I)) {
      FinalIndVar = IndVar;
    }
  }
  if (!FinalIndVar)
    assert(false && "No PHINode present in the loop!\n");
  FinalIndVar->setIncomingValue(0, Val);
}

void LoopSplitting::setEndVal(Loop *L, Value *Val) {
  auto *LoopHeader = L->getHeader();
  for (auto &I : *LoopHeader) {
    if (BranchInst *BI = dyn_cast<BranchInst>(&I)) {
      if (BI->isConditional()) {
        auto *CompareInst = cast<Instruction>(BI->getCondition());
        // CompareInst->print(dbgs());
        CompareInst->setOperand(1, Val);
        Value *EndVal = CompareInst->getOperand(1);
        dbgs() << "From setEndVal : ";
        EndVal->print(dbgs());
        dbgs() << "\n";
        return;
      }
    }
  }
  assert(false);
}

void LoopSplitting::dfsOnTopLevelLoop(Loop *L,
                                      std::vector<Loop *> &InnermostLoopList) {
  if (L->isInnermost())
    InnermostLoopList.push_back(L);
  else {
    for (Loop *SubLoop : L->getSubLoops())
      dfsOnTopLevelLoop(SubLoop, InnermostLoopList);
  }
}

void LoopSplitting::splitInnermostLoop(Loop *L) {
  errs() << "Loop count: " << SE->getSmallConstantTripCount(L) << "\n";

  BasicBlock *Preheader = L->getLoopPreheader();
  BasicBlock *CurrHeader = L->getHeader();
  BasicBlock *CurrExit = L->getLoopLatch();

  Value *StartVal = getStartVal(L, SE);
  if (!StartVal) {
    errs() << "start val is null\n";
    return;
  }

  Value *EndVal = getEndVal(L);
  if (!EndVal) {
    errs() << "end val is null\n";
    return;
  }

  StartVal->print(dbgs());
  dbgs() << "\n";
  EndVal->print(dbgs());
  dbgs() << "\n";

  IRBuilder<> Builder(Preheader);
  Value *Dividend = Builder.CreateSub(EndVal, StartVal);

  Value *Divisor = ConstantInt::get(Type::getInt32Ty(CurrentFunc->getContext()),
                                    NumPartitions);

  Value *EachSize = Builder.CreateSDiv(Dividend, Divisor);

  StartVal = Builder.CreateSub(EndVal, EachSize);

  ValueToValueMapTy VMap;
  for (int I = 0; I < NumPartitions - 1; I++) {
    VMap.clear();
    SmallVector<BasicBlock *, 8> Blocks;
    const std::string Suffix =
        ".split." + std::to_string(NumPartitions - I - 1);
    Loop *ClonedLoop = cloneLoopWithPreheader(CurrExit, CurrHeader, L, VMap,
                                              Suffix, LI, DT, Blocks);

    remapInstructionsInBlocks(Blocks, VMap);

    setStartVal(ClonedLoop, StartVal);
    setEndVal(ClonedLoop, EndVal);

    EndVal = StartVal;
    StartVal = Builder.CreateSub(EndVal, EachSize);

    CurrHeader->getTerminator()->setSuccessor(1,
                                              ClonedLoop->getLoopPreheader());
  }
  setEndVal(L, EndVal);
}

bool LoopSplitting::runOnFunction(Function &F) {
  errs() << "Function name : " << F.getName() << "\n";
  // F.dump();
  errs() << "Paritition count : " << NumPartitions << "\n";

  CurrentFunc = &F;
  LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
  SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
  DT = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();

  std::vector<Loop *> InnermostLoopList;
  for (Loop *L : *LI)
    dfsOnTopLevelLoop(L, InnermostLoopList);

  for (Loop *L : InnermostLoopList) {
    splitInnermostLoop(L);
  }
  return true;
}

char LoopSplitting::ID = 0;
static RegisterPass<LoopSplitting> X("loop-splitting", "Index set splitting");