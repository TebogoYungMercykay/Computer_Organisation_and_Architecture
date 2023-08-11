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
  mov eax, 0 ; This can be deleted, it just keeps function from causing a runtime error until completed
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret