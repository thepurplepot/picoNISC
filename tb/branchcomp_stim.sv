//-----------------------------------------------------
// File Name   : branchcomp_stim.sv
// Function    : Testbench for branch comparator
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`include "src/branchcomp.sv"

module branchcomp_stim;

    logic a, b;
    logic result, golden_result;

    branchcomp uut (
        .a(a), 
        .b(b), 
        .result(result)
    );

    function logic compare (logic a, b);
        return a == b;
    endfunction

    logic pass = 1'b1;
    initial begin
        repeat (100) begin
            a = $random;
            b = $random;
            $display("Running test: a=%b, b=%b", a, b);

            golden_result = compare(a, b);

            #10;

            if (result !== golden_result) begin
                pass = 1'b0;
                $error("\tTest failed: got %b, expected %b", result, golden_result);
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