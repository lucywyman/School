TITLE Assignment 3	(assignment3.asm)
; Lucy Wyman	wymanl@onid.oregonstate.edu
; CS 271 400
; Assignment 3
; Description: Print a user-specified number of composite numbers, beginning with 4

INCLUDE Irvine32.inc

LOWERLIMIT = 1
UPPERLIMIT = 400
PAGE_MAX = 40

.data
introduction		BYTE	"Composite Numbers by Lucy Wyman", 0
instructions1		BYTE	"Please enter the number of composite numbers you'd like to see.", 0
instructions2		BYTE	"The number must be between 1 and 400, inclusive.", 0
prompt				BYTE	"Number of Composites [1 - 400]: ", 0
continue			BYTE	"Press any key to continue...", 0
numComposites		DWORD	? ; The number of composite numbers to print
error				BYTE	"Oops! Your number is out of range.  Enter a number between 1 and 400", 0
composite			DWORD	4
compbool			DWORD	?
total				DWORD	0
remainder			DWORD	?
tabs				BYTE	"	", 0
goodbye				BYTE	"These results are certified by Euclid.  Goodbye!", 0
ec1					BYTE	"**EC: Align output columns", 0
ec2					BYTE	"**EC: Paginate numbers", 0
.code

main PROC
	call	Clrscr
	call	intro
	call	getInput
	call	showComposites
	call	farewell
	exit ; Exit to Operating System
main ENDP


; Introduce program
intro	PROC
	mov		edx, OFFSET introduction
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ec1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ec2
	call	WriteString
	call	CrLf
	call	CrLf
; Print instructions
	mov		edx, OFFSET instructions1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instructions2
	call	WriteString
	call	CrLf
	ret
intro ENDP

; Propmpt user for number
getInput	PROC
	getInputLoop:
		mov		edx, OFFSET prompt
		call	WriteString
		call	ReadInt
		mov		numComposites, eax
		call	validate
		ret
getInput	ENDP

; Verify that input is within range
validate	PROC
		mov		ebx, numComposites
		cmp		ebx, UPPERLIMIT
		jg		outOfRange	; If the number of iterations is larger than or equal to 401, then print error and prompt again
		cmp		ebx, LOWERLIMIT
		jl		outOfRange	; If the number of iterations is less than or equal to 0, then print error and prompt again
		ret

	outOfRange: ; Print error and execute input loop again
		mov		edx, OFFSET error
		call	WriteString
		call	CrLf
		call	getInput
validate	ENDP

; Generate and print composite numbers
showComposites	PROC
	call	CrLf
	mov		ecx, numComposites	; Initialize counter to user-input value
	; Loop to print numbers
	printLoop:
		mov		compbool, 0		; Initialize composite boolean to false
		call	isComposite		; Check if value is composite
		cmp		compbool, 1		; If it is composite, then print it!
		je		printValue
		inc		composite		; Otherwise, increment the value to be tested to test the next number
	printValue:
		inc		total			; Increment total of composites printed, to keep track
		mov		eax, 0			; Clear eax
		mov		eax, composite	; Mov the number into eax
		mov		edx, OFFSET tabs
		call	WriteDec
		call	WriteString
		; Check if output needs newline
		mov		eax, 0			; Clear eax
		mov		ebx, 0
		mov		edx, 0	; Clear edx
		mov		eax, total
		mov		ebx, 5
		div		ebx
		mov		remainder, edx
		cmp		remainder, 0
		jne		noNewLine
		call	newPage
		call	CrLf
		noNewLine:
			inc composite
			loop printLoop
	ret
showComposites	ENDP

; Check whether a given number is composite
isComposite		Proc
	mov		edx, 0 ; Clear edx
	mov		eax, composite
	mov		ebx, 2 ; Initial divisor
	div		ebx		; See if composite is evenly divided by divisor
	cmp		edx, 0
	je		setComposite	; If remainder is 0, then the number is composite
	inc		ebx	; If not, we need to increment ebx to 3
	divisionLoop:
		mov		edx, 0	; Clear edx
		mov		eax, 0	; Clear eax
		cmp		ebx, composite	; If composite is prime, then it's not composite, and we set bool as such
		je		setNotComposite
		mov		eax, composite	; Otherwise, divide and test remainder to see if it is composite
		div		ebx
		cmp		edx, 0
		je		setComposite	; If remainder is 0 then number is composite
		add		ebx, 2	; Increment divisor by 2
		jmp		divisionLoop
	setComposite:
		mov		compbool, 1
		jmp		done
	setNotComposite:
		mov		compbool, 0
	done:
		ret
isComposite		ENDP

newPage		PROC
	mov		eax, 0
	mov		ebx, 0
	mov		edx, 0
	mov		eax, total
	mov		ebx, 40
	div		ebx
	cmp		edx, 0
	jne		return
	call	CrLf
	mov		edx, 0
	mov		edx, OFFSET continue
	call	WriteString
	call	ReadString
	call	Clrscr
	return:
		ret
newPage		ENDP

farewell	PROC
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLf
	ret
farewell	ENDP
END main