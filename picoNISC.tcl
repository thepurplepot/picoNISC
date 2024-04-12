# Copyright (C) 2017  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Intel and sold by Intel or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: picoNISC.tcl
# Generated on: Sat Apr 13 00:10:34 2024

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "picoNISC"]} {
		puts "Project picoNISC is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists picoNISC]} {
		project_open -revision top picoNISC
	} else {
		project_new -revision top picoNISC
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSEMA5F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 16.1.2
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "23:24:23  APRIL 12, 2024"
	set_global_assignment -name LAST_QUARTUS_VERSION "16.1.2 Standard Edition"
	set_global_assignment -name HEX_FILE hex/test.hex
	set_global_assignment -name HEX_FILE hex/prog2.hex
	set_global_assignment -name HEX_FILE hex/prog.hex
	set_global_assignment -name SYSTEMVERILOG_FILE src/top.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/regs.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/prog.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/pc.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/mult.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/fp_mult.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/definitions.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/debouncer.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/cpu.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/counter.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/branchcomp.sv
	set_global_assignment -name SYSTEMVERILOG_FILE src/adder.sv
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name ALLOW_ANY_RAM_SIZE_FOR_RECOGNITION ON
	set_global_assignment -name ALLOW_ANY_ROM_SIZE_FOR_RECOGNITION ON
	set_global_assignment -name OPTIMIZATION_MODE "AGGRESSIVE AREA"
	set_global_assignment -name VERILOG_SHOW_LMF_MAPPING_MESSAGES OFF
	set_global_assignment -name TIMEQUEST_MULTICORNER_ANALYSIS ON
	set_global_assignment -name SDC_FILE top.sdc
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top
	set_location_assignment PIN_AB12 -to SW[0]
	set_location_assignment PIN_AC12 -to SW[1]
	set_location_assignment PIN_AF9 -to SW[2]
	set_location_assignment PIN_AF10 -to SW[3]
	set_location_assignment PIN_AD11 -to SW[4]
	set_location_assignment PIN_AD12 -to SW[5]
	set_location_assignment PIN_AE11 -to SW[6]
	set_location_assignment PIN_AC9 -to SW[7]
	set_location_assignment PIN_AD10 -to SW[8]
	set_location_assignment PIN_AE12 -to SW[9]
	set_location_assignment PIN_AF14 -to fastclk
	set_location_assignment PIN_V16 -to LED[0]
	set_location_assignment PIN_W16 -to LED[1]
	set_location_assignment PIN_V17 -to LED[2]
	set_location_assignment PIN_V18 -to LED[3]
	set_location_assignment PIN_W17 -to LED[4]
	set_location_assignment PIN_W19 -to LED[5]
	set_location_assignment PIN_Y19 -to LED[6]
	set_location_assignment PIN_W20 -to LED[7]

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
