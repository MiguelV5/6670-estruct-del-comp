	.begin
	.org 2048
	ld [A], %r1
	ld [B], %r2
	addcc %r1, %r2, %r3
	st %r3, [C]
A:	2
B:	8
C:	0
	.end
