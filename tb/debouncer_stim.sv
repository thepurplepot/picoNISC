//-----------------------------------------------------
// File Name   : debouncer_stim.sv
// Function    : Testbench for program counter
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`include "src/debouncer.sv"

module debouncer_stim;

    logic clk, nReset, in, out;

    debouncer uut (
        .clk(clk),
        .nReset(nReset),
        .in(in),
        .out(out)
    );

    // Clock
    int cycle = 0;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
            if(clk == 1) begin
                cycle += 1;
            end
        end
    end

    // Reset
    initial begin
        nReset = 0;
        #10 nReset = 1;
        cycle = 0;
    end

    logic pass = 1'b1;
    initial begin
        in = 0;
        repeat (10) begin // Bounce the input (desyncronised)
            #9 in = 1;
            if (out == 1) begin
                $error("Bounce propigated at cycle: %d", cycle);
                pass = 1'b0;
            end
            #9 in = 0;
        end
        #10 in = 1;
        #500; // Hold input high
        if (out == 1) begin
            $display("Input propigated at cycle: %d", cycle);
        end else begin
            $error("Input not propigated at cycle: %d", cycle);
            pass = 1'b0;
        end
        in = 0;
        #30; // Hold input low
        if (out == 0) begin
            $display("Input propigated at cycle: %d", cycle);
        end else begin
            $error("Input not propigated at cycle: %d", cycle);
            pass = 1'b0;
        end

        $display("All tests finished");
        if (pass)
            $display("PASS");
        else
            $display("FAIL");
        $finish;
    end
endmodule