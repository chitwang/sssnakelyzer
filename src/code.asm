.data
		integer_format:	.asciz,	"%ld\n"
.global	main
.text

		# gin_func B@__init__
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

		# __t0 = self + 0;
		movq	-64(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	0(%rbp)

		# *__t0 = 4;
		movq	$4,	-72(%rbp)

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

		# gin_func B@foo
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
		sub	$8,	%rsp

		# return B@foo@a;
		movq	0(%rbp),	%rax
		add	$40,	%rsp
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

		add	$8,	%rsp
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
		sub	$808,	%rsp

		# push_param 32;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$32

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t1 = return_value;

		# *(__t1) = 3;
		movq	$3,	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t2 = __t1 + 8;
		movq	-64(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t2) = 1;
		movq	$1,	%rax
		movq	-72(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t3 = __t1 + 16;
		movq	-64(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-80(%rbp)

		# *(__t3) = 2;
		movq	$2,	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t4 = __t1 + 24;
		movq	-64(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-88(%rbp)

		# *(__t4) = 3;
		movq	$3,	%rax
		movq	-88(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@a = __t1;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-96(%rbp)

		# push_param 32;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$32

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t5 = return_value;

		# *(__t5) = 3;
		movq	$3,	%rax
		movq	-104(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t6 = __t5 + 8;
		movq	-104(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-112(%rbp)

		# *(__t6) = 1;
		movq	$1,	%rax
		movq	-112(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = __t5 + 16;
		movq	-104(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-120(%rbp)

		# *(__t7) = 2;
		movq	$2,	%rax
		movq	-120(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t8 = __t5 + 24;
		movq	-104(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-128(%rbp)

		# *(__t8) = 3;
		movq	$3,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@b = __t5;
		movq	-104(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)

		# main@i = 0;
		movq	$0,	-144(%rbp)

		# main@j = 1;
		movq	$1,	-152(%rbp)

		# __t9 = main@a;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-160(%rbp)

		# __t10 = *(__t9);
		movq	-160(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-168(%rbp)

		# __t11 = main@i >= __t10;
		movq	-144(%rbp),	%rdx
		movq	-168(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-176(%rbp)

		# if_false __t11 goto 47;
		movq	-176(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L47

		# exit_out_of_bound

		# __t10 = main@i * 8;
		movq	-144(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-168(%rbp)

		# __t10 = __t10 + 8;
		movq	-168(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-168(%rbp)

		# __t10 = __t9 + __t10;
		movq	-160(%rbp),	%rdx
		add	-168(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# __t13 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-184(%rbp)

		# __t14 = *(__t13);
		movq	-184(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-192(%rbp)

		# __t15 = main@j >= __t14;
		movq	-152(%rbp),	%rdx
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

		# if_false __t15 goto 55;
		movq	-200(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L55

		# exit_out_of_bound

		# __t14 = main@j * 8;
		movq	-152(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-192(%rbp)

		# __t14 = __t14 + 8;
		movq	-192(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-192(%rbp)

		# __t14 = __t13 + __t14;
		movq	-184(%rbp),	%rdx
		add	-192(%rbp),	%rdx
		movq	%rdx,	-192(%rbp)

		# __t17 = *(__t14);
		movq	-192(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t18 = __t17 + 1;
		movq	-208(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-216(%rbp)

		# *(__t10) = __t18;
		movq	-216(%rbp),	%rax
		movq	-168(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t19 = main@a;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-224(%rbp)

		# __t20 = *(__t19);
		movq	-224(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-232(%rbp)

		# __t21 = main@i >= __t20;
		movq	-144(%rbp),	%rdx
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

		# if_false __t21 goto 66;
		movq	-240(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L66

		# exit_out_of_bound

		# __t20 = main@i * 8;
		movq	-144(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-232(%rbp)

		# __t20 = __t20 + 8;
		movq	-232(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-232(%rbp)

		# __t20 = __t19 + __t20;
		movq	-224(%rbp),	%rdx
		add	-232(%rbp),	%rdx
		movq	%rdx,	-232(%rbp)

		# __t23 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-248(%rbp)

		# __t24 = *(__t23);
		movq	-248(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-256(%rbp)

		# __t25 = main@j >= __t24;
		movq	-152(%rbp),	%rdx
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

		# if_false __t25 goto 74;
		movq	-264(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L74

		# exit_out_of_bound

		# __t24 = main@j * 8;
		movq	-152(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-256(%rbp)

		# __t24 = __t24 + 8;
		movq	-256(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-256(%rbp)

		# __t24 = __t23 + __t24;
		movq	-248(%rbp),	%rdx
		add	-256(%rbp),	%rdx
		movq	%rdx,	-256(%rbp)

		# __t32 = *(__t24);
		movq	-256(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-272(%rbp)

		# __t28 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-280(%rbp)

		# __t27 = main@j - 1;
		movq	-152(%rbp),	%rdx
		sub	$1,	%rdx
		movq	%rdx,	-288(%rbp)

		# __t29 = *(__t28);
		movq	-280(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-296(%rbp)

		# __t30 = __t27 >= __t29;
		movq	-288(%rbp),	%rdx
		movq	-296(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-304(%rbp)

		# if_false __t30 goto 84;
		movq	-304(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L84

		# exit_out_of_bound

		# __t29 = __t27 * 8;
		movq	-288(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-296(%rbp)

		# __t29 = __t29 + 8;
		movq	-296(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-296(%rbp)

		# __t29 = __t28 + __t29;
		movq	-280(%rbp),	%rdx
		add	-296(%rbp),	%rdx
		movq	%rdx,	-296(%rbp)

		# __t33 = *(__t29);
		movq	-296(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-312(%rbp)

		# __t34 = __t32 + __t33;
		movq	-272(%rbp),	%rdx
		add	-312(%rbp),	%rdx
		movq	%rdx,	-320(%rbp)

		# *(__t20) = __t34;
		movq	-320(%rbp),	%rax
		movq	-232(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t35 = main@a;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-328(%rbp)

		# __t36 = *(__t35);
		movq	-328(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-336(%rbp)

		# __t37 = main@i >= __t36;
		movq	-144(%rbp),	%rdx
		movq	-336(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-344(%rbp)

		# if_false __t37 goto 95;
		movq	-344(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L95

		# exit_out_of_bound

		# __t36 = main@i * 8;
		movq	-144(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-336(%rbp)

		# __t36 = __t36 + 8;
		movq	-336(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-336(%rbp)

		# __t36 = __t35 + __t36;
		movq	-328(%rbp),	%rdx
		add	-336(%rbp),	%rdx
		movq	%rdx,	-336(%rbp)

		# __t43 = *(__t40);
		movq	-352(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-376(%rbp)

		# __t39 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-360(%rbp)

		# __t40 = *(__t39);
		movq	-360(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-352(%rbp)

		# __t41 = main@j >= __t40;
		movq	-152(%rbp),	%rdx
		movq	-352(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-368(%rbp)

		# if_false __t41 goto 104;
		movq	-368(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L104

		# exit_out_of_bound

		# __t40 = main@j * 8;
		movq	-152(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-352(%rbp)

		# __t40 = __t40 + 8;
		movq	-352(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-352(%rbp)

		# __t40 = __t39 + __t40;
		movq	-360(%rbp),	%rdx
		add	-352(%rbp),	%rdx
		movq	%rdx,	-352(%rbp)

		# *(__t36) = __t43;
		movq	-376(%rbp),	%rax
		movq	-336(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t44 = main@a;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-384(%rbp)

		# __t45 = *(__t44);
		movq	-384(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-392(%rbp)

		# __t46 = main@i >= __t45;
		movq	-144(%rbp),	%rdx
		movq	-392(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-400(%rbp)

		# if_false __t46 goto 113;
		movq	-400(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L113

		# exit_out_of_bound

		# __t45 = main@i * 8;
		movq	-144(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-392(%rbp)

		# __t45 = __t45 + 8;
		movq	-392(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-392(%rbp)

		# __t45 = __t44 + __t45;
		movq	-384(%rbp),	%rdx
		add	-392(%rbp),	%rdx
		movq	%rdx,	-392(%rbp)

		# __t52 = *(__t45);
		movq	-392(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-408(%rbp)

		# __t48 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-416(%rbp)

		# __t49 = *(__t48);
		movq	-416(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-424(%rbp)

		# __t50 = main@j >= __t49;
		movq	-152(%rbp),	%rdx
		movq	-424(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-432(%rbp)

		# if_false __t50 goto 122;
		movq	-432(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L122

		# exit_out_of_bound

		# __t49 = main@j * 8;
		movq	-152(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-424(%rbp)

		# __t49 = __t49 + 8;
		movq	-424(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-424(%rbp)

		# __t49 = __t48 + __t49;
		movq	-416(%rbp),	%rdx
		add	-424(%rbp),	%rdx
		movq	%rdx,	-424(%rbp)

		# __t53 = *(__t49);
		movq	-424(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-440(%rbp)

		# __t54 = __t52 + __t53;
		movq	-408(%rbp),	%rdx
		add	-440(%rbp),	%rdx
		movq	%rdx,	-448(%rbp)

		# *(__t45) = __t54;
		movq	-448(%rbp),	%rax
		movq	-392(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t55 = main@a;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-456(%rbp)

		# __t56 = *(__t55);
		movq	-456(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-464(%rbp)

		# __t57 = 0 >= __t56;
		movq	$0,	%rdx
		movq	-464(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-472(%rbp)

		# if_false __t57 goto 133;
		movq	-472(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L133

		# exit_out_of_bound

		# __t56 = 0 * 8;
		movq	$0,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-464(%rbp)

		# __t56 = __t56 + 8;
		movq	-464(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-464(%rbp)

		# __t56 = __t55 + __t56;
		movq	-456(%rbp),	%rdx
		add	-464(%rbp),	%rdx
		movq	%rdx,	-464(%rbp)

		# __t59 = *(__t56);
		movq	-464(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-480(%rbp)

		# if_false __t59 goto 142;
		movq	-480(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L142

		# push_param "false";
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-488(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# push_param 32;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$32

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t60 = return_value;

		# *(__t60) = 3;
		movq	$3,	%rax
		movq	-496(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t61 = __t60 + 8;
		movq	-496(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-504(%rbp)

		# *(__t61) = "a";
		movq	-512(%rbp),	%rax
		movq	-504(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t62 = __t60 + 16;
		movq	-496(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-520(%rbp)

		# *(__t62) = "b";
		movq	-528(%rbp),	%rax
		movq	-520(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t63 = __t60 + 24;
		movq	-496(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-536(%rbp)

		# *(__t63) = "c";
		movq	-544(%rbp),	%rax
		movq	-536(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@x = __t60;
		movq	-496(%rbp),	%rdx
		movq	%rdx,	-552(%rbp)

		# main@s = "asdfa";
		movq	-560(%rbp),	%rdx
		movq	%rdx,	0(%rbp)

		# main@strm = "new";
		movq	-568(%rbp),	%rdx
		movq	%rdx,	0(%rbp)

		# __t64 = main@x;
		movq	-552(%rbp),	%rdx
		movq	%rdx,	-576(%rbp)

		# __t65 = *(__t64);
		movq	-576(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-584(%rbp)

		# __t66 = 0 >= __t65;
		movq	$0,	%rdx
		movq	-584(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-592(%rbp)

		# if_false __t66 goto 162;
		movq	-592(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L162

		# exit_out_of_bound

		# __t65 = 0 * 8;
		movq	$0,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-584(%rbp)

		# __t65 = __t65 + 8;
		movq	-584(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-584(%rbp)

		# __t65 = __t64 + __t65;
		movq	-576(%rbp),	%rdx
		add	-584(%rbp),	%rdx
		movq	%rdx,	-584(%rbp)

		# __t72 = *(__t65);
		movq	-584(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-600(%rbp)

		# __t68 = main@x;
		movq	-552(%rbp),	%rdx
		movq	%rdx,	-608(%rbp)

		# __t69 = *(__t68);
		movq	-608(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-616(%rbp)

		# __t70 = 1 >= __t69;
		movq	$1,	%rdx
		movq	-616(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-624(%rbp)

		# if_false __t70 goto 171;
		movq	-624(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L171

		# exit_out_of_bound

		# __t69 = 1 * 8;
		movq	$1,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-616(%rbp)

		# __t69 = __t69 + 8;
		movq	-616(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-616(%rbp)

		# __t69 = __t68 + __t69;
		movq	-608(%rbp),	%rdx
		add	-616(%rbp),	%rdx
		movq	%rdx,	-616(%rbp)

		# __t73 = *(__t69);
		movq	-616(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-632(%rbp)

		# push_param __t72;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-600(%rbp)

		# push_param __t73;
		pushq	-632(%rbp)

		# call strcmp, 2;
		call	func4
		add	$16,	%rsp

		# __t74 = return_value;

		# __t75 = __t74 > 0;
		movq	-640(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-648(%rbp)

		# if_false __t75 goto 187;
		movq	-648(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L187

		# push_param "True";
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-656(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# push_param 32;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$32

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t76 = return_value;

		# *(__t76) = 3;
		movq	$3,	%rax
		movq	-664(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t77 = __t76 + 8;
		movq	-664(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-672(%rbp)

		# *(__t77) = 1;
		movq	$1,	%rax
		movq	-672(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t78 = __t76 + 16;
		movq	-664(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-680(%rbp)

		# *(__t78) = 2;
		movq	$2,	%rax
		movq	-680(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t79 = __t76 + 24;
		movq	-664(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-688(%rbp)

		# *(__t79) = 3;
		movq	$3,	%rax
		movq	-688(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@li = __t76;
		movq	-664(%rbp),	%rdx
		movq	%rdx,	-696(%rbp)

		# __t84 = main@x;
		movq	-552(%rbp),	%rdx
		movq	%rdx,	-704(%rbp)

		# __t80 = main@b;
		movq	-136(%rbp),	%rdx
		movq	%rdx,	-712(%rbp)

		# __t81 = *(__t80);
		movq	-712(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-720(%rbp)

		# __t82 = 1 >= __t81;
		movq	$1,	%rdx
		movq	-720(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-728(%rbp)

		# if_false __t82 goto 206;
		movq	-728(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L206

		# exit_out_of_bound

		# __t81 = 1 * 8;
		movq	$1,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-720(%rbp)

		# __t81 = __t81 + 8;
		movq	-720(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-720(%rbp)

		# __t81 = __t80 + __t81;
		movq	-712(%rbp),	%rdx
		add	-720(%rbp),	%rdx
		movq	%rdx,	-720(%rbp)

		# __t85 = *(__t81);
		movq	-720(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-736(%rbp)

		# __t86 = *(__t84);
		movq	-704(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-744(%rbp)

		# __t87 = __t85 >= __t86;
		movq	-736(%rbp),	%rdx
		movq	-744(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-752(%rbp)

		# if_false __t87 goto 214;
		movq	-752(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L214

		# exit_out_of_bound

		# __t86 = __t85 * 8;
		movq	-736(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-744(%rbp)

		# __t86 = __t86 + 8;
		movq	-744(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-744(%rbp)

		# __t86 = __t84 + __t86;
		movq	-704(%rbp),	%rdx
		add	-744(%rbp),	%rdx
		movq	%rdx,	-744(%rbp)

		# __t89 = *(__t86);
		movq	-744(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-760(%rbp)

		# push_param __t89;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-760(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# push_param 8;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$8

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t90 = return_value;

		# push_param __t90;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-768(%rbp)

		# call B@__init__, 1;
		call	func1
		add	$8,	%rsp

		# main@obj = __t90;
		movq	-768(%rbp),	%rdx
		movq	%rdx,	-776(%rbp)

		# __t91 = 4 + 5;
		movq	$4,	%rdx
		add	$5,	%rdx
		movq	%rdx,	-784(%rbp)

		# main@ac = __t91;
		movq	-784(%rbp),	%rdx
		movq	%rdx,	-792(%rbp)

		# main@ab = 5;
		movq	$5,	-800(%rbp)

		# __t92 = main@ab + 43;
		movq	-800(%rbp),	%rdx
		add	$43,	%rdx
		movq	%rdx,	-808(%rbp)

		# main@c = __t92;
		movq	-808(%rbp),	%rdx
		movq	%rdx,	-816(%rbp)

		# push_param main@obj;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-776(%rbp)

		# __t93 = main@li;
		movq	-696(%rbp),	%rdx
		movq	%rdx,	-824(%rbp)

		# __t94 = *(__t93);
		movq	-824(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-832(%rbp)

		# __t95 = 1 >= __t94;
		movq	$1,	%rdx
		movq	-832(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-840(%rbp)

		# if_false __t95 goto 243;
		movq	-840(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L243

		# exit_out_of_bound

		# __t94 = 1 * 8;
		movq	$1,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-832(%rbp)

		# __t94 = __t94 + 8;
		movq	-832(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-832(%rbp)

		# __t94 = __t93 + __t94;
		movq	-824(%rbp),	%rdx
		add	-832(%rbp),	%rdx
		movq	%rdx,	-832(%rbp)

		# push_param main@ac;
		pushq	-792(%rbp)

		# push_param main@c;
		pushq	-816(%rbp)

		# __t97 = *(__t94);
		movq	-832(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-848(%rbp)

		# push_param __t97;
		pushq	-848(%rbp)

		# call B@foo, 4;
		call	func2
		add	$32,	%rsp

		# __t98 = return_value;

		# main@p = __t98;
		movq	-856(%rbp),	%rdx
		movq	%rdx,	-864(%rbp)

		# push_param main@p;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-864(%rbp)

		# call print, 1;
		call	print
		add	$8,	%rsp

		# d_func

		add	$808,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
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
