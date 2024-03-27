// Calla Chen
// File for RegFile - Lab #4

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: RegFile
// 
//////////////////////////////////////////////////////////////////////////////////

// Module Definition
module RegFile(clk, reset, rg_wrt_en,
    rg_wrt_addr, 
    rg_rd_addr1, 
    rg_rd_addr2, 
    rg_wrt_data,
    rg_rd_data1, 
    rg_rd_data2
);

// Define the input signals
    input clk, reset, rg_wrt_en;                        // Clock, Reset, Write Enable Signal
    input[4:0] rg_wrt_addr;
    input[4:0] rg_rd_addr1;                             // Register Read addresses
    input[4:0] rg_rd_addr2;  
    input[31:0] rg_wrt_data;                            // This is where we put an optional number
                                                        // to write into the selected register for testing
// Define the output signals
    output wire[31:0] rg_rd_data1;                      // The two output lines (both 32 bits)
    output wire[31:0] rg_rd_data2;
// Define the Register File module's behavior
    reg[31:0] register[31:0];

// assigning the read data registers to read address registers
    assign rg_rd_data1 = register[rg_rd_addr1];
    assign rg_rd_data2 = register[rg_rd_addr2]; 
    
    integer i = 0;
    always @(posedge clk,reset)  
        begin
            if(reset == 1) begin
                for(i=0; i < 32; i=i+1)
                    register[i] = 32'h0;
                end
            else if(clk == 1 && rg_wrt_en == 1)
                begin
                    register[rg_wrt_addr] <= rg_wrt_data;
                end
        end
endmodule //RegFile
