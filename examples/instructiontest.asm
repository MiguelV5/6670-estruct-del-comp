!This is an example of all the instructions and
!their syntax.
!Stepping through the execution of this program
!and understanding what's happening with each instruction
!is a good instructional exercise
!Assembly line arithmetic is implemented.
!Any argument with a constant can use assembly line arithmetic

	.begin
	.org 2048
x .equ 24
!Assembly line arithmetic
	ld [x+2*x-24], %r1
	ld %r1 +4+44-4*3, %r2
	!ld %r1+3, %r3, %r4 !INCORRECT %r4 is not a constant
	add %r1, x+4*x, %r2

!ld and store 
!memory accesses have to be word aligned
!These three instructions are identical
	ld [x], %r2
	ld %r0, [x], %r2
	ld %r0+x, %r2
	ld [%r0+x], %r2

!These three instructions are identical
	ld %r2, %r3
	ld %r2 + %r0, %r3
a: 	ld %r2, %r0, %r3

	or %r0, 16, %r2	!moves the value 16 into r2

b: 	
	st %r2, [a]
c: 	st %r2, %r0, [b]
   	st %r2, %r0+c
	st %r2, [%r0+c]

	st %r2, %r0
	st %r2, %r0, %r2
	st %r1, %r3+%r2

	or %r0, 15, %r1
	st %r1, %r3+%r1 !%r1 is not word aligned so 
		  	  !a warning will be issued, execution will stop
		  	  !and 0 will be store into the destination address


	sethi 0x304f15, %r1 !Sets bits 31:10 of %r1 to 0x304f15

	!Logical operations only modify the negative and zero flags
	
	orn %r0, %r0, %r1 !sets %r1 to all ones
	
	andcc %r1, %r2, %r3
	andcc %r1, 0xff, %r2

	orcc %r0, %r2, %r1
	orcc %r0, 0x43, %r1
	
	orncc %r1, %r0, %r1
	orncc %r3, 34, %r1

	xorcc %r1, %r1, %r1 !This should set %r27 to 0
	xorcc %r1, 45, %r1

	and %r1, %r1, %r1
	and %r1, 23, %r3

	or %r0, %r3, %r1
	or %r0, 1, %r1

	orn %r1, %r0, %r1
	orn %r1, 34, %r1

	xor %r1, %r0, %r1
	xor %r1, 45, %r1


	sethi  0x200000, %r1 !sets the msb of %r1 to 1
	sra %r1, 5, %r2
	sethi  0x1fffff, %r1 !Sets the msb %r1 to 0
	or %r0, 8, %r2
	sra %r1, %r2, %r2
	srl %r1, %r2, %r2
	srl %r1, %r5, %r2
	or  %r0,   8, %r1
	sll %r1, 3, %r2
	sll %r1, %r2, %r2

	addcc %r1, 5, %r1
	addcc %r1, %r4, %r1
	add %r1, 5, %r1
	add %r1, %r5, %r1
	subcc %r1, 5, %r1
	subcc %r1, %r2, %r1
	sub %r1, 5, %r1
	sub %r1, %r7, %r1
	
	ba belowBranch
ljmp:	jmpl %r15 +4, %r0

lbne:	subcc %r1, 3000, %r1
	bne ljmp

lbcc:	bcc lbne

lbpos:	bpos lbcc

lbvc:	bvc lbpos

lbe:	subcc %r1, %r1, %r1
	be lbvc

lbneg:	bneg lbe

lbcs:	sethi 0x300000, %r1
	addcc %r1, %r1, %r1
	bcs lbneg

lbvs:	sethi 0x200000, %r1
	subcc %r1, 0x0fff, %r1
	bvs lbcs
	
belowBranch: call lbvs
!The operand of branch is always divided by 4 and subtracted from the PC.
!So if you are going to enter an absolute address just enter the address
!and the compiler will do the math.
!So ba 0x100 will branch to address 0x100 if it can.

halt
sethi 0xffffffff, %r1
sethi 4194303,  %r1
sethi -1, %r1 
sethi 11111111111111111111111111111111b, %r1

ba 0xfffffffc !0x3fffff is 22bits but it's not word aligned
ba 4194304/2 - 4
ba -4194304/2
ba 11111111111111111111111111111100b

call 0xfffffffc !0x3fffffff is 30 bits but not word aligned
call 1073741824/2-4
call -1073741824/2
call 11111111111111111111111111111100b

add %r1, 4095, %r1
add %r1, -4096, %r1
add %r1, 0xffffffff, %r1
add %r1, 11111111111111111111111111111111b, %r1

!LD and ST are the same
ld [4095], %r1
ld [-4096], %r1
ld [0xffffffff], %r1
ld [11111111111111111111111111111111b], %r1

halt

.end
