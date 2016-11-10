.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter a string of size 12: $"
  prompt2 DB 10, 13, "Uppercase equivalent: $"
  string DB 12 DUP(?)
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
  LEA DX, prompt1
  INT 21H
  ;
  ;using SI to store address of string
  ;
  LEA SI, string
  ;
  ;CX help in LOOP as counter
  ;
  MOV CX, 12D
  MOV AH, 01H
  INPUT:
    ;
    ;input single character
    ;
    INT 21H
    ;
    ;converting to uppercase
    ;
    SUB AL, 32D
    ;
    ;storing in the string
    ;
    MOV [SI], AL
    ;
    ;incrementing SI so it can point to next memory location
    ;
    INC SI
    ;
    ;loop until CX <= 0
    ;
    LOOP INPUT ;LOOP automatically check for CX and DEC
  ;
  ;display prompt 2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  ;
  ;using SI to store address of string
  ;
  LEA SI, string
  ;
  ;CX help in LOOP as counter
  ;
  MOV CX, 12D
  MOV AH, 02H
  OUTPUT:
    ;
    ;moving value at address [SI] to DL so it can be displayed
    ;
    MOV DL, [SI]
    ;
    ;display character
    ;
    INT 21H
    ;
    ;incrementing SI so it can point to next memory location
    ;
    INC SI
    LOOP OUTPUT 
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN
