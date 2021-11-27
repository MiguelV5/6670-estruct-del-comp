    .begin

    .macro push RegistroAAlmacenar   
        addcc %r14, -4, %r14              !disminuye la direccion a la que apunta (el stack crece al reves de como crecen las posiciones de memora)
        st RegistroAAlmacenar, %r14      !almaceno lo que se pide
    .endmacro

    .macro pop
        addcc %r14, 4, %r14               !aumenta la direccion a la que apunta el stack pointer
    .endmacro

    .org 2048

        ld [x], %r1

        push %r1        !se pasa parametro por stack
        call absDeEnteroEnComplementoADos
        ld %r14, %r2    !carga a r2 lo que está en el stack (deberia ser el resultado)
        pop
        st %r2, [result_x]  !se almacena en RAM

        ba fin


absDeEnteroEnComplementoADos:   
        ld %r14, %r6        !Se obtiene el valor pasado por stack
        addcc %r6, %r0, %r6     !trigger para el flag negativo
        bneg calcularComplementoADos
        jmpl %r15+4, %r0        !Devuelve sin hacer push del resultado porque si no era negativo el abs es el mismo numero que se pusheo originalmente como parametro


calcularComplementoADos:
        ld %r14, %r7        !Se obtiene el valor pasado por stack (es el mismo de r6 pero se pedia pasar por stack y no por registro)
        pop
        xor %r7, -1 , %r7   !Se invierten los bits del dato (Complemento a la base menos uno)
        add %r7, 1, %r7     !Suma 1 (obtiene Compl. Base 2)
        push %r7
        jmpl %r15+4, %r0

x:  -32
result_x: 0


fin:
    .end