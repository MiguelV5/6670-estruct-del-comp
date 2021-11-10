
	.begin
	.org 8192
x	.equ 900
	addcc %r1, 4, %r1
	addcc %r2, 8, %r2
	addcc %r1, %r2, %r4
	st %r4, [x]
	halt
	.end

	
