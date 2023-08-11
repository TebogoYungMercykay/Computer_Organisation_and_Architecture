; This makes your function available to other files
global greeting

section .data
; ==========================
; Your data goes here
; ==========================

section .text
; void greeting()
; This function prints a greeting to the screen
greeting:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret