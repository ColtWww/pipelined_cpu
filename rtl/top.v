
`include "param.v"

module top (
    input  wire                         clk_i,
    input  wire                         rst_n_i,

    input  wire                         debug_en,
    input  wire                         rxd,
    output wire                         txd
);

wire                                    clk_50m;
wire                                    rst_n;


assign clk_50m = clk_i;
assign rst_n   = rst_n_i;

(* MARK_DEBUG="true" *)wire [`ADDR_BUS_WIDTH-1:0]              m0_addr;
(* MARK_DEBUG="true" *)wire [`DATA_BUS_WIDTH-1:0]              m0_rdata;

(* MARK_DEBUG="true" *)wire [`ADDR_BUS_WIDTH-1:0]              m1_addr;
(* MARK_DEBUG="true" *)wire                                    m1_rd;
(* MARK_DEBUG="true" *)wire                                    m1_we;
(* MARK_DEBUG="true" *)wire [2:0]                              m1_size;
(* MARK_DEBUG="true" *)wire [`DATA_BUS_WIDTH-1:0]              m1_wdata;
(* MARK_DEBUG="true" *)wire [`DATA_BUS_WIDTH-1:0]              m1_rdata;

wire                                    s0_rd;
wire                                    s0_we;
wire [`DATA_BUS_WIDTH-1:0]              s0_data;

wire                                    s1_rd;
wire                                    s1_we;
wire [`DATA_BUS_WIDTH-1:0]              s1_data;

wire                                    s2_rd;
wire                                    s2_we;
wire [`DATA_BUS_WIDTH-1:0]              s2_data;

wire                                    debug_rd;
wire                                    debug_we;
wire [`DATA_BUS_WIDTH-1:0]              debug_rdata;
wire [`ADDR_BUS_WIDTH-1:0]              debug_addr;
wire [`DATA_BUS_WIDTH-1:0]              debug_wdata;

wire [`ADDR_BUS_WIDTH-1:0]              cpu_addr;
wire                                    cpu_rd;
wire                                    cpu_we;
wire [2:0]                              cpu_size;
wire [`DATA_BUS_WIDTH-1:0]              cpu_wdata;
wire [`DATA_BUS_WIDTH-1:0]              cpu_rdata;

assign m1_addr = debug_en ? debug_addr : cpu_addr;
assign m1_rd   = debug_en ? debug_rd : cpu_rd;
assign m1_we   = debug_en ? debug_we : cpu_we;
assign m1_size = debug_en ? 3'b100 : cpu_size;
assign m1_wdata= debug_en ? debug_wdata : cpu_wdata;
assign cpu_rdata = m1_rdata;
assign debug_rdata = m1_rdata;


wire                                    irq_flag = 0;
uart_debug u_uart_debug(

    .clk                                (clk_50m),               
    .rst_n                              (rst_n),           

    .debug_en_i                         (debug_en),        

    .mem_rd_o                           (debug_rd),
    .mem_we_o                           (debug_we),  
    .mem_addr_o                         (debug_addr),
    .mem_wdata_o                        (debug_wdata),
    .mem_rdata_i                        (debug_rdata)

);



cpu u_cpu (
    .clk_i                              (clk_50m),
    .rst_n_i                            (rst_n & (~debug_en)),

    .irq_i                              (irq_flag),

    .ibus_addr_o                        (m0_addr),
    .ibus_data_i                        (m0_rdata),

    .dbus_addr_o                        (cpu_addr),
    .dbus_rd_o                          (cpu_rd),
    .dbus_we_o                          (cpu_we),
    .dbus_size_o                        (cpu_size),
    .dbus_data_o                        (cpu_wdata),
    .dbus_data_i                        (cpu_rdata)
);

rbm u_rbm (
    .m_addr_i                           (m1_addr),
    .m_data_o                           (m1_rdata),
    .m_we_i                             (m1_we),
    .m_rd_i                             (m1_rd),

//  slave 0
    .s0_data_i                          (s0_data),
    .s0_we_o                            (s0_we),
    .s0_rd_o                            (s0_rd),

//  slave 1
    .s1_data_i                          (s1_data),
    .s1_we_o                            (s1_we),
    .s1_rd_o                            (s1_rd),

//  slave 2
    .s2_data_i                          (s2_data),
    .s2_we_o                            (s2_we),
    .s2_rd_o                            (s2_rd),

//  slave 3
    .s3_data_i                          (32'b0),
    .s3_we_o                            (),
    .s3_rd_o                            (),

//  slave 4
    .s4_data_i                          (32'b0),
    .s4_we_o                            (),
    .s4_rd_o                            (),

//  slave 5
    .s5_data_i                          (32'b0),
    .s5_we_o                            (),
    .s5_rd_o                            (),

//  slave 6
    .s6_data_i                          (32'b0),
    .s6_we_o                            (),
    .s6_rd_o                            ()
);
ram #( 
	.LOC_RAM_WIDTH(32),
	.RAM_DEPTH    (`ROM_SIZE),
	.RAM_ADDR_WIDTH($clog2(`ROM_SIZE))
) u_rom (
	.i_clk0   				 			(clk_50m),		     
	.i_mem_reb0    						(1'b1),
	.i_mem_addr0   						(m0_addr[$clog2(`ROM_SIZE)-1:0]>>2),  //addr >> 2 to get 4B-aligned addr
	.o_mem_rdata0  						(m0_rdata),
    
	.i_clk1       						(clk_50m),
	.i_mem_web1    						(s0_we),
	.i_mem_bweb1   						({32{s0_we}}),
	.i_mem_addr1   						(m1_addr[$clog2(`ROM_SIZE)-1:0]>>2),
	.i_mem_wdata1  						(m1_wdata)
);

ram #( 
	.LOC_RAM_WIDTH(32),
	.RAM_DEPTH    (`RAM_SIZE),
	.RAM_ADDR_WIDTH($clog2(`RAM_SIZE))
) u_ram (
	.i_clk0   				 			(clk_50m),		     
	.i_mem_reb0    						(s1_rd),
	.i_mem_addr0   						(m1_addr[$clog2(`RAM_SIZE)-1:0]>>2),
	.o_mem_rdata0  						(s1_data),
    
	.i_clk1       						(clk_50m),
	.i_mem_web1    						(s1_we),
	.i_mem_bweb1   						({32{s1_we}}),
	.i_mem_addr1   						(m1_addr[$clog2(`RAM_SIZE)-1:0]>>2),
	.i_mem_wdata1  						(m1_wdata)
);
/*
ram #(`ROM_SIZE) u_rom (
    .clk_i                              (clk_50m),
    .rst_n_i                            (rst_n),

    .addr1_i                            (m1_addr),
    .rd1_i                              (s0_rd),
    .we1_i                              (s0_we),
    .size1_i                            (m1_size),
    .data1_i                            (m1_wdata),
    .data1_o                            (s0_data),

    .addr2_i                            (m0_addr),
    .rd2_i                              (1'b1),
    .data2_o                            (m0_rdata)
);

ram #(`RAM_SIZE) u_ram (
    .clk_i                              (clk_50m),
    .rst_n_i                            (rst_n),

    .addr1_i                            (m1_addr),
    .rd1_i                              (s1_rd),
    .we1_i                              (s1_we),
    .size1_i                            (m1_size),
    .data1_i                            (m1_wdata),
    .data1_o                            (s1_data),

    .addr2_i                            (32'b0),
    .rd2_i                              (1'b0),
    .data2_o                            ()
);
*/


uart u_uart (
    .clk                                (clk_50m),
    .rst                                (~rst_n),

    .addr_i                             ({{(`DATA_BUS_WIDTH-8){1'b0}},m1_addr[7:0]}),
    .we_i                               (s2_rd ? 1'b0 : s2_we),
    .data_i                             (m1_wdata),
    .data_o                             (s2_data),

    .rx_pin                             (rxd),
    .tx_pin                             (txd)
);


endmodule
