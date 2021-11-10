.begin
a_start .equ 9000	
	.org 3000
	length:		20
	address:	a_start

	.org 1000
a:		25

	.org 2048

	ld [length], %g1
	ld [address], %g2
	ld [a], %g3
	
	and %g3, %r0, %r4
	sub %g3, %r1, %r5
 	and %r1, %r1, %r0
	add %r1, -4, %r7
	add %r1, %r2, %r6
	or %r1, %r2, %i8
	sub %r6, %r2, %r6
	add %r15, 4, %i7
	halt

	.end
