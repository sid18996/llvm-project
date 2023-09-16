#ifndef LLVM_LIB_TRANSFORMS_LOOP_SPLITTING_H
#define LLVM_LIB_TRANSFORMS_LOOP_SPLITTING_H

#include "llvm/ADT/SmallSet.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Value.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
struct LoopSplitting : public FunctionPass {
  static char ID;
  LoopSplitting() : FunctionPass(ID) {}

  LoopInfo* LI;
  ScalarEvolution* SE;
  DominatorTree* DT;
  Function* CurrentFunc;

  void getAnalysisUsage(AnalysisUsage &AU) const override;

  bool runOnFunction(Function &F) override;

  void dfsOnTopLevelLoop(Loop* L, std::vector<Loop*>& InnermostLoopList);

  void splitInnermostLoop(Loop* L);

  void setStartVal(Loop *L, Value *Val);
  void setEndVal(Loop *L, Value *Val);

  Value *getStartVal(Loop *L, ScalarEvolution *SE);
  Value *getEndVal(Loop *L);

};
} // namespace

#endif