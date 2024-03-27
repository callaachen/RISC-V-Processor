// Calla Chen
// File for Data Path - Lab 4

////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,    // CLK in datapath figure
    input                  reset,   // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );

// FlipFlop Datapath and wires used
    wire[7:0] PCPlus4;
    wire[7:0] PC;
    FlipFlop Flip_Flop(
        .reset(reset),
        .clk(clk),
        .d(PCPlus4),
        .q(PC)
        );
    assign PCPlus4 = PC + 8'd4;
    
// Instruction Memory Datapath and Wires Used
    wire[31:0] instruction;
    InstMem Inst_Mem (
        .addr(PC),
        .instruction(instruction)
        );
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
// RegFile Datapath and Wires Used
    wire[31:0] Reg1;
    wire[31:0] Reg2;
    wire[31:0] WriteBack_Data;
    wire[4:0] immedWire1;
    wire[4:0] immedWire2;
    wire[4:0] immedWire3;
    
// Here I assigned immediate wires called immedWire to each instruction
    assign immedWire1 = instruction[19:15];
    assign immedWire2 = instruction[24:20];
    assign immedWire3 = instruction[11:7];
    
    RegFile Reg_File(
        .rg_rd_addr1(immedWire1),
        .rg_rd_addr2(immedWire2),
        .rg_wrt_addr(immedWire3),
        .rg_wrt_en(reg_write),
        .reset(reset),
        .clk(clk),
        .rg_rd_data1(Reg1),
        .rg_rd_data2(Reg2),
        .rg_wrt_data(WriteBack_Data)
       );
       
// Immediate Generator Datapath and Wires Used
    wire[31:0] ExtImm;
    wire[31:0] SrcB;
    ImmGen Imm_Gen(
        .InstCode(instruction),
        .ImmOut(ExtImm)
       );
       
// First MUX Instantiation datapath
    MUX21 MUX_21(
        .S(alu_src),
        .D1(Reg2),
        .D2(ExtImm),
        .Y(SrcB)
      );
    
// ALU Datapath and Wires Used
    wire[31:0] ALU_Result;
    wire cout;
    wire zero;
    wire overflow;
    
    alu_32 ALU_32(
        .A_in(Reg1),
        .B_in(SrcB),
        .ALU_Out(ALU_Result),
        .ALU_Sel(alu_cc),
        .Carry_Out(cout),
        .Zero(zero),
        .Overflow(overflow)
      );
      assign alu_result = ALU_Result;

// Data Memory Datapath and Wires Used
    wire[31:0] DataMem_read;
    DataMem Data_Mem(
        .addr(ALU_Result[8:0]),
        .write_data(Reg2),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .read_data(DataMem_read)
       );
      
// Second MUX Instantiation Datapath
    MUX21 mux_21(
        .S(mem2reg),
        .D1(ALU_Result),
        .D2(DataMem_read),
        .Y(WriteBack_Data)
      );

endmodule // Datapath