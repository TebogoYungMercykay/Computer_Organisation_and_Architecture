; This makes your function available to other files
global calculate_balance

section .data
; ==========================
; Your data goes here
; ==========================

section .text
; Calculate balance based on account number and pin
; Inputs:
;   rdi - account number
;   rsi - pin
; Outputs:
;   eax - balance
calculate_balance:
  push rbp
  mov rbp, rsp

; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
  mov eax, edi  ; account number - A
  mov ebx, esi  ; pin - P

  ; ****** Calculating B' = ((A + P) * P) & (P ^ A) ******
  ; LHS: ((A + P) * P)
  add eax, ebx
  imul eax, ebx
  ; RHS: (P ^ A)
  mov edx, edi
  xor edx, ebx
  ; LHS AND RHS
  and eax, edx
  ; ****** Calculating B = (B' mod 50000) ******
  mov ebx, 50000
  xor edx, edx
  div ebx
  ; ****** Moving the Result into Register eax the Adding 50000 ******
  mov eax, edx
  add eax, 50000
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret
