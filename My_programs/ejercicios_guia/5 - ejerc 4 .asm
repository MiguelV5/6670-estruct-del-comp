    .begin
    .org 2048                   !se traslada a la memoria de usuario
    
    ld [primeraVar], %r1        !se carga desde RAM el valor de lo que esté en la posicion llamada primeraVar al registro r1, en este caso vale 2076
    ld [segundaVar], %r2        !se carga desde RAM el valor de lo que esté en la posicion llamada segundaVar al registro r2, en este caso vale 2080
    call swapeo                 !se llama a la subrutina del swapeo y se almacena la posicion actual en memoria al r15
    ba end                      !FUERZO A QUE VAYA A LA POSICION DE MEMORIA EN LA QUE ESTA? EL END. NO ES NECESARIO PERO LO HICE PARA PROBAR PORQUE NO SALIA NUNCA DEL jmpl

swapeo: st %r2, [primeraVar]    !carga en memoria (primeraVar) el valor que habia en el r2   !addcc %r1, %r0, %r3  ---> Esto seria como guardar en un registro auxiliar, creo que no es necesario acá.
        st %r1, [segundaVar]    !carga en memoria (segundaVar) el valor que habia en el r1
        jmpl %r15 + 4, %r0      !retorna a la siguiente instruccion tras el call

primeraVar: 15                  !se etiqueta la dir 2076 con primeraVar y se le almacena el valor 15
segundaVar: 5                   !se etiqueta la dir 2080 con primeraVar y se le almacena el valor 5

end: 
    .end
