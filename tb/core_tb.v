`timescale 1ns / 1ps

`include "param.v"


module tb();


reg                             sys_clk;
reg                             sys_rst_n;

wire  							debug_en = 0;
wire                            PAD_A0;
wire                            PAD_A1;



//专门用于仿真查看的测试寄存器
wire[31:0] x3 = u_top.u_cpu.u_regfile.u_xreg._x3;
wire[31:0] x26 = u_top.u_cpu.u_regfile.u_xreg._x26;
wire[31:0] x27 = u_top.u_cpu.u_regfile.u_xreg._x27;

integer r;

initial begin
	$display("test running...");
	@(posedge sys_rst_n);
	#200;

	wait(x26 == 32'b1)   // wait sim end, when x26 == 1
	#100
	if (x27 == 32'b1) begin
		$display("~~~~~~~~~~~~~~~~~~~ TEST_PASS ~~~~~~~~~~~~~~~~~~~");
		$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		$display("~~~~~~~~~ #####     ##     ####    #### ~~~~~~~~~");
		$display("~~~~~~~~~ #    #   #  #   #       #     ~~~~~~~~~");
		$display("~~~~~~~~~ #    #  #    #   ####    #### ~~~~~~~~~");
		$display("~~~~~~~~~ #####   ######       #       #~~~~~~~~~");
		$display("~~~~~~~~~ #       #    #  #    #  #    #~~~~~~~~~");
		$display("~~~~~~~~~ #       #    #   ####    #### ~~~~~~~~~");
		$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	end else begin
		$display("~~~~~~~~~~~~~~~~~~~ TEST_FAIL ~~~~~~~~~~~~~~~~~~~~");
		$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		$display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~");
		$display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~");
		$display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~");
		$display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~");
		$display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~");
		$display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~");
		$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		$display("fail testnum = %2d", x3);
	end
end    
	
	
// sim timeout
initial begin
	#500000;
	$display("Time Out.");
	$finish;
end 


initial begin
`ifdef DUMP_VPD
    $vcdplusfile("wave.vpd");
    $vcdpluson(0, tb);
`endif
end

top u_top (
    .clk_i                      (sys_clk),
    .rst_n_i                    (sys_rst_n),

	.debug_en 					(debug_en),
    .rxd                        (PAD_A1),
    .txd                        (PAD_A0)
);

core_data_monitor_tb u_core_data_monitor_tb (
    .clk_i                      (sys_clk),
    .rst_n_i                    (sys_rst_n),

    .data_i                     (u_top.u_cpu.u_regfile.u_csr._mscratchcswl) 
);

core_uart_monitor_tb u_core_uart_monitor_tb (
    .clk_i                      (sys_clk),
    .rst_n_i                    (sys_rst_n),

    .rxd                        (PAD_A0),
    .txd                        ()
);


/////////////////////////////////////////////////
//通过riscv gcc编译生成并转成16进制的指令，仿真阶段加载到rom的存储空间中
//如果是实际上板，则需要固化到rom中或者通过debug模块写入到rom中才行
////////////////////////////////////////////////
reg [32-1:0] tmp_rom[(`ROM_SIZE-1):0];
integer ii;
initial begin
    $readmemh("../example_c/inst_data/rv32ui-p-add.data", u_top.u_rom.fpga_mem);
	/*
	for(ii=0;ii<`ROM_SIZE;ii=ii+1) begin 
		//u_top.u_rom.fpga_mem[ii] = tmp_rom[ii/4];
		//u_top.u_rom.fpga_mem[ii+1] = tmp_rom[ii/4][15:8];
		//u_top.u_rom.fpga_mem[ii+2] = tmp_rom[ii/4][23:16];
		//u_top.u_rom.fpga_mem[ii+3] = tmp_rom[ii/4][31:24];
	end
	*/ 
end

always begin
    sys_clk = 1;
    sys_rst_n = 1;
	#100;
    sys_rst_n = 0;
	#100;
    sys_rst_n = 1;

    while (1) begin
        @ (posedge sys_clk);
    end

    $stop();
end

always #((32'd1_000_000_000/`XTAL_FREQ_HZ)/2) sys_clk = ~sys_clk;

endmodule
