; * Inports and Exports
global encryptString
extern encryptChar
extern strlen
extern printf
extern malloc

; * Sections
section .data
    message equ 0
    keyword equ 8
    message_length equ 24
    keyword_length equ 32
    number_of_spaces equ 40
    stack_message equ 48
    stack_keyword equ 56
    ptr_matrix equ 16
section .bss
    return_string resb 8
    ; first_var db 8
section .text

; * The Encryption Function
encryptString:
    ; * Initialize first_var with a value
    ; mov byte [first_var] , 8
    ; * DONE
    push rbp
    mov rbp , rsp
    sub rsp , 8 * 8
    mov [rsp + stack_message] , rsi
    mov [rsp + stack_keyword] , rdx
    mov [rsp + ptr_matrix] , rdi
    xor r10 , r10
    xor rcx , rcx
    mov r10 , [rsp + stack_message]
    xor r11 , r11

    ; * Calculating the Message Length
    calc_message_length:
        cmp byte [r10] , 0
        je end_calc_message_length

        cmp byte [r10] , 8 * 4
        jz encountered_space

        inc r11
        inc r10
        inc rcx
        jmp calc_message_length

        encountered_space:
        inc r10
        inc rcx
        jmp calc_message_length
    end_calc_message_length:

    mov [rsp + message_length] , rcx
    mov [rsp + number_of_spaces] , r11

    ; * Allocating Memory for the return_string (length in r11)
    mov rdi , r11
    inc rdi
    call malloc
    mov [return_string] , rax

    ; * Calculating the Keyword Length
    mov r10 , [rsp + stack_keyword]
    xor rcx , rcx
    calc_keyword_length:
        cmp byte [r10] , 0
        je end_calc_keyword_length

        inc r10
        inc rcx
        jmp calc_keyword_length
    end_calc_keyword_length:
    mov [rsp + keyword_length] , rcx
    ; * Clearing the Registers
    xor r12 , r12
    xor rcx , rcx
    xor r9 , r9
    xor r13 , r13

    loop_string_encryption:
        cmp r12b , byte [rsp + message_length]
        jz end_string_encryption

        mov r13 , [rsp + stack_message]
        add r13 , r12
        movsx r8 , byte[r13]
        ;test if r13 is holding a space
        cmp byte [r13] , 8 * 4
        jz encountered_space_m
        movsx r13 , byte [r13]
        mov [rsp + message] , r13

        mov r13 , [rsp + stack_keyword]
        add r13 , rcx
        movsx r13 , byte [r13]
        mov [rsp + keyword] , r13

        ; ***** Must Call The Encrypt Char Here *****
        ; * Clearing the Registers
        xor r10 , r10
        xor r15 , r15
        xor r14 , r14
        ; * Finding the Column
        first_loop:
            cmp r10 , 13 * 2
            jz end_first_loop
            ; * Continue: False Condition
            mov r15 , [rsp + ptr_matrix]
            mov r15 , [r15]
            add r15 , r10
            movsx r15 , byte [r15]
            cmp r15 , [rsp + message]
            jz end_first_loop
            ; * Increment the r10 Register
            inc r10
            jmp first_loop

        end_first_loop:
        mov [rsp + message] , r10
        ; * Clearing the Registers
        xor r11 , r11
        xor r14 , r14
        xor r15 , r15
        ; * Finding the Row
        find_the_row_loop:
            cmp r11 , 13 * 2
            jz end_find_the_row_loop
            ; * Continue: False Condition
            ; xor rax , rax
            mov rax , 8
            mul r11
            mov r15 , [rsp + ptr_matrix]
            add r15, rax
            mov r14, [r15]
            movzx r14, byte [r14]
            cmp r14 , [rsp + keyword]
            jz end_find_the_row_loop
            ; * Increment the r11 Register
            inc r11
            jmp find_the_row_loop
        end_find_the_row_loop:
        ; xor r10 , r10
        ; xor r11 , r11
        ; xor r15 , r15
        mov [rsp + keyword] , rax
        ; * Returning the Correct Character
        mov r10 , [rsp + message]
        mov r11 , [rsp + keyword]
        mov r15 , [rsp + ptr_matrix]
        add r15 , r11
        mov r15 , [r15]
        add r15 , r10

        mov r13 , [return_string]
        add r13 , r9
        ; movsx r13 , byte [r13]
        movsx r15 , byte [r15]
        mov [r13] , r15b

        inc r12
        inc rcx
        mov r13 , [rsp + keyword_length]

        cmp rcx , r13
        jz clear_rcx_register
        jmp inrement_r9_register

        clear_rcx_register:
            xor rcx , rcx
        inrement_r9_register:
            inc r9
        jmp loop_string_encryption

        encountered_space_m:
            inc r12
            jmp loop_string_encryption
    end_string_encryption:
    ; * The End of The Encryption Function
    mov r13 , [return_string]
    mov r9 , [rsp + number_of_spaces]
    inc r9
    add r13 , r9
    xor r9 , r9
    mov [r13] , r9

    mov r13 , [return_string]
    mov r9 , 5
    add r13 , r9

    movsx r13 , byte [r13]
    mov rax , [return_string]

    leave
    ret