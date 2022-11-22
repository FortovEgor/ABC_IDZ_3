	.file	"foo1.c"
	.intel_syntax noprefix
	.text
	.globl	absCustom
	.type	absCustom, @function
absCustom:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR -8[rbp]
	jbe	.L7
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	xmm1, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	jmp	.L5
.L7:
	movsd	xmm0, QWORD PTR -8[rbp]
.L5:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	absCustom, .-absCustom
	.globl	findCubicRoot
	.type	findCubicRoot, @function
findCubicRoot:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	QWORD PTR -48[rbp], xmm1
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	jmp	.L9
.L12:
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -20[rbp], 1
	jmp	.L10
.L11:
	movsd	xmm0, QWORD PTR -16[rbp]
	divsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -20[rbp], 1
.L10:
	cmp	DWORD PTR -20[rbp], 2
	jle	.L11
	movsd	xmm0, QWORD PTR -16[rbp]
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
.L9:
	movsd	xmm0, QWORD PTR -8[rbp]
	subsd	xmm0, QWORD PTR -16[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	call	absCustom
	movq	rax, xmm0
	movq	xmm2, rax
	comisd	xmm2, QWORD PTR -48[rbp]
	jnb	.L12
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	findCubicRoot, .-findCubicRoot
	.section	.rodata
	.align 8
.LC4:
	.ascii	"Command line must have 1-st arguement (int (bool) value - 1,"
	.ascii	" 2 or 3) - 1 - if user wants to input a number himself"
	.string	", 2 - generate a double number, 3 - take a number from input file; 2-nd & 3-rd parameters - full names of input & output files. The fourth arguement is double value: in 1-st case it is a number, in the 2-nd - seed of the generator, in the 3-rd - any value."
.LC6:
	.string	"r"
.LC7:
	.string	"%lf"
.LC9:
	.string	"w"
.LC10:
	.string	"initial number: %lf\n"
.LC11:
	.string	"answer: %lf\n"
.LC12:
	.string	"TIME: %lf sec\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 5
	je	.L15
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L22
.L15:
	movsd	xmm0, QWORD PTR .LC5[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L17
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	esi, 0
	mov	rdi, rax
	call	strtod@PLT
	movq	rax, xmm0
	mov	QWORD PTR -80[rbp], rax
	jmp	.L18
.L17:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 2
	jne	.L19
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -36[rbp], eax
	mov	eax, DWORD PTR -36[rbp]
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 715827883
	shr	rax, 32
	sar	eax
	mov	esi, edx
	sar	esi, 31
	sub	eax, esi
	mov	ecx, eax
	mov	eax, ecx
	add	eax, eax
	add	eax, ecx
	sal	eax, 2
	mov	ecx, edx
	sub	ecx, eax
	lea	eax, 7[rcx]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movsd	QWORD PTR -80[rbp], xmm0
	mov	eax, DWORD PTR -36[rbp]
	add	eax, 1
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 2021161081
	shr	rdx, 32
	sar	edx, 3
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	mov	ecx, edx
	sal	ecx, 4
	add	ecx, edx
	sub	eax, ecx
	mov	edx, eax
	lea	eax, 3[rdx]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm0, QWORD PTR -80[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -80[rbp], xmm0
	jmp	.L18
.L19:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	lea	rdx, -80[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rcx, .LC7[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L18:
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	findCubicRoot
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -52[rbp], 3000000
	mov	DWORD PTR -12[rbp], 0
	jmp	.L20
.L21:
	mov	rax, QWORD PTR -80[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	findCubicRoot
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	add	DWORD PTR -12[rbp], 1
.L20:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -52[rbp]
	jl	.L21
	call	clock@PLT
	sub	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -48[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -64[rbp], xmm0
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC9[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC7[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -72[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -80[rbp]
	movq	xmm0, rax
	lea	rax, .LC10[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC11[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	lea	rax, .LC12[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L22:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC2:
	.long	0
	.long	1074266112
	.align 8
.LC3:
	.long	0
	.long	1071644672
	.align 8
.LC5:
	.long	-350469331
	.long	1057634018
	.align 8
.LC8:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
