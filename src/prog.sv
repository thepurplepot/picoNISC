//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory Psize x Csize - reads from file prog.hex
// Author: wf2g20
// Last rev. 26 Feb 24
//-----------------------------------------------------
`ifndef PROG_SV
`define PROG_SV
`include "src/definitions.sv"

module prog #(parameter Psize = 4, Csize = 11) (
    input logic [Psize-1:0] addr,
    output logic [Csize-1:0] controlWord
);

    reg [Csize-1:0] progMem [0:(1<<Psize)-1];

    initial
        $readmemh(`PROG_NAME, progMem);
    
    assign controlWord = progMem[addr];
  
endmodule // end of module prog

`endif