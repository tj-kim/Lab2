//------------------------------------------------------------------------
// SPI memory test bench
//------------------------------------------------------------------------
`timescale 1ns / 1ps

module spimemory_test();
    // SPI I/O pins
    reg clk;
    reg sclk_pin;
    reg cs_pin;
    wire miso_pin;
    reg mosi_pin;
    wire[3:0] leds;

    // Instantiate module
    spiMemory dut(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, leds);

    // SCLK triggers every N clock cycles
    reg sclk_counter = 0; parameter N = 10;
    always begin
        #1 clk <= ~clk;
    end

    always begin
        #10 sclk_pin <= ~sclk_pin;
    end

    initial begin
    	// Your Test Code
        $dumpfile("spimemory.vcd");
        $dumpvars();

        // Initial Conditions time = 0
        clk=1; sclk_pin=0; cs_pin=0;

        // Test 1: CS is high --> ignore all inputs, tristate MISO, and reset FSM

        // Test 2: CS is low, write 0xFF
        mosi_pin = 0; #20
        mosi_pin = 1; #140
        mosi_pin = 1; #400
        cs_pin = 1; #20

        // Test 2: CS is low, write 0xFF
        cs_pin = 0;
        mosi_pin = 1; #20
        mosi_pin = 1; #140
        mosi_pin = 1; #200


        #10 $finish;
    end

endmodule
