.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter a lowercase letter: $"
  prompt2 DB 10, 13, "Wrong. Enter again: $"
  prompt3 DB 10, 13, "The uppercase equivalent is $"
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
  ;repeat until user enter lowercase character
  ;
  AGAIN:
  MOV AH, 01H
  INT 21H
  CMP AL, 'a'
  JNGE WRONG ; AL < 'a' 
  CMP AL, 'z'
  JNLE WRONG ; AL > 'z'
  JMP DISPLAY
  ;
  ;if wrong input is entered than display prompt2 and take input again
  ;
  WRONG:
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  JMP AGAIN

  DISPLAY:
  ;
  ;display prompt3
  ;
  MOV AH, 09H
  LEA DX, prompt3
  INT 21H
  ;
  ;converting lowercase to uppercase character
  ;
  AND AL, 0DFH
  ;
  ;display character
  ;
  MOV DL, AL
  MOV AH, 02H
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN