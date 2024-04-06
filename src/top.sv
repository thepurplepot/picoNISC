// synthesise to run on Altera DE0 for testing and demo

//`define DEBOUNCING

module top (
    input logic fastclk,   // 50MHz Altera DE0 clock
    input logic [9:0] SW,  // Switches SW0..SW9
    output logic [7:0] LED // LEDs 
); 
  
    logic clk; // slow clock, about 10Hz
    logic readyIn;

    `ifndef DEBOUNCING
        counter c (.fastclk(fastclk), .clk(clk));
        assign readyIn = SW[8];
    `else
        assign clk = fastclk;
        debouncer d (.clk(clk), .nReset(SW[9]), .in(SW[8]), .out(readyIn));
    `endif

    cpu processor (.clk(clk), .nReset(SW[9]), .inport({readyIn, SW[7:0]}), .outport(LED));
    
endmodule  