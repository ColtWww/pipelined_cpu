
`include "param.v"


module rbm (
    input  wire [`ADDR_BUS_WIDTH-1:0]   m_addr_i,
    output reg  [`DATA_BUS_WIDTH-1:0]   m_data_o,
    input  wire                         m_we_i,
    input  wire                         m_rd_i,

    input  wire [`DATA_BUS_WIDTH-1:0]   s0_data_i,
    output reg                          s0_we_o,
    output reg                          s0_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s1_data_i,
    output reg                          s1_we_o,
    output reg                          s1_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s2_data_i,
    output reg                          s2_we_o,
    output reg                          s2_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s3_data_i,
    output reg                          s3_we_o,
    output reg                          s3_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s4_data_i,
    output reg                          s4_we_o,
    output reg                          s4_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s5_data_i,
    output reg                          s5_we_o,
    output reg                          s5_rd_o,

    input  wire [`DATA_BUS_WIDTH-1:0]   s6_data_i,
    output reg                          s6_we_o,
    output reg                          s6_rd_o
);


localparam SLAVE_0_ADDR                 = 4'd9; // rom    0x9000_0000 ~ 0x9fff_ffff
localparam SLAVE_1_ADDR                 = 4'd8; // ram    0x8000_0000 ~ 0x8fff_ffff
localparam SLAVE_2_ADDR                 = 4'd3; // uart   0x3000_0000 ~ 0x3fff_ffff


always @ (*) begin
    case (m_addr_i[31:28])
        SLAVE_0_ADDR : m_data_o[`DATA_BUS_WIDTH-1:0] = s0_data_i[`DATA_BUS_WIDTH-1:0];
        SLAVE_1_ADDR : m_data_o[`DATA_BUS_WIDTH-1:0] = s1_data_i[`DATA_BUS_WIDTH-1:0];
        SLAVE_2_ADDR : m_data_o[`DATA_BUS_WIDTH-1:0] = s2_data_i[`DATA_BUS_WIDTH-1:0];
        default      : m_data_o[`DATA_BUS_WIDTH-1:0] = `ZERO_WORD;
    endcase
end

always @ (*) begin
    s0_we_o = `INVALID;
    s1_we_o = `INVALID;
    s2_we_o = `INVALID;
    s3_we_o = `INVALID;
    s4_we_o = `INVALID;
    s5_we_o = `INVALID;
    s6_we_o = `INVALID;
    case (m_addr_i[31:28])
        SLAVE_0_ADDR : s0_we_o = m_we_i;
        SLAVE_1_ADDR : s1_we_o = m_we_i;
        SLAVE_2_ADDR : s2_we_o = m_we_i;
    endcase
end

always @ (*) begin
    s0_rd_o = `INVALID;
    s1_rd_o = `INVALID;
    s2_rd_o = `INVALID;
    s3_rd_o = `INVALID;
    s4_rd_o = `INVALID;
    s5_rd_o = `INVALID;
    s6_rd_o = `INVALID;
    case (m_addr_i[31:28])
        SLAVE_0_ADDR : s0_rd_o = m_rd_i;
        SLAVE_1_ADDR : s1_rd_o = m_rd_i;
        SLAVE_2_ADDR : s2_rd_o = m_rd_i;
    endcase
end

endmodule
