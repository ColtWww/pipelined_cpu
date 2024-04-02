module alu (output logic [31:0] ALUResult,
            output logic Zero,
            input logic [31:0] SrcA, SrcB,
            input logic [2:0] ALUControl);

always_comb begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;      // Addition
            3'b001: ALUResult = SrcA - SrcB;      // Subtraction
            3'b010: ALUResult = SrcA & SrcB;      // AND
            3'b011: ALUResult = SrcA | SrcB;      // OR
            3'b100: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // Set Less Than (SLT)
            3'b101: ALUResult = SrcB; 
            default: ALUResult = 32'b0;           // Undefined operation
        endcase

        // Set the Zero flag if ALUResult is 0
        Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
end

endmodule