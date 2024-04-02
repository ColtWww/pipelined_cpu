module risc_v(output logic [7:0]LEDOut,
                input logic Reset, CLK);

    logic [31:0] Instr, WD3, RD1, RD2, SrcA, SrcB, ALUResult, WD, RD, Result, ImmExt, PCTarget, PCNext, PC, PCPlus4;
    logic [4:0]  A1, A2, A3;
    logic        MemWrite, ALUSrc, RegWrite;
    logic [2:0]  ALUControl;
    logic [2:0]  ImmSrc;
    logic [1:0]  ResultSrc;
    logic [1:0]  PCSrc;
	 logic [31:0] CPUIn;
    logic [31:0] CPUOut;
	 
    always_comb begin
        PCTarget = PC + ImmExt;
    end
	 
	 assign CPUIn = 32'd8;

    instruction_memory instruction_memory(
        .PC(PC),
        .Instr(Instr)
    );

    program_counter pc(
        .CLK(CLK),
        .Reset(Reset),
        .PCTarget(PCTarget),
        .ALUResult(ALUResult),
        .PCSrc(PCSrc),
        .PC(PC)
    );

    control_unit control_unit(
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .Instr(Instr),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ImmSrc(ImmSrc),
        .Zero(Zero)
    );

    reg_file reg_file(
        .CLK(CLK),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(WD3),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2(RD2)
    );

    alu alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .Zero(Zero),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult)
    );

    always_comb begin
        SrcA = RD1;
        SrcB = ALUSrc ? ImmExt : RD2;
    end

    extend extend(
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    data_memory_and_io data_memory_and_io(
        .A(ALUResult),
        .WD(RD2),
        .WE(MemWrite),
        .RD(RD),
        .CLK(CLK),
        .CPUIn(CPUIn),
        .CPUOut(CPUOut)
    );

    always_comb begin
        case (ResultSrc)
            2'b00: WD3 = ALUResult;
            2'b01: WD3 = RD;
            2'b10: WD3 = PCPlus4;
            default: WD3 = 32'b0;
        endcase
    end

	 assign LEDOut = CPUOut[7:0];

endmodule