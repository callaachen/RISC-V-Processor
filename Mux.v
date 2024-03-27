// Calla Chen
// File for Mux - Lab #5

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: MUX21
// 
//////////////////////////////////////////////////////////////////////////////////

// Module definition for Mux
module MUX21 (
        D1 , D2 , S , Y
);
 
// Defining the inputs
    input  S;
    input[31:0] D1, D2;
// Defining the output
    output[31:0] Y;
    reg[31:0] MuxResult;
    assign Y = MuxResult;
// Defining MUX21 module's behavior
// Whenever there is a change in any of inputs, make the choice 
    always @(*)
        begin
            MuxResult = S ? D2 : D1 ;
        end
endmodule //MUX21