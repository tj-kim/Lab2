//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

`include "fsm_pk.v"

module testfsm();

    reg msb_sr;   // most significant bit shift register output
    reg c_cs;     // conditioned chip select signal put thru input conditioner
    reg peripheralClkEdge;    // peripheral clockedge of sclk
    reg clk;                  // clk
    wire MISO_BUFF;           // miso output enable
    wire DM_WE;               // Data Memory Write Enable
    wire ADDR_WE;             // Address Write Enable (for address latch)
    wire SR_WE;                // Shift Register Write Enable

    // Instantiate with parameter width = 8
    fsm dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .msb_sr(msb_sr), 
    		           .c_cs(c_cs), 
    		           .MISO_BUFF(MISO_BUFF), 
    		           .DM_WE(DM_WE),
                       .ADDR_WE(ADDR_WE),
    		           .SR_WE(SR_WE));
    always begin
    #1 clk = ~clk;
    //#4 peripheralClkEdge= ~peripheralClkEdge;
    end

    initial begin
    	// Your Test Code
        $dumpfile("fsm.vcd");
        $dumpvars();

        $display(" clk  |   pclk   |  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        
        // Initial Conditions time = 0
        clk=1; peripheralClkEdge = 0; msb_sr = 0; c_cs = 1; #5

        // Testing Write
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 0; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 0; c_cs =0; #5


        // Testing Write
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5


        // Testing cs off
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =1; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =1; #5

        // Testing Write
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
        peripheralClkEdge = 1; msb_sr = 1; c_cs =0; #2
        peripheralClkEdge = 0; msb_sr = 1; c_cs =0; #5
    
      
        #10 $finish;
    end

endmodule

