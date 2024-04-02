module control_unit (output logic [1:0] PCSrc, 
                    output logic [1:0] ResultSrc,
                    output logic MemWrite, ALUSrc, RegWrite,
                    output logic [2:0] ALUControl,
                    output logic [2:0] ImmSrc,
                    input logic [31:0] Instr,
                    input logic Zero);

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    assign opcode = Instr[6:0];
    assign funct3 = Instr[14:12];
    assign funct7 = Instr[31:25];

    always_comb begin
        // Default values for control signals
        PCSrc = 2'b00;
        ResultSrc = 2'b00;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUControl = 3'b000;
        ImmSrc = 3'b000;

        case (opcode)
            // R-type instructions
            7'b0110011: 
            begin
                RegWrite = 1;
                case (funct3)
                    3'b000: ALUControl = (Instr[30] == 1'b0) ? 3'b000 : 3'b001; // ADD or SUB
                    3'b110: ALUControl = 3'b011; // OR
                    3'b111: ALUControl = 3'b010; // AND
                    3'b010: ALUControl = 3'b100; // SLT
                endcase
            end

            // I-type instructions
            7'b0010011: 
            begin
                RegWrite = 1;
                ALUSrc = 1;
                case (funct3)
                    3'b000: ALUControl = 3'b000; //ADDI
                    3'b110: ALUControl = 3'b011; //ORI
                    3'b111: ALUControl = 3'b010; //ANDI
                endcase
            end

            // Load Word
            7'b0000011: 
            begin
                RegWrite = 1;
                ALUSrc = 1;
                ResultSrc = 2'b01;
            end

            // Store Word
            7'b0100011: 
            begin
                MemWrite = 1;
                ALUSrc = 1;
                ImmSrc = 3'b001;
            end

            // BEQ
            7'b1100011:
            begin
                ImmSrc = 3'b010;
                ALUControl = 3'b001;
                PCSrc = Zero ? 2'b01 : 2'b00;
            end
				
            // Jalr
            7'b1100111: 
            begin
                RegWrite = 1;
                ImmSrc = 3'b011;
                ALUControl = 3'b001;
                PCSrc = 2'b10;
                ResultSrc = 2'b10;
            end
				
            // Jal
            7'b1101111:
            begin
                RegWrite = 1;
                ImmSrc = 3'b011;
                PCSrc = 2'b01;
                ResultSrc = 2'b10;
            end


            // LUI
            7'b0110111: 
            begin
                RegWrite = 1;
                ALUSrc = 1;
                ImmSrc = 3'b100;
                ALUControl = 3'b101;
            end
        endcase
    end
endmodule
