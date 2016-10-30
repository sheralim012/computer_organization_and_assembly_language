;
;number of alphabets between two alphabet whose difference is less than 10
;

.MODEL SMALL
.STACK 10H
.DATA
        prompt1 DB 10, 13, "Enter first alphabet: $"
        prompt2 DB 10, 13, "Enter second alphabet: $"
        prompt3 DB 10, 13, "The difference between $"
        prompt4 DB " and $"
        prompt5 DB " is $"
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
        ;take single character input from user and store it in AL
        ;
        MOV AH, 01H
        INT 21H
        ;
        ;moving value in AL to BL for later use
        ;
        MOV BL, AL
        ;
        ;display prompt2
        ;
        MOV AH, 09H
        MOV DX, OFFSET prompt2
        INT 21H
        ;
        ;take single character input from user and store it in AL
        ;
        MOV AH, 01H
        INT 21H
        ;
        ;moving value in AL to BH for later use
        ;
        MOV BH, AL
        ;
        ;display prompt3
        ;
        MOV AH, 09H
        MOV DX, OFFSET prompt3
        INT 21H
        ;
        ;display first character input
        ;
        MOV DL, BL
        MOV AH, 02H
        INT 21H
        ;
        ;display prompt4
        ;
        MOV AH, 09H
        MOV DX, OFFSET prompt4
        INT 21H
        ;
        ;display second character input
        ;
        MOV DL, BH
        MOV AH, 02H
        INT 21H
        ;
        ;display prompt5
        ;
        MOV AH, 09H
        MOV DX, OFFSET prompt5
        INT 21H
        ;
        ;calculating the difference
        ;
        SUB BL, 48D
        SUB BH, 48D

        SUB BL, BH
        ADD BL, 48D

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

