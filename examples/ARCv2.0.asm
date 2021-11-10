!This demonstrats a few new features of ARCTools v2.0
!A number of arrays are defined at addr 0.
!The program loads values from one array, calls a macro to double its value,
! and stores the result in the other array. The program also test conditional
! assembly code.

.begin
.macro mac x, num
lab:	add x,x,num
.endmacro

.macro mac2 val1, val2, num
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

.macro mac3 x, num
	.if x != 40
	add %r0,%rx, num
	.endif
.endmacro
.end

	.begin
	.org 2048
a_start .equ 0
array_size .equ 8
five	.equ	5
seven	.equ	7

doWork:	orcc %r0, array_size, %r1 !CLEARS THE FLAGS
	ld [a], %r1
	ld [a+4], %r2
	ld [a+8], %r3
	mac %r1, %r5
lab:	mac %r2, %r6
	mac %r3, %r7
	st %r5,[array]
	st %r6,[array+4]
	st %r7,[array+8]
	jmpl %r15 + 4, %r0

main:	call doWork
	rd %psr, %r1
	rd %psr, %r11
	rd %tbr, %r10
	wr %r0, 0x420, %psr
	wr %r0, %r11, %psr


	mac2 five, seven, %r28
	mac2 five, five, %r29
	mac2 seven, five, %r30

	.if five==5
	.if five >= 4
	add %r2, 5, %r24
	.endif
	.endif
	.if seven != 5
	add %r3, 7, %r25
	.endif

	mac3 five-2, %r26
	halt

	.org a_start
array:	.dwb	array_size
a:	47, -10
	33, -5, 7
b:	a_start
c:	a, b

	.end
