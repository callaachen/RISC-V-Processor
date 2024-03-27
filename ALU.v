// Calla Chen
// File for ALU - Lab #5
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ALU_32
//////////////////////////////////////////////////////////////////////////////////

// I used the ALU code provided to us in Lab 4 manual. 
// Module definition
module alu_32 (
    input[31:0] A_in, B_in,         // ALU 32 bit inputs
    input[3:0] ALU_Sel,             // ALU 4 bits selection
    output[31:0] ALU_Out,           // ALU 32 bits output
    output reg Carry_Out,          
    output Zero,                    // 1 bit Zero Flag
    output reg Overflow = 1'b0      // 1 bit Overflow Flag
    );
    
    reg[31:0] ALU_Result; 
    reg[32:0] temp;
    reg[32:0] twos_com; // To hold 2'sc of second source of ALU
    
    assign ALU_Out = ALU_Result;
    assign Zero = (ALU_Result == 0);
    
    always@(*)
        begin
            Overflow = 1'b0;
            Carry_Out = 1'b0;
            case(ALU_Sel)
                4'b0000: // bit-wise and
                    ALU_Result = A_in & B_in;
                    
                4'b0001: // bit-wise or
                   ALU_Result = A_in | B_in;
                   
                4'b0010: // Signed addition with Overflow and Carry_Out checking
                    begin
                        ALU_Result = $signed(A_in) + $signed(B_in);
                        temp = {1'b0, A_in} + {1'b0, B_in};
                        Carry_Out = temp[32];
                        if ((A_in[31] & B_in[31] & ~ALU_Out[31]) | 
                            (~A_in[31] & ~B_in[31] & ALU_Out[31]))
                            Overflow = 1'b1;
                        else
                            Overflow = 1'b0;
                     end
                 
                 4'b0110: // Signed Subtraction with Overflow Checking
                    begin
                        ALU_Result = $signed(A_in) - $signed(B_in);
                        twos_com = ~(B_in) + 1'b1;
                        if((A_in[31] & twos_com[31] & ~ALU_Out[31]) | 
                           (~A_in[31] & ~twos_com[31] & ALU_Out[31]))
                            Overflow = 1'b1;
                        else
                            Overflow = 1'b0;
                    end
                    
                  4'b0111: // Signed less than comparison
                    ALU_Result = ($signed(A_in) < $signed(B_in)) ? 32'd1 : 32'd0;
                    
                  4'b1100: // bitwise nor
                    ALU_Result = ~(A_in | B_in);
                  
                  4'b1111: // Equal Comparison
                    ALU_Result = (A_in == B_in) ? 32'd1 : 32'd0;
                  
                  default: ALU_Result = A_in + B_in;
            endcase
         end
            
endmodule