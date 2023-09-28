global _start

_start:
    call func ; moves to func location and pushes next intruction onto stack
    mov eax, 1 ; sycall number for exiting
    int 0x80   ;syscall

func:
    mov ebx, 69 ; moves 42 into ebx register for exit code
    pop eax ; pops to directly after func location off of stack into eax register
    jmp eax ; jumps to jump location and continues intructions after that
