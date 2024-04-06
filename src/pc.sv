//-----------------------------------------------------
// File Name : pc.sv
// Function : NISC Program Counter
// functions: increment, absolute branches
// Author: wf2g20
// Last rev. 26 Feb 24
//-----------------------------------------------------
`ifndef PC_SV
`define PC_SV

module pc #(parameter Psize = 6) (
    input logic clk, nReset, hold,
    output logic [Psize-1:0] out
);

    logic [Psize-1:0] nextPC;

    always_ff @ (posedge clk or negedge nReset)
        if (!nReset)
            out <= {Psize{1'b0}};
        else if (!hold)
            out <= nextPC;

    assign nextPC = out + 1'b1;
	 
endmodule

`endif