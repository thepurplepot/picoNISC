//-----------------------------------------------------
// File Name   : counter.sv
// Function    : Counter for slow clock to prevent switch bouncing
// Version: 1
// Author:  wf2g20
// Last rev. 26 Feb 24
//-----------------------------------------------------
`ifndef COUNTER_SV
`define COUNTER_SV

module counter #(parameter n = 24) // divides clock by 2^n
    (input logic fastclk, output logic clk);
  
    logic [n-1:0] count;

    always_ff @(posedge fastclk)
        count <= count + 1;

    assign clk = count[n-1]; // slow clock

endmodule

`endif