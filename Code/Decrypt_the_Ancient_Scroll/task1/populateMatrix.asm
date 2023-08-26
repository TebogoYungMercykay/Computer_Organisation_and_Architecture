; * Inports and Exports
global populateMatrix
extern malloc
extern printf
; * Sections
section .bss
    size_matrix_ptr resb 8
section .data
    first_var db 8
section .text
; * The Function
populateMatrix:
    push rbp
    mov rbp , rsp
    ; * Stack memory allocation
    the_varchar equ 0
    mov rax, [first_var]
    shl rax, 1
    sub rsp, rax
    mov rdi , 26 * 8
    call malloc
    mov [size_matrix_ptr] , rax
    ; * Creating the 2D Array
    xor r15 , r15
    mov r14 , [first_var]
    first_loop:
        cmp r15 , 26
        jz end_first_loop
        ; * 26 bytes for each Character
        mov rdi , 26
        call malloc
        mov [rsp + the_varchar] , rax
        xor rax , rax
        mov rax , [first_var]
        mul r15
        ; * Adding 8-byte memory offset for pointers [size_matrix_ptr + rax]
        mov rdi, [rsp + the_varchar]
        mov [size_matrix_ptr + rax] , rdi
        mov [rdi] , r15
        ; * Incrementing counter
        inc r15
        jmp first_loop
    end_first_loop:
    ; * Populating the Array
    xor r10 , r10
    xor r11 , r11
    xor r12 , r12
    ; * Setting All Indexes to Char 'A'
    init_array_with_A:
        cmp r10 , 26
        jz end_init_array_with_A
        mov rax , [first_var]
        mul r10
        mov r15, [size_matrix_ptr + rax]
        mov r12 , 8 * 8 + 1
        mov [r15] , r12
        inc r10
        jmp init_array_with_A
    end_init_array_with_A:
    xor r10 , r10
    xor r11 , r11
    mov r12 , 8 * 8 + 1
    xor r14 , r14
    ; * Cipher block
    looping_through_rows:
        cmp r10 , 26
        jz end_looping_through_rows
        looping_through_cols:
            cmp r11 , 26
            jz end_looping_through_cols
            mov rax , [first_var]
            mul r10
            mov r15, [size_matrix_ptr + rax]
            add r15 , r11
            mov [r15] , r12
            add [r15] , r10
            ; * Wrapping around
            mov r14 , [r15]
            cmp r14 , 12 * 8 - 6
            jg cmp_greater_than
            jmp cmp_end_part
            cmp_greater_than:
                mov r14 , 12 * 8 - 6
                sub [r15] , r14
                mov r14 , 8 * 8
                add [r15] , r14
            cmp_end_part:
                mov r14 , [r15]
            inc r11
            inc r12
            jmp looping_through_cols
        end_looping_through_cols:
            mov r12 , 8 * 8 + 1
            xor r11 , r11
            inc r10
            jmp looping_through_rows
    end_looping_through_rows:
    mov rax , size_matrix_ptr
    ; * The End of Function: Load parameter to be returned
    leave
    ret