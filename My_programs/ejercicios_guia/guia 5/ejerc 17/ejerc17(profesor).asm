!17.-	Un programa recibe a través de %r20 una palabra de 32 bits que representa dos números en complemento a 2 
! en sus dos bytes más significativos y en sus dos bytes menos significativos
! respectivamente. Proponer un código para ese programa tal que devuelva (también por %r20) la suma de ambos
! valores recibidos.
! Considere el manejo de condiciones de fuera de rango si lo considera necesario.

!Para aislar los dos operandor utilizo máscaras y rotación de bits.

!Para sumarlos ubico a los dos números en los 16 bits menos significativos

!Para el manejo de fuera de rango como si se tratara de números de 16 bits los ubico a los dos
!en los 16 bits más significativos para recurrir al bit de overflow del $psr

	.begin
	.org 2048
	andcc %r10,%r0,%r10	!%r10 indica con 0 que no hay overflow y con 1 que hay overflow
	ld [A],%r20		!leo el dato en %r20       				AB
	ld [B],%r3		!leo %r3 máscara para 16 bits bajos
	ld [C],%r4		!leo %r4 máscara para 16 bits altos 
	andcc %r20,%r3,%r1	!16 bits menos significativos   	0B
	andcc %r20,%r4,%r2	!16 bits mas significativos     	A0
	srl %r2,16,%r5	!rotación de 16 bits a la derecha    	0A
	sll %r1,16,%r6	!rotación de 16 bits a la izquierda  	B0 
	addcc %r1,%r5,%r20	!%r20 tiene la suma				 0B+0A	
	addcc %r6,%r2,%r0	!%r20 tiene la suma				 B0+A0
	bvs over		!overflow
	ba fin
over:	addcc %r10,1,%r10
	ba fin
A: 	0xcd8eAf79		!dato  para que de overflow: 0xcd8eAf79     sin overflow: 0xcd8eff79
B:	0x0000ffff		!máscara para 16 bits bajos	  
C:	0xffff0000		!máscara para 16 bits altos
fin:	nop
	.end
