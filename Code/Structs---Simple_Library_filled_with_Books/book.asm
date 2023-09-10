; * I wrote the Code in C and used objconv to convert it to 64-bit x86 NASM
; Disassembly of file: main.o
; Sun Sep 10 10:53:43 2023
; Type: ELF64
; Syntax: NASM
; Instruction set: SSE2, x64
; * C Code
; struct Book
; {
;     char isbn[13];
;     char title[50];
;     float price;
;     int quantity;
; };

; struct Book* allocateBook(char * isbn, char * title, float price, int quantity){
;     struct Book* book = malloc(sizeof(struct Book));
;     strcpy(book->isbn, isbn);
;     strcpy(book->title, title);
;     book->price = price;
;     book->quantity = quantity;
;     return book;
; }
; * Assembly Code: 64-bit x86 NASM -- STARTS HERE
default rel

; * Inports and Exports
global allocateBook: function

extern strcpy
extern malloc
extern _GLOBAL_OFFSET_TABLE_


SECTION .text   align=1 exec
; * The Allocate Book Function
allocateBook:
        endbr64
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        ; * Parameters from the Stack
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        movss   dword [rbp-24H], xmm0
        mov     dword [rbp-28H], edx
        ; * Stack memory allocation
        mov     edi, 72
        call    malloc
        ; * A new Book Structure with the Given Parameters
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        mov     rdx, qword [rbp-18H]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcpy
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+0DH]
        mov     rax, qword [rbp-20H]
        mov     rsi, rax
        mov     rdi, rdx
        call    strcpy
        mov     rax, qword [rbp-8H]
        movss   xmm0, dword [rbp-24H]
        movss   dword [rax+40H], xmm0
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rbp-28H]
        mov     dword [rax+44H], edx
        ; * Returning the Pointer to the Book Structure
        mov     rax, qword [rbp-8H]
        ; * The End of Function
        leave
        ret

; * Sections
SECTION .data   align=1 noexec

SECTION .bss    align=1 noexec

SECTION .note.gnu.property align=8 noexec

        db 04H, 00H, 00H, 00H, 10H, 00H, 00H, 00H
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H
        db 02H, 00H, 00H, 0C0H, 04H, 00H, 00H, 00H
        db 03H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
