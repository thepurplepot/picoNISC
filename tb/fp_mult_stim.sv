//-----------------------------------------------------
// File Name   : fp_mult_stim.sv
// Function    : Testbench for multiplier module
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`define ROUNDING
`include "src/fp_mult.sv"

module fp_mult_stim;

    logic signed [7:0] a, b;
    logic signed [7:0] result;

    fp_mult #(.n(8), .f(7)) uut (
        .a(a), 
        .b(b), 
        .result(result)
    );

    function real fixed_to_real (input logic signed [7:0] w);
        return real'(w)/(2.0**7);
    endfunction

    function real multiply (real a, b);
        return a * b;
    endfunction

    function logic compare(real a, b);
        real diff;
        diff = a - b;
        if (diff < 0)
            diff = -diff;
        return diff < 0.5; // allow pm 1.5 error
    endfunction

    logic pass = 1'b1;
    real golden_result;
    initial begin
        repeat (100) begin
            a = $random;
            b = $random;
            $display("Running test: a=%h, b=%h", a, b);

            golden_result = multiply(real'(a), fixed_to_real(b));

            #10;

            if (!compare(real'(result), golden_result)) begin
                pass = 1'b0;
                $display("\tTest failed: got %d, expected %f", result, golden_result);
            end
        end

        $display("All tests finished");
        if (pass)
            $display("PASS");
        else
            $display("FAIL");
        $finish;
    end
endmodule