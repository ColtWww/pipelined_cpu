
#**************************************************************
# Set Clock 
#**************************************************************
create_clock -period 20.000 -name sys_clk -waveform {0.000 10.000} [get_ports sys_clk]

create_clock -period 100.000 -name clk -waveform {0.000 50.000} [get_nets clk]

