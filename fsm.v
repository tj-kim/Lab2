//------------------------------------------------------------------------
//Finite State Machine
//   
//
//------------------------------------------------------------------------

module fsm
(
input msb_sr,	// most significant bit shift register output
input c_cs,		// conditioned chip select signal put thru input conditioner
input peripheralClkEdge,	// peripheral clockedge of sclk
output reg MISO_BUFF, 			// miso output enable
output reg DM_WE,				// Data Memory Write Enable
output reg ADDR_WE,				// Address Write Enable (for address latch)
output reg SR_WE				// Shift Register Write Enable
);

    // reg [2:0] counter;
    // if (peripheralClkEdge) begin
    // 	if (counter < 3'b100) begin  // get 
    //     	counter <= counter + 3'b001; //increment counter
    //     end
    // 	else if (counter == 3'b100) begin // got
    // 		if (msb_sr == 1) begin 	// if read...
    // 			// skip through read 1
    // 	// 		// read 2
    // 	// 		MISO_BUFF <= 0; DM_WE<=0; ADDR_WE<= 0; SR_WE <=1;
    // 	// 		// read 3
 			// 	// MISO_BUFF <= 1; DM_WE<=0; ADDR_WE<= 0; SR_WE <=0;
    // 		end
    // 		else begin 				// if write...

    // 		end
    // 		counter <= 3'b000;
    // 	end

    // end

    reg [2:0] counter;
    reg [11:0] LUT_command;
    LUT_command[0] =

    if (peripheralClkEdge) begin
    	if (counter < 3'b100) begin  // get 
        	counter <= counter + 3'b001; //increment counter
        end
    	else if (counter == 3'b100) begin // got
    		counter <= 3'b000;
    	end

    end

    fsm_LUT(SR_WE,);


    // assign parallelDataOut = shiftregistermem;
    // assign serialDataOut = shiftregistermem[width-1];

endmodule


 //ALUcontrolLUT controlLUT(muxIndex, invertB, othercontrolsignal, command)

`define Get  12'h000
`define Got  3'd1
`define Read1  3'd2
`define Read2 3'd3
`define Read3  3'd4
`define Write1 3'd5
`define Write2  6'b 111000
`define Done   3'd7

module fsm_LUT // Converts the commands to a more convenient format
(
    output reg  SR_WE,
    output reg  Reset_counter,
    output reg  DM_WE,
    output reg  ADDR_WE,
    output reg  MISO_BUFF,
    input[11:0]  ALUcommand
);

    always @(ALUcommand) begin
      case (ALUcommand)
        `Get:  		begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Got:  		begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Read1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Read2: 	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Read3:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Write1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Write2:   	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
        `Done:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; end
      endcase
    end
endmodule