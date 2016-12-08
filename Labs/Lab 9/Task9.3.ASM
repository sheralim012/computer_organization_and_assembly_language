.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter a sentence: $"
  prompt2 DB 10, 13, "Resultant string: $"
  string DB 100 DUP(?)
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
  ;preparing registers for input
  ;
  LEA DI, string
  MOV CX, 99D
  XOR DX, DX

  CALL STRINP ;store input in string and count number of characters entered

  PUSH DX ;saving content of DX
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H

  POP DX ;restoring DX
  ;
  ;preparing registers
  ;
  LEA SI, string ;starting offset of string
  MOV CL, DL ;total number of characters in string
  INC CL ;helps in last iteration
  XOR CH, CH ;helps in counting the number of characters in a word separated by space
  MOV AH, 02H
  AGAIN:
    MOV AL, [SI]
    CMP AL, ' '
    JNE REMAINING ;jump if space does not encounter in the iteration
    DISPLAY:
      POP DX ;stack has the reverse order of the characters 
      INT 21H ;display the character in DL
      DEC CH ;decrementing thee number of characters in word separated by space
      JNZ DISPLAY
    MOV DL, ' ' ;displaying space after the word reversed 
    INT 21H
    XOR CH, CH ;reinitializing CH
    INC SI ;move SI to next character
    DEC CL ;decrementing total count of string
    JMP REMAIN
    REMAINING:
    PUSH AX ;storing next character 
    INC SI ;moving to next character
    INC CH ;incrmenting count of characters in word
    DEC CL ;decrementing total count of string
    REMAIN:
    JNZ AGAIN

  MOV AH, 4CH
  INT 21H

MAIN ENDP

STRINP PROC
  PUSH AX ;saving content of AX
  MOV AH, 01H
  INPUT:
    INT 21H ;input single character
    CMP AL, 13D
    JE END_INPUT ;jump to END_INPUT if return is pressed
    MOV [DI], AL ;storing input character taken into string
    INC DI ;incrementing DI so it can point to next address in memory
    INC DX ;incrementing total number of characters entered
    LOOP INPUT ;loop until input size is zero
  END_INPUT:
    MOV AL, ' ' 
    MOV [DI], AL ;putting a space at the end of the string which helps in last iteration od displaying the reverse 
    POP AX ;restoring content of AX
  RET
STRINP ENDP

END MAIN