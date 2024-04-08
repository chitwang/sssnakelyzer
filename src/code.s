.data
		integer_format:	.asciz,	"%ld\n"
.global	main
.text

		# gin_func len
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

		# __t18 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t19 = *(__t18);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t19;
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

		# d_func

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

		# gin_func fact
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
		sub	$48,	%rsp

		# __t0 = !(fact@n);
		movq	16(%rbp),	%rdx
		test	%rdx,	%rdx
		sete	%dl
		mov	%rdx,	%rdi
		movq	%rdx,	-64(%rbp)

		# if_false __t0 goto 21;
		movq	-64(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L21

		# __t1 = !(fact@n);
		movq	16(%rbp),	%rdx
		test	%rdx,	%rdx
		sete	%dl
		mov	%rdx,	%rdi
		movq	%rdx,	-72(%rbp)

		# push_param __t1;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-72(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# return 1;
		movq	$1,	%rax
		add	$48,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# __t2 = fact@n < 3;
L21:
		movq	16(%rbp),	%rdx
		movq	$3,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-80(%rbp)

		# if_false __t2 goto 24;
		movq	-80(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L24

		# return fact@n;
		movq	16(%rbp),	%rax
		add	$48,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# __t3 = fact@n - 1;
L24:
		movq	16(%rbp),	%rdx
		sub	$1,	%rdx
		movq	%rdx,	-88(%rbp)

		# push_param __t3;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-88(%rbp)

		# call fact, 1;
		call	func2
		add	$8,	%rsp

		# __t4 = return_value;
		mov	%rax,	-96(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t5 = fact@n * __t4;
		movq	16(%rbp),	%rdx
		imul	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)

		# return __t5;
		movq	-104(%rbp),	%rax
		add	$48,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# d_func

		add	$48,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# gin_func main
main:
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
		sub	$104,	%rsp

		# push_param 88;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$88

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t6 = return_value;
		mov	%rax,	-64(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t6) = 10;
		movq	$10,	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = __t6 + 8;
		movq	-64(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t7) = 1;
		movq	$1,	%rax
		movq	-72(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t8 = __t6 + 16;
		movq	-64(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-80(%rbp)

		# *(__t8) = 2;
		movq	$2,	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t9 = __t6 + 24;
		movq	-64(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-88(%rbp)

		# *(__t9) = 3;
		movq	$3,	%rax
		movq	-88(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t10 = __t6 + 32;
		movq	-64(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-96(%rbp)

		# *(__t10) = 4;
		movq	$4,	%rax
		movq	-96(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t11 = __t6 + 40;
		movq	-64(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-104(%rbp)

		# *(__t11) = 5;
		movq	$5,	%rax
		movq	-104(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t12 = __t6 + 48;
		movq	-64(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-112(%rbp)

		# *(__t12) = 6;
		movq	$6,	%rax
		movq	-112(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t13 = __t6 + 56;
		movq	-64(%rbp),	%rdx
		add	$56,	%rdx
		movq	%rdx,	-120(%rbp)

		# *(__t13) = 7;
		movq	$7,	%rax
		movq	-120(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t14 = __t6 + 64;
		movq	-64(%rbp),	%rdx
		add	$64,	%rdx
		movq	%rdx,	-128(%rbp)

		# *(__t14) = 8;
		movq	$8,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t15 = __t6 + 72;
		movq	-64(%rbp),	%rdx
		add	$72,	%rdx
		movq	%rdx,	-136(%rbp)

		# *(__t15) = 9;
		movq	$9,	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t16 = __t6 + 80;
		movq	-64(%rbp),	%rdx
		add	$80,	%rdx
		movq	%rdx,	-144(%rbp)

		# *(__t16) = 10;
		movq	$10,	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@a = __t6;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)

		# push_param 6;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$6

		# call fact, 1;
		call	func2
		add	$8,	%rsp

		# __t17 = return_value;
		mov	%rax,	-160(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t17;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-160(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# d_func

		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall
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
