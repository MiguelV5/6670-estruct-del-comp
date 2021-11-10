	.begin
	.org 2048

	ld [x], %r1
	sethi 0, %r1

	ld [x], %r2	!load -1 into %r2
	sethi 0x3fffff, %r2 !value too big
	
	halt
.org 3000
x:	-1
	.end
