	.text
	.file	"greedy-algo1.cpp"
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90                         # -- Begin function __cxx_global_var_init
	.type	__cxx_global_var_init,@function
__cxx_global_var_init:                  # @__cxx_global_var_init
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movabsq	$_ZStL8__ioinit, %rdi
	callq	_ZNSt8ios_base4InitC1Ev
	movabsq	$_ZNSt8ios_base4InitD1Ev, %rdi
	movabsq	$_ZStL8__ioinit, %rsi
	movabsq	$__dso_handle, %rdx
	callq	__cxa_atexit
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	__cxx_global_var_init, .Lfunc_end0-__cxx_global_var_init
	.cfi_endproc
                                        # -- End function
	.text
	.globl	_Z18printMaxActivitiesPiS_i     # -- Begin function _Z18printMaxActivitiesPiS_i
	.p2align	4, 0x90
	.type	_Z18printMaxActivitiesPiS_i,@function
_Z18printMaxActivitiesPiS_i:            # @_Z18printMaxActivitiesPiS_i
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movabsq	$_ZSt4cout, %rdi
	movabsq	$.L.str, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movabsq	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %rsi
	callq	_ZNSolsEPFRSoS_E
	movl	$0, -24(%rbp)
	movabsq	$_ZSt4cout, %rdi
	movabsq	$.L.str.1, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	-24(%rbp), %esi
	callq	_ZNSolsEi
	movl	$1, -28(%rbp)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB1_6
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movq	-16(%rbp), %rcx
	movslq	-24(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jl	.LBB1_4
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	movabsq	$_ZSt4cout, %rdi
	movabsq	$.L.str.1, %rsi
	callq	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movq	%rax, %rdi
	movl	-28(%rbp), %esi
	callq	_ZNSolsEi
	movl	-28(%rbp), %eax
	movl	%eax, -24(%rbp)
.LBB1_4:                                # %if.end
                                        #   in Loop: Header=BB1_1 Depth=1
	jmp	.LBB1_5
.LBB1_5:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB1_1
.LBB1_6:                                # %for.end
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	_Z18printMaxActivitiesPiS_i, .Lfunc_end1-_Z18printMaxActivitiesPiS_i
	.cfi_endproc
                                        # -- End function
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
	subq	$80, %rsp
	movl	$0, -4(%rbp)
	movq	.L__const.main.s, %rax
	movq	%rax, -32(%rbp)
	movq	.L__const.main.s+8, %rax
	movq	%rax, -24(%rbp)
	movq	.L__const.main.s+16, %rax
	movq	%rax, -16(%rbp)
	movq	.L__const.main.f, %rax
	movq	%rax, -64(%rbp)
	movq	.L__const.main.f+8, %rax
	movq	%rax, -56(%rbp)
	movq	.L__const.main.f+16, %rax
	movq	%rax, -48(%rbp)
	movl	$6, -68(%rbp)
	leaq	-32(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	movl	-68(%rbp), %edx
	callq	_Z18printMaxActivitiesPiS_i
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.section	.text.startup,"ax",@progbits
	.p2align	4, 0x90                         # -- Begin function _GLOBAL__sub_I_greedy_algo1.cpp
	.type	_GLOBAL__sub_I_greedy_algo1.cpp,@function
_GLOBAL__sub_I_greedy_algo1.cpp:        # @_GLOBAL__sub_I_greedy_algo1.cpp
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	callq	__cxx_global_var_init
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	_GLOBAL__sub_I_greedy_algo1.cpp, .Lfunc_end3-_GLOBAL__sub_I_greedy_algo1.cpp
	.cfi_endproc
                                        # -- End function
	.type	_ZStL8__ioinit,@object          # @_ZStL8__ioinit
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Following activities are selected "
	.size	.L.str, 35

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	" "
	.size	.L.str.1, 2

	.type	.L__const.main.s,@object        # @__const.main.s
	.section	.rodata,"a",@progbits
	.p2align	4
.L__const.main.s:
	.long	1                               # 0x1
	.long	3                               # 0x3
	.long	0                               # 0x0
	.long	5                               # 0x5
	.long	8                               # 0x8
	.long	5                               # 0x5
	.size	.L__const.main.s, 24

	.type	.L__const.main.f,@object        # @__const.main.f
	.p2align	4
.L__const.main.f:
	.long	2                               # 0x2
	.long	4                               # 0x4
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	9                               # 0x9
	.long	9                               # 0x9
	.size	.L__const.main.f, 24

	.section	.init_array,"aw",@init_array
	.p2align	3
	.quad	_GLOBAL__sub_I_greedy_algo1.cpp
	.ident	"clang version 12.0.1 (https://github.com/llvm/llvm-project.git fed41342a82f5a3a9201819a82bf7a48313e296b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __cxx_global_var_init
	.addrsig_sym __cxa_atexit
	.addrsig_sym _Z18printMaxActivitiesPiS_i
	.addrsig_sym _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	.addrsig_sym _ZNSolsEPFRSoS_E
	.addrsig_sym _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	.addrsig_sym _ZNSolsEi
	.addrsig_sym _GLOBAL__sub_I_greedy_algo1.cpp
	.addrsig_sym _ZStL8__ioinit
	.addrsig_sym __dso_handle
	.addrsig_sym _ZSt4cout
