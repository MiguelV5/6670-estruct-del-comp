.begin
.org 2048
	ld [A], %r1
	ld [B], %r2
	addcc %r3, %r0, %r3
	call multiplicar
	st %r3, [C]
	
A:	2
B:	3
C:	0

multiplicar:
	andcc %r2, %r2, %r0
	be listo
	addcc %r3, %r1, %r3
	addcc %r2, -1, %r2
	ba multiplicar

listo: jmpl %r15+4, %r0

.end


