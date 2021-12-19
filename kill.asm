%define sys_write 1
%define sys_exit 60
%define stdout 1

section .data
	message db "Hello", 10, 0
	messageLength equ $-message

section .text

global main

main:
	call write
	call exit

write:
	mov rax, sys_write
	mov rdi, stdout
	mov rsi, message
	mov rdx, messageLength
	syscall
	ret

exit:
	mov rax, sys_exit
	mov rdi, 0
	syscall
	ret
