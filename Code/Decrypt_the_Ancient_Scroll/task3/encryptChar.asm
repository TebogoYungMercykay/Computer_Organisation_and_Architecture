; * Inports and Exports
global encryptChar
; * Sections
section .bss
    ; first_var db 8
section .data
    par_rune equ 0
    par_key_rune equ 8
    ptr_populated_matrix equ 16
section .text
; * The Encryption Function
encryptChar:
    ; * Initialize first_var with a value
    ; mov byte [first_var], 8
    ; * DONE
    push rbp
    mov rbp , rsp
    sub rsp , 8 * 4
    mov [rsp + par_rune] , rsi
    mov [rsp + par_key_rune] , rdx
    mov [rsp + ptr_populated_matrix] , rdi
    ; * Clearing the Registers
    xor r10 , r10
    xor r15 , r15
    xor r14 , r14
    ; * Finding the Column
    first_loop:
        cmp r10 , 13 * 2
        jz end_first_loop
        ; * Continue: False Condition
        mov r15 , [rsp + ptr_populated_matrix]
        mov r15 , [r15]
        add r15 , r10
        movsx r15 , byte [r15]
        cmp r15 , [rsp + par_rune]
        jz end_first_loop
        ; * Increment the r10 Register
        inc r10
        jmp first_loop

    end_first_loop:
    mov [rsp + par_rune] , r10
    ; * Clearing the Registers
    xor r11 , r11
    xor r14 , r14
    xor r15 , r15
    ; * Finding the Row
    find_the_row_loop:
        cmp r11 , 13 * 2
        jz end_find_the_row_loop
        ; * Continue: False Condition
        xor rax , rax
        mov rax , 8
        ; mov rax , [first_var]
        mul r11
        mov r15 , [rsp + ptr_populated_matrix]
        add r15 , rax
        mov r14 , [r15]
        movsx r14 , byte [r14]
        cmp r14 , [rsp + par_key_rune]
        jz end_find_the_row_loop
        ; * Increment the r11 Register
        inc r11
        jmp find_the_row_loop

    end_find_the_row_loop:
    mov [rsp + par_key_rune] , rax
    ;  * Clearing the Registers
    xor r10 , r10
    xor r11 , r11
    xor r15 , r15
    ; * Returning the Correct Character
    mov r10 , [rsp + par_rune]
    mov r11 , [rsp + par_key_rune]
    mov r15 , [rsp + ptr_populated_matrix]
    add r15 , r11
    mov r15 , [r15]
    add r15 , r10
    mov rax , [r15]
    ; * The End of Function
    leave
    ret