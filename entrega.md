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
