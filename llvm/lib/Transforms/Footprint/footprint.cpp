#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include <iostream>
#include <string>
using namespace llvm;
static cl::opt<std::string>
    InputVariable("var-name", cl::desc("Input variable for footprint analysis"),
                  cl::value_desc("var"), cl::Required);
#define DEBUG_TYPE "footprint"

namespace {
struct footprint : public ModulePass {
  static char ID;
  void getScopeOfVar(Module &);
  footprint() : ModulePass(ID) {}
  bool runOnModule(Module &M) override {
    NamedMDNode *NamedMeta = M.getNamedMetadata("llvm.dbg.cu");
    DICompileUnit *CI = cast<DICompileUnit>(NamedMeta->getOperand(0));
    llvm::StringRef prod = CI->getProducer();

    getScopeOfVar(M);

    // LLVM_DEBUG(dbgs() << "Hello from " << F.getName() << "\n");
    return false;
  }
};

void footprint::getScopeOfVar(Module &M) {
  for (Function &F : M) {
    for (BasicBlock &B : F)
      for (Instruction &I : B) {

        Instruction *Inst = &I;
        if (DbgDeclareInst *DDI = dyn_cast<DbgDeclareInst>(Inst)) {
          DIVariable *DV = DDI->getVariable();
          if (isa<MetadataAsValue>(DDI->getOperand(0))) {
            Metadata *m =
                dyn_cast<MetadataAsValue>(DDI->getOperand(0))->getMetadata();
            if (Value *v = dyn_cast<ValueAsMetadata>(m)->getValue()) {
              // std::string s = cast<std::string>(v->getNameOrAsOperand());
              if (InputVariable.compare(v->getNameOrAsOperand()) == 0) {
                dbgs() << "Function:" << F.getName() << "\n";
                dbgs() << "Variable: " << DV->getName() << "\n";
                dbgs() << "Footprint:" << DV->getLine() << "\n";
                for (User *U : v->users()) {
                  if (Instruction *Inst = dyn_cast<Instruction>(U)) {
                    // errs() << "F is used in instruction:\n";
                    // errs() << *Inst << "\n";

                    if (DILocation *DI = Inst->getDebugLoc()) {
                      dbgs() << "Use line num: " << DI->getLine() << " ";
                    }
                  }
                }
              }
            }
          }
        }

        if (DbgValueInst *DVI = dyn_cast<DbgValueInst>(Inst)) {
          DIVariable *DV = DVI->getVariable();
          if (isa<MetadataAsValue>(DVI->getOperand(0))) {
            Metadata *m =
                cast<MetadataAsValue>(DVI->getOperand(0))->getMetadata();
            if (Value *v = dyn_cast<ValueAsMetadata>(m)->getValue()) {
              // std::string s = cast<std::string>(v->getNameOrAsOperand());
              if (InputVariable.compare(v->getNameOrAsOperand()) == 0) {
                dbgs() << "Variable: " << v->getName() << "\n";
              }
            }
          }
        }

        // if (isa<MetadataAsValue>(DDI->getVariable()->getOperand(0))) {
        //   dbgs() << "Here";
        // }
        // if (DILocation *DI = Inst->getDebugLoc()) {
        //   // if (DI->)
        // }
      }
  }
}
} // namespace

char footprint::ID = 'a';
static RegisterPass<footprint> X("footprint",
                                 "prints the footprint of given variable");