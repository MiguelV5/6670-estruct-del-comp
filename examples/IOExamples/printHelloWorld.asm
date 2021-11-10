! Prints "Hello, world!\n" in the msgarea.
! SRCTools version: vph 6/29/00, updated rez 4/16/02
! ARCTools version: mww converted 6/17/05

	.begin
BASE	.equ 0x3fffc0		!Starting point of the memory mapped region
COUT	.equ 0x0		!0xffff0000 Console Data Port
COSTAT	.equ 0x4		!0xffff0004 Console Status Port.

	.org 2048
	add %r0, %r0, %r2
	add %r0, %r0, %r4
	sethi BASE, %r4
Loop:	ld [%r2 + String], %r3	!Load next char into r3
	addcc %r3,%r0,%r3
	be End			! stop if null.
Wait:	ldub [%r4+COSTAT], %r1
	andcc %r1, 0x80, %r1
	be Wait
	stb %r3, [%r4+COUT]	!Print to console
	add %r2, 4, %r2		!increment String offset (r2)
	ba Loop
End:	halt

	.org 3000
! The "Hellow, world!" string
String:	0x48, 0x65, 0x6c, 0x6c, 0x6f
	0x2c, 0x20, 0x77, 0x6f, 0x72 
	0x6c, 0x64, 0x21, 0x0a, 0

	.end
		
