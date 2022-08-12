global loader

MAGIC_NUMBER equ 0x1BADB002
FLAGS equ 0x0
CHECKSUM equ -MAGIC_NUMBER 

KERNEL_STACK_SIZE equ 4096

section .bss
align 4
  kernel_stack:
  resb KERNEL_STACK_SIZE

section .text:
align 4
  dd MAGIC_NUMBER
  dd FLAGS
  dd CHECKSUM

global outb

outb:
  mov al, [esp + 8]
  mov dx, [esp + 4]
  out dx, al
  ret

loader:
  mov eax, 0xCAFEBABE
  mov esp, kernel_stack + KERNEL_STACK_SIZE
  mov eax, 0x4128
  mov [0x000B8000], eax
  
  extern sum_of_three
    push dword 3
    push dword 2
    push dword 1
    call sum_of_three
.loop:
  jmp .loop