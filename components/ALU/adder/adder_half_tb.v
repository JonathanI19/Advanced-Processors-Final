`timescale 1ns / 1ps

module adder_half_tb();

    //inputs
    reg a,b;
    reg c_in;
    
    //outputs
    wire c_out;
    wire sum;
    reg expected_sum, expected_c_out;
    
    //Instantiate 64 bit adder
    half_adder a1(.a(a), .b(b), .sum(sum), .c_out(c_out));
    
    //changing values every 10ns
    initial
        begin
            // Check various test cases
            #10 a=1'd0; b=1'd0;
            expected_sum = a ^ b;
            expected_c_out = a&b;

            #10 a=1'd0; b=1'd1;
            expected_sum = a ^ b;
            expected_c_out = a&b;

            #10 a=1'd1; b=1'd0;
            expected_sum = a ^ b;
            expected_c_out = a&b;

            #10 a=1'd1; b=1'd1;
            expected_sum = a ^ b;
            expected_c_out = a&b;            

            #10 $finish;
        end
endmodule
