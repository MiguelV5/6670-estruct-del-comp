.begin
	one:		1
	two	:	2
	three:		3
	minus1:		-1
	almost:		2147483647
	max:		4294967295
	
	.org 2048
a_start .equ 3000
	ld [one], %g1
	ld [two], %g2
	ld [three], %g3
	ld [minus1], %g4
	ld [almost], %g5
	ld [max], %g9
	add %g5,%g5,%g7
	addcc %g5,%g5,%g6
	addcc %g6,%g6,%g7
	addcc %g9,%g9,%g10
      	srl %g4, 1, %r8
	halt
	nop
	nop
	nop

	.end
