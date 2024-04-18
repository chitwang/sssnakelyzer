.section	.rodata
		integer_format:	.asciz,	"%ld\n"
.LC0:
		.string	"List Index OutofBound!"
.LC14:
		.string	"Another random branch"
.LC15:
		.string	"Between 10 and 20"
.LC6:
		.string	"Divisible by 3"
.LC19:
		.string	"Equal to 15"
.LC22:
		.string	"Equal to 20"
.LC18:
		.string	"Equal to 5"
.LC1:
		.string	"Even number"
.LC2:
		.string	"Greater than 10"
.LC7:
		.string	"Greater than 15"
.LC3:
		.string	"Greater than 20"
.LC17:
		.string	"Greater than 5"
.LC12:
		.string	"Greater than or equal to 10"
.LC11:
		.string	"Less than 10"
.LC20:
		.string	"Less than 15"
.LC23:
		.string	"Less than 20"
.LC10:
		.string	"Less than 5"
.LC16:
		.string	"Less than or equal to 10"
.LC21:
		.string	"Not divisible by 3"
.LC5:
		.string	"Not greater than 10"
.LC8:
		.string	"Not greater than 15"
.LC4:
		.string	"Not greater than 20"
.LC9:
		.string	"Odd number"
.LC13:
		.string	"Random branch"
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
		sub	$8,	%rsp
		movq	16(%rbp),	%rdx
		add	$0,	%rdx
		movq	%rdx,	-64(%rbp)
		movq	$1,	%rax
		movq	-64(%rbp),	%rdx
		movq	%rax,	(%rdx)
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
		movq	16(%rbp),	%rax
		cqto
		movq	$2,	%rbx
		idiv	%rbx
		movq	%rdx,	-64(%rbp)
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
		movq	%rdx,	-72(%rbp)
		movq	-72(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L34
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-80(%rbp)
		movq	-80(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-88(%rbp)
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L31
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-96(%rbp)
		movq	-96(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$20,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-104(%rbp)
		movq	-104(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L28
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-112(%rbp)
		movq	-112(%rbp),	%rdi
		call	puts
		jmp	L30
L28:
		leaq	.LC4(%rip),	%rdi
		movq	%rdi,	-120(%rbp)
		movq	-120(%rbp),	%rdi
		call	puts
L30:
		jmp	L33
L31:
		leaq	.LC5(%rip),	%rdi
		movq	%rdi,	-128(%rbp)
		movq	-128(%rbp),	%rdi
		call	puts
L33:
		jmp	L61
L34:
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-136(%rbp)
		movq	-136(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-144(%rbp)
		movq	-144(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L47
		leaq	.LC6(%rip),	%rdi
		movq	%rdi,	-152(%rbp)
		movq	-152(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$15,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-160(%rbp)
		movq	-160(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L44
		leaq	.LC7(%rip),	%rdi
		movq	%rdi,	-168(%rbp)
		movq	-168(%rbp),	%rdi
		call	puts
		jmp	L61
L44:
		leaq	.LC8(%rip),	%rdi
		movq	%rdi,	-176(%rbp)
		movq	-176(%rbp),	%rdi
		call	puts
		jmp	L61
L47:
		leaq	.LC9(%rip),	%rdi
		movq	%rdi,	-184(%rbp)
		movq	-184(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$5,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-192(%rbp)
		movq	-192(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L54
		leaq	.LC10(%rip),	%rdi
		movq	%rdi,	-200(%rbp)
		movq	-200(%rbp),	%rdi
		call	puts
		jmp	L61
L54:
		movq	16(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-208(%rbp)
		movq	-208(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L59
		leaq	.LC11(%rip),	%rdi
		movq	%rdi,	-216(%rbp)
		movq	-216(%rbp),	%rdi
		call	puts
		jmp	L61
L59:
		leaq	.LC12(%rip),	%rdi
		movq	%rdi,	-224(%rbp)
		movq	-224(%rbp),	%rdi
		call	puts
L61:
		add	$168,	%rsp
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
		sub	$584,	%rsp
		movq	16(%rbp),	%rax
		cqto
		movq	$2,	%rbx
		idiv	%rbx
		movq	%rdx,	-64(%rbp)
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
		movq	%rdx,	-72(%rbp)
		movq	-72(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L136
		leaq	.LC1(%rip),	%rdi
		movq	%rdi,	-80(%rbp)
		movq	-80(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$10,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-88(%rbp)
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L97
		leaq	.LC2(%rip),	%rdi
		movq	%rdi,	-96(%rbp)
		movq	-96(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$20,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-104(%rbp)
		movq	-104(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L86
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-112(%rbp)
		movq	-112(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-120(%rbp)
		movq	-120(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-128(%rbp)
		movq	-128(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L83
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-136(%rbp)
		movq	-136(%rbp),	%rdi
		call	puts
		jmp	L85
L83:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-144(%rbp)
		movq	-144(%rbp),	%rdi
		call	puts
L85:
		jmp	L96
L86:
		leaq	.LC15(%rip),	%rdi
		movq	%rdi,	-152(%rbp)
		movq	-152(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-160(%rbp)
		movq	-160(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-168(%rbp)
		movq	-168(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L94
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-176(%rbp)
		movq	-176(%rbp),	%rdi
		call	puts
		jmp	L96
L94:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-184(%rbp)
		movq	-184(%rbp),	%rdi
		call	puts
L96:
		jmp	L135
L97:
		leaq	.LC16(%rip),	%rdi
		movq	%rdi,	-192(%rbp)
		movq	-192(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$5,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-200(%rbp)
		movq	-200(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L112
		leaq	.LC17(%rip),	%rdi
		movq	%rdi,	-208(%rbp)
		movq	-208(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-216(%rbp)
		movq	-216(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-224(%rbp)
		movq	-224(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L109
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-232(%rbp)
		movq	-232(%rbp),	%rdi
		call	puts
		jmp	L111
L109:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-240(%rbp)
		movq	-240(%rbp),	%rdi
		call	puts
L111:
		jmp	L135
L112:
		movq	16(%rbp),	%rdx
		movq	$5,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-248(%rbp)
		movq	-248(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L125
		leaq	.LC18(%rip),	%rdi
		movq	%rdi,	-256(%rbp)
		movq	-256(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-264(%rbp)
		movq	-264(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-272(%rbp)
		movq	-272(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L122
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-280(%rbp)
		movq	-280(%rbp),	%rdi
		call	puts
		jmp	L135
L122:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-288(%rbp)
		movq	-288(%rbp),	%rdi
		call	puts
		jmp	L135
L125:
		leaq	.LC10(%rip),	%rdi
		movq	%rdi,	-296(%rbp)
		movq	-296(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-304(%rbp)
		movq	-304(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-312(%rbp)
		movq	-312(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L133
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-320(%rbp)
		movq	-320(%rbp),	%rdi
		call	puts
		jmp	L135
L133:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-328(%rbp)
		movq	-328(%rbp),	%rdi
		call	puts
L135:
		jmp	L218
L136:
		leaq	.LC9(%rip),	%rdi
		movq	%rdi,	-336(%rbp)
		movq	-336(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-344(%rbp)
		movq	-344(%rbp),	%rdx
		movq	$0,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-352(%rbp)
		movq	-352(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L180
		leaq	.LC6(%rip),	%rdi
		movq	%rdi,	-360(%rbp)
		movq	-360(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$15,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-368(%rbp)
		movq	-368(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L156
		leaq	.LC7(%rip),	%rdi
		movq	%rdi,	-376(%rbp)
		movq	-376(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-384(%rbp)
		movq	-384(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-392(%rbp)
		movq	-392(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L153
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-400(%rbp)
		movq	-400(%rbp),	%rdi
		call	puts
		jmp	L155
L153:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-408(%rbp)
		movq	-408(%rbp),	%rdi
		call	puts
L155:
		jmp	L179
L156:
		movq	16(%rbp),	%rdx
		movq	$15,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-416(%rbp)
		movq	-416(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L169
		leaq	.LC19(%rip),	%rdi
		movq	%rdi,	-424(%rbp)
		movq	-424(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-432(%rbp)
		movq	-432(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-440(%rbp)
		movq	-440(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L166
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-448(%rbp)
		movq	-448(%rbp),	%rdi
		call	puts
		jmp	L179
L166:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-456(%rbp)
		movq	-456(%rbp),	%rdi
		call	puts
		jmp	L179
L169:
		leaq	.LC20(%rip),	%rdi
		movq	%rdi,	-464(%rbp)
		movq	-464(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-472(%rbp)
		movq	-472(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-480(%rbp)
		movq	-480(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L177
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-488(%rbp)
		movq	-488(%rbp),	%rdi
		call	puts
		jmp	L179
L177:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-496(%rbp)
		movq	-496(%rbp),	%rdi
		call	puts
L179:
		jmp	L218
L180:
		leaq	.LC21(%rip),	%rdi
		movq	%rdi,	-504(%rbp)
		movq	-504(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rdx
		movq	$20,	%rcx
		cmp	%rdx,	%rcx
		jl	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-512(%rbp)
		movq	-512(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L195
		leaq	.LC3(%rip),	%rdi
		movq	%rdi,	-520(%rbp)
		movq	-520(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-528(%rbp)
		movq	-528(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-536(%rbp)
		movq	-536(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L192
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-544(%rbp)
		movq	-544(%rbp),	%rdi
		call	puts
		jmp	L194
L192:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-552(%rbp)
		movq	-552(%rbp),	%rdi
		call	puts
L194:
		jmp	L218
L195:
		movq	16(%rbp),	%rdx
		movq	$20,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-560(%rbp)
		movq	-560(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L208
		leaq	.LC22(%rip),	%rdi
		movq	%rdi,	-568(%rbp)
		movq	-568(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-576(%rbp)
		movq	-576(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-584(%rbp)
		movq	-584(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L205
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-592(%rbp)
		movq	-592(%rbp),	%rdi
		call	puts
		jmp	L218
L205:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-600(%rbp)
		movq	-600(%rbp),	%rdi
		call	puts
		jmp	L218
L208:
		leaq	.LC23(%rip),	%rdi
		movq	%rdi,	-608(%rbp)
		movq	-608(%rbp),	%rdi
		call	puts
		movq	16(%rbp),	%rax
		cqto
		movq	$3,	%rbx
		idiv	%rbx
		movq	%rdx,	-616(%rbp)
		movq	-616(%rbp),	%rdx
		movq	$1,	%rcx
		cmp	%rdx,	%rcx
		je	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-624(%rbp)
		movq	-624(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L216
		leaq	.LC13(%rip),	%rdi
		movq	%rdi,	-632(%rbp)
		movq	-632(%rbp),	%rdi
		call	puts
		jmp	L218
L216:
		leaq	.LC14(%rip),	%rdi
		movq	%rdi,	-640(%rbp)
		movq	-640(%rbp),	%rdi
		call	puts
L218:
		add	$584,	%rsp
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
		sub	$32,	%rsp
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	$8
		call	allocmem
		add	$8,	%rsp
		mov	%rax,	-64(%rbp)
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-64(%rbp)
		call	func2
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-64(%rbp),	%rdx
		movq	%rdx,	-72(%rbp)
		movq	$0,	-80(%rbp)
L232:
		movq	-80(%rbp),	%rdx
		movq	$200000,	%rcx
		cmp	%rdx,	%rcx
		jg	1f
		movq	$0,	%rdx
		jmp	2f
1:
		movq	$1,	%rdx
		jmp	2f
2:
		movq	%rdx,	-88(%rbp)
		movq	-88(%rbp),	%rdx
		cmp	$0,	%rdx
		je	L241
		pushq	%rax
		pushq	%rcx
		pushq	%rdx
		pushq	%r8
		pushq	%r9
		pushq	%r10
		pushq	%r11
		pushq	-80(%rbp)
		call	func4
		add	$8,	%rsp
		popq	%r11
		popq	%r10
		popq	%r9
		popq	%r8
		popq	%rdx
		popq	%rcx
		popq	%rax
		movq	-80(%rbp),	%rdx
		add	$1,	%rdx
		movq	%rdx,	-80(%rbp)
		jmp	L232
L241:
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
