%define sys_write 1
%define sys_exit 60
%define stdout 1
%define success 0

	section .bss

	struc user
            .id:	resq 1
	    align	8
            .name: 	resb 16
	    align	8
	endstruc

users:	resq 1

	section .text
	global main

	extern printf
	extern malloc
	extern strcpy

main:
	call print_intro
	call new_user
	call print_user
	call exit

print_intro:
	section .data
	
.fmt 	db "%s", 10, 0
.msg 	db "[Writing to and reading from memory]", 10, 0

	section .text
	
	mov rdi, .fmt
	mov rsi, .msg
	mov rax, 0
	call printf
	ret

new_user:
	section .data
	
.name 	db "John", 0

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
	
.fmt 	db 'User<{ name: "%s", id: %ld }>', 10, 0

	section .text

	mov r8, [users]		   ; store the address in the register

	lea rdi, [.fmt]		   ; it's a string, we load its address
	lea rsi, [r8+user.name]    ; it's a string, we load its address
	mov rdx, [r8+user.id]      ; it's a digit, we load the value
	mov rax, 0
	call printf

	ret

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall

