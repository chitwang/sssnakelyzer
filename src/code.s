.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"SLR name:"
.LC1:
		.string	"CLR name:"
.LC2:
		.string	"LALR name:"
.LC3:
		.string	"LALR"
.LC4:
		.string	"CLR"
.LC5:
		.string	"Shift-Reduce"
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

		# __t21 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t22 = *(__t21);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t22;
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

		# gin_func ShiftReduceParser@__init__
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
		movq	24(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t0) = ShiftReduceParser@__init__@name_;
		movq	16(%rbp),	%rax
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

		# gin_func LR0Parser@__init__
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
		sub	$16,	%rsp

		# __t1 = self + 8;
		movq	32(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t1) = LR0Parser@__init__@myname_;
		movq	24(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t2 = self + 0;
		movq	32(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t2) = LR0Parser@__init__@parentname_;
		movq	16(%rbp),	%rax
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

		# gin_func CLRParser@__init__
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

		# __t3 = self + 8;
		movq	32(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t3) = CLRParser@__init__@myname_;
		movq	24(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t4 = self + 0;
		movq	32(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t4) = CLRParser@__init__@parentname_;
		movq	16(%rbp),	%rax
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

		# gin_func LALRParser@__init__
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
		sub	$24,	%rsp

		# __t5 = self + 16;
		movq	40(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-64(%rbp)

		# *(__t5) = LALRParser@__init__@myname_;
		movq	32(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t6 = self + 8;
		movq	40(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-72(%rbp)

		# *(__t6) = LALRParser@__init__@clrname_;
		movq	24(%rbp),	%rax
		movq	-72(%rbp),	%rdx
		movq	%rax,	(%rdx)

		# __t7 = self + 0;
		movq	40(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-80(%rbp)

		# *(__t7) = LALRParser@__init__@srname_;
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

		# gin_func LALRParser@foo
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
		sub	$80,	%rsp

		# LALRParser@foo@a = 5;
		movq	$5,	-64(%rbp)

		# string make .LC0 into var __t8
		leaq	.LC0(%rip),	%rdi
		movq	%rdi,	-72(%rbp)

		# string print __t8
		movq	-72(%rbp),	%rdi
		call	puts

		# __t9 = self + 0;
		movq	16(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-80(%rbp)

		# __t10 = *(__t9);
		movq	-80(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-88(%rbp)

		# string print __t10
		movq	-88(%rbp),	%rdi
		call	puts

		# string make .LC1 into var __t11
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-96(%rbp)

		# string print __t11
		movq	-96(%rbp),	%rdi
		call	puts

		# __t12 = self + 8;
		movq	16(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-104(%rbp)

		# __t13 = *(__t12);
		movq	-104(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-112(%rbp)

		# string print __t13
		movq	-112(%rbp),	%rdi
		call	puts

		# string make .LC2 into var __t14
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-120(%rbp)

		# string print __t14
		movq	-120(%rbp),	%rdi
		call	puts

		# __t15 = self + 16;
		movq	16(%rbp),	%rdx
		add	$16,	%rdx
		movq	%rdx,	-128(%rbp)

		# __t16 = *(__t15);
		movq	-128(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-136(%rbp)

		# string print __t16
		movq	-136(%rbp),	%rdi
		call	puts

		# d_func

		add	$80,	%rsp
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
		sub	$40,	%rsp

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

		# string make .LC3 into var __t17
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-72(%rbp)

		# string make .LC4 into var __t18
		leaq	.LC4(%rip),	%rdi
		movq	%rdi,	-80(%rbp)

		# string make .LC5 into var __t19
		leaq	.LC5(%rip),	%rdi
		movq	%rdi,	-88(%rbp)

		# push_param __t17;
		pushq	-72(%rbp)

		# push_param __t18;
		pushq	-80(%rbp)

		# push_param __t19;
		pushq	-88(%rbp)

		# call LALRParser@__init__, 4;
		call	func5
		add	$32,	%rsp

		# none type function call ends
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# main@obj = __t20;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-96(%rbp)

		# push_param main@obj;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-96(%rbp)

		# call LALRParser@foo, 1;
		call	func6
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
