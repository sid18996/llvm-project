; ModuleID = 'linklist.c'
source_filename = "linklist.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.node = type { i32, %struct.node* }

@.str = private unnamed_addr constant [21 x i8] c"Enter the data item\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@stdin = external dso_local global %struct._IO_FILE*, align 8
@.str.2 = private unnamed_addr constant [39 x i8] c"Do you want to continue(Type 0 or 1)?\0A\00", align 1
@.str.3 = private unnamed_addr constant [32 x i8] c"\0A status of the linked list is\0A\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"%d=>\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"NULL\0A\00", align 1
@.str.6 = private unnamed_addr constant [31 x i8] c"No. of nodes in the list = %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @main() #0 {
entry:
  %head = alloca %struct.node*, align 8
  %first = alloca %struct.node*, align 8
  %temp = alloca %struct.node*, align 8
  %count = alloca i32, align 4
  %choice = alloca i32, align 4
  store %struct.node* null, %struct.node** %temp, align 8
  store i32 0, i32* %count, align 4
  store i32 1, i32* %choice, align 4
  store %struct.node* null, %struct.node** %first, align 8
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, i32* %choice, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call = call noalias i8* @malloc(i64 16) #3
  %1 = bitcast i8* %call to %struct.node*
  store %struct.node* %1, %struct.node** %head, align 8
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0))
  %2 = load %struct.node*, %struct.node** %head, align 8
  %num = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0
  %call2 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i32* %num)
  %3 = load %struct.node*, %struct.node** %first, align 8
  %cmp = icmp ne %struct.node* %3, null
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %4 = load %struct.node*, %struct.node** %head, align 8
  %5 = load %struct.node*, %struct.node** %temp, align 8
  %ptr = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 1
  store %struct.node* %4, %struct.node** %ptr, align 8
  %6 = load %struct.node*, %struct.node** %head, align 8
  store %struct.node* %6, %struct.node** %temp, align 8
  br label %if.end

if.else:                                          ; preds = %while.body
  %7 = load %struct.node*, %struct.node** %head, align 8
  store %struct.node* %7, %struct.node** %temp, align 8
  store %struct.node* %7, %struct.node** %first, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %call3 = call i32 @fflush(%struct._IO_FILE* %8)
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.2, i64 0, i64 0))
  %call5 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i32* %choice)
  br label %while.cond, !llvm.loop !2

while.end:                                        ; preds = %while.cond
  %9 = load %struct.node*, %struct.node** %temp, align 8
  %ptr6 = getelementptr inbounds %struct.node, %struct.node* %9, i32 0, i32 1
  store %struct.node* null, %struct.node** %ptr6, align 8
  %10 = load %struct.node*, %struct.node** %first, align 8
  store %struct.node* %10, %struct.node** %temp, align 8
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.3, i64 0, i64 0))
  br label %while.cond8

while.cond8:                                      ; preds = %while.body10, %while.end
  %11 = load %struct.node*, %struct.node** %temp, align 8
  %cmp9 = icmp ne %struct.node* %11, null
  br i1 %cmp9, label %while.body10, label %while.end14

while.body10:                                     ; preds = %while.cond8
  %12 = load %struct.node*, %struct.node** %temp, align 8
  %num11 = getelementptr inbounds %struct.node, %struct.node* %12, i32 0, i32 0
  %13 = load i32, i32* %num11, align 8
  %call12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i64 0, i64 0), i32 %13)
  %14 = load i32, i32* %count, align 4
  %inc = add nsw i32 %14, 1
  store i32 %inc, i32* %count, align 4
  %15 = load %struct.node*, %struct.node** %temp, align 8
  %ptr13 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 1
  %16 = load %struct.node*, %struct.node** %ptr13, align 8
  store %struct.node* %16, %struct.node** %temp, align 8
  br label %while.cond8, !llvm.loop !4

while.end14:                                      ; preds = %while.cond8
  %call15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0))
  %17 = load i32, i32* %count, align 4
  %call16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.6, i64 0, i64 0), i32 %17)
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

declare dso_local i32 @printf(i8*, ...) #2

declare dso_local i32 @__isoc99_scanf(i8*, ...) #2

declare dso_local i32 @fflush(%struct._IO_FILE*) #2

attributes #0 = { noinline nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
