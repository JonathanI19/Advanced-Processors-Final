`timescale 1ns / 1ps

module subtractor_tb();

    //inputs
    reg[63:0] a,b;
    
    //outputs
    wire[63:0] dif;
    wire ovf;
    
    // Additional vars
    reg[63:0] expected_val;

    //Instantiate subtractor
    subtractor s1(.a(a), .b(b), .dif(dif), .ovf(ovf));
    
    //changing values every 10ns
    initial
        begin
            // Check Min signed - max signed
            #10 a=-64'd9223372036854775808; b=64'd9223372036854775807;
            expected_val = a-b;
            
            // Checking random subtraction w/both positive
            #10 a=64'd2036854775808;b=64'd9223372036854;
            expected_val = a-b;
            
            // Checking random subtraction a - (-b)
            #10 a=64'd2036854775808;b=-64'd9223372036854;
            expected_val = a-b;
            
            // Testing adding 2 max values
            #10 a=64'd18446744073709551615 ; b=64'd18446744073709551615;
            expected_val = a-b;
            
            // Testing adding 2 max values
            #10 a=64'd18446744073709551615 ; b=64'd18446744073709551615;
            expected_val = a-b;
            
            // Testing subtracting 2 min values
            #10 a=-64'd9223372036854775808; b=-64'd9223372036854775808;
            expected_val = a-b;
            
            #10 $finish;
        end
endmodule

