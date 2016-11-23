.MODEL SMALL
.STACK 100H
.DATA
  prompt DB 10, 13, "Enter a character: $"
  newLine DB 10, 13, "$"
  commonOutput DB " belongs to category: $"
  lowercase DB "Lowercase$"
  uppercase DB "Uppercase$"
  digit DB "Digit$"
  operators DB "Mathematical Operator$"
  other DB "Other$"
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
  ;taske single character input
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
  ;output that character
  ;
  MOV DL, AL
  MOV AH, 02H
  INT 21H
  ;
  ;display commonOutput
  ;
  MOV AH, 09H
  LEA DX, commonOutput
  INT 21H
  ;
  ;prepare for display
  ;
  MOV AH, 09H
  ;
  ;check for lowercase
  ;
  CMP AL, 'a'
  JNGE UPPERCASE_CATEGORY ; AL < 'a'
  CMP AL, 'z'
  JNLE UPPERCASE_CATEGORY ; AL > 'z'
  LEA DX, lowercase
  INT 21H
  JMP REMAIN
  ;
  ;check for uppercase
  ;
  UPPERCASE_CATEGORY:
  CMP AL, 'A'
  JNGE DIGIT_CATEGORY ; AL < 'A'
  CMP AL, 'Z'
  JNLE DIGIT_CATEGORY ; AL > 'Z'
  LEA DX, uppercase
  INT 21H
  JMP REMAIN
  ;
  ;check for digit
  ;
  DIGIT_CATEGORY:
  CMP AL, '0'
  JNGE OPERATOR_CATEGORY ; AL < '0'
  CMP AL, '9'
  JNLE OPERATOR_CATEGORY ; AL > '9'
  LEA DX, digit
  INT 21H
  JMP REMAIN
  ;
  ;check for operators
  ;
  OPERATOR_CATEGORY:
  CMP AL, '%'
  JE MATH_OPERATOR ; AL == '%'
  CMP AL, '*'
  JE MATH_OPERATOR ; AL == '*'
  CMP AL, '+'
  JE MATH_OPERATOR ; AL == '+'
  CMP AL, '-'
  JE MATH_OPERATOR ; AL == '-'
  CMP AL, '/'
  JE MATH_OPERATOR ; AL == '/'
  JMP OTHER_CATEGORY
  ;
  ;display MATH_OPERATOR
  ;
  MATH_OPERATOR:
  LEA DX, operators
  INT 21H
  JMP REMAIN
  ;
  ;if nothing else than other
  ;
  OTHER_CATEGORY:
  LEA DX, other
  INT 21H
  ;
  ;exit DOS
  ;
  REMAIN:
  MOV AH, 4CH
  INT 21H
  
MAIN ENDP
END MAIN
