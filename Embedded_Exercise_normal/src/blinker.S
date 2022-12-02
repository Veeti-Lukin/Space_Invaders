
//ARM INSTRUCTIONS
//Instructions are conditional
//32-bit instruction


//How to load data from memory:
//LDR R0, =variable 	(Load address to register. You can use any global variable defined in main.c, or variable found here)
//LDR R1, [R0] 			(Load data from address, in this case 32-bit data)
//LDRB R1, [R0] 		(Load data from address, in this case 8-bit data)
//******
//LDR R0, =0x123456		(Load address to register, Use only if you know the memory address)
//LDR R1, [R0]			(load data from address, in this case 32-bit data)
//LDRB R1, [R0]			(load data from address, in this case 8-bit data)

//How to store data to memory:
//STR R1,[R0]			(R1 contains the data and R0 contains the address where  to store, 32-bit)
//STRB R1,[R0]			(R1 contains the data and R0 contains the address where  to store, 8-bit)


.data
	dir: .byte 1		//8-bit variable for direction 1 for left 0 for right

.text

.global blinker

blinker:

	push {r0}				//Push used register to stack
	push {r1}
	push {r2}
	push {r3}

	ldr r0, =0x41200000		//load the 32-bit address of led controlling "register" to register 0
	ldrb r1, [r0]			//load to led controlling "registers" value to register 1
	ldr r2, =dir			//load the 32-bit address of the leds moving direction variable to registet 2
	ldrb r3, [r2]			//load the moing direction variable to register 3

	cmp r1, #0				//compare if led controlling register is 0
	beq position_zero		//if it is branch to position_zero

	cmp r3, #1				//compare if moving direction variable is 1
	beq shift_left			//if it is 1 branch to shift_left
	bne shift_right			//if it is 0 branch to shift_right

position_zero:
	mov r1, #1				//set led control value to be 1
	b end					// branch to end

shift_left:
	lsl r1, r1, #1			//shift led control value left once

	cmp r1, #8				//compare if led control value is 8(0b1000) aka if 4th led is on
	beq direction_to_right	//branch to direction_to_right

	b end					// branch to end

direction_to_right:
	mov r3, #0				//change the direction variable to 0
	str r3, [r2]			//store the changed direction variable back to data memory

	b end					// branch to end

shift_right:
	lsr r1, r1, #1			//shift led control value right once

	cmp r1, #1				//compare if led control value is 0(0b001) aka if 1st led is on
	beq direction_to_left	//branch to direction_to_left

	b end					// branch to end

direction_to_left:
	mov r3, #1				//change the direction variable to 0
	str r3, [r2]			//store the changed direction variable back to data memory

	b end					// branch to end

end:
	str r1, [r0]			//store new led controlling "register" binary value back to data memory
	pop {r3}				//Pop register from stack, Remember the pop order if used more than one register (first pushed, last popped)
	pop {r2}
	pop {r1}
	pop {r0}
	bx lr					//Return to place where this function has been called.

// amount of subfunctions could probably be reduced with some conditinal instructions 