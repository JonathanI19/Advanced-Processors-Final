`timescale 1ns / 1ps

module XOR_tb();

    //registers
    reg[63:0] a,b, expected_val;
    wire[63:0] result;

    //Instantiate 64 bit adder
    XOR x1(.a(a), .b(b), .result(result));
    
    //changing values every 10ns
    initial
        begin
            // Test cases
            #10 a=64'hAAAAAAAAAAAAAAAA; b=64'h5555555555555555;
            expected_val = a ^ b;

            #10 a=64'hAAAAAAAAAAAAAAAA; b=64'hAAAAAAAAAAAAAAAA;
            expected_val = a ^ b;
            
            #10 $finish;
        end
endmodule

