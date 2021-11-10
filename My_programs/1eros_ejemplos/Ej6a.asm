!6a.-	Un programa ARC declara dos variables y luego invoca una rutina que obtiene la suma de ambas. Escribir tres versiones del programa principal y de la rutina 
!	considerando diferentes convenciones para el pasaje de parámetros (a) por registros (b) por pila (c) por área reservada de memoria 

!POR REGISTRO

	.begin
	.org 2048
C	.equ 2076
	ld [A], %r1
	ld [B], %r2
	call suma
	st %r3,[C]
	
A:	2
B:	3



suma:	addcc %r1, %r2, %r3
	jmpl %r15+4,%r0
	.end
