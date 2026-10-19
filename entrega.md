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
### A.3.2
### A.3.3
## A.4 -Crear desde cero (heroe.asm)

## A.2 - El nombre del heroe (Clase 2)

### A.2.1
### Caso 1: nombre corto (Santi)
```
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
Bienvenido al reino, Santi
Tu nombre ya vive en la memoria del proceso.
```

### Caso 2: 31 letras
```
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
Bienvenido al reino, AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Tu nombre ya vive en la memoria del proceso.
```

### Caso 3: 40 letras
```
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
Bienvenido al reino, BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
Tu nombre ya vive en la memoria del proceso.
```

### A.2.2 - strace con nombre de 10 letras
```
write(1, "LA LEYENDA DEL REGISTRO v0.2\n", 29) = 29
write(1, "Como se llama el heroe? (max 31 "..., 40) = 40
read(0, "Abcdefghij\n", 32)             = 11
write(1, "Hola, valiente heroe, bienvenido"..., 59) = 59
write(1, "Abcdefghij", 10)              = 10
write(1, "\n", 1)                       = 1
write(1, "Vuelve pronto, el kernel guardar"..., 44) = 44
+++ exited with 0 +++
```

### A.2.3 - Bloque .data modificado
```asm
section .data
    titulo    db "LA LEYENDA DEL REGISTRO v0.2", 10
    len_titulo equ $ - titulo
    pregunta  db "Como se llama el heroe? (max 31 letras)", 10
    len_pregunta equ $ - pregunta
    saludo   db "Hola, valiente heroe, bienvenido al reino de los registros "
    len_saludo equ $ - saludo
    despedida db "Vuelve pronto, el kernel guardara tu lugar.", 10
    len_despedida equ $ - despedida
    salto     db 10                                    ; un salto de linea suelto

; ------------------------------------------------------------
; SECCION .bss  ->  memoria RESERVADA para lo que aün no existe:
;                   el nombre lo va a ESCRIBIR el jugador.
;                   resb = "reserve bytes": el enlazador crea
;                   el espacio, pero no giga bytes en el binario.
; ------------------------------------------------------------
```

Salida con el nombre Gandalf:
```
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
Hola, valiente heroe, bienvenido al reino de los registros Gandalf
Vuelve pronto, el kernel guardara tu lugar.
```
