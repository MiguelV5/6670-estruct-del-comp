	.begin
	.org 2048
a:	.dwb 100, 100
	.dwb 200
	add %r1, %r1, %r2
	halt
	.end
