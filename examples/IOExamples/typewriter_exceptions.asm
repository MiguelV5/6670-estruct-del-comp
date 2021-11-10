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
Keyboard_Trap	.equ 0xff000150	!Keyboard IO trap table entry
Keyboard_ISR	.equ 0xff001000	!Keyboard interrupt service routine
CRT_Trap	.equ 0xff000160	!CRT IO trap table entry
CRT_ISR		.equ 0xff002000	!CRT interrupt service routine
Buff		.equ 3000

		.org 2048
!Global Variables
BuffPtr:	Buff
Enter:		0

		!Place memory mapped I/O region base address in %r4
main:		add %r0, %r0, %r4	!Clear r4
		sethi BASE, %r4		!Place the I/O memory region base address in r4

		! Enable traps
		rd %psr, %r1		!Read %psr
		or %r1, 0x20, %r1	!Set ET bit (enable traps)
		wr %r1, %r0, %psr	!Write %psr

		!Enable KeyBoard Interrupts
		ldub [%r4 + CICTL], %r1	!Load CICTL
		or %r1, 0x20, %r1	!Set enable interrupt bit
		stb %r1, [%r4 + CICTL]	!Store CICTL

! Busy wait for the 'Enter' variable to go high
Loop:		inc %r31
		ld [Enter], %r1
		cmp %r1, 0		!If 'Enter' is still zero
		be Loop			!Then continue waiting

		!Disable Keyboard Interrupts
		ldub [%r4 + CICTL], %r1	!Load CICTL
		not %r1, %r1		!Not CICTL
		or %r1, 0x20, %r1	!Clear enable interrupt bit
		not %r1, %r1		!Not CICTL
		stb %r1, [%r4 + CICTL]	!Store CICTL

		!Reset 'Enter' and 'BuffPtr'
		st %r0, [Enter]		!Reset 'Enter'
		add %r0, Buff, %r1
		st %r1, [BuffPtr]	!Reset 'BuffPtr'

		!Enable Printer Interrupts
		ldub [%r4 + COSTAT],%r1	!Load COSTAT
		or %r1, 0x20, %r1	!Set enable interrupt bit
		stb %r1, [%r4, COSTAT]	!store COSTAT
		ba Loop
		
End:		halt			!Exit Program

!KeyBoard Trap and ISR:
		.org Keyboard_Trap
		ba Keyboard_ISR		!goto keyboard ISR

		.org Keyboard_ISR
		ldub [%r4 + CIN], %r2	!Load waiting char
		ld [BuffPtr], %r3	!Load buffer pointer
		st %r2, [%r3+0]		!Store char in buffer
		add %r3, 4, %r3		!Increment buffer pointer
		st %r3, [BuffPtr]	!Store buffer pointer
		cmp %r2, 0xa		!Compare char to 'new line'
		bne KB_End		!If Enter pressed
		add %r0,1,%r3
		st %r3, [Enter]		!Then store 1 to 'Enter'

KB_End:		rett %r16, 4		!Return to the next pc location

!CRT Trap and ISR:
		.org CRT_Trap
		ba CRT_ISR

		.org CRT_ISR
		ld [BuffPtr], %r2	!Load buffer pointer
		ld %r2, %r3		!Load char from buffer
		add %r2, 4, %r2		!Increment buffer pointer
		st %r2, [BuffPtr]

		cmp %r3, 0xa		!Compare char to 'new line'
		be CRT_Enter		!If 'new line' found goto CRT_Enter
		ba CRT_End		!Goto exit ISR

CRT_Enter:	add %r0, Buff, %r2	!Reset buffer pointer
		st %r2,[BuffPtr]
		ldub [%r4, CICTL], %r2	!Load CICTL and enable interrupts
		or %r2, 0x20, %r2
		stb %r2, [%r4, CICTL]
		ldub [%r4, COSTAT], %r2	!Load COSTAT and disable interrupts
		not %r2, %r2
		or %r2, 0x20, %r2
		not %r2, %r2
		stb %r2, [%r4, COSTAT]

CRT_End:	stb %r3, [%r4 + COUT]	!Store char into COUT
		rett %r16, 4		!Exit ISR


		.end
