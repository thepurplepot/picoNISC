//-----------------------------------------------------
// File Name   : regs_stim.sv
// Function    : Testbench for register file
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`include "src/regs.sv"

module regs_stim;

    localparam Rsize = 1;

    logic clk, nReset, w;
    logic [7:0] wData, rData;
    logic [Rsize-1:0] addr;

    regs #(.n(8), .Rsize(Rsize)) uut (
        .clk(clk),
        .w(w),
        .Wdata(wData),
        .Raddr(addr),
        .Rdata(rData)
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

    task print_reg();
        $display("Cycle: %d, Register values:", cycle);
        for (int i = 0; i < (1<<Rsize); i++) begin
            $display("\t$%d = %d", i, uut.gpr[i]);
        end
    endtask


    logic [7:0] golden_reg [0:(1<<Rsize)-1];
    logic pass = 1'b1;
    initial begin
        repeat (10) begin // Test random writes then reads
            w = 1;
            wData = $random;
            addr = $random % (1<<Rsize);
            #10 w = 0; // 1-cycle to write
            golden_reg[addr] = wData;
            $display("Writing to register $%d: %d", addr, wData);
            #10; // 1-cycle to read
            if (rData !== wData) begin
                $error("Register write incorrect: got %d, expected %d", rData, wData);
                pass = 1'b0;
            end
        end

        repeat (10) begin // Test random reads (data should persist)
            w = 0;
            wData = $random;
            addr = $random % (1<<Rsize);
            #10; // 1-cycle to read
            $display("Check data: %d persists in $%d", golden_reg[addr], addr);
            if (rData !== golden_reg[addr]) begin
                $error("Register write incorrect: got %d, expected %d", rData, golden_reg[addr]);
                pass = 1'b0;
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