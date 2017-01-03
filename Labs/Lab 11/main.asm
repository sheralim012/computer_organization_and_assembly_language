.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter first string: $"
  prompt2 DB 10, 13, "Enter second string: $"
  prompt3 DB 10, 13, "First is $"
  prompt4 DB "smaller$"
  prompt5 DB "greater$"
  prompt6 DB " than second.$"
  prompt7 DB 10, 13, "Both strings are equal.$"
  prompt8 DB 10, 13, "String you entered is: $"
  prompt9 DB 10, 13, "Substring found$"
  prompt0 DB 10, 13, "Substring not found$"
  prompt10 DB 10, 13, "Length: $"
  prompt11 DB 10, 13, "Fibonacci at: $"
  prompt12 DB " is $"
  STR1 DB 100 DUP(?)
  STR2 DB 100 DUP(?)
.CODE

INCLUDE cstring.asm

MAIN PROC
  MOV AX, @DATA
  MOV DS, AX

  MOV AH, 09H
  LEA DX, prompt1
  INT 21H

  LEA SI, STR1
  MOV CX, 99D
  PUSH SI
  PUSH CX

  CALL STRINP

  MOV AH, 09H
  LEA DX, prompt8
  INT 21H

  LEA SI, STR1
  PUSH SI
  
  CALL STROUT

  MOV AH, 09H
  LEA DX, prompt10
  INT 21H

  LEA SI, STR1
  PUSH SI

  CALL STRLEN

  MOV CL, 4 
  MOV CH, 4 
  AGAIN:
  MOV DL, BH 
  SHR DL, CL 
  CMP DL, 9 
  JLE DIGIT 
  ADD DL, 37H 
  JMP DISPLAY
  DIGIT:
  ADD DL, 30H 
  DISPLAY:
  MOV AH, 02H
  INT 21H 

  ROL BX, CL 
  DEC CH 
  JNZ AGAIN

  MOV AH, 09H
  LEA DX, prompt1
  INT 21H

  LEA SI, STR1
  MOV CX, 99D
  PUSH SI
  PUSH CX

  CALL STRINP

  MOV AH, 09H
  LEA DX, prompt2
  INT 21H

  LEA DI, STR2
  MOV CX, 99D
  PUSH DI
  PUSH CX

  CALL STRINP

  LEA SI, STR1
  LEA DI, STR2

  PUSH SI
  PUSH DI

  CALL STRCMP

  MOV AH, 09H
  CMP AL, 0
  JE EQUAL_STRINGS

  LEA DX, prompt3
  INT 21H
  
  CMP AL, 0
  JL FIRST_IS_LESS 

  LEA DX, prompt5
  INT 21H

  JMP DISPLAY__ 
  FIRST_IS_LESS:
    LEA DX, prompt4
    INT 21H
  DISPLAY__:
    LEA DX, prompt6
    INT 21H
  JMP REMAIN 
  EQUAL_STRINGS:
    LEA DX, prompt7
    INT 21H
  REMAIN:
    MOV AH, 09H
    LEA DX, prompt1
    INT 21H

    LEA SI, STR1
    MOV CX, 99D
    PUSH SI
    PUSH CX

    CALL STRINP

    MOV AH, 09H
    LEA DX, prompt2
    INT 21H

    LEA DI, STR2
    MOV CX, 99D
    PUSH DI
    PUSH CX

    CALL STRINP

    LEA SI, STR1
    LEA DI, STR2

    PUSH SI
    PUSH DI

    CALL SUBSTR_

    MOV AH, 09H
    CMP AL, 0D
    JE NOT_FOUND

    LEA DX, prompt9
    INT 21H
    JMP REMAINING

    NOT_FOUND:
      LEA DX, prompt0
      INT 21H
  REMAINING:
    MOV AH, 09H
    LEA DX, prompt11
    INT 21H

    MOV AH, 01H
    INT 21H

    XOR AH, AH
    SUB AL, 30H
    PUSH AX

    CALL NTH_FIBO

    MOV BX, AX

    MOV AH, 09H
    LEA DX, prompt12
    INT 21H

    MOV CL, 4 
    MOV CH, 4 
    AGAIN_:
    MOV DL, BH 
    SHR DL, CL 
    CMP DL, 9 
    JLE DIGIT_ 
    ADD DL, 37H 
    JMP DISPLAY_
    DIGIT_:
    ADD DL, 30H 
    DISPLAY_:
    MOV AH, 02H
    INT 21H 

    ROL BX, CL 
    DEC CH 
    JNZ AGAIN_

  MOV AH, 4CH
  INT 21H
MAIN ENDP

NTH_FIBO PROC
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH SI
  PUSH DI
  PUSH BP
  MOV BP, SP
  MOV BX, [BP + 12 + 2]
  CMP BX, 1
  JLE NTH_FIBO_BASE_CASE
  JMP NTH_FIBO_RECURSIVE
  NTH_FIBO_BASE_CASE:
    MOV AX, BX
    JMP NTH_FIBO_END
  NTH_FIBO_RECURSIVE:
    MOV DX, BX
    DEC DX
    PUSH DX
    CALL NTH_FIBO
    MOV CX, AX
    DEC DX
    PUSH DX
    CALL NTH_FIBO
    ADD AX, CX
  NTH_FIBO_END:
    POP BP
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET 2
NTH_FIBO ENDP

END MAIN
