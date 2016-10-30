;
;sum of two numbers whose result is two digit
;

.MODEL SMALL
.STACK 10H
.DATA
        prompt1 DB 10, 13, "Enter first number: $"
        prompt2 DB 10, 13, "Enter second number: $"
        prompt3 DB 10, 13, "The sum is $"
.CODE
MAIN PROC
        ;
        ;initialization of data segment
        ;
        MOV AX, @DATA
        MOV DS, AX
      	;
      	;display prompt1
      	;
        MOV AH, 09H
        MOV DX, OFFSET prompt1
        INT 21H
      	;
      	;single character input from user
      	;
        MOV AH, 01H
        INT 21H
      	;
      	;converting character to first digit of first number
      	;
      	MOV BH, AL
      	SUB BH, 48D
      	;
      	;single character input from user
      	;
        MOV AH, 01H
        INT 21H
      	;
      	;converting chacater to second digit of first number
      	;
      	MOV BL, AL
      	SUB BL, 48D
      	;
      	;display prompt2
      	;
      	MOV AH, 09H
        MOV DX, OFFSET prompt2
        INT 21H
      	;
      	;single character input from user
      	;
      	MOV AH, 01H
        INT 21H
      	;
      	;converting character to first digit of second number
      	;
      	MOV CH, AL
      	SUB CH, 48D
      	;
      	;single character input from user
      	;
        MOV AH, 01H
        INT 21H
      	;
      	;converting character to second digit of second number
      	;
      	MOV CL, AL
      	SUB CL, 48D
      	;
      	;display prompt3
      	;
      	MOV AH, 09H
        MOV DX, OFFSET prompt3
        INT 21H
      	;
      	;adding first and second digits of numbers
      	;
      	ADD BH, CH
      	ADD BH, 48D
      	ADD BL, CL
      	ADD BL, 48D	
      	;
      	;displaying single character
      	;
      	MOV DL, BH
      	MOV AH, 02H
      	INT 21H
      	;
      	;displaying single character
      	;
      	MOV DL, BL	
      	MOV AH, 02H
      	INT 21H
      	;
      	;halt program
      	;
      	MOV AH, 4CH
      	INT 21H

MAIN ENDP ;end the main procedure
END MAIN  ;end of that procedure from where program start
