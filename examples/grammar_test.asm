!This is a test of the ARC grammar.  It was not made to be functional.
!To fully test the grammar, comment out .begin and .end separately and together, and
! also wrap various parts of the code as macros as well.
!This file was made with the guidance of ARC.jjt.  Each token and instruction format
! was incorporated into this program. Make sure the codes works inside and outside
! of .begin and .end regions and macros.

.begin

!Macro Grammar
	!Macro for passing an instruction in (through 'y' in this case).
.macro MyMacro x, y
macLab:	ta %r0,0
	y
	be macLab
	.noexpandmacro
	.expandmacro
.endmacro

.macro macLoop x
        add %r0, 5, %r5
loop:   ld [0], %r1
        add %r1,1,%r1
        st %r1, [0]
        subcc %r5, 1, %r5
        bne loop
        add x,x,%r0
.endmacro

	!Demos %hi and %lo
.macro set val, reg
	sethi %hi(val), reg
	add reg, %lo(val), reg
.endmacro

val	.equ	0x01234567
val2	.equ	0x89abcdef

	.noexpandmacro
	.expandmacro



!Opcodes
	.org 0x800
	nop
	.dwb 3
equ	.equ 8
	.dwb "h"

main:	jmpl %r0, logic, %r0
	nop
	halt
	sethi 0xdeaf, %r1
	ba main
	bn main
	be main
	bne main
	bg main
	ble main
	bge main
	bl main
	bgu main
	bleu main
	bcc main
	bcs main
	bpos main
	bneg main
	bvc main
	bvs main
	call main
	jmpl %r15, 4, %r0
logic:	srl %r0,%r0,%r17
	sll %r1,2,%r19
	sra %r2+2,%r20
	add %r3, 3,%r21
	and %r4, 3,%r22
	sub %r5, 3,%r23
	or  %r6, 3,%r24
	xor %r7, 3,%r25
	andn %r8, 3, %r26
	orn %r9, 3,%r27
	xnor %r10, 3, %r28
	addcc %r11, %r0,%r29
	andcc %r12, 3,%r30
	subcc %r13+ 3,%r31
	orcc  %r14, 3,%r3
	xorcc %r15, 3,%r1
	andncc %r16, 3, %r1
	orncc %r17, 3,%r1
	xnorcc %r18, 3, %r1
	ld [0],%r30
	ldsb [0], %r30
	ldsh [0], %r30
	ldub [0], %r30
	lduh [0], %r30
	st %r31, [80]
	stb %r31, [80]
	sth %r31, [80]
	rd %tbr, %r12
	wr %r12, 0, %psr
	ta %r0, 0
	rett %r16, 4
	not %r1, %r3
	neg %r1, %r3
	inc %r1
	dec %r1
	clr %r1
	cmp %r1, %r2
	cmp %r1, 10
	tst %r1
	mov %r1, %r3
	mov 9, %r3

!Symbols Test (i.e. '(', '+'...)
	add %r0 + (4*8/0x2)-110b, %r4
	.expandmacro
	MyMacro %r0, <nop>
asmLab:	MyMacro %r0, <nop>
	add %r0, %g0,%i0
	add %r0, 10010b, %r3
	add %r0, 0x1bf8, %r4

!Instruction format
	!Arithmetic
	add %r1, %r2, %r3
	sub %r1, 6, %r4
	srl %r1 + 10, %r4
	addcc %r1, %r2, %r3
	addcc %r1, 7, %r3
	wr %r1, %r2, %psr
	wr %r1, 0xc, %psr
	rd %psr, %r1
	rd %tbr, %r1
	rett %r1, %r3
	ta %r0,0

	!Memory
	ld 12, %r1, %r3
	ld 12 + %r1, %r3

	ld %r1, [12], %r3
	ld %r1, [%r2], %r3

	ld %r1, 12, %r3
	ld %r1, %r2, %r3
	ld %r1 + 12, %r3
	ld %r1 + %r2, %r3

	ld %r1, %r3

	ld [%r1], %r3
	ld [%r1]12, %r3

	ld [%r1], %r3
	ld [%r1, 12], %r3
	ld [%r1, %r2], %r3
	ld [%r1 + 12], %r3
	ld [%r1 + %r2], %r3

	ld [12], %r3
	ld [12, %r1], %r3
	ld [12 + %r1], %r3

	ld %r4, %r3
	ld %r4, -4, %r3
	ld [%r4 + 4],  %r3
	ld [4 + %r4],  %r3
	ld [%r4],  %r3
	ld [%r4]5 ,  %r3

	!Conditional Code
.macro mac_cond val1, val2, num
	clr num
	.if val1 == val2
	add num, 1, num
	.endif
	.if val1 != val2
	add num, 2, num
	.endif
	.if val1 > val2
	add num, 3, num
	.endif
	.if val1 < val2
	add num, 4, num
	.endif
	.if val1 >= val2
	add num, 5, num
	.endif
	.if val1 <= val2
	add num, 6, num
	.endif
.endmacro
one_a:	nop
two_a:	nop
	.if one_a == two_a
	add %r31, 1, %r31
	.endif
	.if one_a != two_a
	add %r31, 2, %r31
	.endif
	.if one_a > two_a
	add %r31, 3, %r31
	.endif
	.if one_a < two_a
	add %r31, 4, %r31
	.endif
	.if one_a >= two_a
	add %r31, 5, %r31
	.endif
	.if one_a <= two_a
	add %r31, 6, %r31
	.endif
one_b:	nop
two_b:	nop
	mac_cond one_b, two_b, %r31

	macLoop %r1

	! %hi and %lo
	sethi %hi(val), %r1
	add %r1, %lo(val), %r1
	set val2, %r2

	halt
.end

.begin
.end
