// Calla Chen
// Testbench for processor - Lab #5

`timescale 1ns / 1ps
module tb_processor();


reg clk, rst;
wire[31:0] tb_Result;

processor processor_inst (
    .clk(clk),
    .reset(rst),
    .Result(tb_Result)
    );

    always begin
        #10;
        clk = ~clk;
    end

    initial begin
        clk = 0;
        @( posedge clk );
            rst = 1;
        @( posedge clk );
            rst = 0;
        end

    integer point = 0;
 
   always @(*)
        begin
            // Test Case #1
            #20;
            if (tb_Result == 32'h00000000) // and
            begin
                point = point + 1;
            end
           
            // Test case #2
            #20;
            if ( tb_Result == 32'h00000001 ) // addi
                begin
                    point = point + 1;
                end

            // Test Case #3
            #20;
             if ( tb_Result == 32'h00000002 ) // addi
                begin
                    point = point + 1;
                end

            // Test Case #4
            #20;
            if ( tb_Result == 32'h00000004 ) // addi
                begin
                    point = point + 1;
                end;

            // Test Case #5
            #20;
            if ( tb_Result == 32'h00000005 ) // addi
                begin
                    point = point + 1;
                end;

            // Test Case #6
            #20;
            if ( tb_Result == 32'h00000007 ) // addi
                begin
                    point = point + 1;
                end

            // Test Case #7
            #20;
            if ( tb_Result == 32'h00000008 ) // addi
                begin
                    point = point + 1;
                end

            // Test Case #8
            #20;
            if ( tb_Result == 32'h0000000b )// addi
                begin
                    point = point + 1;
                end

            // Test Case #9
            #20;
            if ( tb_Result == 32'h00000003 ) // add
                begin
                    point = point + 1;
                end
            
            // Test Case #10
            #20;
            if ( tb_Result == 32'hfffffffe ) // sub
                begin
                    point = point + 1;
                end;

           // Test Case #11
            #20;
            if ( tb_Result == 32'h00000000 ) // and
                begin
                    point = point + 1;
                end;

           // Test Case #12
            #20;
            if ( tb_Result == 32'h00000005 ) // or
                begin
                    point = point + 1;
                end;
 
            // Test Case #13
            #20;
            if ( tb_Result == 32'h00000001 )// SLT
                begin
                    point = point + 1;
                end;

            // Test Case #14
            #20;
            if ( tb_Result == 32'hfffffff4 ) // NOR
                begin
                    point = point + 1;
                end

            // Test Case #15
            #20;
            if ( tb_Result == 32'h000004D2 ) // andi
                begin
                    point = point + 1;
                end
 
            // Test Case #16
            #20;
            if ( tb_Result == 32'hfffff8d7 ) // ori
                begin
                    point = point + 1;
                end
            
            // Test Case #17
            #20;
            if ( tb_Result == 32'h00000001 ) // SLT
                begin
                    point = point + 1;
                end;
 
            // Test Case #18
            #20;
            if ( tb_Result == 32'hfffffb2c ) // nori
                begin
                    point = point + 1;
                end;
 
            // Test Case #19
            #20;
            if ( tb_Result == 32'h00000030 ) // sw
                begin
                    point = point + 1;
                end;

            // Test Case #20
            #20;
            if ( tb_Result == 32'h00000030 ) // lw
                begin
                point = point + 1;
            end;
 
        $display ("%s%d"," The number of correct test cases is:" , point );
    end

    initial begin
        #430;
        $finish ;
      end

endmodule