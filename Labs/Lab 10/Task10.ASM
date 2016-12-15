.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter an infix expression: $"
  prompt2 DB 10, 13, "Postfix equivalent: $"
  var1 DW ?
  str1 DB 100 DUP('$')
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
  ;preparing for taking input in str1
  ;
  LEA DI, str1
  MOV CX, 99D

  CALL STRINP
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H

  LEA SI, str1 ;preparing for POSTFIX procedure

  CALL POSTFIX 
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP

;
;parameters are DI(offset of string in which input is taken), CX(total size of input)
;take input from user until user enter return aur input size is zero
;
STRINP PROC
  PUSH AX ;saving content of AX
  MOV AH, 01H
  INPUT:
    INT 21H ;input single character
    CMP AL, 13D
    JE END_INPUT ;jump to END_INPUT if return is pressed
    MOV [DI], AL ;storing input character taken into string
    INC DI ;incrementing DI so it can point to next address in memory
    LOOP INPUT ;loop until input size is zero
  END_INPUT:
    POP AX ;restoring previous content of AX
  RET
STRINP ENDP

;
;parameters are SI(offset of the string), CL(length of the string)
;calculate length of the given string's offset in SI
;
STRLEN PROC
  PUSH AX ;saving content of AX
  PUSH SI ;saving content of SI
  XOR CL, CL ;CL = 0
  MOV AH, 99D ;size of the str1
  STR_LENGTH:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_LENGTH ;jump if '$' is fing in string
    INC CL ;incrementing length of string
    INC SI ;incrementing SI so it can point to next address
    DEC AH
    JNZ STR_LENGTH 
  END_LENGTH:
    POP SI ;restoring content of SI
    POP AX ;restoring content of AX
  RET
STRLEN ENDP

;
;parameter is AL(holds mathematical operator)
;return value in AH, 1 if it is mathematical operator else 0
;
IS_MATH_OPERATOR PROC
  CMP AL, '+'
  JE ONE
  CMP AL, '-'
  JE ONE
  CMP AL, '*'
  JE ONE
  CMP AL, '/'
  JE ONE
  CMP AL, '%'
  JE ONE
  MOV AH, 0D
  RET
  ONE:
  MOV AH, 1D
  RET
IS_MATH_OPERATOR ENDP

;
;parameter is AL(holds mathematical operator)
;return value in AH, 1 if +. - else 2 for *, /, %
;
PRECEDENCE PROC
  CMP AL, '+'
  JE ONE
  CMP AL, '-'
  JE ONE
  CMP AL, '*'
  JE TWO
  CMP AL, '/'
  JE TWO
  CMP AL, '%'
  JE TWO
  RET
  ONE:
    MOV AH, 1D
    RET
  TWO:
    MOV AH, 2D
    RET
PRECEDENCE ENDP

;
;reading top of the STACK
;
READ_TOP PROC
  MOV var1, AX ;saving the content of AX
  POP AX ;POP return address
  POP BX ;POP top of the STACK
  PUSH BX ;PUSH back the top of the STACK
  PUSH AX ;PUSH back the return address
  MOV AX, var1 ;moving back the content of AX
  RET
READ_TOP ENDP

;
;parameter is DL(hold the character to display)
;
DISPLAY PROC
  PUSH AX ;saving the content of AX
  MOV AH, 02H
  INT 21H ;display character
  POP AX ;POP back the saved content of AX
  RET
DISPLAY ENDP

POSTFIX PROC
  CALL STRLEN ;length of str1 in CL
  MOV CH, 0D ;help in checking whether STACK is empty aur not
  WHILE_CL_NOT_ZERO:
    MOV AL, [SI] ;moving [SI] to AL so other procedures can use it
    CMP AL, '('
    JE PUSH_INTO_STACK ;jump if AL == '('
    CMP AL, ')'
    JE POP_INTO_DX ;jump if AL == ')'
    CALL IS_MATH_OPERATOR ;check if character aur any mathematical operator
    CMP AH, 1D
    JE MATH_OPERATOR ;jump if AH == 1
      MOV DL, AL ;display procedure parameter
      CALL DISPLAY
      JMP REMAIN_WHILE
    MATH_OPERATOR:
      CALL READ_TOP ;BL will have top of the STACK
      CALL PRECEDENCE ;check for current operator's precedence
      PUSH AX ;saving the contents of AX because top of STACK is about to use AL 
      INC CH
      MOV AL, BL
      CALL PRECEDENCE ;check for top of STACK's precedence
      MOV BH, AH ;moving that precedence
      POP AX ;getting back the precedence of current character in str1
      DEC CH
      CMP CH, 0
      JE PUSH_INTO_STACK ;jump if STACK is empty that is whatever the operator PUSH it into STACK
      CMP BL, '('
      JE PUSH_INTO_STACK ;jump if left brace is encountered because left brace has the higher precedence
      CMP AH, BH
      JG PUSH_INTO_STACK ;jump if current operator has higher precedence than top of STACK
        AGAIN:
          CMP CH, 0D
          JE END_WHILE ;jump if STACK is empty
          CMP BL, '('
          JE END_WHILE ;jump if left brace is occurred while POPing
          CMP AH, BH
          JG END_WHILE ;jump if current operator has higher precedence than top of the STACK
          POP DX ;getting top of the STACK
          DEC CH
          CALL DISPLAY
          CALL READ_TOP
          PUSH AX ;saving content of AX because BL is about to change AL
          INC CH
          MOV AL, BL
          CALL PRECEDENCE
          MOV BH, AH
          POP AX
          DEC CH
          JMP AGAIN
        END_WHILE:
          PUSH AX
          INC CH
        WHILE_NOT_EMPTY:
      JMP REMAIN_WHILE
    PUSH_INTO_STACK:
      PUSH AX
      INC CH
      JMP REMAIN_WHILE
    ;
    ;POPing untill left brace it found
    ;
    POP_INTO_DX:
      POP DX
      DEC CH
      WHILE_NOT_LEFT_BRACE:
        CMP DL, '('
        JE REMAIN_WHILE
        CALL DISPLAY
        POP DX
        DEC CH
        JMP WHILE_NOT_LEFT_BRACE
    REMAIN_WHILE:
    INC SI
    DEC CL
    CMP CL, 0D
    JNE WHILE_CL_NOT_ZERO
    ;
    ;display value in STACK untill STACK is empty
    ;
    AGAIN_:
      CMP CH, 0D
      JE EXIT_POSTFIX
      POP DX
      DEC CH
      CALL DISPLAY
      JMP AGAIN_
    EXIT_POSTFIX:
      RET
POSTFIX ENDP

END MAIN