
module extend (
    output logic [31:0] ImmExt,
    input logic [31:0] Instr,
    input logic [2:0] ImmSrc
);

    logic [31:0] signBitExtended;
    logic [19:0] upper20;
    always_comb begin
        // Common sub-expression for sign bit extension
        signBitExtended = {32{Instr[31]}};

        // Common sub-expression for upper 20 bits
        upper20 = {Instr[31], Instr[30:25], Instr[24:21]}; // Used in J-type and B-type

        case (ImmSrc)
            3'b000: ImmExt = {signBitExtended[11:0], Instr[31:20]}; // I-type
            3'b001: ImmExt = {signBitExtended[11:0], Instr[31:25], Instr[11:7]}; // S-type
            3'b010: ImmExt = {signBitExtended[11:0], upper20[19:12], Instr[7], upper20[11:8], 1'b0}; // B-type
            3'b011: ImmExt = {signBitExtended[19:0], upper20[7:0], Instr[20], 1'b0}; // J-type
            3'b100: ImmExt = {Instr[31:12], 12'b0}; // U-type
            default: ImmExt = 32'b0;
        endcase
    end

endmodule
