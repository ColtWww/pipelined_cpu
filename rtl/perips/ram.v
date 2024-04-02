
`include "param.v"

module ram(/*AUTOARG*/
    //Outputs
    o_mem_rdata0,

    //Inputs
    i_clk0, i_mem_reb0, i_mem_addr0, i_clk1, i_mem_web1, i_mem_bweb1,
    i_mem_addr1, i_mem_wdata1
);

//---------------------------------------------------------//
//-                  Parameter Declare                    -//
//---------------------------------------------------------//
parameter LOC_RAM_WIDTH     = 64      ;     // memory width
parameter RAM_DEPTH         = 1024    ;     // memory depth
parameter RAM_ADDR_WIDTH    = 10      ;     // memory address width
parameter RAM_BWE_GROUP     = 0       ;     // memory bwe group size
parameter LOC_BWE_WIDTH     = 64      ;     // memory bwe width
parameter RAM_FPGA_TYPE     = 1       ;     // fpga memory tpye
parameter DELAY             = 1       ;

localparam FPGA_RAM_WIDTH = (RAM_BWE_GROUP*LOC_BWE_WIDTH > LOC_RAM_WIDTH) ? RAM_BWE_GROUP*LOC_BWE_WIDTH : LOC_RAM_WIDTH;

localparam FPGA_BWE_WIDTH = (RAM_BWE_GROUP == 0) ? 1 : (FPGA_RAM_WIDTH/RAM_BWE_GROUP);
localparam GROUP_BITS     = (RAM_BWE_GROUP == 0) ? LOC_RAM_WIDTH : RAM_BWE_GROUP; 

//---------------------------------------------------------//
//-                  Port Declare                         -//
//---------------------------------------------------------//
input                         i_clk0            ;
input                         i_mem_reb0        ;
input  [RAM_ADDR_WIDTH-1:0]   i_mem_addr0       ;
output [LOC_RAM_WIDTH-1:0]    o_mem_rdata0      ;

input                         i_clk1            ;
input                         i_mem_web1        ;
input  [LOC_RAM_WIDTH-1:0]    i_mem_bweb1       ;
input  [RAM_ADDR_WIDTH-1:0]   i_mem_addr1       ;
input  [LOC_RAM_WIDTH-1:0]    i_mem_wdata1      ;

//---------------------------------------------------------//
//-                  Signal Declare                       -//
//---------------------------------------------------------//
/*AUTODEFINE*/
wire [RAM_ADDR_WIDTH-1:0]  temp_r_addr;
wire [LOC_RAM_WIDTH-1:0]   temp_r_rdata;
wire                       temp_r_re;

wire [RAM_ADDR_WIDTH-1:0]  temp_w_addr;
wire [LOC_RAM_WIDTH-1:0]   temp_w_bwe;
wire                       temp_w_we;

wire [FPGA_RAM_WIDTH-1:0]  temp_wdata;
reg  [FPGA_BWE_WIDTH-1:0]  fpga_bwe;
reg  [FPGA_RAM_WIDTH-1:0]  fpga_rdata, fpga_rdata_w;
integer   b_id;

`ifdef FPGA
    localparam RAM_FPGA_SYN_RAMSTYLE = (RAM_FPGA_TYPE==1) ? "block"     : "distributed";
    localparam RAM_FPGA_RAM_STYPE    = (RAM_FPGA_TYPE==1) ? "block_ram" : "select_ram";
    localparam RAM_FPGA_RAM_BLOCK    = (RAM_FPGA_TYPE==1) ? 1           : 0;
    (* syn_ramstyle = RAM_FPGA_SYN_RAMSTYLE *)
    (* ram_style = RAM_FPGA_RAM_STYPE *)
    (* ram_block = RAM_FPGA_RAM_BLOCK *)
reg  [FPGA_RAM_WIDTH-1:0]  fpga_mem[0:RAM_DEPTH-1];
`else
reg  [FPGA_RAM_WIDTH-1:0]  fpga_mem[0:RAM_DEPTH-1];
`endif

//---------------------------------------------------------//
//-                  Internal Logic                       -//
//---------------------------------------------------------//
assign temp_r_re    = i_mem_reb0;
assign temp_r_addr  = i_mem_addr0;

assign temp_w_we    = i_mem_web1;
assign temp_w_bwe   = i_mem_bweb1;
assign temp_w_addr  = i_mem_addr1;
assign temp_wdata   = {{GROUP_BITS{1'b0}}, i_mem_wdata1};
    
always @(*) begin
    for (b_id=0;b_id<FPGA_BWE_WIDTH;b_id=b_id+1) begin
        fpga_bwe[b_id] = (RAM_BWE_GROUP==0) ? 1'b1 : temp_w_bwe[RAM_BWE_GROUP*b_id];
    end
end

always @(posedge i_clk1) begin
    if (temp_w_we) begin
        for (b_id=0;b_id<FPGA_BWE_WIDTH;b_id=b_id+1) begin
            if (fpga_bwe[b_id]) begin
                fpga_mem[temp_w_addr][b_id*GROUP_BITS +: GROUP_BITS] <= temp_wdata[b_id*GROUP_BITS +: GROUP_BITS];
            end
        end
    end
end




generate 
if(DELAY==1) begin : NORMAL_DELAY
    always @(posedge i_clk0) begin
        if (temp_r_re) begin
            fpga_rdata <= fpga_mem[temp_r_addr];
        end
    end

    assign o_mem_rdata0[LOC_RAM_WIDTH-1:0] = fpga_rdata;
end else begin : ZERO_DELAY
    always @(*)
        fpga_rdata_w = temp_r_re ? fpga_mem[temp_r_addr] : fpga_rdata;

    always @(posedge i_clk0) begin
        if (temp_r_re) begin
            fpga_rdata <= fpga_mem[temp_r_addr];
        end
    end

    assign o_mem_rdata0[LOC_RAM_WIDTH-1:0] = fpga_rdata_w;
end 
endgenerate


endmodule

