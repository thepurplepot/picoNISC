//------------------------------------
// File Name   : cpu.sv
// Function    : NISC CPU top level encapsulating module
// Author      : wf2g20
// Last revised: 31 Mar. 24
//------------------------------------
`ifndef CPU_SV
`define CPU_SV

`include "src/definitions.sv"
`include "src/adder.sv"
`include "src/mult.sv"
`include "src/fp_mult.sv"
`include "src/branchcomp.sv"
`include "src/pc.sv"
`include "src/regs.sv"
`include "src/prog.sv"

module cpu #(parameter n = 8)
(
    input logic clk, nReset,
    input logic [n:0] inport,
    output logic [n-1:0] outport
);

    logic [`CSIZE-1:0] controlWord;

    logic [n-1:0] rData, wData;
    logic [`RSIZE-1:0] rAddr;
    assign rAddr = controlWord[`RADDR_P+`RSIZE-1:`RADDR_P];
    logic w; // register write control
    assign w = !controlWord[`BRANCH_P];

    logic branch;
    assign branch = controlWord[`BRANCH_P];
    logic [`PSIZE-1:0] progAddr;
    logic hold, eq;
    assign hold = eq && branch;

    pc #(.Psize(`PSIZE)) pc (
        .clk(clk),
        .nReset(nReset),
        .hold(hold),
        .out(progAddr)
    );

    prog #(.Psize(`PSIZE), .Csize(`CSIZE)) p (
        .clk(clk),
        .addr(progAddr),
        .controlWord(controlWord)
    );

    regs #(.n(n), .Rsize(`RSIZE)) gpr (
        .clk(clk),
        .w(w),
        .Wdata(wData),
        .Raddr(rAddr),
        .Rdata(rData)
    );

    logic [n-1:0] imm;
    assign imm = controlWord[`IMM_P+n-1:`IMM_P];
    logic [n-1:0] add_result, mult_result;
    assign wData = controlWord[`LOAD_P] ? imm : add_result;

    adder #(.n(n)) add (
        .a(mult_result),
        .b(rData),
        .result(add_result)
    );

    fp_mult #(.n(n), .f(`F)) m (
        .a(inport[n-1:0]),
        .b(imm),
        .result(mult_result)
    );

    branchcomp bc (
        .a(imm[0]),
        .b(inport[n]),
        .result(eq)
    );

    assign outport = rData;

endmodule

`endif