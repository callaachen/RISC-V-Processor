// Calla Chen
// File for FlipFlop - Lab #5
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FlipFlop
//////////////////////////////////////////////////////////////////////////////////

module FlipFlop(clk, reset, d, q);
// Defining input and output signals
    input clk, reset;
    input[7:0] d;
    output reg[7:0] q;  
      
// Define D-Flip Flop Module's Behavior
    always @(posedge clk)
      begin
        if(reset == 1'b1)
            q = 8'b0;
        else
            q = d;
      end
      
endmodule // FlipFlop