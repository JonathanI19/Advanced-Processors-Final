`timescale 1ns / 1ps

module multiplier_tb();

    //inputs
    reg[63:0] a,b;
    
    //outputs
    wire[63:0] prod;
    
    // Additional vars
    reg[127:0] expected_val;

    //Instantiate subtractor
    multiplier m0(.mcand(a), .b(b), .prod(prod));
    
    //changing values every 10ns
    initial
        begin
            // Check Min signed * max signed
            #10 a=-64'd9223372036854775808; b=64'd9223372036854775807;
            expected_val = a*b;
            
            // Checking random multiplication w/both positive
            #10 a=64'd2036854775808;b=64'd9223372036854;
            expected_val = a*b;
            
            // Checking random multiplication with one negative
            #10 a=64'd2036854775808;b=-64'd9223372036854;
            expected_val = a*b;
            
            // Testing multiplying 2 max values
            #10 a=64'd18446744073709551615 ; b=64'd18446744073709551615;
            expected_val = a*b;
            
            // Testing multiplying 2 signed min values
            #10 a=-64'd9223372036854775808; b=-64'd9223372036854775808;
            expected_val = a*b;
            
            #10 $finish;
        end
endmodule