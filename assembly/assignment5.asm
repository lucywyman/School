TITLE Assignment 5	(assignment5.asm)
; Lucy Wyman	wymanl@onid.oregonstate.edu
; CS 271 400
; Assignment 5
; Description

INCLUDE Irvine32.inc

arraySize	=	10	; Number of numbers to be read

STACK_FRAME macro
	push	ebp
	mov		ebp, esp
ENDM

getString			MACRO	var, string
	push			ecx
	push			edx
	displayString	string
	mov				edx, OFFSET var
	mov				ecx, (SIZEOF var) - 1
	call			ReadString
	pop				edx
	pop				ecx
ENDM

displayString		MACRO	string
	push	edx
	mov		edx, OFFSET string
	call	WriteString
	pop		edx
ENDM

.data
array			DWORD	arraySize DUP(?)
intro1			BYTE	"Low-level I/O Procedures by Lucy Wyman", 0
intro2			BYTE	"Please input 10 unsigned decimal integers between 0 and 4,294,967,295", 0
intro3			BYTE	"Once you've entered the numbers, I'll print them as a list", 0
intro4			BYTE	"along with their sum and average.", 0
prompt			BYTE	"Please enter a number: ", 0
oops			BYTE	"Oops!  That was a valid input. Please enter an integer between 0 and 4,294,967,295: ", 0
count			DWORD	? ; Count of how many values the user has entered
input			BYTE	32 DUP(?)
inputLength		DWORD	0
number			DWORD	?
sum				DWORD	?
sumMessage		BYTE	"The sum of these numbers is ", 0
averageMessage	BYTE	"The average of these numbers is ", 0
comma			BYTE	", ", 0
readBack		BYTE	"You entered: ", 0


.code

main PROC
	; Print introduction
	call	introduction

	call	getInput

	; Calculate the sum
	push	OFFSET array
	push	arraySize
	push	sum
	call	calculateSum

	; Calculate the average
	push	sum
	push	arraySize
	call	calculateAverage

	call	CrLf
	exit
main ENDP

;--------------------------------------------------------- 
; Introduces the program to the user 
; Receives: Nothing 
; Returns: Nothing 
;--------------------------------------------------------- 

introduction	PROC
	displayString	intro1
	call	CrLf
	displayString	intro2
	call	CrLf
	displayString	intro3
	call	CrLf
	displayString	intro4
	call	CrLf
	displayString	prompt
	call	CrLf
	ret
introduction	ENDP

;--------------------------------------------------------- 
; Get the values from the user
; Receives: Nothing 
; Returns: Array populate with 10 values from user
;--------------------------------------------------------- 

getInput		PROC
	mov			ecx, arraySize	; Counter to get 10 numbers
getNumber:
	push		OFFSET array	; Push the array onto the stack
	push		count			; Push the current count onto the stack
	call		readVal			; Get value from user
	inc			count			; Increment user input value counter
	loop		getNumber

	call		CrLf			; Print newline
	displayString	readBack
	push		OFFSET array
	push		arraySize
	call		writeVal

	call		CrLf
	ret
getInput	ENDP

;--------------------------------------------------------- 
; Get a value from the user and validate that it's a number
; Receives: Nothing
; Returns: A number from the user
;--------------------------------------------------------- 
readVal PROC
	pushad		; Push all 32-bit registers onto the stack
	mov			ebp, esp
top:
	mov			eax, [ebp+36]	; Set eax to current counter
	inc			eax
	call		WriteDec
	getString	input, prompt	; Print the prompt and get the user input
	jmp			validate		; Validate that it's a number
	
err:
	getString	input, oops

validate:
	mov			inputLength, eax
	mov			ecx, eax		; Move counter value to ecx
	mov			esi,  OFFSET input
	mov			edi, OFFSET number

checkDigit:						; Loop to check each digit of the number
	lodsb
	cmp			al, 48			; 0 is char 48 in ASCII
	jl			err				; If value is less than 0, print error and let user input new value

	cmp			al, 57			; 9 is 57 in ASCII
	jg			err
	loop		checkDigit
	jmp			isNumber		; If we made it through the loop, then it's a number!
	jmp			err				; Otherwise, we go here :(
	
isNumber:
	mov			edx, OFFSET input
	mov			ecx, inputLength
	call		ParseDecimal32	; If the number is too big, the carry flag will be set
	.IF	CARRY?
	jmp			err
	.ENDIF
	mov			edx, [ebp+40]	; Move array to edx
	mov			ebx, [ebp+36]	; Move current count to ebx
	imul		ebx, 4			;
	mov			[edx+ebx], eax	; Place the number into the array

	popad						; Pop all registers from the stack
	ret			8
readVal	ENDP

;--------------------------------------------------------- 
; Print number to the screen
; Receives: Array pointer, and length of the array
; Returns: Nothing
;--------------------------------------------------------- 
writeVal PROC
	STACK_FRAME
	mov			esi, [ebp+12]	; Move the array pointer to esi
	mov			ecx, [ebp+8]	; Length of array becomes loop counter

printNumber:
	mov			eax, [esi]		; Move the head of the array to eax
	call		WriteDec		; Print the value
	cmp			ecx, 1			; if ecx is 1, we don't need a comma
	je			noComma
	displayString	comma
	add			esi, 4			; Move pointer to the next element in the array
noComma:
	loop		printNumber

	pop			ebp
	ret			8
writeVal ENDP

;--------------------------------------------------------- 
; Calculate and print the sum of the number
; Receives: Array pointer, length of the array, and the sum variable
; Returns: Sum of the array
;--------------------------------------------------------- 
calculateSum PROC
	STACK_FRAME
	mov			esi, [ebp+16]	; Move array pointer to esi
	mov			ecx, [ebp+12]	; Length of array to loop counter
	mov			ebx, [ebp+8]	; Register to hold sum variable

addNumber:
	mov			eax, [esi]		; Move the current value to eax
	add			ebx, eax		; Add it to the sum
	add			esi, 4			; Move to the next element in the array
	loop		addNumber

	displayString	sumMessage	; Print the message
	mov			eax, ebx		; Move the sum to eax to be printed
	call		WriteDec		; Print it
	call		CrLf
	mov			sum, ebx
	pop			ebp
	ret			12
calculateSum	ENDP

;--------------------------------------------------------- 
; Calculate and print average of the array
; Receives: The sum, and length of the array
; Returns: Nothing
;--------------------------------------------------------- 
calculateAverage	PROC
	STACK_FRAME
	mov			eax, [ebp+12]	; Move the number of numbers (divisor) to eax
	mov			ebx, [ebp+8]	; Move sum (numerator) to ebx
	mov			edx, 0			; Clear edx

	idiv		ebx

	displayString	averageMessage
	call		WriteDec
	pop			ebp
	ret			8
calculateAverage	ENDP
END main