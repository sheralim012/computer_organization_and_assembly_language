;
;sum of two digits whose sum is less than 10
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
	      ;initialization od data segment
	      ;
        MOV AX, @DATA
        MOV DS, AX
	      ;
	      ;display prompt1
	      ;
        MOV AH, 09H             ;09H service: display $-terminated string
        MOV DX, OFFSET prompt1  ;gives DX offset address so 09H service can output string in promtp1
        INT 21H
	      ;
	      ;single character input from user and store it in AL
	      ;
        MOV AH, 01H             ;01H service: single character input from user and store in AL
        INT 21H
	      ;
	      ;moving value of AL into BL so second input can be taken
	      ;
        MOV BL, AL
	      SUB BL, 48D	       ;converting character into digit
	      ;
	      ;display prompt2
	      ;
        MOV AH, 09H             ;09H service: display $-terminated string
        MOV DX, OFFSET prompt2  ;gives DX offset address so 09H service can output string in promtp2
        INT 21H
	      ;
	      ;input second digit as character and store it in AL
	      ;
        MOV AH, 01H             ;01H service: single character input from user and store in AL
        INT 21H
	      ;
	      ;moving value in AL to BH so it can be added into BL
	      ;
        MOV BH, AL
        SUB BH, 48D

        ADD BL, BH
	      ;
	      ;converting it to character so it can be displayed properly
	      ;
        ADD BL, 48D
	      ;
	      ;display prompt3
	      ;
        MOV AH, 09H
        MOV DX, OFFSET prompt3
        INT 21H
	      ;
	      ;moving value in BL to DL so 02H service can display it
	      ;
        MOV DL, BL
        MOV AH, 02H
        INT 21H
	      ;
	      ;halting the program
	      ;
        MOV AH, 4CH
        INT 21H

MAIN ENDP ;end the main procedure
END MAIN  ;end of that procedure from where program start
