`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/28 15:04:30
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "param.v"

module fpga_top(
    input 		sys_clk,
    input 		sys_rst_n,
    output reg  led,
    output      uart_tx,
	input       uart_rx,
	input 		debug_en
);

////时钟生成
wire clk, lock;
reg  rst_n;
clk_wiz_0 u_clk_rst_gen (
	// Clock out ports
	.clk_out1(clk),     // 20M
	.clk_out2(),     // 10M
	.clk_out3(),     // 50M
	// Status and control signals
	.reset(~sys_rst_n), // input reset
	.locked(lock),       // output locked
	// Clock in ports
	.clk_in1(sys_clk)
);      

always @(posedge clk) begin 
	rst_n <= sys_rst_n & lock;
end 

	
////LED 1S闪烁
(* MARK_DEBUG="true" *)reg[31:0] timer_cnt;
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        led <= 1'd0 ;
        timer_cnt <= 32'd0 ;
    end else if(timer_cnt >= `XTAL_FREQ_HZ-1) begin
        led <= ~led;
        timer_cnt <= 32'd0;
    end else begin
        led <= led;
        timer_cnt <= timer_cnt + 32'd1;
    end
end


////UART串口debug模式切换，按键/电平使能
(* MARK_DEBUG="true" *)reg debug_en_w;
(* MARK_DEBUG="true" *)reg [7:0] debug_en_r;
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        debug_en_w <= 1'd0 ;
    end else if(debug_en) begin
        debug_en_w <= 1'b1;
    end else begin 
		debug_en_w <= 1'b0;
	end
end
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        debug_en_r <= 8'd0 ;
    end else begin
        debug_en_r <= {debug_en_r[6:0],debug_en};
    end
end


////RISCV SOC模块例化
top u_top (
    .clk_i                      (clk),
    .rst_n_i                    (rst_n),

	.debug_en 					(debug_en_w),
    .rxd                        (uart_rx),
    .txd                        (uart_tx)
);




endmodule

