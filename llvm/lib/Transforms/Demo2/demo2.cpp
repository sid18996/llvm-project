#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include <map>

using namespace llvm;

namespace {
struct demo2 : FunctionPass {
  static char ID;
  demo2() : FunctionPass(ID) {}
  bool runOnFunction(Function &F) {
    std::map<std::string, int> instCounter;
    dbgs() << F.getName() << ": \n";
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        if (instCounter.find(I.getOpcodeName()) == instCounter.end())
          instCounter[I.getOpcodeName()] = 1;
        else
          instCounter[I.getOpcodeName()] += 1;
      }
    }
    for (auto &i : instCounter) {
      dbgs() << i.first << ": " << i.second << "\n";
    }
    dbgs() << "\n";
    return false;
  }
}; // end of myInstCount class
} // namespace

char demo2::ID = 'a';
static RegisterPass<demo2> X("demo2", "demo-2: Instruction Count Pass");