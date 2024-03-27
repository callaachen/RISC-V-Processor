// Calla Chen
// File for ALU Controller - Lab #5
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ALUController
//////////////////////////////////////////////////////////////////////////////////

// Module Definition
module ALUController(ALUOp, Funct7, Funct3, Operation);

// Defining input and output signals
    input[1:0] ALUOp;
    input[6:0] Funct7;
    input[2:0] Funct3;
    output[3:0] Operation;

// Defining ALU Controller module's behavior
    assign Operation[0] = ((Funct3 == 3'b110) || ((Funct3 == 3'b010) && (ALUOp[0] == 1'b0))) ? 1'b1 : 1'b0;
    assign Operation[1] = ((Funct3 == 3'b010) || (Funct3 == 3'b000)) ? 1'b1 : 1'b0;
    assign Operation[2] = ((Funct3 == 3'b100) || (Funct3 == 3'b010) && (ALUOp[0] == 1'b0)) || ((Funct7 == 7'b0100000) && (Funct3 == 3'b000) && (ALUOp == 2'b10)) ? 1'b1 : 1'b0;
    assign Operation[3] = ((Funct3 == 3'b100)) ? 1'b1 : 1'b0;

endmodule