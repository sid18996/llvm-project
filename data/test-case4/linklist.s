	.text
	.file	"linklist.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	$0, -24(%rbp)
	movl	$0, -28(%rbp)
	movl	$1, -32(%rbp)
	movq	$0, -16(%rbp)
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -32(%rbp)
	je	.LBB0_6
# %bb.2:                                # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$16, %edi
	callq	malloc
	movq	%rax, -8(%rbp)
	movabsq	$.L.str, %rdi
	movb	$0, %al
	callq	printf
	movq	-8(%rbp), %rsi
	movabsq	$.L.str.1, %rdi
	movb	$0, %al
	callq	__isoc99_scanf
	cmpq	$0, -16(%rbp)
	je	.LBB0_4
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, 8(%rax)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	%rax, -16(%rbp)
.LBB0_5:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	stdin, %rdi
	callq	fflush
	movabsq	$.L.str.2, %rdi
	movb	$0, %al
	callq	printf
	movabsq	$.L.str.1, %rdi
	leaq	-32(%rbp), %rsi
	movb	$0, %al
	callq	__isoc99_scanf
	jmp	.LBB0_1
.LBB0_6:                                # %while.end
	movq	-24(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movabsq	$.L.str.3, %rdi
	movb	$0, %al
	callq	printf
.LBB0_7:                                # %while.cond8
                                        # =>This Inner Loop Header: Depth=1
	cmpq	$0, -24(%rbp)
	je	.LBB0_9
# %bb.8:                                # %while.body10
                                        #   in Loop: Header=BB0_7 Depth=1
	movq	-24(%rbp), %rax
	movl	(%rax), %esi
	movabsq	$.L.str.4, %rdi
	movb	$0, %al
	callq	printf
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB0_7
.LBB0_9:                                # %while.end14
	movabsq	$.L.str.5, %rdi
	movb	$0, %al
	callq	printf
	movl	-28(%rbp), %esi
	movabsq	$.L.str.6, %rdi
	movb	$0, %al
	callq	printf
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Enter the data item\n"
	.size	.L.str, 21

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"Do you want to continue(Type 0 or 1)?\n"
	.size	.L.str.2, 39

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"\n status of the linked list is\n"
	.size	.L.str.3, 32

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"%d=>"
	.size	.L.str.4, 5

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"NULL\n"
	.size	.L.str.5, 6

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"No. of nodes in the list = %d\n"
	.size	.L.str.6, 31

	.ident	"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym malloc
	.addrsig_sym printf
	.addrsig_sym __isoc99_scanf
	.addrsig_sym fflush
	.addrsig_sym stdin
