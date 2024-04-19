.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"False"
.LC1:
		.string	"True"
.LC2:
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
		sub	$16,	%rsp
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L11
		movq	$1,	16(%rbp)
L11:
		movq	$767667,	-64(%rbp)
		movq	-64(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L14
		movq	$1,	-64(%rbp)
L14:
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L17
		leaq	.LC1(%rip),	%rdi
		call	puts
		jmp	L18
L17:
		leaq	.LC0(%rip),	%rdi
		call	puts
L18:
		movq	-64(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-72(%rbp)
		movq	-72(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L21
		movq	$1,	-72(%rbp)
L21:
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
		movq	$54646,	%rax
		add	$0,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
		add	$0,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
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
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L31
		movq	$1,	16(%rbp)
L31:
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L34
		leaq	.LC1(%rip),	%rdi
		call	puts
		jmp	L35
L34:
		leaq	.LC0(%rip),	%rdi
		call	puts
L35:
		add	$0,	%rsp
		popq	%r15
		popq	%r14
		popq	%r13
		popq	%r12
		popq	%rsi
		popq	%rdi
		popq	%rbx
		popq	%rbp
		ret
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
		sub	$48,	%rsp
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L40
		movq	$1,	16(%rbp)
L40:
		movq	32(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-64(%rbp)
		movq	24(%rbp),	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-64(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	-72(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L47
		movq	$1,	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)
L47:
		movq	32(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-80(%rbp)
		movq	$68,	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)
		movq	-80(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-88(%rbp)
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L52
		movq	$1,	%rax
		movq	-80(%rbp),	%rdx
		movq	%rax,	(%rdx)
L52:
		movq	32(%rbp),	%rdx
		add	$8,	%rdx
		movq	%rdx,	-96(%rbp)
		movq	-96(%rbp),	%rdx
		movq	(%rdx),	%rdx
		movq	%rdx,	-104(%rbp)
		movq	-104(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L57
		leaq	.LC1(%rip),	%rdi
		call	puts
		jmp	L58
L57:
		leaq	.LC0(%rip),	%rdi
		call	puts
L58:
		movq	16(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L61
		leaq	.LC1(%rip),	%rdi
		call	puts
		jmp	L62
L61:
		leaq	.LC0(%rip),	%rdi
		call	puts
L62:
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
main:
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
		movq	$1,	%rdx
		cmp	$0,	%rdx
		je	L67
		leaq	.LC1(%rip),	%rdi
		call	puts
		jmp	L68
L67:
		leaq	.LC0(%rip),	%rdi
		call	puts
L68:
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
