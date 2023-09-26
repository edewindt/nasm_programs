global _start

_start:
    sub esp, 5 ; allocate 4 bytes to stack
    mov [esp], byte 'H' ; move 1 byte H to adress of stack pointer
    mov [esp+1], byte 'e' ; move 1 byte e to adress of stack pointer + 1
    mov [esp+2], byte 'y' ; +3
    mov [esp+3], byte '!' ; + 4
    mov [esp+4], byte 10
    mov eax, 4 ; sys_write syscall number
    mov ebx, 1 ; stdout file descriptor
    mov ecx, esp ; pointing to stack pointer, which holds our word
    mov edx, 5 ; the length of our string
    int 0x80 ; syscall
    mov eax, 1 ; exit syscall number
    mov ebx, 0 ; moving 0 for our exit code
    int 0x80 ; syscall for exiting