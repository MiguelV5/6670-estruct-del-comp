	.begin
	.org 2048
	andcc %r1, 55, %r1
	orncc %r1, 55*2, %r1
	orcc %r2, 123,%r5
	xorcc %r2, -1, %r3
	halt
	.end
