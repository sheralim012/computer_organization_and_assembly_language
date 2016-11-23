.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter string: $"
  prompt2 DB 10, 13, "Length is: $"
  input DB 10 DUP(?)
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
  LEA Dx, prompt1
  INT 21H
  ;
  ;prepare for input and counting character input
  ;
  MOV CX, 9D
  MOV BL, 0D
  MOV AH, 01H
  ;
  ;repeating until user enter return or count is 9
  ;
  AGAIN:
  INT 21H ; take input
  CMP AL, 13D 
  JE DISPLAY ; Al == return
  INC BL ; incrementing count of the input characters
  LOOP AGAIN
  
  DISPLAY:
  ;
  ;display prompt2 
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  ;
  ;display number of characters enter by user
  ;
  ADD BL, 48D
  MOV DL, BL
  MOV AH, 02H
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN
