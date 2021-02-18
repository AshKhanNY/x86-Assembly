; Project01_T1.asm
; 
; Task 1: Try "hello world" example we learned in class, but
; instead print out your name, ID, and section number.
;
; Tip: Use the following to compile:
;
; nasm -f elf Project01_T1.asm 
; ld -m elf_i386 Project01_T1.o -o Project01_T1
; ./Project01_T1
 
; Author: Ashraq Khan
; Date: 02-09-21

global _start

; DATA
section .data
name: db "Ashraq Khan", 0xA		; 0xA indicates newline
emplid: db "23900457", 0xA		
sec_num: db "CC2", 0xA

section .text
_start:	
	mov eax, 4			; system call number for write
	mov ebx, 1			; file handle 1 is stdout
	mov ecx, name		; address of string to output
	mov edx, 12			; number of bytes
	int 0x80			  ; request an interrupt on libc

	mov eax, 4			
	mov ecx, emplid		
	mov edx, 9			
	int 0x80			

	mov eax, 4				
	mov ecx, sec_num	
	mov edx, 4			
	int 0x80			
exit:					
	mov eax, 1			; syscam call number for exit
	mov ebx, 0			; return 0 status on exit (no errors)
	int 0x80			
