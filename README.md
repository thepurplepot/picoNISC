# ELEC6234 CW - Application Specific NISC Processor for Affine Transforms

<hr />

# Table of contents
 - [Dependencies](#dependencies)
 - [Setup](#setup)
 - [Todos](#todos)

<hr />

# Dependencies
Qautus Prime 16.1 used for synthesis and FPGA programming.
IVerilog used for simulation within VSCode.
Xcellium used for simulation with waveform view.

# Setup

picoNISC.qpf contains the Quatus Project. To assign correct sorce files run:

```bash
quartus_sh -t picoNISC.tcl -project picoNISC
```

top.sv contains compile switches. "COST" disables top level clock divider & switch debouncer (and multiplier rounding) to give accurate cost figure based on ALM, DSP and RAM usage. "DEBOUNCING" enables the full 50MHz FPGA clock and a debouncer for the handshake input instead of a clock divider. 

defenitions.sv contains paramater defenitions for control word bit placements and value widths; they can be modified.

/tb folder contains testbenches for most design modules. The thest bentches can be run using Icarus Verilog within VSCode using the provided task (Terminal/Run Build Task... on stimulus file).

### Todos

 - Implement program ROM as memory blocks for synthesis
 - Improve syncronous register write to reduce instruction count
 - ...

License
----

GPL-3.0
