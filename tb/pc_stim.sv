//-----------------------------------------------------
// File Name   : pc_stim.sv
// Function    : Testbench for program counter
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`include "src/pc.sv"

module pc_stim;

    localparam Psize = 4;

    logic clk, nReset, hold;
    logic [3:0] progAddr;

    pc #(.Psize(Psize)) progCounter (
        .clk(clk),
        .nReset(nReset),
        .hold(hold),
        .out(progAddr)
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
    int hold_addr;
    initial begin
        hold = 0;
        repeat (2*(1<<Psize)) begin // Test wrap around
            #10;
            $display("Cycle: %d, Program address: %d", cycle, progAddr);
            if (progAddr !== cycle % (1<<Psize)) begin
                $error("Program counter incorrect: got %d, expected %d", progAddr, cycle % (1<<Psize));
                pass = 1'b0;
            end
        end
        
        repeat (1<<Psize) begin // Test hold for each address
            hold_addr = progAddr;
            hold = 1;
            #50; // Hold for 5 cycles
            $display("Cycle: %d, HOLD Program address: %d", cycle, progAddr);
            if (progAddr !== hold_addr) begin
                $error("Program counter incorrect: got %d, expected %d", progAddr, hold_addr);
                pass = 1'b0;
            end
            hold = 0;
            #10; // Release hold
        end

        $display("All tests finished");
        if (pass)
            $display("PASS");
        else
            $display("FAIL");
        $finish;
    end
endmodule