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
		sub	$40,	%rsp
		movq	$5,	-64(%rbp)
		movq	$4,	-72(%rbp)
		movq	-64(%rbp),	%rax
		movq	-72(%rbp),	%rbx
		movq	$1,	%rcx
exp_loop_0:
		test	%rbx,	%rbx
		jz	exp_done_0
		imul	%rax,	%rcx
		dec	%rbx
		jmp	exp_loop_0
exp_done_0:
		movq	%rcx,	%rdx
		movq	%rdx,	-80(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$4,	%rax
		movq	$6,	%rbx
		movq	$1,	%rcx
exp_loop_1:
		test	%rbx,	%rbx
		jz	exp_done_1
		imul	%rax,	%rcx
		dec	%rbx
		jmp	exp_loop_1
exp_done_1:
		movq	%rcx,	%rdx
		movq	%rdx,	-88(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-88(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	$65,	%rax
		movq	$2,	%rbx
		movq	$1,	%rcx
exp_loop_2:
		test	%rbx,	%rbx
		jz	exp_done_2
		imul	%rax,	%rcx
		dec	%rbx
		jmp	exp_loop_2
exp_done_2:
		movq	%rcx,	%rdx
		movq	%rdx,	-96(%rbp)
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-96(%rbp)
		call	print
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
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
