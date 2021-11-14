    .begin
    .org 2048

    .macro push RegistroAAlmacenar   
        addcc %r14, -4, %r14              !disminuye la direccion a la que apunta (recordar que el stack crece al reves de como crecen las posiciones de memora)
        st RegistroAAlmacenar, %r14      !almaceno lo que se pide
    .endmacro

    .macro pop
        addcc %r14, 4, %r14               !aumenta la direccion a la que apunta el sp
    .endmacro

    ld [x], %r1                         !guardo lo que hay en la direccion x al r1
    ld [y], %r2                         !guardo lo que hay en la direccion y al r2

    push %r1                         !push de lo que quedo en r1
    push %r2                         !push de lo que quedo en r2
    call sumaConStack                   !llamo subrutina habiendole pasado como parametro los datos de los registros anteriores POR MEDIO DEL STACK
    ld %r14, %r3                     !cargo al r3 lo que se tenia en el stack tras sumar (como si el valor de retorno estuviera en el stack listo para agarrar)
    pop                              !libera lo que queda del stack (solo deberia quedar el resultado de la suma)
    st %r3, [result]                    !almaceno lo que hay en el r3 a la variable

    ba end                              !termina el programa

x:  5
y:  8
result: 0

sumaConStack:   
        ld %r14, %r3                     !carga lo que hay en la direccion actual del sp al r3
        pop                          !hace pop de lo que ya cargó porque ya no se necesita (ya lo tenemos cargado en r3)
        ld %r14, %r4                     !carga lo que (^^...) al r4
        pop                          !(^^...)
        addcc %r3, %r4, %r5             !realiza la suma con los datos obtenidos del stack
        push %r5                     !pushea el resultado al stack
        jmpl %r15+4, %r0                !vuelve a la instruccion posterior al call

end:
    .end
