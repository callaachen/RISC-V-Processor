// Calla Chen
// File for Controller - Lab #5
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Controller 
//////////////////////////////////////////////////////////////////////////////////

module Controller(Opcode, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, ALUOp);

// Defining input and outputs
    input[6:0] Opcode;
    output reg[1:0] ALUOp;
    output reg RegWrite;
    output reg ALUSrc;
    output reg MemRead;
    output reg MemWrite;
    output reg MemtoReg;
    
// Defining Controller Module's Behavior
    always @(*)
        begin
            case(Opcode)
                7'b0110011: 
                    begin
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        ALUSrc = 1'b0;
                        RegWrite = 1'b1;
                        ALUOp = 2'b10;
                     end
        
                7'b0010011:
                    begin
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        ALUSrc = 1'b1;
                        RegWrite = 1'b1;
                        ALUOp = 2'b00;
                    end
        
                7'b0000011:
                    begin
                        MemtoReg = 1'b1;
                        MemWrite = 1'b0;
                        MemRead = 1'b1;
                        ALUSrc = 1'b1;
                        RegWrite = 1'b1;
                        ALUOp = 2'b01;
                    end
        
                7'b0100011:
                    begin
                        MemtoReg = 1'b0;
                        MemWrite = 1'b1;
                        MemRead = 1'b0;
                        ALUSrc = 1'b1;
                        RegWrite = 1'b0;
                        ALUOp = 2'b01;
                    end 
             endcase
        end   
endmodule