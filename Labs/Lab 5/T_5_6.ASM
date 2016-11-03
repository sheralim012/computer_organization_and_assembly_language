.MODEL SMALL
.STACK 100H
.DATA
  str1 DB 10, 13, "Enter first word: $"
  str2 DB 10, 13, "Enter second word: $"
  str3 DB 10, 13, "In Pig-Latin: $"
  char1 DB ?
  char2 DB ?
  char3 DB ?
  char4 DB ?
  char5 DB ?
  char6 DB ?
  char7 DB ?
  char8 DB ?
  char9 DB ?
  char10 DB ?
  char11 DB 'a'
  char12 DB 'y'
.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX

  MOV AH, 09H
  MOV DX, OFFSET str1
  INT 21H

  MOV AH, 01H
  INT 21H
  MOV char1, AL

  MOV AH, 01H
  INT 21H
  MOV char2, AL

  MOV AH, 01H
  INT 21H
  MOV char3, AL

  MOV AH, 01H
  INT 21H
  MOV char4, AL

  MOV AH, 01H
  INT 21H
  MOV char5, AL

  MOV AH, 09H
  MOV DX, OFFSET str2
  INT 21H

  MOV AH, 01H
  INT 21H
  MOV char6, AL

  MOV AH, 01H
  INT 21H
  MOV char7, AL

  MOV AH, 01H
  INT 21H
  MOV char8, AL

  MOV AH, 01H
  INT 21H
  MOV char9, AL

  MOV AH, 01H
  INT 21H
  MOV char10, AL

  MOV AH, 09H
  MOV DX, OFFSET str3
  INT 21H

  MOV DL, char2
  MOV AH, 02H
  INT 21H

  MOV DL, char3
  MOV AH, 02H
  INT 21H

  MOV DL, char4
  MOV AH, 02H
  INT 21H

  MOV DL, char5
  MOV AH, 02H
  INT 21H

  MOV DL, char1
  MOV AH, 02H
  INT 21H

  MOV DL, char11
  MOV AH, 02H
  INT 21H

  MOV DL, char12
  MOV AH, 02H
  INT 21H
  ;
  ;display space
  ;
  MOV AH, 02H
  MOV DL, 32D
  INT 21H

  MOV DL, char7
  MOV AH, 02H
  INT 21H

  MOV DL, char8
  MOV AH, 02H
  INT 21H

  MOV DL, char9
  MOV AH, 02H
  INT 21H

  MOV DL, char10
  MOV AH, 02H
  INT 21H

  MOV DL, char6
  MOV AH, 02H
  INT 21H

  MOV DL, char11
  MOV AH, 02H
  INT 21H

  MOV DL, char12
  MOV AH, 02H
  INT 21H

  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN