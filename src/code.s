.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.LC1:
		.string	"Hello\n"
.LC2:
		.string	"Gello"
.LC3:
		.string	"a"
.LC4:
		.string	"b"
.LC5:
		.string	"c"
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

		# gin_func main
main:
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
		sub	$168,	%rsp

		# string make .LC1 into var __t0
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-64(%rbp)

		# main@s = __t0;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)

		# __t1 = 1 + 4;
		movq	$1,	%rdx
		add	$4,	%rdx
		movq	%rdx,	-80(%rbp)

		# main@ar = __t1;
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)

		# push_param main@ar;
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

		# string print main@s
		movq	-72(%rbp),	%rdi
		call	puts

		# string make .LC2 into var __t2
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-96(%rbp)

		# string print __t2
		movq	-96(%rbp),	%rdi
		call	puts

		# string make .LC3 into var __t3
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-104(%rbp)

		# string make .LC4 into var __t4
		leaq	.LC4(%rip),	%rdi
		movq	%rdi,	-112(%rbp)

		# string make .LC5 into var __t5
		leaq	.LC5(%rip),	%rdi
		movq	%rdi,	-120(%rbp)

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

		# __t6 = return_value;
		mov	%rax,	-128(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# *(__t6) = 3;
		movq	$3,	%rax
		movq	-128(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = __t6 + 8;
		movq	-128(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-136(%rbp)

		# *(__t7) = __t3;
		movq	-104(%rbp),	%rax
		movq	-136(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t8 = __t6 + 16;
		movq	-128(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-144(%rbp)

		# *(__t8) = __t4;
		movq	-112(%rbp),	%rax
		movq	-144(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t9 = __t6 + 24;
		movq	-128(%rbp),	%rdx
		add	$24,	%rdx
		movq	%rdx,	-152(%rbp)

		# *(__t9) = __t5;
		movq	-120(%rbp),	%rax
		movq	-152(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# main@a = __t6;
		movq	-128(%rbp),	%rdx
		movq	%rdx,	-160(%rbp)

		# push_param main@a;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-160(%rbp)

		# call len, 1;
		call	func1
		add	$8,	%rsp

		# __t10 = return_value;
		mov	%rax,	-168(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t11 = __t10 + 1;
		movq	-168(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-176(%rbp)

		# main@i = 0;
		movq	$0,	-184(%rbp)

		# __t17 = main@i < __t11;
L43:
		movq	-184(%rbp),	%rdx
		movq	-176(%rbp),	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-192(%rbp)

		# if_false __t17 goto 57;
		movq	-192(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L57

		# __t12 = main@a;
		movq	-160(%rbp),	%rdx
		movq	%rdx,	-200(%rbp)

		# __t13 = *(__t12);
		movq	-200(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t14 = main@i >= __t13;
		movq	-184(%rbp),	%rdx
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

		# if_false __t14 goto 50;
		movq	-216(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L50

		# exit_out_of_bound
		leaq	.LC0(%rip),	%rdi
		call	puts
		movq	$60,	%rax
		xor	%rdi,	%rdi
		syscall

		# __t13 = main@i * 8;
L50:
		movq	-184(%rbp),	%rdx
		imul	$8,	%rdx
		movq	%rdx,	-208(%rbp)

		# __t13 = __t13 + 8;
		movq	-208(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-208(%rbp)

		# __t13 = __t12 + __t13;
		movq	-200(%rbp),	%rdx
		add	-208(%rbp),	%rdx
		movq	%rdx,	-208(%rbp)

		# __t16 = *(__t13);
		movq	-208(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-224(%rbp)

		# string print __t16
		movq	-224(%rbp),	%rdi
		call	puts

		# main@i = main@i + 1;
		movq	-184(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-184(%rbp)

		# goto 43;
		jmp	L43

		# d_func

L57:
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
