.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"dance"
.LC1:
		.string	"Minimum value: "
.LC2:
		.string	"Average value: "
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

		# __t38 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t39 = *(__t38);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t39;
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

		# gin_func compute_min
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
		sub	$160,	%rsp

		# compute_min@min_value = 0;
		movq	$0,	-64(%rbp)

		# compute_min@i = 0;
		movq	$0,	-72(%rbp)

		# push_param compute_min@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	16(%rbp)

		# call len, 1;
		call	func1
		add	$8,	%rsp

		# __t0 = return_value;
		mov	%rax,	-80(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# compute_min@i = 0;
		movq	$0,	-72(%rbp)

		# __t18 = compute_min@i < __t0;
L17:
		movq	-72(%rbp),	%rdx
		movq	-80(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-88(%rbp)

		# if_false __t18 goto 62;
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L62

		# push_param compute_min@i;
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

		# string print .LC0
		leaq	.LC0(%rip),	%rdi
		call	puts

		# __t1 = compute_min@min_value == 0;
		movq	-64(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-104(%rbp)

		# if_false __t1 goto 39;
		movq	-104(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L39

		# __t2 = compute_min@data;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-112(%rbp)

		# __t3 = *(__t2);
		movq	-112(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-120(%rbp)

		# __t4 = compute_min@i >= __t3;
		movq	-72(%rbp),	%rdx
		movq	-120(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-128(%rbp)

		# if_false __t4 goto 32;
		movq	-128(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L32

		# exit_out_of_bound

		# __t3 = compute_min@i * 8;
L32:
		movq	-72(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-120(%rbp)

		# __t3 = __t3 + 8;
		movq	-120(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-120(%rbp)

		# __t3 = __t2 + __t3;
		movq	-112(%rbp),	%rdx
		add	-120(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)

		# __t6 = *(__t3);
		movq	-120(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-136(%rbp)

		# compute_min@min_value = __t6;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# compute_min@a = 4;
		movq	$4,	-144(%rbp)

		# goto 60;
		jmp	L60

		# __t7 = compute_min@data;
L39:
		movq	16(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)

		# __t8 = *(__t7);
		movq	-152(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-160(%rbp)

		# __t9 = compute_min@i >= __t8;
		movq	-72(%rbp),	%rdx
		movq	-160(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-168(%rbp)

		# if_false __t9 goto 44;
		movq	-168(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L44

		# exit_out_of_bound

		# __t8 = compute_min@i * 8;
L44:
		movq	-72(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-160(%rbp)

		# __t8 = __t8 + 8;
		movq	-160(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-160(%rbp)

		# __t8 = __t7 + __t8;
		movq	-152(%rbp),	%rdx
		add	-160(%rbp),	%rdx
		movq	%rdx,	-160(%rbp)

		# __t11 = *(__t8);
		movq	-160(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-176(%rbp)

		# __t12 = __t11 < compute_min@min_value;
		movq	-176(%rbp),	%rdx
		movq	-64(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-184(%rbp)

		# if_false __t12 goto 60;
		movq	-184(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L60

		# __t13 = compute_min@data;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-192(%rbp)

		# __t14 = *(__t13);
		movq	-192(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-200(%rbp)

		# __t15 = compute_min@i >= __t14;
		movq	-72(%rbp),	%rdx
		movq	-200(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-208(%rbp)

		# if_false __t15 goto 55;
		movq	-208(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L55

		# exit_out_of_bound

		# __t14 = compute_min@i * 8;
L55:
		movq	-72(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-200(%rbp)

		# __t14 = __t14 + 8;
		movq	-200(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-200(%rbp)

		# __t14 = __t13 + __t14;
		movq	-192(%rbp),	%rdx
		add	-200(%rbp),	%rdx
		movq	%rdx,	-200(%rbp)

		# __t17 = *(__t14);
		movq	-200(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-216(%rbp)

		# compute_min@min_value = __t17;
		movq	-216(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# compute_min@i = compute_min@i + 1;
L60:
		movq	-72(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-72(%rbp)

		# goto 17;
		jmp	L17

		# return compute_min@min_value;
L62:
		movq	-64(%rbp),	%rax
		add	$160,	%rsp
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

		add	$160,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# gin_func compute_avg
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
		sub	$88,	%rsp

		# compute_avg@avg_value = 0;
		movq	$0,	-64(%rbp)

		# compute_avg@sum = 0;
		movq	$0,	-72(%rbp)

		# compute_avg@i = 0;
		movq	$0,	-80(%rbp)

		# push_param compute_avg@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	16(%rbp)

		# call len, 1;
		call	func1
		add	$8,	%rsp

		# __t19 = return_value;
		mov	%rax,	-88(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# compute_avg@i = 0;
		movq	$0,	-80(%rbp)

		# __t25 = compute_avg@i < __t19;
L75:
		movq	-80(%rbp),	%rdx
		movq	-88(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-96(%rbp)

		# if_false __t25 goto 89;
		movq	-96(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L89

		# __t20 = compute_avg@data;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)

		# __t21 = *(__t20);
		movq	-104(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-112(%rbp)

		# __t22 = compute_avg@i >= __t21;
		movq	-80(%rbp),	%rdx
		movq	-112(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-120(%rbp)

		# if_false __t22 goto 82;
		movq	-120(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L82

		# exit_out_of_bound

		# __t21 = compute_avg@i * 8;
L82:
		movq	-80(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-112(%rbp)

		# __t21 = __t21 + 8;
		movq	-112(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-112(%rbp)

		# __t21 = __t20 + __t21;
		movq	-104(%rbp),	%rdx
		add	-112(%rbp),	%rdx
		movq	%rdx,	-112(%rbp)

		# __t24 = *(__t21);
		movq	-112(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-128(%rbp)

		# compute_avg@sum = compute_avg@sum + __t24;
		movq	-72(%rbp),	%rdx
		add	-128(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)

		# compute_avg@i = compute_avg@i + 1;
		movq	-80(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-80(%rbp)

		# goto 75;
		jmp	L75

		# push_param compute_avg@data;
L89:
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	16(%rbp)

		# call len, 1;
		call	func1
		add	$8,	%rsp

		# __t26 = return_value;
		mov	%rax,	-136(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t27 = compute_avg@sum / __t26;
		movq	-72(%rbp),	%rax
		cqto
		movq	-136(%rbp),	%rbx
		idiv	%rbx
		movq	%rax,	%rdx
		movq	%rdx,	-144(%rbp)

		# return __t27;
		movq	-144(%rbp),	%rax
		add	$88,	%rsp
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

		add	$88,	%rsp
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
		sub	$120,	%rsp

		# __t28 = -(2);
		xor	%rdx,	%rdx
		sub	$2,	%rdx
		movq	%rdx,	-64(%rbp)

		# __t29 = -(9);
		xor	%rdx,	%rdx
		sub	$9,	%rdx
		movq	%rdx,	-72(%rbp)

		# push_param 48;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$48

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t30 = return_value;
		mov	%rax,	-80(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t30) = 5;
		movq	$5,	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t31 = __t30 + 8;
		movq	-80(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-88(%rbp)

		# *(__t31) = __t28;
		movq	-64(%rbp),	%rax
		movq	-88(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t32 = __t30 + 16;
		movq	-80(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-96(%rbp)

		# *(__t32) = 3;
		movq	$3,	%rax
		movq	-96(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t33 = __t30 + 24;
		movq	-80(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-104(%rbp)

		# *(__t33) = 2;
		movq	$2,	%rax
		movq	-104(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t34 = __t30 + 32;
		movq	-80(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-112(%rbp)

		# *(__t34) = 11;
		movq	$11,	%rax
		movq	-112(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t35 = __t30 + 40;
		movq	-80(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-120(%rbp)

		# *(__t35) = __t29;
		movq	-72(%rbp),	%rax
		movq	-120(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@data = __t30;
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-128(%rbp)

		# push_param main@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-128(%rbp)

		# call compute_min, 1;
		call	func2
		add	$8,	%rsp

		# __t36 = return_value;
		mov	%rax,	-136(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@min_value = __t36;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-144(%rbp)

		# string print .LC1
		leaq	.LC1(%rip),	%rdi
		call	puts

		# push_param main@min_value;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-144(%rbp)

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

		# push_param main@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-128(%rbp)

		# call compute_avg, 1;
		call	func3
		add	$8,	%rsp

		# __t37 = return_value;
		mov	%rax,	-160(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@avg_value = __t37;
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# string print .LC2
		leaq	.LC2(%rip),	%rdi
		call	puts

		# push_param main@avg_value;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-168(%rbp)

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
