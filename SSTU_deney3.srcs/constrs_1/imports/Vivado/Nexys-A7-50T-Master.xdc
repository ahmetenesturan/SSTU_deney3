## This file is a general .xdc for the Nexys A7-50T
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];


##Switches
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports a]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports b]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports c]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports d]


## LEDs
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports f0]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports f1]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports f2]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports f3]


set_max_delay -from [get_ports {a b c d}] -to [get_ports {f0 f1 f2 f3}] 6.000

#set_property BEL C5LUT [get_cells f0_OBUF_inst_i_1]
#set_property LOC SLICE_X12Y67 [get_cells f0_OBUF_inst_i_1]
#set_property BEL D6LUT [get_cells f1_2/XOR_GATE]
#set_property LOC SLICE_X12Y67 [get_cells f1_2/XOR_GATE]
#set_property BEL B6LUT [get_cells f1_2/XOR_GATE_i_1]
#set_property LOC SLICE_X12Y67 [get_cells f1_2/XOR_GATE_i_1]
#set_property BEL A6LUT [get_cells f1_2/XOR_GATE_i_2]
#set_property LOC SLICE_X12Y67 [get_cells f1_2/XOR_GATE_i_2]
#set_property BEL C6LUT [get_cells f2_4/XOR_GATE]
#set_property LOC SLICE_X12Y66 [get_cells f2_4/XOR_GATE]
#set_property BEL D6LUT [get_cells f2_4/f3_OBUF_inst_i_1]
#set_property BEL D5LUT [get_cells f2_4/XOR_GATE_i_1__0]
#set_property LOC SLICE_X12Y66 [get_cells f2_4/f3_OBUF_inst_i_1]
#set_property LOC SLICE_X12Y66 [get_cells f2_4/XOR_GATE_i_1__0]

