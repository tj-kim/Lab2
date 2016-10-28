module fsm
(
	input clk,
	input msb_sr,	// most significant bit shift register output
	input c_cs,		// conditioned chip select signal put thru input conditioner
	input peripheralClkEdge,	// peripheral clockedge of sclk
	output reg MISO_BUFF, 			// miso output enable
	output reg DM_WE,				// Data Memory Write Enable
	output reg ADDR_WE,				// Address Write Enable (for address latch)
	output reg SR_WE				// Shift Register Write Enable
);
reg[7:0] state;

localparam GET = 8'b00000001,
		   GOT = 8'b00000010,
		   READ1 = 8'b00000100,
		   READ2 = 8'b00001000,
		   READ3 = 8'b00010000,
		   WRITE1 = 8'b00100000,
		   WRITE2 = 8'b01000000,
		   DONE = 8'b10000000;
reg [3:0] counter;
reg counter_reset;
reg reset_flg;

initial begin
counter = 4'b0000;
counter_reset = 0;
state = GET;
MISO_BUFF = 0;
DM_WE =0;
ADDR_WE =0;
SR_WE =0;
end



always @(posedge clk) begin

	//if (counter_reset) begin
	//counter_reset <= 0;
	//counter = 4'b0000;
	//reset_flg <= 1;
	//end



	if (peripheralClkEdge && !counter_reset) begin
		counter <= counter + 1;
	end

	if(counter_reset || c_cs ) begin
		counter <=0;
		counter_reset <= 0;
	end

	if (c_cs) begin
		state <= GET;
		counter <= 4'b0000;
		MISO_BUFF <= 0;
		DM_WE <=0;
		ADDR_WE <=0;
		SR_WE <=0;
	end

	else begin
		case (state)
			GET: begin
				if (counter==4'b1000) begin
					state <= GOT;
				end
				else begin
					state <= GET;
					//counter <= counter + 4'b0001;
				end
			end

			GOT: begin
				if (msb_sr ) begin	// && reset_flg
					state <= READ1;
					//reset_flg <=0;
				end
				else begin
					if (!msb_sr ) begin // && reset_flg
						state <= WRITE1;
						// reset_flg <=0;
					end
				end
			end

			READ1: begin
				state <= READ2;
			end

			READ2: begin
				// reset_flg <= 0;
				state <= READ3;
			end

			READ3: begin
				if (counter == 4'b1000) begin
					state <= DONE;
				end
				else begin
					state <= READ3;
					//counter <= counter + 1;
				end
			end

			WRITE1: begin
				if (counter == 4'b1000) begin
					state <= WRITE2;
					// counter_reset <= 1;
				end
				else begin
					// counter_reset <=0;
					state <= WRITE1;
					//counter <= counter + 1;
				end
			end

			WRITE2: begin
				state <= DONE;
			end

			DONE: begin
				// if (reset_flg); begin
					state <= DONE;
					// reset_flg <=0;
				// end
			end
		endcase
//end // @ peripheralclkedge
end
end
always @(state) begin
	case (state)
		GET: begin
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		GOT: begin
			MISO_BUFF <= 0;
			ADDR_WE <= 1;
			DM_WE <=0;
			SR_WE <=0;
			counter_reset <= 1;
			counter <= 4'b0000;
		end

		READ1: begin
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		READ2: begin
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=1;
		end

		READ3: begin
			MISO_BUFF <=1;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		WRITE1: begin
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		WRITE2: begin
			MISO_BUFF <= 0;
			DM_WE <=1;
			ADDR_WE <=0;
			SR_WE <=0;
		end

		DONE: begin
			MISO_BUFF <= 0;
			DM_WE <=0;
			ADDR_WE <=0;
			SR_WE <=0;
			counter <= 4'b0000;
		end
	endcase
end // @ state

endmodule
