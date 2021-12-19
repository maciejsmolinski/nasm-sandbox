%define sys_read 0
%define sys_write 1
%define sys_exit 60
%define stdin 0
%define stdout 1

section .data
	message db "Hello", 10, 0
	messageLength equ $-message

section .text

global main

main:
	call write
	call read
	call write
	call exit

write:
	mov rax, sys_write
	mov rdi, stdout
	mov rsi, message
	mov rdx, messageLength
	syscall
	ret

read:
	mov rax, sys_read
	mov rdi, stdin
	mov rsi, r8
	mov rdx, 1
	syscall
	ret

exit:
	mov rax, sys_exit
	mov rdi, r8
	syscall
	ret
