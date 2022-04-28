EXTRN   DISPBX: FAR 

DSEG	 SEGMENT  PUBLIC
	DATA DW 1234H,5678H,9B4DH,0D7H,0,-1,7F2EH,8E0AH,10F5H,645DH
    N    EQU $-DATA
    MIN  DW ?
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
        CALL    DISPBX
		MOV	    AX, 4C00H
		INT	    21H
MAIN	ENDP 
CSEG	ENDS
		END	MAIN 