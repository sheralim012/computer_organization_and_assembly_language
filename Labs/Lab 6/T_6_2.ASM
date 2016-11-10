.MODEL SMALL
.STACK 100H
.DATA
  prompt DB 10, 13, "Enter size: $"
  newLine DB 10, 13, "$" 
  totalRows DB ?
  totalColumns DB ?
.CODE
MAIN PROC
  ;
  ;initialization of data segment  
  ;
  MOV AX, @DATA
  MOV DS, AX
  ;
  ;display prompt
  ;
  MOV AH, 09H
  LEA DX, prompt
  INT 21H
  ;
  ;input single character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;display newLine
  ;
  MOV AH, 09H
  LEA DX, newLine
  INT 21H
  ;
  ;converting input charcter to digit
  ;
  SUB AL, 48D
  ;
  ;moving digit to BL so AL can be used in other places
  ;
  MOV BL, AL
  ;
  ;number of rows to display
  ;
  MOV totalRows, BL
  ;
  ;outter loop will determine number of rows
  ;
  ROW:
    ;
    ;every row will display same number of columns
    ;
    MOV totalColumns, BL
    MOV AH, 02H
    MOV DL, '*'
    ;
    ;inner loop will display * as specified by total number of columns
    ;
    COL:
      INT 21H ;display *
      DEC totalColumns ;decrementing totalColumns so loop can be terminated
      JNZ COL ;jump if totalColumns are greater than 0
    ;
    ;display newLine
    ;
    MOV AH, 09H
    LEA DX, newLine
    INT 21H

    DEC totalRows ;decrementing totalRows so loop can be terminated
    JNZ ROW ;jump if totalRows are greater than 0
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN
