.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter a string: $"
  prompt2 DB "Reverse is $"
  input DB 100 DUP(?)
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
  ;prepare to take input as characters and setting counters
  ;
  LEA SI, input ; giving starting address of input to SI
  MOV BL, 0D
  MOV CX, 99D
  MOV AH, 01H
  ;
  ;repeat until user enter return
  ;
  AGAIN:
  INT 21H
  CMP AL, 13D
  JE PREPARE_DISPLAY ; AL == return
  INC BL
  MOV [SI], AL ; moving input taken to address pointing by SI
  INC SI ; SI point to next memory location
  LOOP AGAIN

  PREPARE_DISPLAY:
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  ;
  ;check if no character is entered
  ;
  CMP BL, 0D ; BL == 0 
  JE REMAIN
  ;
  ;repeat until count is 0
  ;
  MOV AH, 02H
  DISPLAY:
  DEC SI ; moving current location to back to print in reverse
  MOV DL, [SI] ; moving character pointed by SI to DL
  INT 21H
  DEC BL ; decrementing count
  JNZ DISPLAY
  ;
  ;exit DOS
  ;
  REMAIN:
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN