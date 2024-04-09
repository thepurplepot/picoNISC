//-----------------------------------------------------
// File Name   : cpu_stim.sv
// Function    : Testbench for cpu
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`include "src/cpu.sv"

module cpu_stim;

    logic clk, nReset, readyIn;
    logic [8:0] in;
    logic [7:0] data, out;
    assign in = {readyIn, data};

    cpu #(.n(8)) uut (
        .clk(clk),
        .nReset(nReset),
        .inport(in),
        .outport(out)
    );

    // Clock
    int cycle = 0;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
            if(clk == 1) begin
                //print_reg();
                cycle += 1;
            end
        end
    end

    // Reset
    initial begin
        nReset = 0;
        #10 nReset = 1;

    end

    function void print_reg();
        $display("PC %d, Register values: x2=%d, y2=%d", uut.progAddr, uut.gpr.gpr[0], uut.gpr.gpr[1]);
    endfunction

    task run (
        input logic signed [7:0] x1, y1,
        output logic signed [7:0] x2, y2
    );
        data = x1;
        readyIn = 1;
        $display("Set x1: %d", x1);
        #50 readyIn = 0;
        #50 data = y1;
        readyIn = 1;
        $display("Set y1: %d", y1);
        #50 readyIn = 0;
        #50 x2 = out;
        $display("Get x2: %d", x2);
        readyIn = 1;
        #50 y2 = out;
        $display("Get y2: %d", y2);
        readyIn = 0;
        #200;
    endtask

    task golden_affine(
        input real b0, b1, a0, a1, a2, a3,
        input real x1, y1,
        output real x2, y2
    );
        x2 = x1*a0 + y1*a1 + b0;
        y2 = x1*a2 + y1*a3 + b1;
    endtask

    function logic compare(real a, b);
        real diff;
        diff = a - b;
        if (diff < 0)
            diff = -diff;
        return diff <= 1.0; // allow pm 1.0 error
    endfunction

    logic pass = 1'b1;
    // Affine transformation parameters
    int seed = 1;
    real b0 = 20, b1 = -20, a0 = 0.75, a1 = 0.5, a2 = -0.5, a3 = 0.75; // prog.hex values
    //real b0 = 5, b1 = 12, a0 = 0.5, a1 = -0.875, a2 = -0.875, a3 = 0.75; // prog2.hex values
    real golden_x2, golden_y2;
    // Test cases
    logic signed [7:0] x1, y1, x2, y2;
    initial begin
        void'($urandom(seed)); // Seed random number generator
        readyIn = 0;
        data = 0;
        #100 cycle = 0; // Wait for reset to finish and start counting cycles
        repeat (10) begin
            x1 = 63-$urandom_range(127); // -64 to 63, prevent overflow
            y1 = 63-$urandom_range(127);

            run(x1, y1, x2, y2); // Follow input/output procedure
            $display("Running test: (%d, %d) -> (%d, %d)", x1, y1, x2, y2);
            golden_affine(b0,b1,a0,a1,a2,a3, real'(x1), real'(y1), golden_x2, golden_y2);
            if (!compare(real'(x2), golden_x2) || !compare(real'(y2), golden_y2)) begin
                pass = 1'b0;
                $error("\tTest failed, expected (%f, %f)", golden_x2, golden_y2);
            end else begin
                $display("\tTest passed");
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