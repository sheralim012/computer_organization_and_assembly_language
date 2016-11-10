.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter a hex digit (A-F): $"
  prompt2 DB 10, 13, "In decimal, it is: $"
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
  LEA DX, prompt1
  MOV AH, 09H
  INT 21H
  ;
  ;input single character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;display prompt2
  ;
  LEA DX, prompt2
  MOV AH, 09H
  INT 21H
  ;
  ;moving input taken so it can be converted to right digit of the number
  ;
  MOV BL, AL
  SUB BL, 17D ;convert character to right digit
  ;
  ;dispaly 1 as left digit
  ;
  MOV DL, 49D
  MOV AH, 02H
  INT 21H
  ;
  ;display right digit
  ;
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