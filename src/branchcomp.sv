//-----------------------------------------------------
// File Name   : branchcomp.sv
// Function    : Single bit branch comparator for NISC processor
// Version: 1
// Author:  wf2g20
// Last rev. 31 Mar. 24
//-----------------------------------------------------
`ifndef BRANCHCOMP_SV
`define BRANCHCOMP_SV

module branchcomp (
   input logic a, b,
   output logic result
);

   assign result = (a == b);

endmodule

`endif