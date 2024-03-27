// Calla Chen
// File for ImmGen - Lab #5

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ImmGen
// 
//////////////////////////////////////////////////////////////////////////////////

// This code was provided to us from Lab 3 Manual
module ImmGen(
    InstCode ,
    ImmOut
    );
   
// Defining Input 
    input[31:0] InstCode;
// Defining Output
    output reg[31:0] ImmOut;
    
// Defining ImmGen module's behavior
    always @(InstCode)
        begin
            case(InstCode[6:0])
                // I-type Load
                7'b0000011:
                    ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0 , InstCode[31:20]};
                // I-Type Non-Load
                7'b0010011:
                    ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0 , InstCode[31:20]};
                // S-Type Store
                7'b0100011:
                    ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0 , InstCode[31:25] , InstCode[11:7]};
                // U-Type
                7'b0010111:
                    ImmOut = {InstCode[31:12] , 12'b0};
                default: ImmOut = {32'b0};
             endcase
        end
endmodule //ImmGen