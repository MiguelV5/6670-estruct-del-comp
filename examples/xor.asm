	.begin
	.org 2048
a_start .equ 3000
	ld [length], %g1
	ld [address], %g2

	xorcc %g1, %g2, %g3
	halt
	
length:		0x11
address:	0x12

	.end
