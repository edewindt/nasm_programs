global _start

section .data
    name db "ProjectXiel ",10
    len1 equ $ - name
    name2 db "Elias",10
    len2 equ $ - name2

section .text
_start:
    ; Print first string
    mov eax, 4  ;syscall for sys_write
    mov ebx, 1 ;file descriptor for stdout
    mov ecx, name  ;pointer to the first string
    mov edx, len1  ;length of the first string
    int 0x80 ;invoke the interrupt for stdout and syswrite

    ; Print second string
    mov eax, 4 ;syscall for sys_write
    mov ecx, name2 ;pointing to the second string
    mov edx, len2 ;length to the second string
    int 0x80 ;invoke the interrupt for stdout and syswrite once again

    ; Exit the program
    mov eax, 1 ;syscall for exit
    xor ebx, ebx ;
    int 0x80