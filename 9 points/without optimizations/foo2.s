	.file	"foo2.c"
	.intel_syntax noprefix
	.text
	.globl	absCustom
	.type	absCustom, @function
absCustom:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
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
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	absCustom, .-absCustom
	.globl	findCubicRoot
	.type	findCubicRoot, @function
findCubicRoot:
.LFB1:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	QWORD PTR -48[rbp], xmm1
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	jmp	.L9
.L12:
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -20[rbp], 1
	jmp	.L10
.L11:
	movsd	xmm0, QWORD PTR -8[rbp]
	divsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -20[rbp], 1
.L10:
	cmp	DWORD PTR -20[rbp], 2
	jle	.L11
	movsd	xmm0, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
.L9:
	movsd	xmm0, QWORD PTR -16[rbp]
	subsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	call	absCustom
	movq	rax, xmm0
	movq	xmm2, rax
	comisd	xmm2, QWORD PTR -48[rbp]
	jnb	.L12
	movsd	xmm0, QWORD PTR -16[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	findCubicRoot, .-findCubicRoot
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
