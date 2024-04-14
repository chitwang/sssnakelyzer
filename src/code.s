.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.LC1:
		.string	"f"
.LC2:
		.string	"d"
.LC3:
		.string	"t"
.LC4:
		.string	"r"
.LC5:
		.string	"y"
.LC6:
		.string	"e"
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

		# __t60 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t61 = *(__t60);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t61;
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

		# gin_func bubbleSort
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
		sub	$304,	%rsp

		# bubbleSort@i = 0;
		movq	$0,	-64(%rbp)

		# push_param bubbleSort@array;
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
		mov	%rax,	-72(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# bubbleSort@i = 0;
		movq	$0,	-64(%rbp)

		# __t39 = bubbleSort@i < __t0;
L16:
		movq	-64(%rbp),	%rdx
		movq	-72(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-80(%rbp)

		# if_false __t39 goto 104;
		movq	-80(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L104

		# bubbleSort@swapped = 0;
		movq	$0,	-88(%rbp)

		# bubbleSort@j = 0;
		movq	$0,	-96(%rbp)

		# push_param bubbleSort@array;
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

		# __t1 = return_value;
		mov	%rax,	-104(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t2 = __t1 - bubbleSort@i;
		movq	-104(%rbp),	%rdx
		sub	-64(%rbp),	%rdx
		movq	%rdx,	-112(%rbp)

		# __t3 = __t2 - 1;
		movq	-112(%rbp),	%rdx
		sub	$1,	%rdx
		movq	%rdx,	-120(%rbp)

		# bubbleSort@j = 0;
		movq	$0,	-96(%rbp)

		# __t37 = bubbleSort@j < __t3;
L28:
		movq	-96(%rbp),	%rdx
		movq	-120(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-128(%rbp)

		# if_false __t37 goto 99;
		movq	-128(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L99

		# __t4 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)

		# __t5 = *(__t4);
		movq	-136(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-144(%rbp)

		# __t6 = bubbleSort@j >= __t5;
		movq	-96(%rbp),	%rdx
		movq	-144(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-152(%rbp)

		# if_false __t6 goto 35;
		movq	-152(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L35

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t5 = bubbleSort@j * 8;
L35:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-144(%rbp)

		# __t5 = __t5 + 8;
		movq	-144(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-144(%rbp)

		# __t5 = __t4 + __t5;
		movq	-136(%rbp),	%rdx
		add	-144(%rbp),	%rdx
		movq	%rdx,	-144(%rbp)

		# __t13 = *(__t5);
		movq	-144(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-160(%rbp)

		# __t9 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# __t8 = bubbleSort@j + 1;
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-176(%rbp)

		# __t10 = *(__t9);
		movq	-168(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-184(%rbp)

		# __t11 = __t8 >= __t10;
		movq	-176(%rbp),	%rdx
		movq	-184(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-192(%rbp)

		# if_false __t11 goto 45;
		movq	-192(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L45

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t10 = __t8 * 8;
L45:
		movq	-176(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-184(%rbp)

		# __t10 = __t10 + 8;
		movq	-184(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-184(%rbp)

		# __t10 = __t9 + __t10;
		movq	-168(%rbp),	%rdx
		add	-184(%rbp),	%rdx
		movq	%rdx,	-184(%rbp)

		# __t14 = *(__t10);
		movq	-184(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-200(%rbp)

		# push_param __t13;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-160(%rbp)

		# push_param __t14;
		pushq	-200(%rbp)

		# call strcmp1, 2;
		call	strcmp1
		add	$16,	%rsp

		# __t15 = return_value;
		mov	%rax,	-208(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t16 = __t15 > 0;
		movq	-208(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-216(%rbp)

		# if_false __t16 goto 97;
		movq	-216(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L97

		# __t17 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-224(%rbp)

		# __t18 = *(__t17);
		movq	-224(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-232(%rbp)

		# __t19 = bubbleSort@j >= __t18;
		movq	-96(%rbp),	%rdx
		movq	-232(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-240(%rbp)

		# if_false __t19 goto 62;
		movq	-240(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L62

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t18 = bubbleSort@j * 8;
L62:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-232(%rbp)

		# __t18 = __t18 + 8;
		movq	-232(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-232(%rbp)

		# __t18 = __t17 + __t18;
		movq	-224(%rbp),	%rdx
		add	-232(%rbp),	%rdx
		movq	%rdx,	-232(%rbp)

		# __t21 = *(__t18);
		movq	-232(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-248(%rbp)

		# bubbleSort@temp = __t21;
		movq	-248(%rbp),	%rdx
		movq	%rdx,	-256(%rbp)

		# __t22 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-264(%rbp)

		# __t23 = *(__t22);
		movq	-264(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-272(%rbp)

		# __t24 = bubbleSort@j >= __t23;
		movq	-96(%rbp),	%rdx
		movq	-272(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-280(%rbp)

		# if_false __t24 goto 72;
		movq	-280(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L72

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t23 = bubbleSort@j * 8;
L72:
		movq	-96(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-272(%rbp)

		# __t23 = __t23 + 8;
		movq	-272(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-272(%rbp)

		# __t23 = __t22 + __t23;
		movq	-264(%rbp),	%rdx
		add	-272(%rbp),	%rdx
		movq	%rdx,	-272(%rbp)

		# __t27 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-288(%rbp)

		# __t26 = bubbleSort@j + 1;
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-296(%rbp)

		# __t28 = *(__t27);
		movq	-288(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-304(%rbp)

		# __t29 = __t26 >= __t28;
		movq	-296(%rbp),	%rdx
		movq	-304(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-312(%rbp)

		# if_false __t29 goto 81;
		movq	-312(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L81

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t28 = __t26 * 8;
L81:
		movq	-296(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-304(%rbp)

		# __t28 = __t28 + 8;
		movq	-304(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-304(%rbp)

		# __t28 = __t27 + __t28;
		movq	-288(%rbp),	%rdx
		add	-304(%rbp),	%rdx
		movq	%rdx,	-304(%rbp)

		# __t31 = *(__t28);
		movq	-304(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-320(%rbp)

		# *(__t23) = __t31;
		movq	-320(%rbp),	%rax
		movq	-272(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t33 = bubbleSort@array;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-328(%rbp)

		# __t32 = bubbleSort@j + 1;
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-336(%rbp)

		# __t34 = *(__t33);
		movq	-328(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-344(%rbp)

		# __t35 = __t32 >= __t34;
		movq	-336(%rbp),	%rdx
		movq	-344(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-352(%rbp)

		# if_false __t35 goto 92;
		movq	-352(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L92

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t34 = __t32 * 8;
L92:
		movq	-336(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-344(%rbp)

		# __t34 = __t34 + 8;
		movq	-344(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-344(%rbp)

		# __t34 = __t33 + __t34;
		movq	-328(%rbp),	%rdx
		add	-344(%rbp),	%rdx
		movq	%rdx,	-344(%rbp)

		# *(__t34) = bubbleSort@temp;
		movq	-256(%rbp),	%rax
		movq	-344(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# bubbleSort@swapped = 1;
		movq	$1,	-88(%rbp)

		# bubbleSort@j = bubbleSort@j + 1;
L97:
		movq	-96(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-96(%rbp)

		# goto 28;
		jmp	L28

		# __t38 = !(bubbleSort@swapped);
L99:
		movq	-88(%rbp),	%rdx
		test	%rdx,	%rdx
		sete	%dl
		mov	%rdx,	%rdi
		movq	%rdx,	-360(%rbp)

		# if_false __t38 goto 102;
		movq	-360(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L102

		# goto 104;
		jmp	L104

		# bubbleSort@i = bubbleSort@i + 1;
L102:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-64(%rbp)

		# goto 16;
		jmp	L16

		# d_func

L104:
		add	$304,	%rsp
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
		sub	$168,	%rsp

		# string make .LC1 into var __t40
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-64(%rbp)

		# string make .LC2 into var __t41
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-72(%rbp)

		# string make .LC3 into var __t42
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-80(%rbp)

		# string make .LC4 into var __t43
		leaq	.LC4(%rip),	%rdi
		movq	%rdi,	-88(%rbp)

		# string make .LC5 into var __t44
		leaq	.LC5(%rip),	%rdi
		movq	%rdi,	-96(%rbp)

		# string make .LC6 into var __t45
		leaq	.LC6(%rip),	%rdi
		movq	%rdi,	-104(%rbp)

		# push_param 56;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$56

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t46 = return_value;
		mov	%rax,	-112(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t46) = 6;
		movq	$6,	%rax
		movq	-112(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t47 = __t46 + 8;
		movq	-112(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-120(%rbp)

		# *(__t47) = __t40;
		movq	-64(%rbp),	%rax
		movq	-120(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t48 = __t46 + 16;
		movq	-112(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-128(%rbp)

		# *(__t48) = __t41;
		movq	-72(%rbp),	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t49 = __t46 + 24;
		movq	-112(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-136(%rbp)

		# *(__t49) = __t42;
		movq	-80(%rbp),	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t50 = __t46 + 32;
		movq	-112(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-144(%rbp)

		# *(__t50) = __t43;
		movq	-88(%rbp),	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t51 = __t46 + 40;
		movq	-112(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-152(%rbp)

		# *(__t51) = __t44;
		movq	-96(%rbp),	%rax
		movq	-152(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t52 = __t46 + 48;
		movq	-112(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-160(%rbp)

		# *(__t52) = __t45;
		movq	-104(%rbp),	%rax
		movq	-160(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@data = __t46;
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# push_param main@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-168(%rbp)

		# call bubbleSort, 1;
		call	func2
		add	$8,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@i = 0;
		movq	$0,	-176(%rbp)

		# push_param main@data;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-168(%rbp)

		# call len, 1;
		call	func1
		add	$8,	%rsp

		# __t53 = return_value;
		mov	%rax,	-184(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@i = 0;
		movq	$0,	-176(%rbp)

		# __t59 = main@i < __t53;
L143:
		movq	-176(%rbp),	%rdx
		movq	-184(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-192(%rbp)

		# if_false __t59 goto 157;
		movq	-192(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L157

		# __t54 = main@data;
		movq	-168(%rbp),	%rdx
		movq	%rdx,	-200(%rbp)

		# __t55 = *(__t54);
		movq	-200(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t56 = main@i >= __t55;
		movq	-176(%rbp),	%rdx
		movq	-208(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-216(%rbp)

		# if_false __t56 goto 150;
		movq	-216(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L150

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t55 = main@i * 8;
L150:
		movq	-176(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-208(%rbp)

		# __t55 = __t55 + 8;
		movq	-208(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-208(%rbp)

		# __t55 = __t54 + __t55;
		movq	-200(%rbp),	%rdx
		add	-208(%rbp),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t58 = *(__t55);
		movq	-208(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-224(%rbp)

		# string print __t58
		movq	-224(%rbp),	%rdi
		call	puts

		# main@i = main@i + 1;
		movq	-176(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-176(%rbp)

		# goto 143;
		jmp	L143

		# d_func

L157:
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
