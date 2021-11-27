    .begin
    .org 2048

    .macro push RegistroAAlmacenar   
        addcc %r14, -4, %r14              !disminuye la direccion a la que apunta (el stack crece al reves de como crecen las posiciones de memora)
        st RegistroAAlmacenar, %r14      !almaceno lo que se pide
    .endmacro

    .macro pop
        addcc %r14, 4, %r14               !aumenta la direccion a la que apunta el stack pointer
    .endmacro


        ld [x], %r1
        push %r1
        call determinarSiEsNegativo
        ld %r14, %r2    !cargo lo que hay en el tope del stack (deberia ser el resultado)
        pop             !ya se puede liberar
        st %r2, [result]    !lo almaceno en la direccion result

        ba fin                          !termina el programa


x:  -7
result: 0

determinarSiEsNegativo:   
        
        ld %r14, %r3    
        pop
        addcc %r3, %r0, %r3
        bneg fueNegativo
        ba fuePositivo


fuePositivo:
    push %r0
    jmpl %r15+4, %r0

fueNegativo:
    add %r0, 1, %r5
    push %r5
    jmpl %r15+4, %r0


fin:
    .end
