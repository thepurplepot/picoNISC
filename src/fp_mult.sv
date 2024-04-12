//-----------------------------------------------------
// File Name   : fp_mult.sv
// Function    : Embedded floating point multiply module for NISC processor
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`ifndef FP_MULT_SV
`define FP_MULT_SV

`include "src/mult.sv"
//`define ROUNDING

module fp_mult #(parameter n = 8, f = 7) (
    input logic signed [n-1:0] a, b,
    output logic signed [n-1:0] result
);

    logic signed [2*n-1:0] mult;
    logic [n-1:0] tmp_result;

    mult #(.n(n)) m (
        .a(a),
        .b(b),
        .result(mult)
    );

    always_comb begin
        tmp_result = mult[n+f-1:f]; // Truncate result and remove fractional part (f-bits)
        `ifdef ROUNDING
            if (mult[f-1] == 1'b1)
                result = tmp_result + 1'b1; // Round if fractional part is greater than 0.5
            else
                result = tmp_result;
        `else
            result = tmp_result;
        `endif
    end
endmodule

`endif