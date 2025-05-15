; ascii translator by Max Monson cmsc 313 
inputBuf:   db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen:   equ 8

section .bss
outputBuf:  resb 80

section .text
global _start

_start:                     ; making pointers
    mov esi, inputBuf       
    mov edi, outputBuf      
    mov ecx, inputLen       ; number of bytes to process (length)

convert_loop:               ; load a byte from esi into AL (8-bit reg) from ESI then copy it into AH, increment ESI
    lodsb                   
    mov ah, al              

    shr al, 4               ; get first 4-bits in AL
    call half_byte_to_ascii
    stosb                   ; store in [EDI], increment EDI

    
    mov al, ah              ; original byte
    and al, 0x0F            ; get other 4-bits
    call half_byte_to_ascii
    stosb                   

    ; Add space -- until last byte of data
    dec ecx
    jz  .done
    mov al, ' '
    stosb
    jmp convert_loop 

.done:
    ; New line
    mov al, 0x0A
    stosb

    ; Print outputBuf
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, outputBuf  ; buffer to write/print
    mov edx, edi
    sub edx, outputBuf  
    int 0x80

    ; Finished translating (exit)
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; status 0
    int 0x80

; Convert 4 bits from AL to ASCII
half_byte_to_ascii:
    cmp al, 9
    jbe .digit
    add al, 0x37        ; A-F
    ret
.digit:
    add al, 0x30        ; 0-9
    ret
