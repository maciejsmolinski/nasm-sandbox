%define sys_write 0x02000004
%define sys_exit 0x02000001
%define stdout 1
%define success 0

	default rel

	section .bss

	struc user
		.id:	resq 1
	    .name: 	resb 32
	endstruc

    users:	resw 1

	section .text
	global _main

	extern _printf
	extern _malloc

_main:
	call print_welcome_message
	call new_user
	call print_user
	call exit

print_welcome_message:
	section .data
	.fmt db "%s", 10, 0
	.msg db "Welcome!", 0

	section .text
	mov rdi, .fmt
	mov rsi, .msg
	mov rax, 0
	call _printf
	ret

new_user:
	section .data
	.username db "John", 0
	.fmt db "%s", 10, 0

	section .text
	mov rdi, user_size
	call _malloc
	mov rdi, rax
	mov [users], rdi
    mov [rax+user.id], byte 1
	mov rsi, .username
	mov [rax+user.name], rsi
	ret

print_user:
	section .data
	.fmt db "%s", 10, 0

	section .text

	mov rdi, .fmt
	mov rsi, [users+user.name]
	mov rax, 0
	call _printf

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall
	ret
