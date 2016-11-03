;
;convert lowercase alphabet to uppercase alphabet
;

.MODEL SMALL
.STACK 10H
.DATA
        prompt1 DB 10, 13, "Enter a lowercase alphabet: $"
        prompt2 DB 10, 13, "The uppercase equivalent is $"
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
        MOV AH, 09H            ;09H service: display $-terminated string
        MOV DX, OFFSET prompt1 ;gives DX offset address so 09H service can output string in promtp1
        INT 21H                
        ;
        ;single character input
        ;
        MOV AH, 01H            ;01H service: single character input from user and store in AL
        int 21H
        ;
        ;subtract 32D from AL which contains lowercase alphabet to convert it to uppercase alphabet
        ;
        SUB AL, 32D            

        MOV AH, 09             
        MOV DX, OFFSET prompt2
        INT 21H
        ;
        ;display single character
        ;
        MOV DL, AL             ;gives value in AL to DL so 02H service can output it
        MOV AH, 02H            ;02H service: display single character stored in DL
        INT 21H
        ;
        ;halt the program excution
        ;
        MOV AH, 4CH
        INT 21H

MAIN ENDP ;end the main procedure
END MAIN  ;end of that procedure from where program start
