; * Inports and Exports
global allocateBook
extern malloc
extern strcpy

section .data
struc Book
    .isbn resb 13
    .title resb 50
    .price resd 1  ; Use resd for single-precision float
    .quantity resd 1
endstruc

section .text
allocateBook:
    push rbp
    mov rbp, rsp

    ; Stack memory allocation for the Book structure
    mov rdi, (13 + 50 + 4 + 4)
    call malloc

    ; Pointer to the new Book Structure
    mov rbx, rax

    ; Copy ISBN and Title directly from parameters
    mov rax, rdi ; isbn
    mov rcx, rsi ; title

    mov rdi, rbx
    add rdi, Book.isbn
    call strcpy

    mov rdi, rbx
    add rdi, Book.title
    call strcpy

    ; Copy Price and Quantity
    mov eax, [rbp + 32] ; Load the integer value (quantity)
    mov [rbx + Book.quantity], eax ; Store it in the structure

    mov eax, [rbp + 40] ; Load the integer value (quantity)
    mov [rbx + Book.price], eax ; Store it in the structure

    ; Returning the Pointer to the Book Structure
    mov rax, rbx

    ; The End of Function
    pop rbp
    ret
