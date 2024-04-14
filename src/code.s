.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.LC1:
		.string	"aewgergrhregherg"
.LC2:
		.string	"bdssefe"
.LC3:
		.string	"s is greater"
.LC4:
		.string	"t is greater"
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

		# __t8 = len@list;
		movq	16(%rbp),	%rdx
		movq	%rdx,	-64(%rbp)

		# __t9 = *(__t8);
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)

		# return __t9;
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
		sub	$88,	%rsp

		# string make .LC1 into var __t0
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-64(%rbp)

		# main@s = __t0;
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)

		# string make .LC2 into var __t1
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-80(%rbp)

		# main@t = __t1;
		movq	-80(%rbp),	%rdx
		movq	%rdx,	-88(%rbp)

		# push_param main@s;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-72(%rbp)

		# push_param main@t;
		pushq	-88(%rbp)

		# call strcmp1, 2;
		call	strcmp1
		add	$16,	%rsp

		# __t2 = return_value;
		mov	%rax,	-96(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t3 = __t2 > 0;
		movq	-96(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-104(%rbp)

		# main@a = __t3;
		movq	-104(%rbp),	%rdx
		movq	%rdx,	-112(%rbp)

		# push_param main@a;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-112(%rbp)

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

		# push_param main@s;
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-72(%rbp)

		# push_param main@t;
		pushq	-88(%rbp)

		# call strcmp1, 2;
		call	strcmp1
		add	$16,	%rsp

		# __t4 = return_value;
		mov	%rax,	-120(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax

		# __t5 = __t4 > 0;
		movq	-120(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-128(%rbp)

		# if_false __t5 goto 36;
		movq	-128(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L36

		# string make .LC3 into var __t6
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-136(%rbp)

		# string print __t6
		movq	-136(%rbp),	%rdi
		call	puts

		# goto 38;
		jmp	L38

		# string make .LC4 into var __t7
L36:
		leaq	.LC4(%rip),	%rdi
		movq	%rdi,	-144(%rbp)

		# string print __t7
		movq	-144(%rbp),	%rdi
		call	puts

		# d_func

L38:
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
