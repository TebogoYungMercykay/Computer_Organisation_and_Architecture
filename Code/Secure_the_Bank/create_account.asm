; This tells the function that these exist outside of this file
extern greeting
extern get_pin
extern obscure_pin
extern calculate_balance
extern calculate_account

; This makes your function available to other files
global create_account

section .data
; ==========================
; Your data goes here
  acc_ptr dq 0
  pin_ptr dq 0
  bal_ptr dq 0
  acc_num_val dd 0
  pin_val dd 0
; ==========================

section .text
; void create_account(char *account_number, char *obscured_pin, char *balance)
; 
; Inputs:
;   rdi - account number
;   rsi - pin
;   rdx - balance
; 
; README:
; A lot has been given to start you off. You should be able to complete this without fully understanding how
; the functions work. I recommend using the foundation provided, however, you are free to change it as you see fit.
create_account:
  push rbp
  mov rbp, rsp
  sub rsp, 32

  mov qword [acc_ptr], rdi
  mov qword [pin_ptr], rsi
  mov qword [bal_ptr], rdx

  ; Greet the user (Diplomacy)
  call greeting

  ; Get the pin as a 32 bit integer
  call get_pin ; Call get_pin function
  mov [pin_val], eax  ; save pin

  ; Calculate the account number
  mov edi, eax
  call calculate_account
  mov [acc_num_val], eax  ; save account number

  ; Calculate the balance
  mov edi, eax  ; set account number as the first argument to calculate balance
  mov esi, [pin_val]  ; set pin as the second argument to calculate balance
  call calculate_balance

  ; Convert the balance to ascii and store it in the balance pointer

  ; Convert the pin to ascii and store it in the pin pointer

  ; Convert the account number to ascii and store it in the account number pointer

  ; Output account message

  ; Output account number

  ; Output balance message

  ; Output balance

  ; Obsfucate the pin

  ; Output pin message

  ; Output obscured pin

  leave
  ret
