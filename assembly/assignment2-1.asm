TITLE Assignment 2	(assignment2.asm)
; Lucy Wyman	wymanl@onid.oregonstate.edu
; CS 271 400
; Assignment 2
; Description: Get users name, greet user, and print user-input iterations of the fibonacci sequence.

INCLUDE Irvine32.inc

.data

userName		BYTE	33 DUP(0) ; Users name, max of 32 characters
intro			BYTE	"Fibonacci Numbers by Lucy Wyman", 0
getName			BYTE	"What's your name? ", 0
helloUser		BYTE	"Hello, ", 0
instructions	BYTE	"Enter the number of Fibonacci terms to be displayed.", 0
instructions2	BYTE	"The number must be an integer between 1 and 46 inclusive", 0
getIterations	BYTE	"How many Fibonacci terms would you like? ", 0
numIterations	DWORD	? ; The number of fibonacci numbers to print
num1			DWORD	? ; In fibonacci addition, the first number to add.
num2			DWORD	? ; The second number to add
sum				DWORD	? ; The sum of those two numbers, and next in the fibonacci sequence
count			DWORD	? ; How many iterations have happened
remainder		DWORD	? ; If we need to print a newline
space			BYTE	"	",0 ; Tab instead of space to align columns
rangeError		BYTE	"Oops! Your number is out of range.  Enter a number between 1 and 46", 0
ec1				BYTE	"** EC: Display the numbers in aligned columns", 0
ec2				BYTE	"** EC: Do something incredible", 0
goodbye			BYTE	"Goodbye, ", 0

.code

main PROC

	call	Clrscr

; Introduce program
	mov		edx, OFFSET intro
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ec1
	call	WriteString
	call	CrLf

; Get user's name
	mov		edx, OFFSET getName
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString

; Greet user
	mov		edx, OFFSET helloUser
	call	Writestring
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

; Instructions (userInstruction)
	mov		edx, OFFSET instructions
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instructions2
	call	WriteString
	call	CrLf

; Get number of iterations 
	getIterLoop:
		mov		edx, OFFSET getIterations
		call	WriteString
		call	ReadInt
		mov		numIterations, eax

; Verify that number is within range
		mov		ebx, numIterations
		cmp		ebx, 47
		jge		outOfRange ; If the number is greater than 46, go to error message instructions
		cmp		ebx, 0
		jle		outOfRange ; If the number is less than 1, go to error message instructions
		jmp		initialize ; If neither, skip ahead to calculation

	outOfRange: ; Print error and go back to get user number loop
		mov		edx, OFFSET rangeError
		call	WriteString
		call	CrLf
		jmp		getIterLoop

; Calculate fibonacci numbers
	initialize:
		; Set ecx for loop count
		mov		eax, numIterations ; First we need to subtract two from the count to account for inital 1's that are printed
		sub		eax, 1
		mov		numIterations, eax
		mov		ecx, numIterations
		; Set first two numbers to 0 and 1
		mov		num1, 0
		mov		num2, 1
		mov		sum, 1
		call	CrLf
		mov		eax, num2
		mov		edx, OFFSET space
		call	WriteDec
		call	WriteString

	calculate: 
		; Print number
		mov		eax, sum
		mov		edx, OFFSET space
		call	WriteDec
		call	WriteString

		add		eax, num1	; Add first number to sum
		add		eax, num2	; Add second number to sum
		mov		sum, eax	; Move the sum to variable
		mov		eax, num2	; Set first number equal to old second number
		mov		num1, eax	; Populate variable
		mov		eax, sum	; Set second number equal to sum
		mov		num2, eax	; Populat variable

		; Increment counter
		inc		ebx 
		mov		edx, 0
		mov		count, ebx

		; Check if output needs newline
		mov		eax, count
		mov		ebx, 5
		div		ebx
		mov		remainder, edx
		cmp		remainder, 0
		jne		noNewLine

		newLine:
			call	CrLf

		noNewLine:
			mov		edx, 0 ; reset edx
			mov		eax, 0 ; reset eax
			mov		ebx, count

		loop calculate

; Exit
	sayGoodbye:
		call	CrLf
		mov		edx, OFFSET	goodbye
		call	WriteString
		mov		edx, OFFSET userName
		call	WriteString
		call	CrLf

exit ; Exit to Operating System
main ENDP

END main
