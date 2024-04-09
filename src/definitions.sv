//-----------------------------------------------------
// File Name : defenitions.sv
// Function : Defenitions for NISC processor
// Author: wf2g20
// Last rev. 24 March 24
//-----------------------------------------------------

`ifndef DEFENITIONS
`define DEFENITIONS

`define PROG_NAME "hex/prog.hex"

// Adjustable parameters
`define N 8 // 8-bit data width
`define F 7 // 7-bit fractional part for fixed-point arithmetic
`define PSIZE 4 // up to 16 instructions CHANGED
`define ROUNDING // Enable rounding for fixed-point multiplication
`define DSP_ADDER // Use DSP adder for adder module

// -------------------------

`define RSIZE 1 // Register address width
`define IMM_P 0 // immediate operand (8-bit)
`define RADDR_P `IMM_P + `N // register destination (RSIZE bits)
`define BRANCH_P `RADDR_P + `RSIZE  // branch control (1-bit)
`define LOAD_P `BRANCH_P + 1 // accumulator control (1-bit)
`define HIGH_P `LOAD_P + 1 // use switch input (1-bit)

`define CSIZE `LOAD_P + 1 // control word width

`endif



