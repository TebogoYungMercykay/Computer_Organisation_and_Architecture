; This makes your function available to other files
; This makes your function available to other files
global get_pin

section .data
; ==========================
; Your data goes here
; ==========================

section .text
; uint32_t get_pin()
; Reads a 4-digit PIN from stdin and converts it to an integer.
; The PIN returned must be a valid 4-digit (32-bit) integer.
get_pin:
  push rbp
  mov rbp, rsp
; Do not modify anything above this line unless you know what you are doing
; ==========================
; Your code goes here
; 
; Print the message that asks for a pin
; 
; Read the pin from stdin and store it in a buffer
; 
; Convert the pin to an integer
; 
; Store the integer in eax
  mov eax, 0 ; This can be deleted, it just keeps function from causing a runtime error until completed
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret