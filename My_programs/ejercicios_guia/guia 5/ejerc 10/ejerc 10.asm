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
        ld [y], %r2

        push %r1        !se pasan parametros por stack
        push %r2
        call esSumaRepresentableEn32Bits
        ld %r14, %r2    !carga a r2 lo que está en el stack (deberia ser el resultado)
        pop
        st %r2, [result]  !se almacena en RAM

        ba fin


esSumaRepresentableEn32Bits:   
        ld %r14, %r6        !Se obtienen valores pasados por stack
        pop
        ld %r14, %r7
        pop
        addcc %r6, %r7, %r8     
        bvs sumaNoRepresentable
        push %r0    !si no entra al branch devuelve 0 (caso la suma si es representable)
        jmpl %r15+4, %r0        

    
sumaNoRepresentable:
        add %r0, -1, %r9     !si entro al branch devuelve -1 (caso la suma NO es representable)
        push %r9   
        jmpl %r15+4, %r0        



x:  0x7fffffff  !0 en el bit más significativo (signo positivo) y el resto de bits en 1. 
y:  1           !con sumarle uno a x deberia ser suficiente para causar overflow.


! PARA EL EJERCICIO 11 SERIA EXACTAMENTE LO MISMO, EXCEPTO QUE EN LA LINEA 34 SERIA bcs Y LA x
! TENDRIA VALOR 0xffffffff para que al sumarle 1 causara set del Carry.

result: 0

fin:
    .end
