global obscure_pin

section .data
; ==========================
; Your data goes here
  mask db 0Fh, 0Fh, 0Fh, 0Fh
; ==========================

; void obscure_pin(char* pin)
; Obscures a 4-digit ASCII PIN in place.
; Assumes pin is in rdi.
section .text
obscure_pin:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
  ; ***** load PIN digits *****
  mov rsi, rdi  ; rsi holds the address of the string pointer
  ; ***** obscure digits *****
  movdqa xmm0, [mask]
  ; Appliying XOR to the PIN digits with the mask
  movdqu xmm1, [rsi]
  pxor xmm1, xmm0
  movdqu [rsi], xmm1
  ; ***** convert back to ASCII and store in reverse order *****
  ; Reversing the First and the Last Digit
  mov al, byte [rsi + 1]
  mov ah, byte [rsi + 2]
  mov [rsi + 1], ah
  mov [rsi + 2], al
  ; Reversing the Middle Two digits
  mov al, byte [rsi]
  mov ah, byte [rsi + 3]
  mov [rsi], ah
  mov [rsi + 3], al
; ==========================
; Do not modify anything below this line unless you know what you are doing

  leave
  ret
