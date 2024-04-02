onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group top /tb/u_top/m1_rdata
add wave -noupdate -expand -group top /tb/u_top/m1_wdata
add wave -noupdate -expand -group top /tb/u_top/m1_size
add wave -noupdate -expand -group top /tb/u_top/m1_we
add wave -noupdate -expand -group top /tb/u_top/m1_rd
add wave -noupdate -expand -group top /tb/u_top/m1_addr
add wave -noupdate -expand -group top /tb/u_top/m0_rdata
add wave -noupdate -expand -group top /tb/u_top/m0_addr
add wave -noupdate -expand -group top /tb/u_top/txd
add wave -noupdate -expand -group top /tb/u_top/rxd
add wave -noupdate -expand -group top /tb/u_top/debug_en
add wave -noupdate -expand -group top /tb/u_top/clk_i
add wave -noupdate -expand -group top /tb/sys_rst_n
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/irq_i
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/ibus_addr_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/ibus_data_i
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_addr_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_rd_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_we_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_size_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_data_o
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/dbus_data_i
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/exu_hold_flag
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/int_hold_flag
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/hold_flag
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/jump_flag
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/jump_addr
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/inst_addr
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/inst_data
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/inst_set
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/inst_type
add wave -noupdate -expand -group cpu /tb/u_top/u_cpu/inst_func
add wave -noupdate /tb/u_top/u_cpu/u_ifu/_pc
add wave -noupdate -radix decimal /tb/u_top/u_cpu/u_exu/iresult_o
add wave -noupdate /tb/u_top/u_cpu/u_exu/iresult_vld_o
add wave -noupdate /tb/u_top/u_cpu/u_exu/reg_waddr_o
add wave -noupdate /tb/u_top/u_cpu/u_exu/reg_waddr_vld_o
add wave -noupdate -expand -group uart /tb/u_top/u_uart/rst
add wave -noupdate -expand -group uart /tb/u_top/u_uart/clk
add wave -noupdate -expand -group uart /tb/u_top/u_uart/uart_baud
add wave -noupdate -expand -group uart /tb/u_top/u_uart/uart_status
add wave -noupdate -expand -group uart /tb/u_top/u_uart/uart_ctrl
add wave -noupdate -expand -group uart /tb/u_top/u_uart/uart_status
add wave -noupdate -expand -group uart /tb/u_top/u_uart/uart_ctrl
add wave -noupdate -expand -group uart /tb/u_top/u_uart/data_i
add wave -noupdate -expand -group uart /tb/u_top/u_uart/addr_i
add wave -noupdate -expand -group uart /tb/u_top/u_uart/we_i
add wave -noupdate -expand -group uart /tb/u_top/u_uart/tx_data
add wave -noupdate -expand -group uart /tb/u_top/u_uart/rx_pin
add wave -noupdate -expand -group uart /tb/u_top/u_uart/tx_pin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {96180000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 261
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {96052051 ps} {96377249 ps}
