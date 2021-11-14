    .begin
    .org 2048

    ld [A], %r1
    ld [B], %r2

    st %r1, [X]
    st %r2, [X+4]       !se copian los valores de los registros a las posiciones previamente reservadas
    addcc %r0, X, %r3   !se copia la direccion al comienzo del area reservada (es preferible tener lo que se pueda en registros para facil acceso y evitar tener que acceder a memoria de vuelta con [X]).

    call sumaConDwb     !llama a la subrutina
    ld %r3+8, %r4       !recupero lo que hay en la ultima posicion reservada (deberia estar ahi dentro el resultado de la suma) a otro registro
    st %r4, [result]    !carga el resultado de la suma al contenido de la posicion result (2116) 

    ba end !termina el programa


sumaConDwb: 
        ld %r3, %r5             !carga en r5 el contenido de lo que se estaba apuntando en r3, que era el valor 15 almacenado en la direccion X
        ld %r3+4, %r6           !carga en r6 el contenido (...) una posición despues de r3 (tambien estaba reservada)
        addcc %r5, %r6, %r7     !realiza la suma con los datos obtenidos
        st %r7, %r3+8           !carga el resultado en la ultima posicion reservada a partir de la X
        jmpl %r15+4, %r0        !vuelve a la subrutina principal
        

A: 15   !posicion 2108
B: 8    !posicion 2112
result: 0   !posicion 2116
X:  .dwb 3  !reserva memoria para los 2 operandos a tener por parametro y su resultado (posiciones de memoria:  2120 - 2124 - 2128)


end:
    .end