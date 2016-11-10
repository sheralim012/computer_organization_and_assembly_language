.MODEL SMALL
.STACK 100H
.DATA
  prompt DB 10, 13, "Enter size: $"
  newLine DB 10, 13, "$"
  totalRows DB ?
  totalColumns DB ?
  totalSpaces DB ?
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
  ;single character input
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;converting character to digit
  ;
  SUB AL, 48D
  ;
  ;initializing totalRows
  ;
  MOV totalRows, AL
  ;
  ;every row has same number of columns as number of the row
  ;
  MOV BL, 1D
  ;
  ;display newLine
  ;
  MOV AH, 09H
  LEA DX, newLine
  INT 21H
  ;
  ;this loop control rows
  ;
  ROW:
    ;
    ;every row has same number of spaces as the number of the row
    ;
    MOV CL, totalRows
    MOV totalSpaces, CL

    MOV AH, 02H
    MOV DL, ' '
    SPACE:
      ;
      ;display space
      ;
      INT 21H
      ;
      ;if totalSpaces greater than 0 then jump to SPACE
      ;
      DEC totalSpaces
      JNZ SPACE

    MOV totalColumns, BL ;every row have same number of * as the number of the row
    MOV DL, '*'
    COL:
        ;
        ;display *
        ;
        INT 21H
        ;
        ;decrementing totalColumns so loop can be ended
        ;
        DEC totalColumns
        JNZ COL
    ;
    ;display newLine
    ;
    INC BL
    MOV AH, 09H
    LEA DX, newLine
    INT 21H
    ;
    ;decrementing totalRows so loop can be ended
    ;
    DEC totalRows
    JNZ ROW
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN