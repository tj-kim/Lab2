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
    #2 clk = ~clk;
    //#20 peripheralClkEdge= ~peripheralClkEdge;
    end

    initial begin
    	// Your Test Code
        $dumpfile("shiftregister.vcd");
        $dumpvars();
        clk=0; 
        peripheralClkEdge=0; parallelLoad=0; parallelDataIn=8'b00000000; serialDataIn=1;#2
        $display("  clk |  pclk  |   pload   |    pin    |   sin   |    sout |  expected");
        peripheralClkEdge=0; parallelLoad=0; parallelDataIn=8'b11110000; serialDataIn=1;#2
        peripheralClkEdge = 1;
        $display("  %b  |   %b      |    %b   |   %b   |   %b   |   %b    |     11100001   1",  clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        parallelLoad=1; parallelDataIn=8'b11110000; serialDataIn=1;
        #30 $display("  %b  |   %b      |    %b   |   %b   |   %b   |   %b    |     11100001   0",  clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
        parallelLoad=1; parallelDataIn=8'b11110000; serialDataIn=1;
        #40 $display("  %b  |   %b      |    %b   |   %b   |   %b   |   %b    |     11100001   0",  clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);


        #60 $finish;
    end

endmodule

