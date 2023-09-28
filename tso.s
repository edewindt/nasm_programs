%macro syscall3 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro

%macro syscall2 3
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    syscall
%endmacro

%macro syscall1 2
    mov rax, %1
    mov rdi, %2
    syscall
%endmacro

%macro listen 2
    syscall2 sys_listen, %1, %2
%endmacro

%macro write 3
    syscall3 sys_write, %1, %2, %3
%endmacro

%macro socket 3
    syscall3 sys_socket, %1, %2, %3
%endmacro

%macro bind 3
    syscall3 sys_bind, %1, %2, %3
%endmacro

%macro exit 1
    mov rax, sys_exit
    mov rdi, %1
    syscall
%endmacro

%macro close 1
    syscall1 sys_close, %1
%endmacro



global _start

section .text
_start:
    write stdout, msg, msg_len
    write stdout, socket_trace_msg, socket_trace_msg_len
    socket AF_INET, SOCK_STREAM, 0
    cmp rax, 0
    jl error
    mov qword [sockfd], rax

    write stdout, bind_trace_msg, bind_trace_msg_len
    mov word [servaddr.sin_family], AF_INET
    mov word [servaddr.sin_port], 14619
    mov dword [servaddr.sin_addr], INADDR_ANY
    bind [sockfd], servaddr.sin_family, sizeof_servaddr
    cmp rax, 0
    jl error

    write stdout, listen_trace_msg, listen_trace_msg_len
    listen [sockfd], MAX_CONN
    cmp rax, 0
    jl error

    write stdout, ok_msg, ok_msg_len
    close [sockfd]
    exit exit_success

error:
    write stderror, error_msg, error_msg_len
    close [sockfd]
    exit exit_fail

section .data
    sockfd dq 0
    servaddr.sin_family  dw 0
    servaddr.sin_port  dw 0
    servaddr.sin_addr  dw 0
    servaddr.sin_zero  dq 0
    sizeof_servaddr equ $ - servaddr.sin_family
    msg db "INFO: Starting Web Server!", 10
    msg_len equ $ - msg
    error_msg db "ERROR!!", 10
    error_msg_len equ $ - error_msg
    socket_trace_msg db "INFO: Creating Socket...", 10
    socket_trace_msg_len equ $ - socket_trace_msg
    bind_trace_msg db "INFO: Binding Socket...", 10
    bind_trace_msg_len equ $ - bind_trace_msg
    listen_trace_msg db "INFO: Listening to Socket...", 10
    listen_trace_msg_len equ $ - listen_trace_msg
    ok_msg db "INFO: OK!!", 10
    ok_msg_len equ $ - ok_msg
    sys_write equ 1
    sys_exit equ 60
    sys_socket equ 41
    sys_bind equ 49
    sys_listen equ 50
    sys_close equ 3
    AF_INET equ 2
    INADDR_ANY equ 0
    SOCK_STREAM equ 1
    stdout equ 1
    stderror equ 2
    exit_success equ 0
    exit_fail equ 1
    MAX_CONN equ 5