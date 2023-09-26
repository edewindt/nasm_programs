section .data
    string1 db "Hello, ", 0
    string2 db "World!", 10

section .text
global _start

_start:
    ; Print the first string
    mov eax, 4       ; syscall number for sys_write
    mov ebx, 1       ; file descriptor 1 (stdout)
    mov ecx, string1 ; pointer to the first string
    mov edx, 8      ; length of the first string (including the null terminator)
    int 0x80         ; invoke the syscall to print the first string

    ; Print the second string
    mov eax, 4       ; syscall number for sys_write
    mov ecx, string2 ; pointer to the second string
    mov edx, 7       ; length of the second string (including the null terminator)
    int 0x80         ; invoke the syscall to print the second string

    ; Exit the program
    mov eax, 1       ; syscall number for exit
    xor ebx, ebx     ; exit status code 0
    int 0x80         ; invoke the syscall to exit
