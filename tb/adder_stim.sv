//-----------------------------------------------------
// File Name   : adder_stim.sv
// Function    : Testbench for adder module
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`define DSP_ADDER
`include "src/adder.sv"

module adder_stim;

    logic signed [7:0] a, b;
    logic signed [7:0] result, golden_result;

    adder #(.n(8)) uut (
        .a(a), 
        .b(b), 
        .result(result)
    );

    function logic signed [7:0] add (logic signed [7:0] a, b);
        return a + b;
    endfunction

    logic pass = 1'b1;
    initial begin
        repeat (100) begin
            a = $random;
            b = $random;
            $display("Running test: a=%h, b=%h", a, b);

            golden_result = add(a, b);

            #10;

            if (result !== golden_result) begin
                pass = 1'b0;
                $error("\tTest failed: got %d, expected %d", a, b, result, golden_result);
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