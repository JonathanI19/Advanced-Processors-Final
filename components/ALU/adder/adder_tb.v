`timescale 1ns / 1ps

module adder_tb();

    //inputs
    reg[63:0] a,b;
    reg c_in;
    
    //outputs
    wire[63:0]   sum;
    reg[63:0] expected_val;
    wire ovf;
    
    //Instantiate 64 bit adder
    sixty_four_bit_adder a1(.a(a), .b(b), .sum(sum), .c_in(c_in), .ovf(ovf));
    
    //changing values every 10ns
    initial
        begin
            // Check Min signed + max signed
            #10 a=-64'd9223372036854775808; b=64'd9223372036854775807; c_in=0;
            expected_val = a+b+c_in;
            
            // Checking random addition w/both positive
            #10 a=64'd2036854775808;b=64'd9223372036854;c_in=1;
            expected_val = a+b+c_in;
            
            // Checking random addition w/one negative, one positive
            #10 a=-64'd2036854775808;b=64'd9223372036854;c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with carry in
            #10 a=64'd18446744073709551615 ; b=64'd18446744073709551615; c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with no carry in
            #10 a=64'd18446744073709551615 ; b=64'd18446744073709551615; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with no carry in
            #10 a=-64'd9223372036854775808; b=-64'd9223372036854775808; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with carry in
            #10 a=-64'd9223372036854775808; b=-64'd9223372036854775808; c_in=1;
            expected_val = a+b+c_in;
            
            
            #10 $finish;
        end
endmodule

