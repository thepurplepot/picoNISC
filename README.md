# ELEC6234 CW - Application Specific NISC Processor for Affine Transforms

<hr />

# Table of contents
 - [Dependencies](#dependencies)
 - [Project Structure](#project-structure)
 - [Todos](#todos)

<hr />

# Dependencies
Qautus Prime 16 used for synthesis and FPGA programming.
IVerilog used for simulation within VSCode.
Xcellium used for simulation with waveform view.

# Project Structure

This is the project structure:
```bash
picoNISC
├── src
│   ├── <module>.sv
|   └── definitions.sv 
├── tb
|   └── <module>_stim.sv
├── hex
|   ├──
|   └──
└── pins.qsf
```

### Todos

 - Implement program ROM as memory blocks for synthesis
 - Improve syncronous register write to reduce instruction count
 - ...

License
----

GPL-3.0
