//-----------------------------------------------------
// File Name : regs.sv
// Function : NISC 2 x n registers
// %0 = x2, %1 = y2
// Version 1
// Author: wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`ifndef REGS_SV
`define REGS_SV

module regs #(parameter n = 8, Rsize = 1) (
    input logic clk, w,
    input logic [n-1:0] Wdata,
    input logic [Rsize-1:0] Raddr,
    output logic [n-1:0] Rdata
);
	// Only 2 general purpose registers
	reg [n-1:0] gpr [0:(1<<Rsize)-1];
	
	// Syncronous read and write (memory block synthesizable)
	always_ff @ (posedge clk) begin
		if (w)
			gpr[Raddr] <= Wdata;
		Rdata = gpr[Raddr];
	end
	
endmodule

`endif