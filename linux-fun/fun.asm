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

	section .text
	
	mov rdi, user_size
	call malloc
	
	mov [users], rax
	mov [rax+user.id], byte 1

	lea rsi, [.name]	
	lea rdi, [rax+user.name]
	call strcpy
	ret

print_user:
	section .data
	
.fmt 	db "%s", 10, 0
.fmt2	db "%ld", 10, 0

	section .text

	mov r8, [users]

	mov rdi, .fmt
	mov rsi, r8
	add rsi, user.name
	mov rax, 0
	call printf

	mov r8, [users]
	mov rdi, .fmt2
	mov rsi, r8
	add rsi, user.id
	mov rsi, [rsi]
	mov rax, 0
	call printf
	ret

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall

