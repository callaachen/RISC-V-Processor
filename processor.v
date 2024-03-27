// Calla Chen
// File Processor - Lab #5

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: processor
//////////////////////////////////////////////////////////////////////////////////

module processor (
    input clk, reset,
    output[31:0] Result
);

// Datapath for data_path module and wires used
    wire[3:0] Operation;
    wire MemtoReg;
    wire MemWrite;
    wire MemRead;
    wire ALUSrc;
    wire RegWrite;
    wire[6:0] Opcode;
    wire[2:0] Funct3;
    wire[6:0] Funct7;
    
    data_path Data_Path(
        .alu_result(Result),
        .clk(clk),
        .reset(reset),
        .funct7(Funct7),
        .funct3(Funct3),
        .opcode(Opcode),
        .mem2reg(MemtoReg),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .alu_src(ALUSrc),
        .reg_write(RegWrite),
        .alu_cc(Operation)
       );
       
// Datapath for controller and wries used
    wire[1:0] ALUOp;
    Controller Controller_(
        .Opcode(Opcode),
        .ALUOp(ALUOp),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
      );
      
// Datapath for ALUController and wires used
    ALUController ALU_Controller(
        .Funct3(Funct3),
        .Funct7(Funct7),
        .Operation(Operation),
        .ALUOp(ALUOp)
      );
             
endmodule