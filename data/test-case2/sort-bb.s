	.text
	.file	"sort-bb.c"
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
	subq	$144, %rsp
	leaq	-144(%rbp), %rdi
	movabsq	$.L__const.main.number, %rsi
	movl	$120, %edx
	callq	memcpy@PLT
	movl	$30, -16(%rbp)
	movl	$0, -4(%rbp)
.LBB0_1:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB0_12
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
.LBB0_3:                                # %for.cond1
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-8(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB0_10
# %bb.4:                                # %for.body3
                                        #   in Loop: Header=BB0_3 Depth=2
	movslq	-4(%rbp), %rax
	movl	-144(%rbp,%rax,4), %eax
	movslq	-8(%rbp), %rcx
	cmpl	-144(%rbp,%rcx,4), %eax
	jle	.LBB0_6
# %bb.5:                                # %if.then
                                        #   in Loop: Header=BB0_3 Depth=2
	movslq	-4(%rbp), %rax
	movl	-144(%rbp,%rax,4), %eax
	movl	%eax, -12(%rbp)
	movslq	-8(%rbp), %rax
	movl	-144(%rbp,%rax,4), %ecx
	movslq	-4(%rbp), %rax
	movl	%ecx, -144(%rbp,%rax,4)
	movl	-12(%rbp), %ecx
	movslq	-8(%rbp), %rax
	movl	%ecx, -144(%rbp,%rax,4)
.LBB0_6:                                # %if.end
                                        #   in Loop: Header=BB0_3 Depth=2
	cmpl	$30, -16(%rbp)
	jge	.LBB0_8
# %bb.7:                                # %if.then16
                                        #   in Loop: Header=BB0_3 Depth=2
	movl	$30, -16(%rbp)
.LBB0_8:                                # %if.end17
                                        #   in Loop: Header=BB0_3 Depth=2
	jmp	.LBB0_9
.LBB0_9:                                # %for.inc
                                        #   in Loop: Header=BB0_3 Depth=2
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_3
.LBB0_10:                               # %for.end
                                        #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_11
.LBB0_11:                               # %for.inc18
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_1
.LBB0_12:                               # %for.end20
	addq	$144, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.number,@object   # @__const.main.number
	.section	.rodata,"a",@progbits
	.p2align	4
.L__const.main.number:
	.long	30                              # 0x1e
	.long	29                              # 0x1d
	.long	28                              # 0x1c
	.long	27                              # 0x1b
	.long	26                              # 0x1a
	.long	25                              # 0x19
	.long	24                              # 0x18
	.long	23                              # 0x17
	.long	22                              # 0x16
	.long	21                              # 0x15
	.long	20                              # 0x14
	.long	19                              # 0x13
	.long	18                              # 0x12
	.long	17                              # 0x11
	.long	16                              # 0x10
	.long	15                              # 0xf
	.long	14                              # 0xe
	.long	13                              # 0xd
	.long	12                              # 0xc
	.long	11                              # 0xb
	.long	10                              # 0xa
	.long	9                               # 0x9
	.long	8                               # 0x8
	.long	7                               # 0x7
	.long	6                               # 0x6
	.long	5                               # 0x5
	.long	4                               # 0x4
	.long	3                               # 0x3
	.long	2                               # 0x2
	.long	1                               # 0x1
	.size	.L__const.main.number, 120

	.ident	"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
