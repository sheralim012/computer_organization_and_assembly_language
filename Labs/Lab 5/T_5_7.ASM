.MODEL SMALL
.STACK 100H
.DATA
  PROMPT1 DB "Enter first character: $"
  PROMPT2 DB 10, 13, "Enter second character: $"
  OUTPUT1 DB 10, 13, "First character = "
  CH1 DB ?
    DB 10, 13, "Second character = "
  CH2 DB ?
  DB 10, 13, "$"
.CODE
MAIN PROC
  ;
  ;initialization of data segment
  ;
  MOV AX, @DATA
  MOV DS, AX
  ;
  ;display PROMPT1
  ;
  MOV AH, 09H
  MOV DX, OFFSET PROMPT1
  INT 21H
  ;
  ;input first character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;moving first character to CH1 to second input can also be taken
  ;
  MOV CH1, AL
  ;
  ;display PROMPT2
  ;
  MOV AH, 09H
  MOV DX, OFFSET PROMPT2
  INT 21H
  ;
  ;input second character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;moving second character to CH1
  ;
  MOV CH2, AL
  ;
  ;swaping numbers
  ;
  MOV AL, CH1
  XCHG AL, CH2
  MOV CH1, AL
  ;
  ;display OUTPUT1
  ;
  MOV DX, OFFSET OUTPUT1
  MOV AH, 09
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN