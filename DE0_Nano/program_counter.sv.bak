module program_counter (output logic [31:0] PC, PCPlus4,
                        input logic [31:0] PCTarget, ALUResult,
                        input logic [1:0] PCSrc, 
                        input logic Reset, CLK);

always_ff @(posedge CLK or posedge Reset) begin
    if (Reset) begin
        PC <= 32'b0;
    end 
    else begin
        case (PCSrc)
            2'b00: PC <= PC + 4;
            2'b01: PC <= PCTarget;
            2'b10: PC <= ALUResult;
            default: PC <= PC + 4;
        endcase
    end
end

// Combinational logic for PCPlus4
always_comb begin
    PCPlus4 = PC + 4;
end

endmodule