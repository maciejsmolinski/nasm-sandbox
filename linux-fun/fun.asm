%define sys_write 1
%define sys_exit 60
%define stdout 1
%define success 0

	section .bss

	struc user
            .id:	resq 1
            .name: 	resb 32
	endstruc

users:	resq 1

	section .text
	global main

	extern printf
	extern malloc
	extern strcpy

main:
	call print_welcome_message
	call new_user
	call print_user
	call exit

print_welcome_message:
	section .data
	
.fmt 	db "%s", 10, 0
.msg 	db "Welcome!", 0

	section .text
	
	mov rdi, .fmt
	mov rsi, .msg
	mov rax, 0
	call printf
	ret

new_user:
	section .data
	
.name 	db "John", 0
.fmt 	db "%s", 10, 0

	section .text
	
	mov rdi, user_size
	call malloc
	
	mov [users], rax
	mov [rax], byte 1

	lea rsi, [.name]	
	lea rdi, [rax+user.id] ; offset by id for name
	call strcpy
	ret

print_user:
	section .data
	
.fmt 	db "%s", 10, 0

	section .text

	mov rdi, .fmt
	mov rsi, [users]
	mov rax, 0
	call printf
	ret

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall

