global _start

_start:
    call func ; moves to func location and pushes next instruction on stack
    mov eax, 1 ; syscall number for exiting
    mov ebx, 0 ; place 0 into ebx register for exit code
    int 0x80 ; perform syscall for exiting

func:
    push ebp
    mov ebp, esp ; moves stack pointer location into ebp regiter
    sub esp, 3 ; allocate 2 bytes on stack
    mov [esp], byte 'H' ; move byte H to adress of stack pointer
    mov [esp+1], byte 'i' ; move byte i to adress of stack pointer + 1
    mov [esp+2], byte 10
    mov eax, 4 ; sys_write syscall number
    mov ebx, 1 ; stdout file descriptor
    mov ecx, esp ; pointing to the stack pointer holding the begging of the word
    mov edx, 3 ; the length of our string
    int 0x80 ; syscall
    mov esp, ebp ; 
    pop ebp
    ret