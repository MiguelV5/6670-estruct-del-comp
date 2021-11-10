!This tests loading signed/unsigned bytes and halfwords from memory
! and loading words from memory
.begin
	.org 0
len:	-1
len2:	20
len3:	0x01234567
len4:	0x89abcdef

	.org 0x800
main:	ba ld_sb
other:	ld [len], %r1
	ld %r6, [len], %r2
	ld %r0+len, %r3 
	ld %r0+%r1, %r3
	ld %r0, %r1, %r3
	ld [len2], %r4
	ld %r2, [len2], %r5
	ld [len2], %r6
	ld %r1, %r2
	halt

	nop
	nop

	!ldsb
ld_sb:	ldsb [len4+0], %r1
	ldsb [len4+1], %r2
	ldsb [len4+2], %r3
	ldsb [len4+3], %r4
	nop
	ldsb [len3+0], %r1
	ldsb [len3+1], %r2
	ldsb [len3+2], %r3
	ldsb [len3+3], %r4
	nop
	!ldsh
	ldsh [len4+1], %r1
	ldsh [len4+0], %r1
	ldsh [len4+2], %r2
	ldsh [len3+0], %r3
	ldsh [len3+2], %r4
	nop
	!ldub
	ldub [len4+0], %r1
	ldub [len4+1], %r2
	ldub [len4+2], %r3
	ldub [len4+3], %r4
	nop
	ldub [len3+0], %r1
	ldub [len3+1], %r2
	ldub [len3+2], %r3
	ldub [len3+3], %r4
	nop
	!lduh
	lduh [len4+1], %r1
	lduh [len4+0], %r1
	lduh [len4+2], %r2
	lduh [len3+0], %r3
	lduh [len3+2], %r4
	ba other
	halt
.end
