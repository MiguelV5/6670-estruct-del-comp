   
   
!====================================PUSH====================================
   
   .macro push RegAAlmacenar   
    add %r14, -4, %r14              !disminuye la direccion a la que apunta (el stack crece al reves de como crecen las posiciones de memora)
    st RegAAlmacenar, %r14      !almaceno lo que se pide
    .endmacro

!====================================POP====================================

    .macro pop RegALoadearAntesDePopear
    ld %r14, RegALoadearAntesDePopear   !Guarda el dato antes de popearlo
    add %r14, 4, %r14               !aumenta la direccion a la que apunta el stack pointer
    .endmacro

!=================================Multip. Enteros POSITIVOS===============================
   !(JUNTO CON LAS SUBRUTINAS DE VERIFICACION DE SUMA DE ENTEROS NO REPRESENTABLES EN 32 BITS)

    .macro multiplicacionEnterosPositivos Reg1, Reg2, RegResult
    andcc Reg1, Reg1, %r0   !si es cero alguno de los factores devuelve 0
    be  finMultiplicacion

    andcc Reg2, Reg2, %r0
    be  finMultiplicacion

    add Reg2, %r0, %r6  !guardo el valor de los aux (r6 decrementador)
    add %r0, %r0, %r7   !(r7 va a ser mi registro que cargue el resultado parcial)

    inicioMultiplicacionEnterosPositivos:
        andcc %r6, %r6, %r0     !r6 va a ser mi aux contador regresivo; 
        be finMultiplicacion    
        
        !VERIFICACION DE REPRESENTABILIDAD ANTES DE SEGUIR SUMANDO EL RESULTADO PARCIAL:
            push %r7        !se pasan parametros por stack
            push Reg1
            call esSumaPositivaRepresentableEn32Bits
            pop %r8

            andcc %r8, %r8, %r0    !verifica el flag N. Si es negativo (el -1) es porque no puede seguir multiplicando.
            bneg multiplicacionNoFueRepresentable

        addcc %r7, Reg1, %r7     
        addcc %r6, -1, %r6

    ba inicioMultiplicacionEnterosPositivos

    multiplicacionNoFueRepresentable:
        add %r0, -1, RegResult
        ba finMultiplicacionERR

    finMultiplicacion:
        add %r7, %r0, RegResult

    finMultiplicacionERR:

    .endmacro


!(RUTINAS NECESARIAS):

    _esSumaEnteraRepresentableEn32Bits0:   !TOCO PONERLE ESE NOMBRE PARA QUE LO TOMARA EN LA MACRO EL CALL
            pop %r16        !Se obtienen valores pasados por stack
            pop %r17
            addcc %r16, %r17, %r18     
            bvs sumaNoRepresentable
            push %r0    !si no entra al branch devuelve 0 (caso la suma si es representable)
            jmpl %r15+4, %r0        

    _esSumaPositivaRepresentableEn32Bits0:   !TOCO PONERLE ESE NOMBRE PARA QUE LO TOMARA EN LA MACRO EL CALL
            pop %r16        !Se obtienen valores pasados por stack
            pop %r17
            addcc %r16, %r17, %r18     
            bcs sumaNoRepresentable
            push %r0    !si no entra al branch devuelve 0 (caso la suma si es representable)
            jmpl %r15+4, %r0        

    sumaNoRepresentable:
            add %r0, -1, %r19     !si entro al branch devuelve -1 (caso la suma NO es representable)
            push %r19   
            jmpl %r15+4, %r0  



!=================================Multip. Enteros POSITIVOS===============================
   !(SIN LAS SUBRUTINAS DE VERIFICACION DE SUMA DE ENTEROS NO REPRESENTABLES EN 32 BITS)

    .macro multiplicacionEnterosPositivos Reg1, Reg2, RegResult
        andcc Reg1, Reg1, %r0   !si es cero alguno de los factores devuelve 0
        be  finMultiplicacion

        andcc Reg2, Reg2, %r0
        be  finMultiplicacion

        add Reg2, %r0, %r6  !guardo el valor de los aux (r6 decrementador)
        add %r0, %r0, %r7   !(r7 va a ser mi registro que cargue el resultado parcial)

        inicioMultiplicacionEnterosPositivos:
            andcc %r6, %r6, %r0     !r6 va a ser mi aux contador regresivo; 
            be finMultiplicacion    

            addcc %r7, Reg1, %r7     
            addcc %r6, -1, %r6

        ba inicioMultiplicacionEnterosPositivos

        finMultiplicacion:
            add %r7, %r0, RegResult

    .endmacro


!=================================COMPLEMENTO A 2 (POR REGISTRO)===============================

    .macro calcularComplementoADos RegACalcular RegResultado
        xor RegACalcular, -1 , %r20   !Se invierten los bits del dato (Complemento a la base menos uno)
        add %r20, 1, RegResultado     !Suma 1 (obtiene Compl. Base 2)
    .endmacro

!=================================MODULO===============================

    .macro absDeEnteroEnComplementoADos RegACalcular RegResultado
        addcc RegACalcular, %r0, RegACalcular     !trigger para el flag negativo
        bneg calcularComplementoADos
        ba absDePositivo

        calcularComplementoADos:
            xor RegACalcular, -1 , %r20   !Se invierten los bits del dato (Complemento a la base menos uno)
            add %r20, 1, RegResultado     !Suma 1 (obtiene Compl. Base 2)
            ba finAbs

        absDePositivo:
            add RegACalcular, %r0, RegResultado

        finAbs:

    .endmacro


!(RUTINAS NECESARIAS):
    

!=================================default===============================



!=================================default===============================



!=================================default===============================