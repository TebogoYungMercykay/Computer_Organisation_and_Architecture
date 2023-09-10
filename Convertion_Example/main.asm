; Disassembly of file: main.o
; Sun Sep 10 15:00:53 2023
; Type: ELF64
; Syntax: NASM
; Instruction set: 8086, x64

default rel

global main: function

extern puts                                             ; near
extern _GLOBAL_OFFSET_TABLE_                            ; byte


SECTION .text   align=1 exec                            ; section number 1, code

main:   ; Function begin
        endbr64                                         ; 0000 _ F3: 0F 1E. FA
        push    rbp                                     ; 0004 _ 55
        mov     rbp, rsp                                ; 0005 _ 48: 89. E5
        lea     rdi, [rel ?_001]                        ; 0008 _ 48: 8D. 3D, 00000000(rel)
        call    puts                                    ; 000F _ E8, 00000000(PLT r)
        mov     eax, 0                                  ; 0014 _ B8, 00000000
        pop     rbp                                     ; 0019 _ 5D
        ret                                             ; 001A _ C3
; main End of function


SECTION .data   align=1 noexec                          ; section number 2, data


SECTION .bss    align=1 noexec                          ; section number 3, bss


SECTION .rodata align=1 noexec                          ; section number 4, const

?_001:                                                  ; byte
        db 48H, 65H, 6CH, 6CH, 6FH, 2CH, 20H, 57H       ; 0000 _ Hello, W
        db 6FH, 72H, 6CH, 64H, 21H, 00H                 ; 0008 _ orld!.


SECTION .note.gnu.property align=8 noexec               ; section number 5, const

        db 04H, 00H, 00H, 00H, 10H, 00H, 00H, 00H       ; 0000 _ ........
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 00H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 03H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0018 _ ........


