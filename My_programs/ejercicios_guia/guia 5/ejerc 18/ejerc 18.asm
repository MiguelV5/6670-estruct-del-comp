    .begin

    .macro push RegAAlmacenar   
        add %r14, -4, %r14              !disminuye la direccion a la que apunta (el stack crece al reves de como crecen las posiciones de memora)
        st RegAAlmacenar, %r14      !almaceno lo que se pide
    .endmacro

    .macro pop RegALoadearAntesDePopear
        ld %r14, RegALoadearAntesDePopear   !Guarda el dato antes de popearlo
        add %r14, 4, %r14               !aumenta la direccion a la que apunta el stack pointer
    .endmacro

    .org 2048

    ld [x], %r1
    push %r1
    call contarUnosDeRepresentacionBinaria
    pop %r2
    st %r2, [result]
    ba fin

contarUnosDeRepresentacionBinaria:
    pop %r10
    add %r0, 1, %r11    !r11 va a ser una máscara "dinámica" que va a ir desplazando el 1 que tiene para ir viendo si el valor de r3 tiene un uno en tal posicion
    add %r0, 31, %r12    !r12 va a ser un decrementador para identificar cuando acabó de recorrer el valor dado
    add %r0, %r0, %r16    !r16 va a ser el contador de unos

    seguirBuscandoUnos:
        be finalizarConteo

        andcc %r10, %r11, %r0
        bne encontradoUno 
        continuacionBusqueda:
            sll	%r11, 1, %r11
            subcc %r12, 1, %r12
            ba seguirBuscandoUnos

        encontradoUno:
            add %r16, 1, %r16
            ba continuacionBusqueda

    finalizarConteo:
        push %r16
        jmpl %r15+4, %r0


x:  0x7f !valor con 7 unos               !0x7fffffff   valor con 31 unos anda :)
result: 0

fin:
    .end
