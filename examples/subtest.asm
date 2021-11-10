	.begin
	.org 2000
a_start .equ 3000
	ld [one], %g1
	ld [two], %g2
	ld [three], %g3
	ld [minus1], %g4
	ld [almost], %g5
	
	subcc %g4,%g5,%g6
	subcc %g5,%g4,%g9
	subcc %g6,%g5,%g7
	halt
	nop
	nop
	nop


		
.org 3000
one:		1
two	:	2
three:		3
minus1:		-1
almost:		2147483647

	.end
