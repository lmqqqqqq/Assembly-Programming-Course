EXTRN   DISPBX: FAR 

DSEG	 SEGMENT  PUBLIC
	DATA DW 1234H,5678H,9B4DH,0D7H,0,-1,7F2EH,8E0AH,10F5H,645DH
    N    EQU $-DATA
    MIN  DW ?
    MAX  DW ?
    STRING1 DB "MIN:",'$'
    STRING2 DB 13,10,"MAX:",'$'
DSEG		ENDS

CSEG		SEGMENT
	ASSUME	CS: CSEG, DS: DSEG
MAIN 	PROC		FAR
START:  MOV     AX,DSEG
        MOV     DS,AX
        MOV     CX,N-1
        MOV     BX,OFFSET DATA
        MOV     AX,[BX]
AGAIN:  INC     BX
        MOV     SI, [BX]
        TEST    SI, 01H
        JNZ     NEXT
        CMP     AX,[BX]
        JLE     NEXT
        MOV     AX,[BX]
NEXT:   LOOP    AGAIN
        MOV     MIN,AX
        MOV     BX,AX
        LEA     DX,STRING1
        MOV     AH,09H
        INT     21H
        CALL    DISPBX

        MOV     CX,N-1
        MOV     BX,OFFSET DATA
        MOV     AX,[BX]
AGAIN1: INC     BX
        MOV     SI, [BX]
        TEST    SI, 01H
        JNZ     NEXT1
        CMP     AX,[BX]
        JGE     NEXT1
        MOV     AX,[BX]
NEXT1:  LOOP    AGAIN1
        MOV     MAX,AX
        MOV     BX,AX
        LEA     DX,STRING2
        MOV     AH,09H
        INT     21H
        CALL    DISPBX

		MOV	    AX, 4C00H
		INT	    21H
MAIN	ENDP 
CSEG	ENDS
		END	MAIN 