//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

`include "shiftregister.v"

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    always begin
    #1 clk = ~clk;
    //#6 peripheralClkEdge= ~peripheralClkEdge;
    end

    initial begin
    	// Your Test Code
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        $display(" clk  |   pclk   |  pload |     pin      |  sin  |      pout     |  sout  |  expected");
        
        clk=1; 
        
        peripheralClkEdge=0;
        parallelLoad=0; parallelDataIn=8'b00000000; serialDataIn=1;#10
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  00000000   0",  1, 1'b0, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        
        parallelLoad=1;#10
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  00000000   0",  1, 1'b0, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut); 

        parallelLoad=0; serialDataIn=1;#8
        peripheralClkEdge = 1; #10
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  00000001   0",  1, 1'b1, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        
        peripheralClkEdge = 0; #10
        parallelLoad=0; parallelDataIn=8'b11110000; serialDataIn=1; #10 
        peripheralClkEdge = 1; #10
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  11100001   1",  1, 1'b0, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        
        parallelLoad=1; parallelDataIn=8'b11110000; serialDataIn=1; #10 
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  11100001   1",  1, 1'b0, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        
        parallelLoad=1; parallelDataIn=8'b11110000; serialDataIn=1;
        $display("  %b  |    %b     |    %b   |   %b   |   %b   |   %b    |   %b    |  11100001   1",  1, 1'b1, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);


        #60 $finish;
    end

endmodule

