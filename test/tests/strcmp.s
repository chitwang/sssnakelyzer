	.file	"strcmp.c"
	.text
	.section	.rodata
.LC0:
	.string	"First string is greater"
.LC1:
	.string	"Second string is greater"
.LC2:
	.string	"strings are same"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movabsq	$8022916924116329832, %rax
	movl	$560229490, %edx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movl	$0, -48(%rbp)
	movabsq	$8022916924116329800, %rax
	movl	$560229490, %edx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movl	$0, -16(%rbp)
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jle	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L3
.L2:
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L4
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	jmp	.L3
.L4:
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L3:
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
