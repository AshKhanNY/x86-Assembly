; Project01_T2.asm
; 
; Task 2: Create function called 'strlen' for the "hello world" 
; program in order to count the length of the string. Then call
; that function to get str length so that there's no need to
; specify length of the string. 
;
; Tip: Use the following to compile:
;
; nasm -f elf Project01_T2.asm 
; ld -m elf_i386 Project01_T2.o -o Project01_T2
; ./Project01_T2
 
; Author: Ashraq Khan
; Date: 02-09-21

global _start

; DATA - *Change message so terminal can display something different!*
section .data
string: db "Greetings.", 0xA, 1  ; newline at end, 1 indicates end of str

section .text
_start:	
	push eax 		  	   ; save value of EAX register, will be used in strlen
	push string 	  	  ; push string, use as an argument
	call strlen    		  ; begins function to calculate len of str given above 
	pop eax			    	  ; restores original value of EAX
	mov ecx, string		  ; move string to ECX register to be outputted
	mov eax, 4		  	  ; system call number for write
	mov ebx, 1		    	; file handle 1 is stdout
	int 0x80 		      	; request an interrupt on libc
exit:					  
	mov eax, 1			   ; syscam call number for exit
	mov ebx, 0		     	; return 0 status on exit (no errors)
	int 0x80		      	; request an interrupt on libc	

; FUNCTION
strlen:		
	push ebp		      	; save value of base pointer
	mov ebp, esp	    	; move address of stack pointer to base pointer
	push edi		      	; save value of EDI register, used for incrementation
	mov edi, -1		    	; initialize EDI with -1 so incrementation can start
	mov eax, [ebp + 8]  ; store address of start of string to EAX
	call len_finder 	  ; call function, which loops until length is found
len_finder:
	inc edi					    ; EDI starts at 0 and behaves as an indent
	cmp BYTE [eax + edi], 1	; compares start of str address + indent and 1
	jne len_finder      ; called when above comparison is not equal
	mov edx, edi 			  ; copys EDI to EDX, which stores str length
	pop edi             ; restores original value of EDI 
	mov esp, ebp        ; deallocates space on stack
	pop ebp					    ; restores base pointer position
	ret 					      ; we reach end of string and return
  
