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
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r12
	push	r13
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi  # argc
	# mov	QWORD PTR -96[rbp], rsi  # argv
	mov	r12, rsi  #  теперь argv лежит в регистре, а не на стеке по адресу rbp-96
	cmp	DWORD PTR -84[rbp], 5
	
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L9
.L2:
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR -24[rbp], xmm0  # будет описано ниже 
	mov	rax, r12
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L4
	mov	rax, r12
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	esi, 0  # 2-ой аргумент функции
	mov	rdi, rax  # первый аргумент ф-ии
	call	strtod@PLT
	movq	rax, xmm0  # xmm0 - в нем лежит посчитанное значение
	mov	QWORD PTR -80[rbp], rax  # по адресу rbp-80 лежит seed
	jmp	.L5
.L4:
	mov	rax, r12
	add	rax, 8
	mov	rax, QWORD PTR [rax]  
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 2
	jne	.L6
	mov	rax, r12
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -36[rbp], eax  # seed лежит по адресу rbp-36
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
	jmp	.L5
.L6:
	mov	rax, r12
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax  # по адресу rbp-32 лежит input
	lea	rdx, -80[rbp]  # по адресу rbp-80 лежит num
	mov	rax, QWORD PTR -32[rbp]
	lea	rcx, .LC3[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L5:
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax  # по адресу rbp-48 лежит t
	mov	rax, QWORD PTR -80[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]  # по адресу rbp-24 лежит eps
	movapd	xmm1, xmm0  # eps
	movq	xmm0, rax  # num
	call	findCubicRoot@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax  # по адресу rbp-8 лежит result
	mov	DWORD PTR -52[rbp], 3000000  # по адресу rbp-52 лежит iterations_num
	mov	DWORD PTR -12[rbp], 0  # по адресу rbp-12 лежит счетчик цикла i
	jmp	.L7
.L8:
	# блок кода ниже - это цикл for, выполняющийся 3М раз
	mov	rax, QWORD PTR -80[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	findCubicRoot@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax  # result 
	add	DWORD PTR -12[rbp], 1  # ++i
.L7:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -52[rbp]
	jl	.L8
	call	clock@PLT
	sub	rax, QWORD PTR -48[rbp]  # по адресу rbp-48 лежит t
	mov	QWORD PTR -48[rbp], rax  # обновили значение t
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR .LC4[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -64[rbp], xmm0  # по адресу rbp-64 лежит time_taken
	mov	rax, r12
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rdx
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	rax, QWORD PTR -72[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -80[rbp]
	movq	xmm0, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L9:
	pop	r13
	pop	r12
	leave
	ret
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
