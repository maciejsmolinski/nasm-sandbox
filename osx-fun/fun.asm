%define sys_write 0x02000004
%define sys_exit 0x02000001
%define stdout 1
%define success 0

	section .bss

	struc user
		.id:	resq 1
		.name: 	resb 255
	endstruc

	section .text
	global _main

	extern _printf

_main:
	call print_welcome_message
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

exit:
	mov rax, sys_exit
	mov rdi, success
	syscall
	ret
