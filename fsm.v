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
input clk,					// clk
output reg MISO_BUFF, 			// miso output enable
output reg DM_WE,				// Data Memory Write Enable
output reg ADDR_WE,				// Address Write Enable (for address latch)
output reg SR_WE				// Shift Register Write Enable
);

    reg [2:0]  counter;
    reg [10:0] LUT_command;
    reg [7:0]  one_hot_signal;
    reg [3:0]  next_index;
    reg 	   counter_full_holder;
    reg  	   Reset_counter;

    always @(posedge clk) begin
    	LUT_command[10] = c_cs;
    	LUT_command[9] = msb_sr;
    	LUT_command[7:0] = one_hot_signal;

	    if (peripheralClkEdge) begin
	    	counter <= counter + 3'b001;
	    	if (counter == 3'b111) begin
	    		LUT_command[8] = 1;
	    	end
	    	else begin
	    		LUT_command[8] = 0;
	    	end
	    end

	    fsm_LUT(SR_WE, Reset_counter, DM_WE, ADDR_WE, MISO_BUFF, next_index, LUT_command);

	    if (Reset_counter) begin
	    	counter <= 3'b000;
	    end

	    if(next_index == 4'b1000) begin
	    	one_hot_signal <= 8'b00000000
	    end
	    else begin
	    	one_hot_signal = 1<<next_index; 
	    end
    end

endmodule


// Table Abbreviations
// Key:
//      First bit is Cs, 2nd is msb, 3rd is counterfull
//		Last 8 are next state index (Which state the name lines up to) in one hot form

`define RESET_1   11'b110xxxxxxxx // initial state with msb 1
`define RESET_2   11'b100xxxxxxxx // initial state with msb 0
`define RESET_3   11'b11000000000 // initial state with msb 1
`define RESET_4   11'b10000000000 // initial state with msb 0

`define Get_1     11'b10000000001 // Get state with msb 0, counter_full 0
`define Get_2     11'b11000000001 // Get state with msb 1, counter_full 0
`define Get_3     11'b10100000001 // Get state with msb 0, counter_full 1
`define Get_4     11'b11100000001 // Get state with msb 1, counter_full 1

`define Got_1     11'b11100000010 // Got state with msb 1, counter_full 1, goes to read
`define Got_2     11`b10100000010 // Got state with msb 0, counter_full 1, goes to write

`define Read1     11'b11000000100 // Read 1 state with msb 1, countefull 0

`define Read2     11'b11000001000 // Read 2 state with msb 1, counterfull 0

`define Read3_1   11'b10000010000 // Read 3 state with msb 0, counter_full 0
`define Read3_2   11'b11000010000 // Read 3 state with msb 1, counter_full 0
`define Read3_3   11'b10100010000 // Read 3 state with msb 0, counter_full 1
`define Read3_4   11'b11100010000 // Read 3 state with msb 1, counter_full 1

`define Write1_1  11'b10000100000 // Write 1 state with msb 0, counter_full 0
`define Write1_2  11'b11000100000 // Write 1 state with msb 1, counter_full 0
`define Write1_3  11'b10100100000 // Write 1 state with msb 0, counter_full 1
`define Write1_4  11'b11100100000 // Write 1 state with msb 1, counter_full 1

`define Write2_1  11'b10101000000 // Write 2 state with msb 0, counter_full 1
`define Write2_2  11'b11101000000 // Write 2 state with msb 1, counter_full 1

`define Done_1    11'b10110000000 // Done satate with msb 0, counter_full 1
`define Done_2    11'b11110000000 // Done satate with msb 1, counter_full 1


module fsm_LUT // Converts the commands to a more convenient format
(
    output reg  SR_WE,
    output reg  Reset_counter,
    output reg  DM_WE,
    output reg  ADDR_WE,
    output reg  MISO_BUFF,
    output reg [3:0]  next_index,
    input[10:0]  LUT_command
);

    always @(LUT_command) begin
      case (LUT_command)
      	
      	`RESET1:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET2:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
        `RESET3:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
      	`RESET4:    begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end

        `Get_1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
		`Get_2:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0000; end
        `Get_3:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0001; end
        `Get_4:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0001; end

        `Got_1:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 1; MISO_BUFF = 0; next_index = 4'b0010; end
        `Got_2:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 1; MISO_BUFF = 0; next_index = 4'b0101; end

        `Read1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0011; end
        
        `Read2: 	begin SR_WE = 1; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0100; end
        
        `Read3_1:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0100; end
        `Read3_2:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0100; end
        `Read3_3:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0111; end
        `Read3_4:  	begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 1; next_index = 4'b0111; end
        
 
        `Write1_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0101; end
        `Write1_2:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0101; end
        `Write1_3:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0110; end
        `Write1_4:  begin SR_WE = 0; Reset_counter=0; DM_WE = 1; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0110; end

        
        `Write2_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0111; end
        `Write2_1:  begin SR_WE = 0; Reset_counter=0; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b0111; end

        `Done_1:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b1000; end
        `Done_2:  	begin SR_WE = 0; Reset_counter=1; DM_WE = 0; ADDR_WE = 0; MISO_BUFF = 0; next_index = 4'b1000; end
      endcase
    end
endmodule