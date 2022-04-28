DATA 	SEGMENT
LETTER DB 0
NUM    DB 0
OTHER  DB 0
BUF DB 81, ?, 81 DUP(?)
STRING1	DB	0DH, 0AH, "LETTER:",'$'
STRING2	DB	0DH, 0AH, "NUM:", '$'
STRING3	DB	0DH, 0AH, "OTHER:",'$'
DATA ENDS

CODE 	SEGMENT
	ASSUME 	CS:CODE, DS:DATA
START:	
	MOV	AX, DATA
	MOV	DS, AX
	LEA DX, BUF			
	MOV AH, 0AH	
	INT 21H
	MOV BX, 0
	JMP NEXT2
NEXT1:
	MOV AL, BUF[BX+2]
	INC BX              
	CMP AL, "0"			
	JB	OTHERS
	CMP AL, "9"
	JA 	ELSE1
	INC NUM
	JMP NEXT2
ELSE1:					
	CMP AL, "A"
	JB	OTHERS
	CMP AL, "Z"
	JA	ELSE2
	INC LETTER
	JMP NEXT2
ELSE2:
	CMP AL,"a"
	JB	OTHERS
	CMP AL, "z"
	JA	OTHERS
	INC LETTER
	JMP	NEXT2
OTHERS:
	INC OTHER
	JMP NEXT2
NEXT2:
	CMP BL, BUF[0]
	JAE	OUTPUT
	CMP BL, BUF[1]
	JNE	NEXT1
OUTPUT:
    LEA	DX, STRING1
	MOV	AH, 9
	INT	21H
	MOV	AH, 2
	MOV BL, LETTER 
	MOV CL, 4
	SHR BL, CL
	CMP BL, 9
	JA  X1
	JMP Y1
X1: ADD BL, 7H
Y1: ADD BL, 30H
	MOV	DL, BL
	INT	21H
	MOV AH,2
	AND LETTER,0FH
	CMP LETTER,9
	JA  X2
	JMP Y2
X2: ADD LETTER,7H
Y2: ADD LETTER,30H
	MOV	DL, LETTER
	INT	21H	
	
	LEA	DX, STRING2
	MOV	AH, 9
	INT	21H
	MOV	AH, 2
	MOV BL, NUM 
	MOV CL, 4
	SHR BL, CL
	CMP BL, 9
	JA  X3
	JMP Y3
X3: ADD BL, 7H
Y3: ADD BL, 30H
	MOV	DL, BL
	INT	21H
	MOV AH, 2
	AND NUM,0FH
	CMP NUM,9
	JA  X4
	JMP Y4
X4: ADD NUM,7H
Y4: ADD NUM,30H
	MOV	DL, NUM
	INT	21H	

	LEA	DX, STRING3
	MOV	AH, 9
	INT	21H
	MOV	AH, 2
	MOV BL, OTHER 
	MOV CL, 4
	SHR BL, CL
	CMP BL, 9
	JA  X5
	JMP Y5
X5:  ADD BL,7H
Y5:  ADD BL,30H
	MOV	DL, BL
	INT	21H
	MOV AH, 2
	AND OTHER,0FH
	CMP OTHER,9
	JA  X6
	JMP Y6
X6:  ADD OTHER,7H
Y6:  ADD OTHER,30H
	MOV	DL, OTHER
	INT	21H	
	MOV	AX, 4C00H
	INT	21H	
CODE	ENDS
END		START
