	.file	"foo1.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.ascii	"Command line must have 1-st arguement (int (bool) value - 1,"
	.ascii	" 2 or 3) - 1 - if user wants to input a number himself"
	.string	", 2 - generate a double number, 3 - take a number from input file; 2-nd & 3-rd parameters - full names of input & output files. The fourth arguement is double value: in 1-st case it is a number, in the 2-nd - seed of the generator, in the 3-rd - any value."
.LC2:
	.string	"r"
.LC3:
	.string	"%lf"
.LC5:
	.string	"w"
.LC6:
	.string	"initial number: %lf\n"
.LC7:
	.string	"answer: %lf\n"
.LC8:
	.string	"TIME: %lf sec\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	cmp	DWORD PTR -84[rbp], 5
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L9
.L2:
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR -48[rbp], xmm0
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L4
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	esi, 0
	mov	rdi, rax
	call	strtod@PLT
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	jmp	.L5
.L4:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 2
	jne	.L6
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -72[rbp], eax
	mov	eax, DWORD PTR -72[rbp]
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
	movsd	QWORD PTR -64[rbp], xmm0
	mov	eax, DWORD PTR -72[rbp]
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
	movsd	xmm0, QWORD PTR -64[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -64[rbp], xmm0
	jmp	.L5
.L6:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	lea	rdx, -64[rbp]
	mov	rax, QWORD PTR -40[rbp]
	lea	rcx, .LC3[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L5:
	call	clock@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	findCubicRoot@PLT
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	mov	DWORD PTR -68[rbp], 3000000
	mov	DWORD PTR -76[rbp], 0
	jmp	.L7
.L8:
	mov	rax, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	findCubicRoot@PLT
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	add	DWORD PTR -76[rbp], 1
.L7:
	mov	eax, DWORD PTR -76[rbp]
	cmp	eax, DWORD PTR -68[rbp]
	jl	.L8
	call	clock@PLT
	sub	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -32[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR .LC4[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -56[rbp]
	movq	xmm0, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L9:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	-350469331
	.long	1057634018
	.align 8
.LC4:
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
