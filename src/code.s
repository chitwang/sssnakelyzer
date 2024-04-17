.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.global	main
.text
func1:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$16,	%rsp
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	-72(%rbp),	%rax
		add	$16,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$16,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
func2:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$224,	%rsp
		movq	24(%rbp),	%rdx
		and	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	24(%rbp),	%rdx
		or	16(%rbp),	%rdx
		movq	%rdx,	-80(%rbp)
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	24(%rbp),	%rdx
		xor	16(%rbp),	%rdx
		movq	%rdx,	-96(%rbp)
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)
		movq	24(%rbp),	%rdx
		not	%rdx
		movq	%rdx,	-112(%rbp)
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)
		movq	16(%rbp),	%rdx
		not	%rdx
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)
		movq	24(%rbp),	%rdx
		movq	$1,	%rcx
		sal	%cl,	%rdx
		movq	%rdx,	-144(%rbp)
		movq	-144(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)
		movq	16(%rbp),	%rdx
		movq	$1,	%rcx
		sal	%cl,	%rdx
		movq	%rdx,	-160(%rbp)
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)
		movq	24(%rbp),	%rdx
		movq	$1,	%rcx
		sar	%cl,	%rdx
		movq	%rdx,	-176(%rbp)
		movq	-176(%rbp),	%rdx
		movq	%rdx,	-184(%rbp)
		movq	16(%rbp),	%rdx
		movq	$1,	%rcx
		sar	%cl,	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-192(%rbp),	%rdx
		movq	%rdx,	-200(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$80
		call	allocmem
		add	$8,	%rsp
		mov	%rax,	-208(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$9,	%rax
		movq	-208(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-216(%rbp)
		movq	-72(%rbp),	%rax
		movq	-216(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-224(%rbp)
		movq	-88(%rbp),	%rax
		movq	-224(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-232(%rbp)
		movq	-104(%rbp),	%rax
		movq	-232(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-240(%rbp)
		movq	-120(%rbp),	%rax
		movq	-240(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-248(%rbp)
		movq	-136(%rbp),	%rax
		movq	-248(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-256(%rbp)
		movq	-152(%rbp),	%rax
		movq	-256(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$56,	%rdx
		movq	%rdx,	-264(%rbp)
		movq	-168(%rbp),	%rax
		movq	-264(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$64,	%rdx
		movq	%rdx,	-272(%rbp)
		movq	-184(%rbp),	%rax
		movq	-272(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rdx
		add	$72,	%rdx
		movq	%rdx,	-280(%rbp)
		movq	-200(%rbp),	%rax
		movq	-280(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-208(%rbp),	%rax
		add	$224,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$224,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
func3:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$152,	%rsp
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jne	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-80(%rbp)
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-96(%rbp)
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-112(%rbp)
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)
		movq	24(%rbp),	%rdx
		movq	16(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jge	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-144(%rbp)
		movq	-144(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$56
		call	allocmem
		add	$8,	%rsp
		mov	%rax,	-160(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$6,	%rax
		movq	-160(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-168(%rbp)
		movq	-72(%rbp),	%rax
		movq	-168(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-176(%rbp)
		movq	-88(%rbp),	%rax
		movq	-176(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-184(%rbp)
		movq	-104(%rbp),	%rax
		movq	-184(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-120(%rbp),	%rax
		movq	-192(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-200(%rbp)
		movq	-136(%rbp),	%rax
		movq	-200(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-208(%rbp)
		movq	-152(%rbp),	%rax
		movq	-208(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-160(%rbp),	%rax
		add	$152,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$152,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
func4:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$176,	%rsp
		movq	24(%rbp),	%rdx
		add	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	24(%rbp),	%rdx
		sub	16(%rbp),	%rdx
		movq	%rdx,	-80(%rbp)
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	24(%rbp),	%rdx
		imul	16(%rbp),	%rdx
		movq	%rdx,	-96(%rbp)
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)
		movq	24(%rbp),	%rax
		cqto
		movq	16(%rbp),	%rbx
		idiv	%rbx
		movq	%rax,	%rdx
		movq	%rdx,	-112(%rbp)
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)
		movq	24(%rbp),	%rax
		cqto
		movq	16(%rbp),	%rbx
		idiv	%rbx
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)
		movq	24(%rbp),	%rax
		movq	16(%rbp),	%rbx
		movq	$1,	%rcx
exp_loop:
		test	%rbx,	%rbx
		jz	exp_done
		imul	%rax,	%rcx
		dec	%rbx
		jmp	exp_loop
exp_done:
		movq	%rcx,	%rdx
		movq	%rdx,	-144(%rbp)
		movq	-144(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)
		movq	24(%rbp),	%rax
		cqto
		movq	16(%rbp),	%rbx
		idiv	%rbx
		movq	%rax,	%rdx
		movq	%rdx,	-160(%rbp)
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$64
		call	allocmem
		add	$8,	%rsp
		mov	%rax,	-176(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$7,	%rax
		movq	-176(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-184(%rbp)
		movq	-72(%rbp),	%rax
		movq	-184(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-88(%rbp),	%rax
		movq	-192(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-200(%rbp)
		movq	-104(%rbp),	%rax
		movq	-200(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-208(%rbp)
		movq	-120(%rbp),	%rax
		movq	-208(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-216(%rbp)
		movq	-136(%rbp),	%rax
		movq	-216(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-224(%rbp)
		movq	-152(%rbp),	%rax
		movq	-224(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rdx
		add	$56,	%rdx
		movq	%rdx,	-232(%rbp)
		movq	-168(%rbp),	%rax
		movq	-232(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-176(%rbp),	%rax
		add	$176,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$176,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
func5:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$104,	%rsp
		movq	24(%rbp),	%rdx
		cmp	$0,	%rdx
		je	1f
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	1f
		movq	$1,	%rdx
		jmp	2f
1:
		movq	$0,	%rdx
2:
		movq	%rdx,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	24(%rbp),	%rdx
		cmp	$0,	%rdx
		jne	1f
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		jne	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
2:
		movq	%rdx,	-80(%rbp)
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	24(%rbp),	%rdx
		test	%rdx,	%rdx
		sete	%al
		movzbl	%al,	%edx
		movq	%rdx,	-96(%rbp)
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)
		movq	16(%rbp),	%rdx
		test	%rdx,	%rdx
		sete	%al
		movzbl	%al,	%edx
		movq	%rdx,	-112(%rbp)
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$40
		call	allocmem
		add	$8,	%rsp
		mov	%rax,	-128(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$4,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-128(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-136(%rbp)
		movq	-72(%rbp),	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-128(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-144(%rbp)
		movq	-88(%rbp),	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-128(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-152(%rbp)
		movq	-104(%rbp),	%rax
		movq	-152(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-128(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-160(%rbp)
		movq	-120(%rbp),	%rax
		movq	-160(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-128(%rbp),	%rax
		add	$104,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$104,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
main:
func6:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$280,	%rsp
		movq	$10,	-64(%rbp)
		movq	$5,	-72(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)
		pushq	-72(%rbp)
		call	func2
		add	$16,	%rsp
		mov	%rax,	-80(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	$0,	-96(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-88(%rbp)
		call	func1
		add	$8,	%rsp
		mov	%rax,	-104(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$0,	-96(%rbp)
L172:
		movq	-96(%rbp),	%rdx
		movq	-104(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-112(%rbp)
		movq	-112(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L190
		movq	-88(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)
		movq	-120(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-128(%rbp)
		movq	-96(%rbp),	%rdx
		movq	-128(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-136(%rbp)
		movq	-136(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L179
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
L179:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-128(%rbp)
		movq	-120(%rbp),	%rdx
		add	-128(%rbp),	%rdx
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-144(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-144(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)
		jmp	L172
L190:
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)
		pushq	-72(%rbp)
		call	func3
		add	$16,	%rsp
		mov	%rax,	-152(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-152(%rbp),	%rdx
		movq	%rdx,	-160(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-160(%rbp)
		call	func1
		add	$8,	%rsp
		mov	%rax,	-168(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$0,	-96(%rbp)
L203:
		movq	-96(%rbp),	%rdx
		movq	-168(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-176(%rbp)
		movq	-176(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L221
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-184(%rbp)
		movq	-184(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-96(%rbp),	%rdx
		movq	-192(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-200(%rbp)
		movq	-200(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L210
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
L210:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-192(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-184(%rbp),	%rdx
		add	-192(%rbp),	%rdx
		movq	%rdx,	-192(%rbp)
		movq	-192(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-208(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-208(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)
		jmp	L203
L221:
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)
		pushq	-72(%rbp)
		call	func4
		add	$16,	%rsp
		mov	%rax,	-216(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-216(%rbp),	%rdx
		movq	%rdx,	-224(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-224(%rbp)
		call	func1
		add	$8,	%rsp
		mov	%rax,	-232(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$0,	-96(%rbp)
L234:
		movq	-96(%rbp),	%rdx
		movq	-232(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-240(%rbp)
		movq	-240(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L252
		movq	-224(%rbp),	%rdx
		movq	%rdx,	-248(%rbp)
		movq	-248(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-256(%rbp)
		movq	-96(%rbp),	%rdx
		movq	-256(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-264(%rbp)
		movq	-264(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L241
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
L241:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-256(%rbp)
		movq	-256(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-256(%rbp)
		movq	-248(%rbp),	%rdx
		add	-256(%rbp),	%rdx
		movq	%rdx,	-256(%rbp)
		movq	-256(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-272(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-272(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)
		jmp	L234
L252:
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$1
		pushq	$0
		call	func5
		add	$16,	%rsp
		mov	%rax,	-280(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-280(%rbp),	%rdx
		movq	%rdx,	-288(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-288(%rbp)
		call	func1
		add	$8,	%rsp
		mov	%rax,	-296(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$0,	-96(%rbp)
L265:
		movq	-96(%rbp),	%rdx
		movq	-296(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-304(%rbp)
		movq	-304(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L283
		movq	-288(%rbp),	%rdx
		movq	%rdx,	-312(%rbp)
		movq	-312(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-320(%rbp)
		movq	-96(%rbp),	%rdx
		movq	-320(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-328(%rbp)
		movq	-328(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L272
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
L272:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-320(%rbp)
		movq	-320(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-320(%rbp)
		movq	-312(%rbp),	%rdx
		add	-320(%rbp),	%rdx
		movq	%rdx,	-320(%rbp)
		movq	-320(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-336(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-336(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)
		jmp	L265
L283:
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
allocmem:
    pushq	%rbp
    mov	%rsp,	%rbp
    pushq	%rbx
    pushq	%rdi
    pushq	%rsi
    pushq	%r12
    pushq	%r13
    pushq	%r14
    pushq	%r15

    testq $15, %rsp
    jz is_mem_aligned

    pushq $0                 # align to 16 bytes
    
    movq 16(%rbp), %rdi
    call malloc

    add $8, %rsp             # remove padding

    jmp mem_done

is_mem_aligned:

    movq 16(%rbp), %rdi
    call malloc
   
mem_done: 

    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rsi
    popq %rdi
    popq %rbx
    popq %rbp

    ret



print:
    pushq	%rbp
    mov	%rsp,	%rbp
    pushq	%rbx
    pushq	%rdi
    pushq	%rsi
    pushq	%r12
    pushq	%r13
    pushq	%r14
    pushq	%r15

    testq $15, %rsp
    jz is_print_aligned

    pushq $0                 # align to 16 bytes

    lea  integer_format(%rip), %rdi
    movq  16(%rbp), %rsi      
    xor %rax, %rax          
    call printf

    add $8, %rsp
    jmp print_done

is_print_aligned:

    lea  integer_format(%rip), %rdi
    movq  16(%rbp), %rsi          
    xor %rax, %rax         
    call printf
    
print_done: 

    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rsi
    popq %rdi
    popq %rbx
    popq %rbp

    ret




strcmp1:
    pushq	%rbp
    mov	%rsp,	%rbp
    pushq	%rbx
    pushq	%rdi
    pushq	%rsi
    pushq	%r12
    pushq	%r13
    pushq	%r14
    pushq	%r15

    testq $15, %rsp
    jz is_aligned

    pushq $0                 # align to 16 bytes

    movq  24(%rbp), %rdi      
    movq  16(%rbp), %rsi
    xor %rax, %rax          
    call strcmp
    cdqe
    add $8, %rsp
    jmp cmp_done

is_aligned:

    movq  24(%rbp), %rdi      
    movq  16(%rbp), %rsi
    xor %rax, %rax          
    call strcmp
    cdqe

cmp_done: 

    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rsi
    popq %rdi
    popq %rbx
    popq %rbp

    ret
