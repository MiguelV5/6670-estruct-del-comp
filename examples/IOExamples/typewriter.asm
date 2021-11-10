! typewriter.asm
! Echoes typed characters in the msgarea.
! SRCTools version: vph 6/29/00
! ARCTools version: mww converted 6/17/05

		.begin
BASE    .equ 0x3fffc0           !Starting point of the memory mapped region
COUT    .equ 0x0                !0xffff0000 Console Data Port
COSTAT  .equ 0x4                !0xffff0004 Console Status Port.
CIN	.equ 0x8		!0xffff0008 Keyboard Data Port
CICTL	.equ 0xc		!0xffff000c Keyboard Control Port

		.org 2048
		add %r0, %r0, %r4	!Clear r4
		sethi BASE, %r4

InWait:		ldub [%r4 + CICTL], %r1
		andcc %r1, 0x80, %r1
		be InWait

		ldub [%r4 + CIN], %r3
		subcc %r3, 27, %r5	! 27 is Escape
		be End			! stop if it is.

Wait:		ldub [%r4 + COSTAT], %r1
		andcc %r1, 0x80, %r1
		be Wait
		stb %r3, [%r4 + COUT]
		ba InWait

End:		halt
		.end
		
