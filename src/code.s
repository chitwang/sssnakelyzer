.data
		integer_format:	.asciz,	"%ld\n"
.global	main
.text

		# gin_func main
main:
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
		sub	$224,	%rsp

		# main@i = 0;
		movq	$0,	-64(%rbp)

		# __t1 = main@i < 10;
L3:
		movq	-64(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-72(%rbp)

		# if_false __t1 goto 10;
		movq	-72(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L10

		# __t0 = main@i == 4;
		movq	-64(%rbp),	%rdx
		movq	$4,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-80(%rbp)

		# if_false __t0 goto 8;
		movq	-80(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L8

		# goto 10;
		jmp	L10

		# main@i = main@i + 1;
L8:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-64(%rbp)

		# goto 3;
		jmp	L3

		# main@i = main@i + 1;
L10:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-64(%rbp)

		# __t2 = main@i < 10;
L11:
		movq	-64(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-88(%rbp)

		# if_false __t2 goto 26;
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L26

		# __t3 = main@i + 1;
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)

		# push_param __t3;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-96(%rbp)

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

		# __t4 = main@i == 7;
		movq	-64(%rbp),	%rdx
		movq	$7,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-104(%rbp)

		# if_false __t4 goto 24;
		movq	-104(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L24

		# main@i = main@i + 2;
		movq	-64(%rbp),	%rdx
		add	$2,	%rdx
		movq	%rdx,	-64(%rbp)

		# if_false 3 goto 24;
		movq	$3,	%rdx
		cmp	$0,	%rdx
		je	L24

		# goto 11;
		jmp	L11

		# main@i = main@i + 1;
L24:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-64(%rbp)

		# goto 11;
		jmp	L11

		# __t5 = 0 ^ 1;
L26:
		movq	$0,	%rdx
		xor	$1,	%rdx
		movq	%rdx,	-112(%rbp)

		# if_false __t5 goto 33;
		movq	-112(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L33

		# push_param 123;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$123

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

		# push_param 88;
L33:
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
		mov	%rax,	-120(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t6) = 10;
		movq	$10,	%rax
		movq	-120(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = __t6 + 8;
		movq	-120(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-128(%rbp)

		# *(__t7) = 1;
		movq	$1,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t8 = __t6 + 16;
		movq	-120(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-136(%rbp)

		# *(__t8) = 2;
		movq	$2,	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t9 = __t6 + 24;
		movq	-120(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-144(%rbp)

		# *(__t9) = 3;
		movq	$3,	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t10 = __t6 + 32;
		movq	-120(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-152(%rbp)

		# *(__t10) = 4;
		movq	$4,	%rax
		movq	-152(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t11 = __t6 + 40;
		movq	-120(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-160(%rbp)

		# *(__t11) = 5;
		movq	$5,	%rax
		movq	-160(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t12 = __t6 + 48;
		movq	-120(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-168(%rbp)

		# *(__t12) = 6;
		movq	$6,	%rax
		movq	-168(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t13 = __t6 + 56;
		movq	-120(%rbp),	%rdx
		add	$56,	%rdx
		movq	%rdx,	-176(%rbp)

		# *(__t13) = 7;
		movq	$7,	%rax
		movq	-176(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t14 = __t6 + 64;
		movq	-120(%rbp),	%rdx
		add	$64,	%rdx
		movq	%rdx,	-184(%rbp)

		# *(__t14) = 8;
		movq	$8,	%rax
		movq	-184(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t15 = __t6 + 72;
		movq	-120(%rbp),	%rdx
		add	$72,	%rdx
		movq	%rdx,	-192(%rbp)

		# *(__t15) = 9;
		movq	$9,	%rax
		movq	-192(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t16 = __t6 + 80;
		movq	-120(%rbp),	%rdx
		add	$80,	%rdx
		movq	%rdx,	-200(%rbp)

		# *(__t16) = 10;
		movq	$10,	%rax
		movq	-200(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@a = __t6;
		movq	-120(%rbp),	%rdx
		movq	%rdx,	-208(%rbp)

		# main@i = 2;
		movq	$2,	-64(%rbp)

		# __t24 = main@i < 10;
L61:
		movq	-64(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-216(%rbp)

		# if_false __t24 goto 83;
		movq	-216(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L83

		# __t17 = main@i == 5;
		movq	-64(%rbp),	%rdx
		movq	$5,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-224(%rbp)

		# if_false __t17 goto 66;
		movq	-224(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L66

		# goto 81;
		jmp	L81

		# __t18 = main@a;
L66:
		movq	-208(%rbp),	%rdx
		movq	%rdx,	-232(%rbp)

		# __t19 = *(__t18);
		movq	-232(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-240(%rbp)

		# __t20 = main@i >= __t19;
		movq	-64(%rbp),	%rdx
		movq	-240(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-248(%rbp)

		# if_false __t20 goto 71;
		movq	-248(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L71

		# exit_out_of_bound

		# __t19 = main@i * 8;
L71:
		movq	-64(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-240(%rbp)

		# __t19 = __t19 + 8;
		movq	-240(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-240(%rbp)

		# __t19 = __t18 + __t19;
		movq	-232(%rbp),	%rdx
		add	-240(%rbp),	%rdx
		movq	%rdx,	-240(%rbp)

		# __t22 = *(__t19);
		movq	-240(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-256(%rbp)

		# __t23 = __t22 - 1;
		movq	-256(%rbp),	%rdx
		sub	$1,	%rdx
		movq	%rdx,	-264(%rbp)

		# push_param __t23;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-264(%rbp)

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

		# main@i = main@i + 1;
L81:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-64(%rbp)

		# goto 61;
		jmp	L61

		# __t25 = 64 // 17;
L83:
		movq	$64,	%rax
		cqto
		movq	$17,	%rbx
		idiv	%rbx
		movq	%rax,	%rdx
		movq	%rdx,	-272(%rbp)

		# main@num = __t25;
		movq	-272(%rbp),	%rdx
		movq	%rdx,	-280(%rbp)

		# push_param main@num;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-280(%rbp)

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
