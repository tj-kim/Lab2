//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
)

    reg mosi_conditioned, sclk_posedge, sclk_negedge, cs_conditioned;
    reg mosi_posedge, mosi_negedge, sclk_conditioned, cs_posedge, cs_negedge; // Unused registers
    inputconditioner conditioner0(clk, mosi_pin, mosi_conditioned, mosi_posedge, mosi_negedge);
    inputconditioner conditioner1(clk, sclk_pin, sclk_conditioned, sclk_posedge, sclk_negedge);
    inputconditioner conditioner2(clk, cs_pin, cs_conditioned, cs_posedge, cs_negedge);

    reg miso_buff, dm_we, addr_we, sr_we;
    wire[7:0] shiftRegOutP;
    fsm fsm0(shiftRegOutP[0], cs_conditioned, sclk_posedge, miso_buff, dm_we, addr_we, sr_we);

    reg[7:0] dataMemOut, address;
    wire shiftRegOutS, shiftRegOutS_DFF;
    datamemory datamemory0(clk, dataMemOut, address, dm_we, shiftRegOutP);
    shiftregister #(8) shiftregister0(clk, sclk_posedge, sr_we, dataMemOut, mosi_conditioned, shiftRegOutP, shiftRegOuts);

    always @(posedge clk) {
        address <= shiftRegOutP;
        shiftRegOutS_DFF <= shiftRegOutS
    }

    if (miso_buff) {
        miso_pin = shiftRegOutS_DFF
    }
endmodule
