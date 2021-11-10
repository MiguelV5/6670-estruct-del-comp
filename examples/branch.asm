.begin
	ba callBranch

callReturn:	jmpl %r15+4, %r0

lbvs:	sethi 0x200000, %r1
	addcc %r1, %r1, %r1
	bvs callReturn

lbvc:	addcc %r0, %r0, %r0
	bvc lbvs

lbneg:	sethi 0x200000, %r1
	addcc %r0, %r1, %r2
	bneg lbvc

lbpos:	addcc %r0, %r0, %r0
	bpos lbneg

lbcs:	add %r0, -1, %r1
	addcc %r1, 50, %r3
	bcs lbpos

lbcc:	addcc %r0, %r0, %r0
	bcc lbcs

lbleu2:	add %r0, -3, %r1
	subcc %r1, -3, %r3
	bleu lbcc

lbleu1:	add %r0, 3, %r1
	subcc %r1, 8, %r3
	bleu lbleu2

lbgu:	add %r0, 0x1fff, %r1
	subcc %r1, 3, %r3
	bgu lbleu1

lbl:	add %r0, 3, %r1
	subcc %r1, 8, %r3
	bl lbgu

lbge2:	add %r0, 7, %r1
	subcc %r1, 3, %r3
	bge lbl

lbge1:	add %r0, 7, %r1
	subcc %r1, 7, %r3
	bge lbge2

lble2:	add %r0, -3, %r1
	subcc %r1, -3, %r3
	ble lbge1

lble1:	add %r0, 3, %r1
	subcc %r1, 8, %r3
	ble lble2

lbg2:	add %r0, -1, %r1
	subcc %r1, -5, %r3
	bg lble1

lbg1:	add %r0, 5, %r1
	subcc %r1, 2, %r3
	bg lbg2

lbe:	xorcc %r0, %r0, %r0
	be lbg1

lbn:	bn lbne

lbne:	addcc %r0,1,%r1
	bne lbe

lba:	ba lbn

callBranch:	call lba
	halt
.end
