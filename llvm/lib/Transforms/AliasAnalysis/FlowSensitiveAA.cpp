#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SetOperations.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;

#define DEBUG_TYPE "alis-analysis"


namespace {
  // FlowSensitiveAA - The flow sensitive may alias analysis implementation based on points-to information for an input program.
  struct FlowSensitiveAA : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    FlowSensitiveAA() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {
      // Set to storing pointers in the input function
      SmallSet<Instruction*, 8> ptrSet;
      // Collecting the pointers in input function and adding it to ptrSet
      for(auto &BB : F) {
        for(auto &I : BB) {                                        
          if(I.getOpcode() == 31 && I.getType()->isPointerTy() && I.getType()->getPointerElementType()->isPointerTy()) { // for alloca instruction
            ptrSet.insert(&I);                        
          }
          else if(I.getOpcode() == 32 && I.getType()->isPointerTy()) { // for load instruction            
            ptrSet.insert(&I);
          }
        }
      }
      // Worklist contaning basic blocks used in Kildall's Algomithm
      SmallVector<BasicBlock*, 8> worklist;
      // The map of basic block to points to information after last instruction of basic block
      DenseMap<BasicBlock*, DenseMap<Instruction*, SmallSet<Instruction*, 8>>> pointsToInfoMap;
      // Pushing basic blocks in worklist and initilizing points to set of each basic block to empty set
      for(auto &BB : F) {
        worklist.push_back(&BB);
        DenseMap<Instruction*, SmallSet<Instruction*, 8>> pointsToMap;
        for(auto i : ptrSet) {
          SmallSet<Instruction*, 8> temp;
          std::pair<Instruction*, SmallSet<Instruction*, 8>> PAIR1(i, temp);
          pointsToMap.insert(PAIR1);
        }
        std::pair<BasicBlock*, DenseMap<Instruction*, SmallSet<Instruction*, 8>>> PAIR2(&BB, pointsToMap);
        pointsToInfoMap.insert(PAIR2);
      }

      while(worklist.size() > 0) {
        BasicBlock* currBB = worklist[0];
        worklist.erase(worklist.begin());
        // Creating a temporary points to sets 
        DenseMap<Instruction*, SmallSet<Instruction*, 8>> pointsToMap;
        for(auto i : ptrSet) {
          SmallSet<Instruction*, 8> temp;
          std::pair<Instruction*, SmallSet<Instruction*, 8>> PAIR1(i, temp);
          pointsToMap.insert(PAIR1);
        }
        // Taking unuion of points to information coming from predecessors
        for (BasicBlock *Pred : predecessors(currBB))
        {
          auto currPointsToMap = pointsToInfoMap.find(Pred)->second;
          for(auto ptr : ptrSet) {
            auto pointToSet = currPointsToMap.find(ptr)->second;
            auto tempSet = pointsToMap.find(ptr)->second;
            tempSet.insert(pointToSet.begin(), pointToSet.end());
            pointsToMap.find(ptr)->second = tempSet;
          }
        }
        // Applying Flow function
        for(auto &I : *currBB) {                                      
          if(I.getOpcode() == 32 && I.getType()->isPointerTy()) { // for load instruction            
            auto op = I.getOperand(0);            
            Instruction *opInst;
            if(isa<Instruction>(op)) {
              opInst = cast<Instruction>(op);
            }
            if(isa<AllocaInst>(op)) { // Op1 is alloca
              auto pointToSetOperand = pointsToMap.find(opInst)->second;
              pointsToMap.find(&I)->second = pointToSetOperand;
            }
            else { // Op1 is other then alloca
              auto pointToSetOperand = pointsToMap.find(opInst)->second;
              SmallSet<Instruction*, 8> tempSet;
              for(auto ptr : pointToSetOperand) {
                if(pointsToMap.find(ptr) !=  pointsToMap.end()) {
                  auto pointToSet = pointsToMap.find(ptr)->second;
                  tempSet.insert(pointToSet.begin(), pointToSet.end());                  
                }
              }
              pointsToMap.find(&I)->second = tempSet;
            }
            
          }
          else if(I.getOpcode() == 33 && I.getOperand(0)->getType()->isPointerTy()) { // for store instruction          
            auto op1 = I.getOperand(0);
            Instruction *opInst1;
            if(isa<Instruction>(op1)) {
              opInst1 = cast<Instruction>(op1);
            }
            
            auto op2 = I.getOperand(1);
            Instruction *opInst2;
            if(isa<Instruction>(op2)) {
              opInst2 = cast<Instruction>(op2);
            }

            if(isa<AllocaInst>(op1) && isa<LoadInst>(op2)) { // Op1 alloca and Op2 load
              auto pointToSet = pointsToMap.find(opInst2)->second;
              for(auto i: pointToSet){
                auto pointToSet = pointsToMap.find(i)->second;
                pointToSet.clear();
                pointToSet.insert(opInst1);
                pointsToMap.find(i)->second = pointToSet;  
              }
            }
            else if(isa<LoadInst>(op1) && isa<LoadInst>(op2)) { // Op1 load and Op2 load
              auto pointToSet = pointsToMap.find(opInst2)->second;
              auto pointToSetOp1 = pointsToMap.find(opInst1)->second;
              for(auto i: pointToSet){
                auto pointToSet = pointsToMap.find(i)->second;
                pointToSet.clear();
                pointsToMap.find(i)->second = pointToSetOp1;  
              }
            }
            else if((isa<AllocaInst>(op1) && isa<AllocaInst>(op2))) { // Op1 alloca and Op2 alloca
              auto pointToSet = pointsToMap.find(opInst2)->second;
              pointToSet.clear();
              pointToSet.insert(opInst1);
              pointsToMap.find(opInst2)->second = pointToSet;  
            }
            else {  // Op1 load and Op2 alloca
              auto pointToSetOp1 = pointsToMap.find(opInst1)->second;
              pointsToMap.find(opInst2)->second = pointToSetOp1;  
            }
                      
          }
        }

        // Get old pointsToSet of current baisc block
        auto oldPointsToMap = pointsToInfoMap.find(currBB)->second;
        if(!(oldPointsToMap == pointsToMap)) {
          pointsToInfoMap.find(currBB)->second = pointsToMap;
          for (BasicBlock *Succ : successors(currBB))
          {
            worklist.push_back(Succ);
          }
        }

      }
      // Printing points to information after last program point of function
      if(!ptrSet.empty()){        
        errs() << "Points-to information as observed at the last program point in function " << F.getName() << ":\n";
        auto endBB = &F.back();
        auto finalPointsToMap = pointsToInfoMap.find(endBB)->second;
        for(auto i : ptrSet) {
          
          errs() << "Pointer Var ";
          errs() << finalPointsToMap.find(i)->first->getNameOrAsOperand();
          auto pointToSet = finalPointsToMap.find(i)->second;
          errs() << " ={";
          bool firstIt = true;

          SmallVector<std::string, 8> ptrStrVec;
          for (auto const& ptr : pointToSet)
          {
              ptrStrVec.insert(ptrStrVec.begin(), ptr->getNameOrAsOperand()); 
          }
          std::sort(ptrStrVec.begin(), ptrStrVec.end());
          for (auto const ptr : ptrStrVec)
          {
              if(!firstIt) {
                errs() << ",";
              }
              else {
                firstIt = false;
              }
              errs() << ptr; 
          }
          errs() << "}\n";

        }
        // Printing alias relationships between the pointers in function
        errs() << "\nAlias relationships between the pointers in function "<< F.getName() <<":\n               ";
        for(auto i : ptrSet) {
          errs() << finalPointsToMap.find(i)->first->getNameOrAsOperand() << "  ";        
        }

        errs() << "\n";
        for(auto i : ptrSet)
        {
          errs() << "Pointer Var ";
          errs() << finalPointsToMap.find(i)->first->getNameOrAsOperand();

          auto pointToSetFirst = finalPointsToMap.find(i)->second;

          for(auto j : ptrSet)
          {
            auto pointToSetSecond = finalPointsToMap.find(j)->second;
            auto setSizeBefore = pointToSetSecond.size();
            SmallSet<Instruction*,8> intersect;
            set_subtract<llvm::SmallSet<llvm::Instruction *, 8U>, llvm::SmallSet<llvm::Instruction *, 8U>>(pointToSetSecond, pointToSetFirst);
            auto setSizeAfter = pointToSetSecond.size();
            if(setSizeBefore != setSizeAfter)
              errs() << " Yes";
            else
              errs() << " No ";
          }
          errs() << "\n";

        }
        errs() << "\n";      
      }
      return false;
    }

    
    
  };


char FlowSensitiveAA::ID = 0;
static RegisterPass<FlowSensitiveAA> X("fsaa", "Flow Senstive Alias Analysis Pass");
}