%define NULL 0
%define NEWLINE 10

org 0x7C00
    lea si, [message]

print_string:
    ; Load byte from memory location defined in `si` into `al`. Increment `si`.
    lodsb

    ; Check for the NULL-termination character. If found, exit the loop.
    cmp al, NULL
    je infinite_loop

    ; Write the byte in `al` as an ASCII character to the screen.
    mov ah, 0x0E
    int 0x10

    jmp print_string

infinite_loop:
    jmp infinite_loop

message: db NEWLINE, "Hi, I'm a tiny bootloader!", NULL

; Pad out the file to the 510th byte with zeroes.
times 510-($-$$) db 0

; MBR boot signature.
db 0x55, 0xAA
