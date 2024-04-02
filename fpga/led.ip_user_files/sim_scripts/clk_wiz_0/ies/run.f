-makelib ies_lib/xil_defaultlib -sv \
  "F:/Xilinx/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/Xilinx/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../led.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
  "../../../../led.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

