; ModuleID = 'fabonacci.c'
source_filename = "fabonacci.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [26 x i8] c"Enter a positive number: \00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2 = private unnamed_addr constant [27 x i8] c"Fibonacci Series: %d, %d, \00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"%d, \00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i32, align 4
  %t2 = alloca i32, align 4
  %nextTerm = alloca i32, align 4
  %n = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %t1, align 4
  store i32 1, i32* %t2, align 4
  store i32 0, i32* %nextTerm, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str, i64 0, i64 0))
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i32* %n)
  %0 = load i32, i32* %t1, align 4
  %1 = load i32, i32* %t2, align 4
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0), i32 %0, i32 %1)
  %2 = load i32, i32* %t1, align 4
  %3 = load i32, i32* %t2, align 4
  %add = add nsw i32 %2, %3
  store i32 %add, i32* %nextTerm, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %4 = load i32, i32* %nextTerm, align 4
  %5 = load i32, i32* %n, align 4
  %cmp = icmp sle i32 %4, %5
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %6 = load i32, i32* %nextTerm, align 4
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i64 0, i64 0), i32 %6)
  %7 = load i32, i32* %t2, align 4
  store i32 %7, i32* %t1, align 4
  %8 = load i32, i32* %nextTerm, align 4
  store i32 %8, i32* %t2, align 4
  %9 = load i32, i32* %t1, align 4
  %10 = load i32, i32* %t2, align 4
  %add4 = add nsw i32 %9, %10
  store i32 %add4, i32* %nextTerm, align 4
  br label %while.cond, !llvm.loop !2

while.end:                                        ; preds = %while.cond
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #1

declare dso_local i32 @__isoc99_scanf(i8*, ...) #1

attributes #0 = { noinline nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
