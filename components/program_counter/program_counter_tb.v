`timescale 1ns / 1ps

module program_counter_tb();

    //inputs
    wire [31:0] new_addr;
    wire [31:0] addr;
    reg clk;
    
    
    //Instantiate program counter
    program_counter P1(.addr(addr), .new_addr(new_addr), .clk(clk));

    // Instantiate 32-bit adder with 4-bit addition
    thirty_two_bit_adder a1(.a(addr), .b(32'd4), .c_in(1'd0), .sum(new_addr));
    
    //changing values every 10ns
    initial begin

        for(integer i = 0; i < 5; i = i + 1) begin
            #10 clk = 0;
            #10 clk = 1;
        end    
        #10 $finish;
    end
endmodule