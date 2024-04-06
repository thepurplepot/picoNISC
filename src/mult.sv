//-----------------------------------------------------
// File Name   : mult.sv
// Function    : Embedded multiply module for NISC processor
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`ifndef MULT_SV
`define MULT_SV

module mult #(parameter n = 8) (
    input signed [n-1:0] a, b,
    output signed [2*n-1:0] result
);

    assign result = a * b;

endmodule

`endif