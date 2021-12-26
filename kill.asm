%define sys_read 0
%define sys_write 1
%define sys_exit 60
%define stdin 0
%define stdout 1

section .data
	message db "Hello", 10, 0
	messageLength equ $-message

section .bss
	input resb 4

section .text

global main

main:
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
	mov rsi, input
	mov rdx, 4
	syscall
	ret

;; Learned from https://ostack.cn/?qa=402927/
string_to_int:
	xor rbx, rbx
.next_digit:
	movzx rax, byte [rsi]
	inc rsi
	sub al, '0'
	imul rbx, 10
	add rbx, rax
	loop .next_digit
	mov rax, rbx
	ret

exit:
	mov rax, sys_exit
	mov rdi, 0
	syscall
	ret
