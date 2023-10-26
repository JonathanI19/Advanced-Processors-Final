`timescale 1ns / 1ps

module adder_full_tb();

    //inputs
    reg a,b;
    reg c_in;
    
    //outputs
    wire c_out;
    wire sum;
    reg expected_val;
    
    //Instantiate 64 bit adder
    full_adder a1(.a(a), .b(b), .sum(sum), .c_in(c_in), .c_out(c_out));
    
    //changing values every 10ns
    initial
        begin
            // Check various test cases
            #10 a=1d'0; b=1d'0; c_in=1d'0;
            expected_val = a+b+c_in;

            #10 a=1d'0; b=1d'0; c_in=1d'1;
            expected_val = a+b+c_in;

            #10 a=1d'0; b=1d'1; c_in=1d'0;
            expected_val = a+b+c_in;

            #10 a=1d'0; b=1d'1; c_in=1d'1;
            expected_val = a+b+c_in;

            #10 a=1d'1; b=1d'0; c_in=1d'0;
            expected_val = a+b+c_in;

            #10 a=1d'1; b=1d'0; c_in=1d'1;
            expected_val = a+b+c_in;

            #10 a=1d'1; b=1d'1; c_in=1d'0;
            expected_val = a+b+c_in;

            #10 a=1d'1; b=1d'1; c_in=1d'1;
            expected_val = a+b+c_in;
            
            
            #10 $finish;
        end
endmodule
