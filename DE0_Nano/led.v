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

module led(
    input 		sys_clk,
    input 		sys_rst_n, 

	 input 		debug_en,
	 input 		uart_rx,
	 output 		uart_tx,
	 output reg led
);

////时钟生成
reg clk, lock;
reg rst_n;
reg [31:0] cnt;
//assign rst_n = sys_rst_n;
//assign clk   = sys_clk;

always @(posedge sys_clk or negedge sys_rst_n) 
begin 	
	if(sys_rst_n==0) 
	begin 
		clk <= 0;
		cnt <= 32'b0;
	end 
	else begin
		if(cnt==25-1) begin //1M clk 
			cnt <= 32'b0;
			clk <= ~clk;
		end else begin 
			cnt <= cnt + 32'b1;
		end 
	end 
end
	
always @(posedge clk)
begin
	rst_n  <= sys_rst_n;
end 
	
reg[31:0] timer_cnt;
always @(posedge clk or negedge rst_n) 
begin 	
	if(rst_n==0) 
	begin 
		led <= 0;
		timer_cnt <= 32'b0;
	end 
	else begin
		if(timer_cnt==1000000-1) begin //1M clk 
			timer_cnt <= 32'b0;
			led <= ~led;
		end else begin 
			timer_cnt <= timer_cnt + 32'b1;
		end 
	end 
end

////RISCV SOC模块例化
top u_top (
    .clk_i                      (clk),
    .rst_n_i                    (rst_n),

	 .debug_en 					(debug_en),
    .rxd                        (uart_rx),
    .txd                        (uart_tx)
);




endmodule

