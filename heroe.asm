section .data
    prompt     db "Nombre: "
    len_prompt equ $ - prompt
    nl         db 10

section .bss
    nombre resb 16

section .text
    global _start

_start:
    ; 1. imprimir "Nombre: " (sin salto de línea)
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, len_prompt
    syscall

    ; 2. leer el nombre (hasta 16 bytes)
    mov rax, 0
    mov rdi, 0
    mov rsi, nombre
    mov rdx, 16
    syscall
    dec rax                ; quita el LF del Enter
    mov rdx, rax           ; rdx = largo real del nombre

    ; 3. imprimir el nombre
    mov rax, 1
    mov rdi, 1
    mov rsi, nombre
    syscall

    ; 4. imprimir el salto de línea
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    ; salir con código 0
    mov rax, 60
    mov rdi, 0
    syscall 