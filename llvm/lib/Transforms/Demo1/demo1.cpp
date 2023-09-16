#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
using namespace llvm;
namespace {
struct demo1 : public FunctionPass {
  static char ID;
  demo1() : FunctionPass(ID) {}
  bool runOnFunction(Function &F) override {
    dbgs() << "Hello from " << F.getName() << "\n";
    return false;
  }
};
} // namespace
char demo1::ID = 'a';
static RegisterPass<demo1> X("demo1", "demo-1 Pass");