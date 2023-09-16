; ModuleID = 'sort-bb-opt.ll'
source_filename = "sort-bb.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.number = private unnamed_addr constant [30 x i32] [i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1], align 16

; Function Attrs: noinline nounwind uwtable
define dso_local void @main() #0 {
entry:
  %number = alloca [30 x i32], align 16
  %0 = bitcast [30 x i32]* %number to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([30 x i32]* @__const.main.number to i8*), i64 120, i1 false)
  br label %for.cond

for.cond:                                         ; preds = %for.inc15, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc16, %for.inc15 ]
  %cmp = icmp slt i32 %i.0, 30
  br i1 %cmp, label %for.body, label %for.end17

for.body:                                         ; preds = %for.cond
  %add = add nsw i32 %i.0, 1
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ %add, %for.body ], [ %inc, %for.inc ]
  %cmp2 = icmp slt i32 %j.0, 30
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom
  %1 = load i32, i32* %arrayidx, align 4
  %idxprom4 = sext i32 %j.0 to i64
  %arrayidx5 = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom4
  %2 = load i32, i32* %arrayidx5, align 4
  %cmp6 = icmp sgt i32 %1, %2
  br i1 %cmp6, label %if.then, label %if.end

if.then:                                          ; preds = %for.body3
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom7
  %3 = load i32, i32* %arrayidx8, align 4
  %idxprom9 = sext i32 %j.0 to i64
  %arrayidx10 = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom9
  %4 = load i32, i32* %arrayidx10, align 4
  %idxprom11 = sext i32 %i.0 to i64
  %arrayidx12 = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom11
  store i32 %4, i32* %arrayidx12, align 4
  %idxprom13 = sext i32 %j.0 to i64
  %arrayidx14 = getelementptr inbounds [30 x i32], [30 x i32]* %number, i64 0, i64 %idxprom13
  store i32 %3, i32* %arrayidx14, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body3
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %j.0, 1
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  br label %for.inc15

for.inc15:                                        ; preds = %for.end
  %inc16 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !4

for.end17:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
