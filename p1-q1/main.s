		INCLUDE core_cm4_constants.s		
		INCLUDE stm32l476xx_constants.s      
                

		AREA 	data, DATA, READWRITE
str1 	DCB "8AB", 0   
str2 	DCB "478", 0   
result	DCD 0  

		AREA    main, CODE, READONLY
		EXPORT  __main        
		ENTRY 

__main  PROC
		
		;hex to dec first one
		LDR	R2, = str1
		BL hexToDec
		MOV R4, R0
		
		;hex to dec second one
		LDR R2, = str2
		BL hexToDec
		MOV R5, R0
		
		;subtraction
		SUB R2, R4, R5
		LDR R0, =result
		;written to the memory that result label corresponds to
		STR R2, [R0]
		
stop	B stop

hexToDec
		PUSH{LR}
		MOV R0, #0
parse
		LDRB R1, [R2], #1
		CMP R1, #'0' ;if reached end of string
		BLT done
		CMP R1, #'9' ;if it is numeric
		BLE numeric
		SUB R1, R1, #'A' - 10 ;then it is hexa
		B convert
numeric
		SUB R1, R1, #'0'
convert
		LSL R0, R0, #4
		ADD R0, R0, R1
		B parse
done
		POP {PC}
		
		ENDP
                
		END