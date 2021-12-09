    .begin
    
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


    .macro calcularElDobleElevadoALaN RegConBase, RegConExponenteN, RegResultado
    
        add %r0, 2, %r4        !guardo el 2 a multiplicar en un registro auxiliar
        multiplicacionEnterosPositivos RegConBase, %r4, %r21     !uso macro de multiplicacion
        bvs NoRepresentable     !verifico si fue representable el resultado

        add RegConExponenteN, -1, %r20     !guardo en un registro auxiliar el valor del exponente MENOS UNO para usarlo como decrementador en la potencia.
       

        iteracionDeCalculoDePotencia:
            be finDelCalculo       !si el aux del exponente ahora es cero, acabó la potencia.
            multiplicacionEnterosPositivos %r21, RegConBase, %r21      !multiplico el valor actual de r21 por la base en cada iteracion
            bvs NoRepresentable     !verifico si fue representable el resultado
            addcc %r20, -1, %r20    !decremento en uno el aux del exponente
            ba iteracionDeCalculoDePotencia     !vuelvo al inicio del loop

        finDelCalculo:
            add %r21, %r0, RegResultado     !guardo el resultado de toda la operacion

    .endmacro

    .org 2048

    ld [x], %r1
    ld [n], %r2

    calcularElDobleElevadoALaN %r1, %r2, %r3
    st %r3, [resultado]

    ba fin

    x:  0x7fffffff
    n:  2
    resultado:  0
    
_NoRepresentable0:       !El nombre del label es para que lo tome desde la macro
        add %r0, -1 , %r3   !guardo un -1 en el registro en el que se espera el resultado para indicar que hubo fallo al representar el resultado en 32 bits 
        ba fin


fin:
    .end
