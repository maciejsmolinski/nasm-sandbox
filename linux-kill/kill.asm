%define sys_read 0
%define sys_write 1
%define sys_exit 60
%define sys_kill 62
%define stdin 0
%define stdout 1
%define sig_kill 9

section .data
	message db "Hello", 10, 0
	messageLength equ $-message

section .bss
	input resb 6

section .text

global main

main:
	call read
	call convert
	push rax
	call write
	pop rax
	call kill
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
	mov rdx, 6
	syscall
	ret

convert:
	lea rsi, [input]
	mov rcx, 6
	call string_to_int
	ret

;; Learned from https://ostack.cn/?qa=402927/
;; and iterated on (e.g. bounds)
string_to_int:
	xor rbx, rbx
.next_digit:
	movzx rax, byte [rsi]
	inc rsi
	sub al, '0'
	cmp al, 0
	jl .return
	cmp al, 9
	jg .return
	imul rbx, 10
	add rbx, rax
	loop .next_digit
.return:
 	xor rcx, rcx
	mov rax, rbx
	ret

kill:
	mov rdi, rax				; pid
	mov rax, sys_kill
	mov rsi, sig_kill
	syscall
	ret

exit:
	mov rax, sys_exit
	mov rdi, 0
	syscall
	ret
