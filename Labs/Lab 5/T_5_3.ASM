.MODEL SMALL
.STACK 100H
.DATA
  str1 db 10, 13, "First character = $"
  str2 db 10, 13, "Second character = $"
  ALPHA db 6FH
  BETA db 4DH
.CODE
MAIN PROC
  ;
  ;initialization of data segment
  ;
  MOV AX, @data
  MOV DS, AX
  ;
  ;moving first and second characters to registers so they can be swaped
  ;
  MOV BL, ALPHA
  MOV BH, BETA
  ;
  ;a = a + b
  ;b = b - a
  ;-b
  ;a = a - b
  ;
  ADD BL, BH
  SUB BH, BL
  NEG BH
  SUB BL, BH
  ;
  ;putting back values
  ;      
  MOV ALPHA, BH
  MOV BETA, BL
  ;
  ;display str1
  ;
  MOV AH, 09H
  MOV DX, OFFSET str1
  INT 21H
  ;
  ;display ALPHA
  ;
  MOV DL, ALPHA
  MOV AH, 02H
  INT 21H
  ;
  ;display str2
  ;
  MOV AH, 09H
  MOV DX, OFFSET str2
  INT 21H
  ;
  ;display BETA
  ;
  MOV DL, BETA
  MOV AH, 02H
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
