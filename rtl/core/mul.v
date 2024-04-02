
`include "param.v"


module mul (
    input  wire [`DATA_BUS_WIDTH-1:0]   data1_i,
    input  wire [`DATA_BUS_WIDTH-1:0]   data2_i,

    input  wire                         sign_i,

    output wire [63:0]                  data_o
);


wire [47:0]                             iresult_final_high;
wire [47:0]                             iresult_final_low;

assign iresult_final_high[47:0] = data1_i[31:0] * {16'b0, data2_i[31:16]};
assign iresult_final_low [47:0] = data1_i[31:0] * {16'b0, data2_i[15: 0]};

wire [63:0]                             iresult_final;

assign iresult_final[63:0] = {iresult_final_high[47:0], 16'b0}
                           + {16'b0,  iresult_final_low[47:0]};

assign data_o[63:0] = sign_i ? (~iresult_final[63:0] + 64'b1)
                             : ( iresult_final[63:0]);

endmodule
