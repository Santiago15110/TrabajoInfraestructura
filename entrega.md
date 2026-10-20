#Entrega - Parte practica
## A.1 - El despertar (Clase 1)
### A.1.1

```
nasm -f elf64 clase01.asm -o clase01.o
ld clase01.o -o clase01
./clase01
```

Salida:

```
LA LEYENDA DEL REGISTRO v0.1
Bienvenido, heroe. Tu aventura empieza aqui.
El sistema operativo te despidio con elegancia (código 0).
```

`echo $?` = `0`

### A.1.2

```
write(1, "LA LEYENDA DEL REGISTRO v0.1\n", 29) = 29
write(1, "Bienvenido, heroe. Tu aventura e"..., 45) = 45
write(1, "El sistema operativo te despidio"..., 60) = 60
+++ exited with 0 +++
```

1. 3 llamadas `write`.
2. `exit_group` devuelve 0 (`mov rdi, 0`).
3. `write` es la syscall 1 (`mov rax, 1`).

## A.2 - El nombre del héroe (Clase 2)
### A.2.1
### A.2.2
### A.2.3
## A.3 - Los atributos del heroe (Clase 3)
### A.3.1

**Caso 1 (FUE 3, AGI 5)

--TERMINAL--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ bash compilar.sh
OK: binario 'clase03' generado. Ejecutalo con: ./clase03
david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 3
AGI (agilidad, 0 a 9): 5
El heroe despierta como ELITE del reino.
FUE: 3
AGI: 5
VID: 1
Puntos gastados: 8
Nivel: 2
Los atributos quedaron grabados en los registros del heroe.


--Salida de datos--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ echo $?
0



**Caso 2 (FUE 0, AGI 9)

--Terminal--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
AGI (agilidad, 0 a 9): 9
El heroe despierta como ELITE del reino.
FUE: 0
AGI: 9
VID: 0
Puntos gastados: 9
Nivel: 2
Los atributos quedaron grabados en los registros del heroe.

--Salida--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ echo $?
0


**Caso 3 (FUE 9, AGI 9)

--Terminal--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 9
AGI (agilidad, 0 a 9): 9
Error: no te alcanzan los 9 puntos.


--Salida--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ echo $?
1


**Caso 4(FUE 0, AGI 0)

--Terminal--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
AGI (agilidad, 0 a 9): 0
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 0
VID: 9
Puntos gastados: 0
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.


--Salida--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ echo $?
0

**Caso 5 (FUE 'X', AGI 5)

--Terminal--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): x
AGI (agilidad, 0 a 9): 5
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 5
VID: 4
Puntos gastados: 5
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.


--Salida--

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ echo $?
0




### A.3.2

**Strace

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ strace -o trace3.txt -e trace=write,read,exit_group ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 8
AGI (agilidad, 0 a 9): 2
Error: no te alcanzan los 9 puntos.
david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ cat trace3.txt
write(1, "LA LEYENDA DEL REGISTRO v0.3\n", 29) = 29
write(1, "Tienes 9 puntos para repartir. E"..., 62) = 62
write(1, "FUE (fuerza, 0 a 9): ", 21)   = 21
read(0, "8\n", 2)                       = 2
write(1, "AGI (agilidad, 0 a 9): ", 23) = 23
read(0, "2\n", 2)                       = 2
write(1, "Error: no te alcanzan los 9 punt"..., 36) = 36
+++ exited with 1 +++


### A.3.3


**edicion de inicio

 sin_fuerza     db "Un heroe sin fuerza no es heroe"
    len_sin_fuerza equ $ - sin_fuerza
    salto     db 10

**Edicion del texto

.fue_leido:
    cmp byte [v_fue], 0
    je .sin_fuerza
    jmp .fue_ok
.sin_fuerza:
    mov rax, 1
    mov rdi, 1
    mov rsi, sin_fuerza
    mov rdx, len_sin_fuerza
    syscall
.fue_ok:

**Terminal del nuevo texto 

david_1511@DESKTOP-G665J9V:~/explorar/examen/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
Un heroe sin fuerza no es heroeAGI (agilidad, 0 a 9): 3
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 3
VID: 6
Puntos gastados: 3
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.


## A.4 -Crear desde cero (heroe.asm)


**Terminal


david_1511@DESKTOP-G665J9V:~/explorar/examen$ code heroe.asm
david_1511@DESKTOP-G665J9V:~/explorar/examen$ nasm -f elf64 heroe.asm -o heroe.o
nasm: fatal: unable to open input file `heroe.asm' No such file or directory
david_1511@DESKTOP-G665J9V:~/explorar/examen$ nasm -f elf64 heroe.asm -o heroe.o
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ld heroe heroe.o -o heroe
/usr/bin/x86_64-linux-gnu-ld.bfd: input file 'heroe' is the same as output file
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ./heroe
-bash: ./heroe: No such file or directory
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ls
README.md  clase-02  entrega.md  heroe.asm
clase-01   clase-03  examen.md   heroe.o
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ld heroe.o -o heroe
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ./heroe
Nombre: david
david
david_1511@DESKTOP-G665J9V:~/explorar/examen$ echo $?
0
david_1511@DESKTOP-G665J9V:~/explorar/examen$ ./heroe
Nombre: Sauron
Sauron

**Salida

david_1511@DESKTOP-G665J9V:~/explorar/examen$ echo $?
0