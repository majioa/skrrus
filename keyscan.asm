.286
.MODEL	SMALL
.STACK	100H
COD	SEGMENT PARA
ASSUME	CS:COD,DS:DATA,SS:STACK
OLD_9	DW	     0,0
START:
	XOR	AX,AX
	MOV	DS,AX
	LEA	BX,NEW9
	MOV	AX,CS
	CLI
	XCHG	DS:[9*4],BX
	XCHG	DS:[9*4+2],AX
	MOV	CS:[OLD_9],BX
	MOV	CS:[OLD_9+2],AX
	STI
	CALL	ENTKEY
	CLI
	MOV	BX,CS:[OLD_9]
	MOV	AX,CS:[OLD_9+2]
	XCHG	DS:[9*4],BX
	XCHG	DS:[9*4+2],AX
	STI
	MOV	AX,3100H
	MOV	DX,10H+10H+(ECS-OLD_9+15)/16
	INT	21H
ENTKEY	PROC
	XOR	AX,AX
	INT	16H
	CMP	AL,13
	JNZ	ENTKEY
	RET
ENDP
NEW9:
	CALL	PRINTHEX
	JMP	DWORD PTR CS:[OLD_9]
PRINTHEX	PROC
	PUSHA
	IN	AL,60H
	XOR	AH,AH
	CALL	WRITE_HEX
	POPA
	RET
ENDP
INCLUDE WRITEHEX.LIB
ECS:
ENDS
DATA	SEGMENT PARA
ENDS
END     START