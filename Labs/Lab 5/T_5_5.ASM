.MODEL SMALL
.STACK 100H
.DATA
    newLine db 10, 13, "$"
    totalRows db 5
    totalCols db 10
.CODE
MAIN PROC
    ;
    ;initialization of data segment
    ;
    MOV AX, @DATA
    MOV DS, AX
    ;
    ;loop which control rows
    ;
    ROW:
        MOV totalCols, 10 ; each row have 10 columns
        COL:
            ;
            ;display *
            ;
            MOV DL, '*'
            MOV AH, 02H
            INT 21H
            ;
            ;decrementing totalCols so loop can be ended
            ;
            DEC totalCols
            JNZ COL
        ;
        ;display newLine
        ;
        MOV AH, 09H
        MOV DX, OFFSET newLine
        INT 21H
        ;
        ;decrementing totalRows so loop can be ended
        ;
        DEC totalRows
        JNZ ROW
    ;
    ;exit DOS
    ;
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN