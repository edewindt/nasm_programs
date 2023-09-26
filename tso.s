%macro write 3
    mov rax, sys_write
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

%macro exit 1
    mov rax, sys_exit
    mov rdi, %1
    syscall
%endmacro

%macro socket 3
    mov rax, sys_socket
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

global _start

section .text
_start:
    
    write stdout, msg, msg_len
    socket AF_INET, SOCK_STREAM, 0
    cmp rax, 0
    jl error
    mov dword [sockfd], eax
    exit 0

error:
    write stderror, error_msg, error_msg_len
    exit 1
section .data
    sockfd dd 0
    msg db "Starting Web Server!", 10
    msg_len equ $ - msg
    error_msg db "ERROR!!", 10
    error_msg_len equ $ - error_msg
    sys_write equ 1
    sys_exit equ 60
    sys_socket equ 41
    AF_INET equ 2
    SOCK_STREAM equ 1
    stdout equ 1
    stderror equ 2