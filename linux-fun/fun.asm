%define sys_write 1
%define sys_exit 60
%define stdout 1
%define success 0

	section .bss

	struc user
	    .id:	resq 1
	    align	4
	    .name:	resb 64
	    align	8
	endstruc

users:	resq 1

	section .text

	global main

	extern printf, malloc, strcpy

main:
	call print_intro
	call new_user
	call print_user
	call print_newline
	call exit

print_intro:
	section .data
.fmt	db "%s", 10, 0
.msg	db  `\e[90m// Exercise: Writing to and reading from memory\e[0m`, 10, 0

	section .text

	mov rdi, .fmt
	mov rsi, .msg
	mov rax, 0
	call printf
	ret

new_user:
	section .data
.name	db "Paul Tray", 0

	section .text

	mov rdi, user_size
	call malloc

	mov [users], rax
	mov [rax+user.id], word 256

	lea rsi, [.name]
	lea rdi, [rax+user.name]
	call strcpy
	ret

print_user:
	section .data
.fmt	db `-> \e[0mUser\e[0m<\e[90m{ name: \e[36m"%s"\e[0;90m, id: \e[36m%ld\e[0m }\e[0m>`, 10,  0

	section .text

	mov r8, [users]		   ; store the address in the register

	lea rdi, [.fmt]		   ; it's a string, we load its address
	lea rsi, [r8+user.name]    ; it's a string, we load its address
	mov rdx, [r8+user.id]      ; it's a digit, we load the value
	mov rax, 0
	call printf

	ret

print_newline:
	section .data
.fmt	db 10, 0

	section .text
	xor rax, rax
	mov rdi, .fmt
	call printf

	ret

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall
