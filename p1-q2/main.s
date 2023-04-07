		INCLUDE core_cm4_constants.s		
		INCLUDE stm32l476xx_constants.s   
             

		AREA 	data, DATA, READWRITE 						
str1    	DCB   "This is a test", 0
str2    	DCB   "This is a test", 0   
str1_new	SPACE 64
str2_new	SPACE 64
	
		AREA    main, CODE, READONLY

		EXPORT  __main        
		ENTRY 

__main  PROC
		
		LDR R0, = str1
		LDR R1, = str1_new
		BL upper_to_lower
		
		LDR R0, = str2
		LDR R1, = str2_new
		BL lower_to_upper
		
stop	B stop

upper_to_lower
		PUSH{LR}
		MOV R2, #0
		MOV R3, #0
		
loop1
		LDRB R2, [R0], #1
		CMP R2, #0
		BEQ finish
		
		CMP R2, #'A'
		BLT other1
		
		CMP R2, #'Z'
		BGT other1
		
		ADD R2, R2, #'a' - 'A'
		STRB R2, [R1], #1
		B loop1
		
other1
		STRB R2, [R1], #1
		B loop1

lower_to_upper
		PUSH{LR}
		MOV R2, #0
		MOV R3, #0
		
loop2
		LDRB R2, [R0], #1
		CMP R2, #0
		BEQ finish
		
		CMP R2, #'a'
		BLT other2
		
		CMP R2, #'z'
		BGT other2
		
		ADD R2, R2, #'A' - 'a'
		STRB R2, [R1], #1
		B loop2
		
other2
		STRB R2, [R1], #1
		B loop2
		
finish
		STRB R3, [R1], #1
		POP{PC}
		
		ENDP
                
		END