TITLE Assignment 1   (Assignment1.asm)
; Lucy Wyman	wymanl@onid.oregonstate.edu
; CS 271 400
; Assignment 1
; Description: Prints introduction and instructions to user, gets 2 numbers from the user, performs addition, subtraction, multiplication and division, and prints results and goodbye.

INCLUDE Irvine32.inc

.data

num1			DWORD	?	; first integer
num2			DWORD	?	; int by user
intro			BYTE	"Elementary Arithmetic by Lucy Wyman", 0 ; Introduction
instructions	BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0 ; Instructions
ec1				BYTE	"**EC: Repeat program until the user decides to quit", 0  ; Print extra credit option
ec2				BYTE	"**EC: Validate that the second number is less than the first", 0 ; Second EC option
num1_prompt		BYTE	"Enter the first number: ", 0 
num2_prompt		BYTE	"Enter the second number: ", 0
error			BYTE	"Oops! The first number must be larger than the second. Try again", 0 ; Error if second input is greater than first
plus			BYTE	"+", 0
minus			BYTE	"-", 0
star			BYTE	"*", 0 
slash			BYTE	"/", 0 ; Because words like add and sub are taken, I got creative with the variable names here.
equals			BYTE	"=", 0
remainder		BYTE	" remainder ", 0
add_result		DWORD	?
sub_result		DWORD	?
mult_result		DWORD	?
div_result		DWORD	?
rem_result		DWORD	?
repeat_q		BYTE	"Would you like to calculate again? 1 for yes, 0 for no: ", 0
rep_input		DWORD	1 ; This will only be 1 character, so is limited to 1. We'll assume user correctly inputs either Y or N
goodbye			BYTE	"Goodbye!", 0

.code

main PROC

	call	Clrscr	; Make sure screen is cleared

; Introduce programmer
	mov		edx, OFFSET	intro	; Set edx to be the address of the intro variable
	call	WriteString
	call	CrLf ; Carried return line freed
; Extra credit print
	mov		edx, OFFSET ec1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ec2
	call	WriteString
	call	CrLf
; Instructions
	mov		edx, OFFSET	instructions
	call	WriteString
	call	CrLf 

; Begin program loop
	calculate:
	; Get both numbers from the user input
		mov		edx, OFFSET num1_prompt
		call	Writestring	
		call	ReadInt		; Read in integer from the user
		mov		num1, eax	; Move user input from eax to variable
		mov		edx, OFFSET num2_prompt
		call	WriteString
		call	ReadInt
		mov		num2, eax
		call	CrLf
	; Ensure the second number is less than the first
		mov		eax, num1
		mov		ebx, num2
		cmp		eax, ebx
		jae		ifNoError
		mov		edx, OFFSET error
		call	WriteString
		call	CrLf
		jmp		calculate		

	ifNoError:
	; Calculate results
		; Addition
		mov		eax, 0		; Clear eax
		mov		eax, num1	; Move first number to eax
		add		eax, num2	; Add first number to second number
		mov		add_result, eax ; Move result into variable. 
		; Subtraction
		mov		eax, 0
		mov		eax, num1
		sub		eax, num2
		mov		sub_result, eax
		; Multiplication
		mov		eax, 0
		mov		eax, num1
		mov		ebx, num2
		mul		ebx
		mov		mult_result, eax
		; Division
		mov		eax, 0
		mov		eax, num1
		mov		ebx, num2
		div		ebx
		mov		div_result, eax
		mov		rem_result, edx

	; Report result
		; Report addition result
		mov		eax, num1
		call	WriteDec
		mov		edx, OFFSET plus
		call	WriteString
		mov		eax, num2
		call	WriteDec
		mov		edx, OFFSET equals
		call	WriteString
		mov		eax, add_result
		call	WriteDec
		call	CrLf
		; Report subtraction result
		mov		eax, num1
		call	WriteDec
		mov		edx, OFFSET minus
		call	WriteString
		mov		eax, num2
		call	WriteDec
		mov		edx, OFFSET equals
		call	WriteString
		mov		eax, sub_result
		call	WriteDec
		call	CrLf
		; Report multiplication result
		mov		eax, num1
		call	WriteDec
		mov		edx, OFFSET star
		call	WriteString
		mov		eax, num2
		call	WriteDec
		mov		edx, OFFSET equals
		call	WriteString
		mov		eax, mult_result
		call	WriteDec
		call	CrLf
		; Report division result
		mov		eax, num1
		call	WriteDec
		mov		edx, OFFSET slash
		call	WriteString
		mov		eax, num2
		call	WriteDec
		mov		edx, OFFSET equals
		call	WriteString
		mov		eax, div_result
		call	WriteDec
		mov		edx, OFFSET remainder
		call	WriteString
		mov		eax, rem_result
		call	WriteDec
		call	CrLf

	; Ask user if they want to calculate again
		mov		edx, OFFSET repeat_q
		call	WriteString
		call	ReadInt
		mov		rep_input, eax ; Get users answer and mov into variable
		mov		ebx, rep_input
		; Compare user input with YES constant
		cmp		ebx, 1
		; If they are equal, jump back to calculate label
		je		calculate

; Exit
	mov		edx, OFFSET	goodbye
	call	WriteString
	call	CrLf

exit ; Exit to Operating System
main ENDP

END main
