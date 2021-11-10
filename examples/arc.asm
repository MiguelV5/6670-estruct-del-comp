!This declares an array of size 5 using literal definitions then
!stores it into an array of size 5 using .dwb

	.begin
	.org 2048
a_start .equ 3000
array_size .equ 5

	orcc %r0, array_size, %r1 !CLEARS THE FLAGS
	sub %r1, 1, %r1
	xor %r31, %i31, %g31
	sll %r1, 2, %r1
loop:	
	ld %r1, [a], %r5
	st %r5, %r1, [array]
	sub %r1, 4, %r1
	be done
	subcc %r1, 0, %r0	
	ba loop
done:	
	halt
	.org a_start
array:	.dwb	array_size
a:	47, -10, 33, -5, 7

	.end
