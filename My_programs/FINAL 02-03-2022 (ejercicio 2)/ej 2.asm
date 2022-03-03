! ENUNCIADO
! Un periférico mapeado en la dirección A7220350h entrega palabras de 32 bits que comprenden dos numeros enteros
! signados en sus 16 bits más significativos y en sus 16 bits menos significativos respectivamente. Esta
! palabra de 32 bits es pasada vía stack a una rutina que se encarga de separar ambos numeros y devolverlos
! por stack representados en 32 bits. Cada uno de los valores leidos se guarda en un arreglo de 48 elementos
! que es declarado por el mismo programa. Cuando la capacidad del arreglo se agota el programa termina.
! Programa principal y subrutina deben ser declarados en el mismo módulo.

! A7220350h = 1010 0111 0010 0010 0000 0011 0101 0000
!  =>         1010011100100010000000 | 1101010000
!               cte22 = 29C880h          cte10 = 350h   

.begin
.org 2048

.macro push RegAAlmacenar   
    add %r14, -4, %r14              
    st RegAAlmacenar, %r14, %r0
.endmacro

.macro pop RegALoadearAntesDePopear
    ld %r0, %r14, RegALoadearAntesDePopear   
    add %r14, 4, %r14              
.endmacro

add %r15, %r0, %r30

sethi 29C880h, %r1
add %r1, 350h, %r1

add %r0, Array, %r2
add %r0, 192, %r3

cargaDeArray:   addcc %r3, -4, %r3
    bneg arrayLleno

    ld %r0, %r1, %r4
    push %r4
    call separarNumeros

    pop %r5
    st %r5, %r2, %r3

    addcc %r3, -4, %r3
    bneg arrayLleno

    pop %r6
    st %r6, %r2, %r3
    
    ba cargaDeArray

separarNumeros: pop %r7
    sra %r7, 16, %r8
    push %r8
    sll %r7, 16, %r9
    sra %r9, 16, %r9
    push %r9
    jmpl %r15, 4, %r0


arrayLleno: jmpl %r30, 4 , %r0

Array:  .dwb 48

.end
