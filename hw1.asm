; HW 1 Fencing A Pasture    (template.asm)

; Author: Bernardo Mendes
; Last Modified: 1/24/24
; OSU email address: mendesb@oregonstate.edu
; Course number/section: CS 271-001-W2024
; Assignment Number:      HW1           Due Date: 1/24/24
; Description: Intro to MASM program where we take in length/width inputs and fence a pasture

INCLUDE Irvine32.inc

.data

; (insert variable definitions here)
	intro	BYTE		"HW 1: fencing a pasture by Bernardo Mendes", 0
	good_bye	BYTE		"Good Bye ", 0
	username	BYTE		33 DUP(0)		;string enter by the user, initialized to 0 

	prompt_1	BYTE		"What's your name? ", 0
	prompt_2	BYTE		"Enter the width of the pasture (in feet) : ", 0
	prompt_3	BYTE		"Enter the length of the pasture (in feet) : ", 0
	prompt_4	BYTE		"Enter the linear feet of the wood planks : ", 0
	prompt_5	BYTE		"Would you like to do another calculation? (0 = NO | 1 = YES)", 0

	result_1	BYTE		"The area of the pasture is : ", 0
	result_2	BYTE		"The perimeter of the pasture is : ", 0
	result_3	BYTE		"You have enough wood for ", 0
	result_4	BYTE		" rails and an extra ", 0
	result_5	BYTE		" linear feat of 1x6 wooden planks. ", 0

	plank_width		DWORD	?
	plank_length	DWORD	?
	linear_length	DWORD	?
	area		DWORD	?
	perimeter	DWORD	?
	rail_count	DWORD	?
	extra_feet	DWORD	?

.code
main PROC

; (insert executable instructions here)
; 1. Introduce the programmer
	
	mov			edx, OFFSET intro
	call		WriteString
	call		Crlf
	 

; 2. Get the name from the user 
	mov			edx, OFFSET prompt_1
	call		WriteString

	mov			edx, OFFSET username
	mov			ecx, 32
	call		ReadString

start_program: ; label to restart program inputs and calculations

; 3. Get the width from the user 
	mov			edx, OFFSET prompt_2
	call		WriteString
	call		ReadInt		;	user input will be stored in eax 
	mov			plank_width, eax

; 4. Get the length from the user
	mov			edx, OFFSET prompt_3
	call		WriteString
	call		ReadInt		; user input will be stored in eax
	mov			plank_length, eax

; 5. Get the linear length of the planks
	mov			edx, OFFSET prompt_4
	call		WriteString
	call		ReadInt
	mov			linear_length, eax

 ; 6. Calculations for area
	mov			eax, plank_width
	mov			ebx, plank_length
	mul			ebx
	mov			area, eax

 ; 7. Calculations for perimeter
	mov			eax, plank_width
	add			eax, plank_length
	shl			eax, 1
	mov			perimeter, eax

 ; 8. Calculations for the rails of the fence
	mov			eax, linear_length
	mov			ebx, perimeter
	div			ebx
	mov			rail_count, eax
	mov			extra_feet, edx

 ; 9. Report the results
	mov			edx, OFFSET result_1
	call		WriteString
	mov			eax, area
	call		WriteDec
	call		Crlf
	mov			edx, OFFSET result_2
	call		WriteString
	mov			eax, perimeter
	call		WriteDec
	call		Crlf
	mov			edx, OFFSET result_3
	call		WriteString
	mov			eax, rail_count
	call		WriteDec
	mov			edx, OFFSET result_4
	call		WriteString
	mov			eax, extra_feet
	call		WriteDec
	mov			edx, OFFSET	result_5
	call		WriteString
	call		Crlf

input: ; label to restart try again prompt

 ; 10. Ask if the user wants to try again?
	mov			edx, OFFSET prompt_5
	call		WriteString
	call		ReadInt
	cmp			eax, 1
	je			start_program
	cmp			eax, 0
	je			end_program
	jmp			input

end_program: ; label to end the program

 ; 11. End Program
	mov			edx, OFFSET good_bye
	call		WriteString

	mov			edx, OFFSET username
	call		WriteString
	call		Crlf

	exit	; exit to operating system

main ENDP

END main
