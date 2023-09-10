; * I wrote the Code in C and used objconv to convert it to 64-bit x86 NASM
; Disassembly of file: main.o
; Sun Sep 10 10:53:43 2023
; Type: ELF64
; Syntax: NASM
; Instruction set: SSE2, x64
; * C Code
; struct Book {
;     char isbn[13];
;     char title[50];
;     float price;
;     int quantity;
; };
; extern struct Book *allocateBook(char *isbn, char *title, float price, int quantity);
;
; struct Library {
;     struct Book books[5];
;     int count;
; };
; struct Library *initialiseLibrary(void) {
;     struct Library *lib = (struct Library *)malloc(sizeof(struct Library));
;     if (lib != NULL) {
;         lib->count = 0;
;     }
;     return lib;
; }
; int addBook(struct Library *lib, struct Book *book) {
;     if (lib == NULL || lib->count >= 5 || book == NULL) {
;         return 0;
;     }
;     for (int i = 0; i < lib->count; i++) {
;         struct Book *libraryBook = &lib->books[i];
;         if (strcmp(libraryBook->isbn, book->isbn) == 0) {
;             libraryBook->quantity += book->quantity;
;             return 1;
;         }
;     }
;     struct Book *libraryBook = &lib->books[lib->count];
;     strcpy(libraryBook->isbn, book->isbn);
;     strcpy(libraryBook->title, book->title);
;     libraryBook->price = book->price;
;     libraryBook->quantity = book->quantity;
;     lib->count++;
;     return 1;
; }
; struct Book *searchBookByISBN(struct Library *lib, char *isbn) {
;     if (lib == NULL || isbn == NULL) {
;         return NULL;
;     }
;     for (int i = 0; i < lib->count; i++) {
;         struct Book *book = &lib->books[i];
;         if (strcmp(book->isbn, isbn) == 0) {
;             return book;
;         }
;     }
;     return NULL;
; }
; * Assembly Code: 64-bit x86 NASM -- STARTS HERE
; Disassembly of file: main.o
; Sun Sep 10 11:47:07 2023
; Type: ELF64
; Syntax: NASM
; Instruction set: SSE2, x64
default rel

global initialiseLibrary: function
global addBook: function
global searchBookByISBN: function

extern strcpy
extern strcmp
extern malloc
extern _GLOBAL_OFFSET_TABLE_

SECTION .text align=1 exec
; * The Initialise Library Function
initialiseLibrary:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     edi, 364
        call    malloc
        mov     qword [rbp-8H], rax
        cmp     qword [rbp-8H], 0
        jz      ?_001
        mov     rax, qword [rbp-8H]
        mov     dword [rax+168H], 0
?_001:  mov     rax, qword [rbp-8H]
        ; * The End of Function
        leave
        ret

; * The Add Book Function
addBook:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        mov     qword [rbp-28H], rdi
        mov     qword [rbp-30H], rsi
        cmp     qword [rbp-28H], 0
        jz      ?_002
        mov     rax, qword [rbp-28H]
        mov     eax, dword [rax+168H]
        cmp     eax, 4
        jg      ?_002
        cmp     qword [rbp-30H], 0
        jnz     ?_003
?_002:  mov     eax, 0
        jmp     ?_007

?_003:  mov     dword [rbp-14H], 0
        jmp     ?_006

?_004:  mov     eax, dword [rbp-14H]
        movsxd  rdx, eax
        mov     rax, rdx
        shl     rax, 3
        add     rax, rdx
        shl     rax, 3
        mov     rdx, qword [rbp-28H]
        add     rax, rdx
        mov     qword [rbp-8H], rax
        mov     rdx, qword [rbp-30H]
        mov     rax, qword [rbp-8H]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcmp
        test    eax, eax
        jnz     ?_005
        mov     rax, qword [rbp-8H]
        mov     edx, dword [rax+44H]
        mov     rax, qword [rbp-30H]
        mov     eax, dword [rax+44H]
        add     edx, eax
        mov     rax, qword [rbp-8H]
        mov     dword [rax+44H], edx
        mov     eax, 1
        jmp     ?_007

?_005:  add     dword [rbp-14H], 1
?_006:  mov     rax, qword [rbp-28H]
        mov     eax, dword [rax+168H]
        cmp     dword [rbp-14H], eax
        jl      ?_004
        mov     rax, qword [rbp-28H]
        mov     eax, dword [rax+168H]
        movsxd  rdx, eax
        mov     rax, rdx
        shl     rax, 3
        add     rax, rdx
        shl     rax, 3
        mov     rdx, qword [rbp-28H]
        add     rax, rdx
        mov     qword [rbp-10H], rax
        mov     rdx, qword [rbp-30H]
        mov     rax, qword [rbp-10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcpy
        mov     rax, qword [rbp-30H]
        lea     rdx, [rax+0DH]
        mov     rax, qword [rbp-10H]
        add     rax, 13
        mov     rsi, rdx
        mov     rdi, rax
        call    strcpy
        mov     rax, qword [rbp-30H]
        movss   xmm0, dword [rax+40H]
        mov     rax, qword [rbp-10H]
        movss   dword [rax+40H], xmm0
        mov     rax, qword [rbp-30H]
        mov     edx, dword [rax+44H]
        mov     rax, qword [rbp-10H]
        mov     dword [rax+44H], edx
        mov     rax, qword [rbp-28H]
        mov     eax, dword [rax+168H]
        lea     edx, [rax+1H]
        mov     rax, qword [rbp-28H]
        mov     dword [rax+168H], edx
        mov     eax, 1
        ; * The End of Function
?_007:  leave
        ret

; * The Search Book By ISBN Function
searchBookByISBN:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        cmp     qword [rbp-18H], 0
        jz      ?_008
        cmp     qword [rbp-20H], 0
        jnz     ?_009
?_008:  mov     eax, 0
        jmp     ?_013

?_009:  mov     dword [rbp-0CH], 0
        jmp     ?_012

?_010:  mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, rdx
        shl     rax, 3
        add     rax, rdx
        shl     rax, 3
        mov     rdx, qword [rbp-18H]
        add     rax, rdx
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        mov     rdx, qword [rbp-20H]
        mov     rsi, rdx
        mov     rdi, rax
        call    strcmp
        test    eax, eax
        jnz     ?_011
        mov     rax, qword [rbp-8H]
        jmp     ?_013
?_011:  add     dword [rbp-0CH], 1
?_012:  mov     rax, qword [rbp-18H]
        mov     eax, dword [rax+168H]
        cmp     dword [rbp-0CH], eax
        jl      ?_010
        mov     eax, 0
        ; * The End of Function
?_013:  leave
        ret

; * Sections
SECTION .data   align=1 noexec

SECTION .bss    align=1 noexec

SECTION .note.gnu.property align=8 noexec

        db 04H, 00H, 00H, 00H, 10H, 00H, 00H, 00H
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H
        db 02H, 00H, 00H, 0C0H, 04H, 00H, 00H, 00H
        db 03H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
