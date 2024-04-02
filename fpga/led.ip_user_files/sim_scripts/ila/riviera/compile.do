vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../led.srcs/sources_1/ip/ila/hdl/verilog" "+incdir+../../../../led.srcs/sources_1/ip/ila/hdl/verilog" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../led.srcs/sources_1/ip/ila/hdl/verilog" "+incdir+../../../../led.srcs/sources_1/ip/ila/hdl/verilog" \
"../../../../led.srcs/sources_1/ip/ila/sim/ila.v" \

vlog -work xil_defaultlib \
"glbl.v"

