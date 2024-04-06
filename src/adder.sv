//-----------------------------------------------------
// File Name   : adder.sv
// Function    : Adder module for NISC processor
// Version: 2
// Author:  wf2g20
// Last rev. 1 Apr. 24
//-----------------------------------------------------
`ifndef ADDER_SV
`define ADDER_SV

`include "src/mult.sv"

module adder #(parameter n = 8) (
    input logic signed [n-1:0] a, b,
    output logic signed [n-1:0] result
);

`ifdef DSP_ADDER
    // Use 16-bit multiplier in DSP for 8-bit adder, saves cost
    logic [4*n-1:0] tmp;
    mult #(.n(2*n)) m (
        .a({a, b}),
        .b({{(n-1){1'b0}}, 1'b1, {(n-1){1'b0}}, 1'b1}),
        .result(tmp)
    );
    assign result = tmp[2*n-1:n];
`else
    assign result = a + b;
`endif

endmodule

`endif