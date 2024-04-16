.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.LC1:
		.string	"Hi"
.LC2:
		.string	"Yello"
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

		# __t90 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t91 = *(__t90);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t91;
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

		# gin_func GrandParent@__init__
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

		# __t0 = self + 0;
		movq	16(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t0) = 0;
		movq	$0,	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

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

		# gin_func GrandParent@show
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
		sub	$40,	%rsp

		# string make .LC1 into var __t1
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-64(%rbp)

		# string print __t1
		movq	-64(%rbp),	%rdi
		call	puts

		# push_param GrandParent@show@num;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	16(%rbp)

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

		# __t2 = self + 0;
		movq	24(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-72(%rbp)

		# __t3 = *(__t2);
		movq	-72(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-80(%rbp)

		# push_param __t3;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

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

		# __t4 = self + 0;
		movq	24(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-88(%rbp)

		# __t5 = *(__t4);
		movq	-88(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-96(%rbp)

		# return __t5;
		movq	-96(%rbp),	%rax
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

		# gin_func Parent@__init__
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
		sub	$16,	%rsp

		# __t6 = self + 8;
		movq	24(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t6) = Parent@__init__@num;
		movq	16(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = self + 0;
		movq	24(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t7) = 1;
		movq	$1,	%rax
		movq	-72(%rbp),	%rdx
		movq	%rax,	(%rdx)

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

		# gin_func Parent@ret_grand_parent
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

		# __t8 = return_value;
		mov	%rax,	-64(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t8;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)

		# call GrandParent@__init__, 1;
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

		# Parent@ret_grand_parent@g1 = __t8;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)

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

		# __t9 = return_value;
		mov	%rax,	-80(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t9;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call GrandParent@__init__, 1;
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

		# Parent@ret_grand_parent@g2 = __t9;
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)

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

		# __t10 = return_value;
		mov	%rax,	-96(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t10;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-96(%rbp)

		# call GrandParent@__init__, 1;
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

		# Parent@ret_grand_parent@g3 = __t10;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)

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

		# __t11 = return_value;
		mov	%rax,	-112(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t11;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-112(%rbp)

		# call GrandParent@__init__, 1;
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

		# Parent@ret_grand_parent@g4 = __t11;
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)

		# push_param 40;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$40

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t12 = return_value;
		mov	%rax,	-128(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t12) = 4;
		movq	$4,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t13 = __t12 + 8;
		movq	-128(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-136(%rbp)

		# *(__t13) = Parent@ret_grand_parent@g1;
		movq	-72(%rbp),	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t14 = __t12 + 16;
		movq	-128(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-144(%rbp)

		# *(__t14) = Parent@ret_grand_parent@g2;
		movq	-88(%rbp),	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t15 = __t12 + 24;
		movq	-128(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-152(%rbp)

		# *(__t15) = Parent@ret_grand_parent@g3;
		movq	-104(%rbp),	%rax
		movq	-152(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t16 = __t12 + 32;
		movq	-128(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-160(%rbp)

		# *(__t16) = Parent@ret_grand_parent@g4;
		movq	-120(%rbp),	%rax
		movq	-160(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# return __t12;
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

		# d_func

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

		# gin_func Child@__init__
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
		sub	$24,	%rsp

		# __t17 = self + 8;
		movq	40(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t17) = Child@__init__@num;
		movq	24(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t18 = self + 16;
		movq	40(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t18) = Child@__init__@name;
		movq	32(%rbp),	%rax
		movq	-72(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t19 = self + 0;
		movq	40(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-80(%rbp)

		# *(__t19) = Child@__init__@b;
		movq	16(%rbp),	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# d_func

		add	$24,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# gin_func Child@ret_parent
func7:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$256,	%rsp

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t20 = return_value;
		mov	%rax,	-64(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t20;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)

		# push_param 1;
		pushq	$1

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p1 = __t20;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t21 = return_value;
		mov	%rax,	-80(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t21;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# push_param 2;
		pushq	$2

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p2 = __t21;
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t22 = return_value;
		mov	%rax,	-96(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t22;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-96(%rbp)

		# push_param 3;
		pushq	$3

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p3 = __t22;
		movq	-96(%rbp),	%rdx
		movq	%rdx,	-104(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t23 = return_value;
		mov	%rax,	-112(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t23;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-112(%rbp)

		# push_param 4;
		pushq	$4

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p4 = __t23;
		movq	-112(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t24 = return_value;
		mov	%rax,	-128(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t24;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-128(%rbp)

		# push_param 5;
		pushq	$5

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p5 = __t24;
		movq	-128(%rbp),	%rdx
		movq	%rdx,	-136(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t25 = return_value;
		mov	%rax,	-144(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t25;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-144(%rbp)

		# push_param 6;
		pushq	$6

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p6 = __t25;
		movq	-144(%rbp),	%rdx
		movq	%rdx,	-152(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t26 = return_value;
		mov	%rax,	-160(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t26;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-160(%rbp)

		# push_param 7;
		pushq	$7

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p7 = __t26;
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t27 = return_value;
		mov	%rax,	-176(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t27;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-176(%rbp)

		# push_param 8;
		pushq	$8

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p8 = __t27;
		movq	-176(%rbp),	%rdx
		movq	%rdx,	-184(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t28 = return_value;
		mov	%rax,	-192(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t28;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-192(%rbp)

		# push_param 9;
		pushq	$9

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p9 = __t28;
		movq	-192(%rbp),	%rdx
		movq	%rdx,	-200(%rbp)

		# push_param 16;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$16

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t29 = return_value;
		mov	%rax,	-208(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t29;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-208(%rbp)

		# push_param 10;
		pushq	$10

		# call Parent@__init__, 2;
		call	func4
		add	$16,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# Child@ret_parent@p10 = __t29;
		movq	-208(%rbp),	%rdx
		movq	%rdx,	-216(%rbp)

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

		# __t30 = return_value;
		mov	%rax,	-224(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t30) = 10;
		movq	$10,	%rax
		movq	-224(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t31 = __t30 + 8;
		movq	-224(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-232(%rbp)

		# *(__t31) = Child@ret_parent@p1;
		movq	-72(%rbp),	%rax
		movq	-232(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t32 = __t30 + 16;
		movq	-224(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-240(%rbp)

		# *(__t32) = Child@ret_parent@p2;
		movq	-88(%rbp),	%rax
		movq	-240(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t33 = __t30 + 24;
		movq	-224(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-248(%rbp)

		# *(__t33) = Child@ret_parent@p3;
		movq	-104(%rbp),	%rax
		movq	-248(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t34 = __t30 + 32;
		movq	-224(%rbp),	%rdx
		add	$32,	%rdx
		movq	%rdx,	-256(%rbp)

		# *(__t34) = Child@ret_parent@p4;
		movq	-120(%rbp),	%rax
		movq	-256(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t35 = __t30 + 40;
		movq	-224(%rbp),	%rdx
		add	$40,	%rdx
		movq	%rdx,	-264(%rbp)

		# *(__t35) = Child@ret_parent@p5;
		movq	-136(%rbp),	%rax
		movq	-264(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t36 = __t30 + 48;
		movq	-224(%rbp),	%rdx
		add	$48,	%rdx
		movq	%rdx,	-272(%rbp)

		# *(__t36) = Child@ret_parent@p6;
		movq	-152(%rbp),	%rax
		movq	-272(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t37 = __t30 + 56;
		movq	-224(%rbp),	%rdx
		add	$56,	%rdx
		movq	%rdx,	-280(%rbp)

		# *(__t37) = Child@ret_parent@p7;
		movq	-168(%rbp),	%rax
		movq	-280(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t38 = __t30 + 64;
		movq	-224(%rbp),	%rdx
		add	$64,	%rdx
		movq	%rdx,	-288(%rbp)

		# *(__t38) = Child@ret_parent@p8;
		movq	-184(%rbp),	%rax
		movq	-288(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t39 = __t30 + 72;
		movq	-224(%rbp),	%rdx
		add	$72,	%rdx
		movq	%rdx,	-296(%rbp)

		# *(__t39) = Child@ret_parent@p9;
		movq	-200(%rbp),	%rax
		movq	-296(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t40 = __t30 + 80;
		movq	-224(%rbp),	%rdx
		add	$80,	%rdx
		movq	%rdx,	-304(%rbp)

		# *(__t40) = Child@ret_parent@p10;
		movq	-216(%rbp),	%rax
		movq	-304(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# Child@ret_parent@obj = __t30;
		movq	-224(%rbp),	%rdx
		movq	%rdx,	-312(%rbp)

		# return Child@ret_parent@obj;
		movq	-312(%rbp),	%rax
		add	$256,	%rsp
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

		add	$256,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret

		# gin_func Child@display
func8:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$32,	%rsp

		# __t41 = self + 16;
		movq	16(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-64(%rbp)

		# __t42 = *(__t41);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# string print __t42
		movq	-72(%rbp),	%rdi
		call	puts

		# __t43 = self + 8;
		movq	16(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-80(%rbp)

		# __t44 = *(__t43);
		movq	-80(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-88(%rbp)

		# push_param __t44;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-88(%rbp)

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

		add	$32,	%rsp
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
func9:
		pushq	%rbp
		movq	%rsp,	%rbp
		pushq	%rbx
		pushq	%rdi
		pushq	%rsi
		pushq	%r12
		pushq	%r13
		pushq	%r14
		pushq	%r15
		sub	$328,	%rsp

		# string make .LC2 into var __t45
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-64(%rbp)

		# push_param 24;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$24

		# call allocmem, 1;
		call	allocmem
		add	$8,	%rsp

		# __t46 = return_value;
		mov	%rax,	-72(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t46;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-72(%rbp)

		# push_param __t45;
		pushq	-64(%rbp)

		# push_param 100;
		pushq	$100

		# push_param 1;
		pushq	$1

		# call Child@__init__, 4;
		call	func6
		add	$32,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@c = __t46;
		movq	-72(%rbp),	%rdx
		movq	%rdx,	-80(%rbp)

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

		# __t47 = return_value;
		mov	%rax,	-88(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t47;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-88(%rbp)

		# call GrandParent@__init__, 1;
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

		# main@obj = __t47;
		movq	-88(%rbp),	%rdx
		movq	%rdx,	-96(%rbp)

		# push_param main@c;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call Child@ret_parent, 1;
		call	func7
		add	$8,	%rsp

		# __t48 = return_value;
		mov	%rax,	-104(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t49 = __t48;
		movq	-104(%rbp),	%rdx
		movq	%rdx,	-112(%rbp)

		# __t50 = *(__t49);
		movq	-112(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-120(%rbp)

		# __t51 = 9 >= __t50;
		movq	$9,	%rdx
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

		# if_false __t51 goto 316;
		movq	-128(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L316

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t50 = 9 * 8;
L316:
		movq	$9,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-120(%rbp)

		# __t50 = __t50 + 8;
		movq	-120(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-120(%rbp)

		# __t50 = __t49 + __t50;
		movq	-112(%rbp),	%rdx
		add	-120(%rbp),	%rdx
		movq	%rdx,	-120(%rbp)

		# __t54 = *(__t50);
		movq	-120(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-136(%rbp)

		# __t53 = __t54 + 8;
		movq	-136(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-144(%rbp)

		# __t55 = *(__t53);
		movq	-144(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-152(%rbp)

		# push_param __t55;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-152(%rbp)

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

		# push_param main@c;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call Child@ret_parent, 1;
		call	func7
		add	$8,	%rsp

		# __t56 = return_value;
		mov	%rax,	-160(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t57 = __t56;
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-168(%rbp)

		# __t58 = *(__t57);
		movq	-168(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-176(%rbp)

		# __t59 = 3 >= __t58;
		movq	$3,	%rdx
		movq	-176(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-184(%rbp)

		# if_false __t59 goto 337;
		movq	-184(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L337

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t58 = 3 * 8;
L337:
		movq	$3,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-176(%rbp)

		# __t58 = __t58 + 8;
		movq	-176(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-176(%rbp)

		# __t58 = __t57 + __t58;
		movq	-168(%rbp),	%rdx
		add	-176(%rbp),	%rdx
		movq	%rdx,	-176(%rbp)

		# __t61 = *(__t58);
		movq	-176(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-192(%rbp)

		# push_param __t61;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-192(%rbp)

		# call Parent@ret_grand_parent, 1;
		call	func5
		add	$8,	%rsp

		# __t62 = return_value;
		mov	%rax,	-200(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t63 = __t62;
		movq	-200(%rbp),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t64 = *(__t63);
		movq	-208(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-216(%rbp)

		# __t65 = 1 >= __t64;
		movq	$1,	%rdx
		movq	-216(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-224(%rbp)

		# if_false __t65 goto 351;
		movq	-224(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L351

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t64 = 1 * 8;
L351:
		movq	$1,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-216(%rbp)

		# __t64 = __t64 + 8;
		movq	-216(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-216(%rbp)

		# __t64 = __t63 + __t64;
		movq	-208(%rbp),	%rdx
		add	-216(%rbp),	%rdx
		movq	%rdx,	-216(%rbp)

		# __t67 = *(__t64);
		movq	-216(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-232(%rbp)

		# push_param __t67;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-232(%rbp)

		# push_param 5;
		pushq	$5

		# call GrandParent@show, 2;
		call	func3
		add	$16,	%rsp

		# __t68 = return_value;
		mov	%rax,	-240(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t68;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-240(%rbp)

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

		# push_param main@c;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call Child@ret_parent, 1;
		call	func7
		add	$8,	%rsp

		# __t69 = return_value;
		mov	%rax,	-248(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t70 = __t69;
		movq	-248(%rbp),	%rdx
		movq	%rdx,	-256(%rbp)

		# __t71 = *(__t70);
		movq	-256(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-264(%rbp)

		# __t72 = 3 >= __t71;
		movq	$3,	%rdx
		movq	-264(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jle	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-272(%rbp)

		# if_false __t72 goto 376;
		movq	-272(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L376

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t71 = 3 * 8;
L376:
		movq	$3,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-264(%rbp)

		# __t71 = __t71 + 8;
		movq	-264(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-264(%rbp)

		# __t71 = __t70 + __t71;
		movq	-256(%rbp),	%rdx
		add	-264(%rbp),	%rdx
		movq	%rdx,	-264(%rbp)

		# __t74 = *(__t71);
		movq	-264(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-280(%rbp)

		# push_param __t74;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-280(%rbp)

		# call Parent@ret_grand_parent, 1;
		call	func5
		add	$8,	%rsp

		# __t75 = return_value;
		mov	%rax,	-288(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t76 = __t75;
		movq	-288(%rbp),	%rdx
		movq	%rdx,	-296(%rbp)

		# __t77 = *(__t76);
		movq	-296(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-304(%rbp)

		# __t78 = 1 >= __t77;
		movq	$1,	%rdx
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

		# if_false __t78 goto 390;
		movq	-312(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L390

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t77 = 1 * 8;
L390:
		movq	$1,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-304(%rbp)

		# __t77 = __t77 + 8;
		movq	-304(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-304(%rbp)

		# __t77 = __t76 + __t77;
		movq	-296(%rbp),	%rdx
		add	-304(%rbp),	%rdx
		movq	%rdx,	-304(%rbp)

		# push_param main@c;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call Child@ret_parent, 1;
		call	func7
		add	$8,	%rsp

		# __t80 = return_value;
		mov	%rax,	-320(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t81 = __t80;
		movq	-320(%rbp),	%rdx
		movq	%rdx,	-328(%rbp)

		# __t82 = *(__t81);
		movq	-328(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-336(%rbp)

		# __t83 = 9 >= __t82;
		movq	$9,	%rdx
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

		# if_false __t83 goto 403;
		movq	-344(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L403

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t82 = 9 * 8;
L403:
		movq	$9,	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-336(%rbp)

		# __t82 = __t82 + 8;
		movq	-336(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-336(%rbp)

		# __t82 = __t81 + __t82;
		movq	-328(%rbp),	%rdx
		add	-336(%rbp),	%rdx
		movq	%rdx,	-336(%rbp)

		# __t86 = *(__t82);
		movq	-336(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-352(%rbp)

		# __t85 = __t86 + 8;
		movq	-352(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-360(%rbp)

		# __t87 = *(__t77);
		movq	-304(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-368(%rbp)

		# push_param __t87;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-368(%rbp)

		# __t88 = *(__t85);
		movq	-360(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-376(%rbp)

		# push_param __t88;
		pushq	-376(%rbp)

		# call GrandParent@show, 2;
		call	func3
		add	$16,	%rsp

		# __t89 = return_value;
		mov	%rax,	-384(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# push_param __t89;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-384(%rbp)

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

		# push_param main@c;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)

		# call Child@display, 1;
		call	func8
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
