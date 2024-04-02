####CLK & RESET
set_property PACKAGE_PIN J15 [get_ports sys_rst_n]
set_property PACKAGE_PIN U18 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

####50M CLK
create_clock -period 20.000 -name sys_clk -waveform {0.000 10.000} [get_ports sys_clk]

####LED
set_property PACKAGE_PIN G14 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]


####UART, in J8pin7 pin9
set_property PACKAGE_PIN Y7 [get_ports uart_tx]
set_property PACKAGE_PIN Y6 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]

####uart debug key
set_property PACKAGE_PIN V20 [get_ports debug_en]
set_property IOSTANDARD LVCMOS33 [get_ports debug_en]

####ILA for DEBUG



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list u_clk_rst_gen/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u_top/u_uart/tx_data[0]} {u_top/u_uart/tx_data[1]} {u_top/u_uart/tx_data[2]} {u_top/u_uart/tx_data[3]} {u_top/u_uart/tx_data[4]} {u_top/u_uart/tx_data[5]} {u_top/u_uart/tx_data[6]} {u_top/u_uart/tx_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u_top/u_uart/uart_baud[0]} {u_top/u_uart/uart_baud[1]} {u_top/u_uart/uart_baud[2]} {u_top/u_uart/uart_baud[3]} {u_top/u_uart/uart_baud[4]} {u_top/u_uart/uart_baud[5]} {u_top/u_uart/uart_baud[6]} {u_top/u_uart/uart_baud[7]} {u_top/u_uart/uart_baud[8]} {u_top/u_uart/uart_baud[9]} {u_top/u_uart/uart_baud[10]} {u_top/u_uart/uart_baud[11]} {u_top/u_uart/uart_baud[12]} {u_top/u_uart/uart_baud[13]} {u_top/u_uart/uart_baud[14]} {u_top/u_uart/uart_baud[15]} {u_top/u_uart/uart_baud[16]} {u_top/u_uart/uart_baud[17]} {u_top/u_uart/uart_baud[18]} {u_top/u_uart/uart_baud[19]} {u_top/u_uart/uart_baud[20]} {u_top/u_uart/uart_baud[21]} {u_top/u_uart/uart_baud[22]} {u_top/u_uart/uart_baud[23]} {u_top/u_uart/uart_baud[24]} {u_top/u_uart/uart_baud[25]} {u_top/u_uart/uart_baud[26]} {u_top/u_uart/uart_baud[27]} {u_top/u_uart/uart_baud[28]} {u_top/u_uart/uart_baud[29]} {u_top/u_uart/uart_baud[30]} {u_top/u_uart/uart_baud[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 4 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_top/u_uart/state[0]} {u_top/u_uart/state[1]} {u_top/u_uart/state[2]} {u_top/u_uart/state[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {u_top/u_uart/uart_rx[0]} {u_top/u_uart/uart_rx[1]} {u_top/u_uart/uart_rx[2]} {u_top/u_uart/uart_rx[3]} {u_top/u_uart/uart_rx[4]} {u_top/u_uart/uart_rx[5]} {u_top/u_uart/uart_rx[6]} {u_top/u_uart/uart_rx[7]} {u_top/u_uart/uart_rx[8]} {u_top/u_uart/uart_rx[9]} {u_top/u_uart/uart_rx[10]} {u_top/u_uart/uart_rx[11]} {u_top/u_uart/uart_rx[12]} {u_top/u_uart/uart_rx[13]} {u_top/u_uart/uart_rx[14]} {u_top/u_uart/uart_rx[15]} {u_top/u_uart/uart_rx[16]} {u_top/u_uart/uart_rx[17]} {u_top/u_uart/uart_rx[18]} {u_top/u_uart/uart_rx[19]} {u_top/u_uart/uart_rx[20]} {u_top/u_uart/uart_rx[21]} {u_top/u_uart/uart_rx[22]} {u_top/u_uart/uart_rx[23]} {u_top/u_uart/uart_rx[24]} {u_top/u_uart/uart_rx[25]} {u_top/u_uart/uart_rx[26]} {u_top/u_uart/uart_rx[27]} {u_top/u_uart/uart_rx[28]} {u_top/u_uart/uart_rx[29]} {u_top/u_uart/uart_rx[30]} {u_top/u_uart/uart_rx[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 4 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {u_top/u_uart/rx_clk_edge_cnt[0]} {u_top/u_uart/rx_clk_edge_cnt[1]} {u_top/u_uart/rx_clk_edge_cnt[2]} {u_top/u_uart/rx_clk_edge_cnt[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {u_top/u_uart/uart_ctrl[0]} {u_top/u_uart/uart_ctrl[1]} {u_top/u_uart/uart_ctrl[2]} {u_top/u_uart/uart_ctrl[3]} {u_top/u_uart/uart_ctrl[4]} {u_top/u_uart/uart_ctrl[5]} {u_top/u_uart/uart_ctrl[6]} {u_top/u_uart/uart_ctrl[7]} {u_top/u_uart/uart_ctrl[8]} {u_top/u_uart/uart_ctrl[9]} {u_top/u_uart/uart_ctrl[10]} {u_top/u_uart/uart_ctrl[11]} {u_top/u_uart/uart_ctrl[12]} {u_top/u_uart/uart_ctrl[13]} {u_top/u_uart/uart_ctrl[14]} {u_top/u_uart/uart_ctrl[15]} {u_top/u_uart/uart_ctrl[16]} {u_top/u_uart/uart_ctrl[17]} {u_top/u_uart/uart_ctrl[18]} {u_top/u_uart/uart_ctrl[19]} {u_top/u_uart/uart_ctrl[20]} {u_top/u_uart/uart_ctrl[21]} {u_top/u_uart/uart_ctrl[22]} {u_top/u_uart/uart_ctrl[23]} {u_top/u_uart/uart_ctrl[24]} {u_top/u_uart/uart_ctrl[25]} {u_top/u_uart/uart_ctrl[26]} {u_top/u_uart/uart_ctrl[27]} {u_top/u_uart/uart_ctrl[28]} {u_top/u_uart/uart_ctrl[29]} {u_top/u_uart/uart_ctrl[30]} {u_top/u_uart/uart_ctrl[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {u_top/u_uart/uart_status[0]} {u_top/u_uart/uart_status[1]} {u_top/u_uart/uart_status[2]} {u_top/u_uart/uart_status[3]} {u_top/u_uart/uart_status[4]} {u_top/u_uart/uart_status[5]} {u_top/u_uart/uart_status[6]} {u_top/u_uart/uart_status[7]} {u_top/u_uart/uart_status[8]} {u_top/u_uart/uart_status[9]} {u_top/u_uart/uart_status[10]} {u_top/u_uart/uart_status[11]} {u_top/u_uart/uart_status[12]} {u_top/u_uart/uart_status[13]} {u_top/u_uart/uart_status[14]} {u_top/u_uart/uart_status[15]} {u_top/u_uart/uart_status[16]} {u_top/u_uart/uart_status[17]} {u_top/u_uart/uart_status[18]} {u_top/u_uart/uart_status[19]} {u_top/u_uart/uart_status[20]} {u_top/u_uart/uart_status[21]} {u_top/u_uart/uart_status[22]} {u_top/u_uart/uart_status[23]} {u_top/u_uart/uart_status[24]} {u_top/u_uart/uart_status[25]} {u_top/u_uart/uart_status[26]} {u_top/u_uart/uart_status[27]} {u_top/u_uart/uart_status[28]} {u_top/u_uart/uart_status[29]} {u_top/u_uart/uart_status[30]} {u_top/u_uart/uart_status[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {u_top/u_uart/rx_data[0]} {u_top/u_uart/rx_data[1]} {u_top/u_uart/rx_data[2]} {u_top/u_uart/rx_data[3]} {u_top/u_uart/rx_data[4]} {u_top/u_uart/rx_data[5]} {u_top/u_uart/rx_data[6]} {u_top/u_uart/rx_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {u_top/u_uart_debug/mem_addr_o[0]} {u_top/u_uart_debug/mem_addr_o[1]} {u_top/u_uart_debug/mem_addr_o[2]} {u_top/u_uart_debug/mem_addr_o[3]} {u_top/u_uart_debug/mem_addr_o[4]} {u_top/u_uart_debug/mem_addr_o[5]} {u_top/u_uart_debug/mem_addr_o[6]} {u_top/u_uart_debug/mem_addr_o[7]} {u_top/u_uart_debug/mem_addr_o[8]} {u_top/u_uart_debug/mem_addr_o[9]} {u_top/u_uart_debug/mem_addr_o[10]} {u_top/u_uart_debug/mem_addr_o[11]} {u_top/u_uart_debug/mem_addr_o[12]} {u_top/u_uart_debug/mem_addr_o[13]} {u_top/u_uart_debug/mem_addr_o[14]} {u_top/u_uart_debug/mem_addr_o[15]} {u_top/u_uart_debug/mem_addr_o[16]} {u_top/u_uart_debug/mem_addr_o[17]} {u_top/u_uart_debug/mem_addr_o[18]} {u_top/u_uart_debug/mem_addr_o[19]} {u_top/u_uart_debug/mem_addr_o[20]} {u_top/u_uart_debug/mem_addr_o[21]} {u_top/u_uart_debug/mem_addr_o[22]} {u_top/u_uart_debug/mem_addr_o[23]} {u_top/u_uart_debug/mem_addr_o[24]} {u_top/u_uart_debug/mem_addr_o[25]} {u_top/u_uart_debug/mem_addr_o[26]} {u_top/u_uart_debug/mem_addr_o[27]} {u_top/u_uart_debug/mem_addr_o[28]} {u_top/u_uart_debug/mem_addr_o[29]} {u_top/u_uart_debug/mem_addr_o[30]} {u_top/u_uart_debug/mem_addr_o[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {u_top/u_uart_debug/mem_wdata_o[0]} {u_top/u_uart_debug/mem_wdata_o[1]} {u_top/u_uart_debug/mem_wdata_o[2]} {u_top/u_uart_debug/mem_wdata_o[3]} {u_top/u_uart_debug/mem_wdata_o[4]} {u_top/u_uart_debug/mem_wdata_o[5]} {u_top/u_uart_debug/mem_wdata_o[6]} {u_top/u_uart_debug/mem_wdata_o[7]} {u_top/u_uart_debug/mem_wdata_o[8]} {u_top/u_uart_debug/mem_wdata_o[9]} {u_top/u_uart_debug/mem_wdata_o[10]} {u_top/u_uart_debug/mem_wdata_o[11]} {u_top/u_uart_debug/mem_wdata_o[12]} {u_top/u_uart_debug/mem_wdata_o[13]} {u_top/u_uart_debug/mem_wdata_o[14]} {u_top/u_uart_debug/mem_wdata_o[15]} {u_top/u_uart_debug/mem_wdata_o[16]} {u_top/u_uart_debug/mem_wdata_o[17]} {u_top/u_uart_debug/mem_wdata_o[18]} {u_top/u_uart_debug/mem_wdata_o[19]} {u_top/u_uart_debug/mem_wdata_o[20]} {u_top/u_uart_debug/mem_wdata_o[21]} {u_top/u_uart_debug/mem_wdata_o[22]} {u_top/u_uart_debug/mem_wdata_o[23]} {u_top/u_uart_debug/mem_wdata_o[24]} {u_top/u_uart_debug/mem_wdata_o[25]} {u_top/u_uart_debug/mem_wdata_o[26]} {u_top/u_uart_debug/mem_wdata_o[27]} {u_top/u_uart_debug/mem_wdata_o[28]} {u_top/u_uart_debug/mem_wdata_o[29]} {u_top/u_uart_debug/mem_wdata_o[30]} {u_top/u_uart_debug/mem_wdata_o[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 14 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {u_top/u_uart_debug/state[0]} {u_top/u_uart_debug/state[1]} {u_top/u_uart_debug/state[2]} {u_top/u_uart_debug/state[3]} {u_top/u_uart_debug/state[4]} {u_top/u_uart_debug/state[5]} {u_top/u_uart_debug/state[6]} {u_top/u_uart_debug/state[7]} {u_top/u_uart_debug/state[8]} {u_top/u_uart_debug/state[9]} {u_top/u_uart_debug/state[10]} {u_top/u_uart_debug/state[11]} {u_top/u_uart_debug/state[12]} {u_top/u_uart_debug/state[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {u_top/m0_addr[0]} {u_top/m0_addr[1]} {u_top/m0_addr[2]} {u_top/m0_addr[3]} {u_top/m0_addr[4]} {u_top/m0_addr[5]} {u_top/m0_addr[6]} {u_top/m0_addr[7]} {u_top/m0_addr[8]} {u_top/m0_addr[9]} {u_top/m0_addr[10]} {u_top/m0_addr[11]} {u_top/m0_addr[12]} {u_top/m0_addr[13]} {u_top/m0_addr[14]} {u_top/m0_addr[15]} {u_top/m0_addr[16]} {u_top/m0_addr[17]} {u_top/m0_addr[18]} {u_top/m0_addr[19]} {u_top/m0_addr[20]} {u_top/m0_addr[21]} {u_top/m0_addr[22]} {u_top/m0_addr[23]} {u_top/m0_addr[24]} {u_top/m0_addr[25]} {u_top/m0_addr[26]} {u_top/m0_addr[27]} {u_top/m0_addr[28]} {u_top/m0_addr[29]} {u_top/m0_addr[30]} {u_top/m0_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 32 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {u_top/m0_rdata[0]} {u_top/m0_rdata[1]} {u_top/m0_rdata[2]} {u_top/m0_rdata[3]} {u_top/m0_rdata[4]} {u_top/m0_rdata[5]} {u_top/m0_rdata[6]} {u_top/m0_rdata[7]} {u_top/m0_rdata[8]} {u_top/m0_rdata[9]} {u_top/m0_rdata[10]} {u_top/m0_rdata[11]} {u_top/m0_rdata[12]} {u_top/m0_rdata[13]} {u_top/m0_rdata[14]} {u_top/m0_rdata[15]} {u_top/m0_rdata[16]} {u_top/m0_rdata[17]} {u_top/m0_rdata[18]} {u_top/m0_rdata[19]} {u_top/m0_rdata[20]} {u_top/m0_rdata[21]} {u_top/m0_rdata[22]} {u_top/m0_rdata[23]} {u_top/m0_rdata[24]} {u_top/m0_rdata[25]} {u_top/m0_rdata[26]} {u_top/m0_rdata[27]} {u_top/m0_rdata[28]} {u_top/m0_rdata[29]} {u_top/m0_rdata[30]} {u_top/m0_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {u_top/m1_addr[0]} {u_top/m1_addr[1]} {u_top/m1_addr[2]} {u_top/m1_addr[3]} {u_top/m1_addr[4]} {u_top/m1_addr[5]} {u_top/m1_addr[6]} {u_top/m1_addr[7]} {u_top/m1_addr[8]} {u_top/m1_addr[9]} {u_top/m1_addr[10]} {u_top/m1_addr[11]} {u_top/m1_addr[12]} {u_top/m1_addr[13]} {u_top/m1_addr[14]} {u_top/m1_addr[15]} {u_top/m1_addr[16]} {u_top/m1_addr[17]} {u_top/m1_addr[18]} {u_top/m1_addr[19]} {u_top/m1_addr[20]} {u_top/m1_addr[21]} {u_top/m1_addr[22]} {u_top/m1_addr[23]} {u_top/m1_addr[24]} {u_top/m1_addr[25]} {u_top/m1_addr[26]} {u_top/m1_addr[27]} {u_top/m1_addr[28]} {u_top/m1_addr[29]} {u_top/m1_addr[30]} {u_top/m1_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 3 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {u_top/m1_size[0]} {u_top/m1_size[1]} {u_top/m1_size[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 32 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {u_top/m1_rdata[0]} {u_top/m1_rdata[1]} {u_top/m1_rdata[2]} {u_top/m1_rdata[3]} {u_top/m1_rdata[4]} {u_top/m1_rdata[5]} {u_top/m1_rdata[6]} {u_top/m1_rdata[7]} {u_top/m1_rdata[8]} {u_top/m1_rdata[9]} {u_top/m1_rdata[10]} {u_top/m1_rdata[11]} {u_top/m1_rdata[12]} {u_top/m1_rdata[13]} {u_top/m1_rdata[14]} {u_top/m1_rdata[15]} {u_top/m1_rdata[16]} {u_top/m1_rdata[17]} {u_top/m1_rdata[18]} {u_top/m1_rdata[19]} {u_top/m1_rdata[20]} {u_top/m1_rdata[21]} {u_top/m1_rdata[22]} {u_top/m1_rdata[23]} {u_top/m1_rdata[24]} {u_top/m1_rdata[25]} {u_top/m1_rdata[26]} {u_top/m1_rdata[27]} {u_top/m1_rdata[28]} {u_top/m1_rdata[29]} {u_top/m1_rdata[30]} {u_top/m1_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 32 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {u_top/m1_wdata[0]} {u_top/m1_wdata[1]} {u_top/m1_wdata[2]} {u_top/m1_wdata[3]} {u_top/m1_wdata[4]} {u_top/m1_wdata[5]} {u_top/m1_wdata[6]} {u_top/m1_wdata[7]} {u_top/m1_wdata[8]} {u_top/m1_wdata[9]} {u_top/m1_wdata[10]} {u_top/m1_wdata[11]} {u_top/m1_wdata[12]} {u_top/m1_wdata[13]} {u_top/m1_wdata[14]} {u_top/m1_wdata[15]} {u_top/m1_wdata[16]} {u_top/m1_wdata[17]} {u_top/m1_wdata[18]} {u_top/m1_wdata[19]} {u_top/m1_wdata[20]} {u_top/m1_wdata[21]} {u_top/m1_wdata[22]} {u_top/m1_wdata[23]} {u_top/m1_wdata[24]} {u_top/m1_wdata[25]} {u_top/m1_wdata[26]} {u_top/m1_wdata[27]} {u_top/m1_wdata[28]} {u_top/m1_wdata[29]} {u_top/m1_wdata[30]} {u_top/m1_wdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 32 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {timer_cnt[0]} {timer_cnt[1]} {timer_cnt[2]} {timer_cnt[3]} {timer_cnt[4]} {timer_cnt[5]} {timer_cnt[6]} {timer_cnt[7]} {timer_cnt[8]} {timer_cnt[9]} {timer_cnt[10]} {timer_cnt[11]} {timer_cnt[12]} {timer_cnt[13]} {timer_cnt[14]} {timer_cnt[15]} {timer_cnt[16]} {timer_cnt[17]} {timer_cnt[18]} {timer_cnt[19]} {timer_cnt[20]} {timer_cnt[21]} {timer_cnt[22]} {timer_cnt[23]} {timer_cnt[24]} {timer_cnt[25]} {timer_cnt[26]} {timer_cnt[27]} {timer_cnt[28]} {timer_cnt[29]} {timer_cnt[30]} {timer_cnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 8 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {debug_en_r[0]} {debug_en_r[1]} {debug_en_r[2]} {debug_en_r[3]} {debug_en_r[4]} {debug_en_r[5]} {debug_en_r[6]} {debug_en_r[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list debug_en_w]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list u_top/m1_rd]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list u_top/m1_we]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list u_top/u_uart_debug/mem_rd_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list u_top/u_uart_debug/mem_we_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list u_top/u_uart/rx_negedge]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list u_top/u_uart/rx_over]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list u_top/u_uart/rx_q0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list u_top/u_uart/rx_q1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list u_top/u_uart/rx_start]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
