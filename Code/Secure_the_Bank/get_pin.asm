; This makes your function available to other files
global get_pin

section .data
; ==========================
; Your data goes here
  pin_prompt db "Enter 4-digit PIN: ", 0
  input db 0
  output db 0
  newline db 10
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
  mov rax, 1
  mov rdi, 1
  lea rsi, [pin_prompt]
  mov rdx, 19
  syscall
; 
; Read the pin from stdin and store it in a buffer
  mov rax, 0
  mov rdi, 0
  lea rsi, [input]
  mov rdx, 5
  syscall
; 
; Convert the pin to an integer
  movzx eax, byte [input]
  sub al, '0'
  movzx ebx, byte [input + 1]
  sub bl, '0'
  movzx ecx, byte [input + 2]
  sub cl, '0'
  movzx edx, byte [input + 3]
  sub dl, '0'
; 
; Store the integer in eax
  mov edi, 10
  imul eax, edi
  add eax, ebx
  imul eax, edi
  add eax, ecx
  imul eax, edi
  add eax, edx
; ==========================
; Do not modify anything below this line unless you know what you are doing
  leave
  ret
