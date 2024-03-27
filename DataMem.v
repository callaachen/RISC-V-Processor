// Calla Chen
// File for DataMem - Lab #5
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/// data memory
//////////////////////////////////////////////////////////////////////////////////

// Module definition
module DataMem(MemRead, MemWrite, addr, write_data, read_data);
// Define I/O ports
    input MemRead, MemWrite;
    input[8:0] addr;
    input[31:0] write_data;
    output[31:0] read_data;
    
// Describe DataMem behavior 
    reg[31:0] Data_Memory[127:0];
    always @(posedge MemWrite)
        begin
                Data_Memory[addr[8:0]] <= write_data;
        end
    
    assign read_data = (MemRead == 1) ? Data_Memory[addr[8:0]] : 32'b0;
endmodule //DataMem
     