# Estructura del computador - FIUBA 2c 2021 - Curso Burín

Este repo contiene algunos ejercicios de Assembler de la guía de ejercicios (VER NOTA) y mi solución al ejercicio de Assembler del final (Checkeada).

## NOTA IMPORTANTE

Mis soluciones a ejercicios de la guía en su gran mayoría tienen una implementación **INCORRECTA** de cómo se debe FINALIZAR un programa Assembler; esto debido a que en su momento, en las clases prácticas / parcialitos entregados, no hacen una reivisón detallada de eso, pero es un detalle muy importante para el exámen final y te pueden llegar a desaprobar solo por eso.

La forma **CORRECTA** de finalizar los programas es siempre "devolverle el mando" al proceso padre del programa, que sería el sistema operativo en general. Por lo tanto lo correcto es siempre finalizar con un:

```Assembly
jmpl %r15+4, %r0   
!Tambien notar que se puede almacenar el valor del r15 al principio del programa para no tener que usar ese necesariamente al finalizarlo.
```

Como se menciona antes, el ejercicio del final está revisado y correctamente solucionado.

Ver el directorio My_programs para todo lo anterior.
