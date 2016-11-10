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
  ;initialize data segment
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
  ;moving input to BL and converting it from character to digit
  ;
  MOV BL, AL
  SUB BL, 48D
  ;
  ;initializing rows and columns
  ;
  MOV totalRows, BL
  SUB totalRows, 2D
  MOV totalColumns, BL
  
  MOV AH, 02H
  MOV DL, '*'
  ;
  ;this loop display first row of *
  ;
  UPPER_ROW:
    INT 21H
    ;
    ;if totalColumns greater than 0 then jump to UPPER_ROW
    ;
    DEC totalColumns
    JNZ UPPER_ROW
  ;
  ;display newLine
  ;
  LEA DX, newLine
  MOV AH, 09H
  INT 21H
  ;
  ;this loop display middle rows and spaces
  ;
  MID_ROWS:
    ;
    ;display first * per row
    ;
    MOV AH, 02H
    MOV DL, '*'
    INT 21H
    ;
    ;spaces are 2 less than columns
    ;
    MOV totalColumns, BL
    SUB totalColumns, 2
    MOV DL, ' '
    ;
    ;this loop display spaces
    ;
    SPACES:
      INT 21H
      ;
      ;if totalColumns greater than 0 then jump to SPACES
      ;
      DEC totalColumns
      JNZ SPACES
    ;
    ;display last * per row
    ;
    MOV DL, '*'
    INT 21H
    ;
    ;display newLine
    ;
    LEA DX, newLine
    MOV AH, 09H
    INT 21H
    ;
    ;if totalRows greater than 0 then jump to MID_ROWS
    ;
    DEC totalRows
    JNZ MID_ROWS

  MOV DL, '*'
  MOV AH, 02H
  MOV totalColumns, BL
  ;
  ;this loop display last row of *
  ;
  LOWER_ROW:
    INT 21H
    ;
    ;if totalColumns greater than 0 then jump to LOWER_ROW
    ;
    DEC totalColumns
    JNZ LOWER_ROW
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN