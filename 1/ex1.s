global _start
_start:
    mov eax, 1 ; Loads the syscall number for the interrupt
    mov ebx, 69 ; Loads exit code into ebx register
    int 0x80 ; This performs a syscall for the 0x80 interrupt