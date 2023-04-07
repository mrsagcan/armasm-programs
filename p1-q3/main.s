	INCLUDE core_cm4_constants.s		
	INCLUDE stm32l476xx_constants.s   
             

NUM_ROWS EQU 4
NUM_COLS EQU 3
	
	AREA matrices, DATA, READWRITE 		
input_matrix	
	DCD	1, 2, 3
	DCD 4, 5, 6
	DCD 7, 8, 9
	DCD 10, 11, 12

output_matrix
	DCD 0, 0, 0, 0 
	DCD	0, 0, 0, 0 
	DCD	0, 0, 0, 0

	
	
	AREA    main, CODE, READONLY

	EXPORT  __main        
	ENTRY 

__main  PROC
	
	; Initialize input matrix index
	MOV R4, #0
	
; Loop through columns of input matrix
outer_loop
	
	; Initialize column index
	MOV R2, #0
	
	MOV R6, #12
	
	MOV R7, #16

; Loop through rows of input matrix
inner_loop

	; Calculate input matrix element address
	LDR R0, = input_matrix
	MOV R5, R4
	MUL R4, R4, R6
	ADD R0, R0, R4
	ADD R0, R0, R2, LSL #2
	MOV R4, R5

	
	; Calculate output matrix element address
	LDR R1, = output_matrix
	MOV R5, R2
	MUL R2, R2, R7
	ADD R1, R1, R2
	ADD R1, R1, R4, LSL #2
	MOV R2, R5
	
	; Load input matrix element
	LDR R3, [R0]
	
	; Store input matrix element in output matrix
	STR R3, [R1]
	
	;Increment column index
	ADD R2, R2, #1
	
	;Check if row index has reached end of input matrix
	CMP R2, NUM_COLS
	BNE inner_loop
	
	;end of inner loop body
	
	; Increment row index
	ADD R4, R4, #1
	
	;Check if column index has reached end of input matrix
	CMP R4, NUM_ROWS
	BNE outer_loop
	
;end of outer loop


stop B 	stop	
		ENDP
			
		END