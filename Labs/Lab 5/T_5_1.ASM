.MODEL SMALL
.STACK 100H
.DATA
  string DB 10, 13, "Seems like I can display a string. Let's try.$"
MAIN PROC
  ;
  ;initialization of data segment
  ;
  MOV AX, @data
  MOV DS, AX
  ;
  ;display str
  ;
  MOV AH, 09H
  MOV DX, OFFSET string
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
