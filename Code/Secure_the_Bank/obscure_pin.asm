global obscure_pin

section .data
; ==========================
; Your data goes here
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
  ; load PIN digits
  ; obscure digits
  ; convert back to ASCII and store in reverse order
; ==========================
; Do not modify anything below this line unless you know what you are doing

  leave
  ret