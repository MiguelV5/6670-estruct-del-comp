!This program demonstrates macros.  Macros can be called with in macros,
!    as long as there is not a recursive loop. You can easily use macros
!    aaa and bbb to test this.  Add a call to aaa from bbb and the parser
!    will emmit an error.
!addxy implements: num = 3x - 2y + 5 (as long execMe <instr> does not
!    change a register value addxy is using.)
!addab implements: num = 2a + 2b, and it calls addxy a, b, num2
!Watch for decimal values of 10, 6, 4, and 5 in registers r19, r23, r27 and r31

.begin
.macro addxy x, y, num, instr
lab:	addcc x, x, %r20
	add %r20, x, %r20
	sll y, 1, %r21
	execMe <instr>
	sub %r20, %r21, %r20
	addcc %r20, 5, num
.endmacro

.macro addab a, b, num, num2, con
	add a, a, %r16 !This is a macro instrution
	add b, b, %r17
	add %r16, %r17, num
	addxy a, b, num2, <nop>
	ccc a, con, %r17
.endmacro

.macro execMe instr
	instr
.endmacro

.macro aaa
	add %g1, %g2, %g28
	bbb
.endmacro

.macro bbb
	add %g2, %g3, %g29
.endmacro

.macro ccc x, con, num
	add x, con, num
.endmacro

.macro recurs_add X
.if	X > 2
	recurs_add X-1
.endif
	addcc %r1, %rX, %r1
.endmacro

	one:		1
	two	:	2
	three:		3
	two_2	.equ	2
	eight_8	.equ	0x8

	.org 2048
a_start .equ 3000
	ld [one], %g1
	ld [two], %g2
	ld [three], %g3
	nop
	nop
mac:	addxy %r3, %r2, %r19, <add %g1, %g2, %g30> !Macro Use Comment
	nop
	nop
	execMe <add %g1, %g2, %g0>
	aaa
mac2:	addab %r1, %r2, %r23, %r27, eight_8
	nop
	nop
	ccc %r3, two_2, %r31
	recurs_add 4
	halt
	nop
	nop
	nop

	.end
