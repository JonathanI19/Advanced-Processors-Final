`timescale 1ns / 1ps

module adder_32_bit_tb();

    //inputs
    reg[31:0] a,b;
    reg c_in;
    
    //outputs
    wire c_out;
    wire[31:0]   sum;
    reg[31:0] expected_val;
    
    //Instantiate 64 bit adder
    thirty_two_bit_adder a1(.a(a), .b(b), .sum(sum), .c_in(c_in), .c_out(c_out));
    
    //changing values every 10ns
    initial
        begin
            // Check Min signed + max signed
            #10 a=-32'd2147483648; b=32'd2147483647; c_in=0;
            expected_val = a+b+c_in;
            
            // Checking random addition w/both positive
            #10 a=32'd294967;b=32'd67296;c_in=1;
            expected_val = a+b+c_in;
            
            // Checking random addition w/one negative, one positive
            #10 a=-32'd294967;b=32'd67296;c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with carry in
            #10 a=32'd4294967296 ; b=32'd4294967296; c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with no carry in
            #10 a=32'd4294967296; b=32'd4294967296; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with no carry in
            #10 a=-32'd2147483648; b=-32'd2147483648; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with carry in
            #10 a=-32'd2147483648; b=-32'd2147483648; c_in=1;
            expected_val = a+b+c_in;
            
            
            #10 $finish;
        end
endmodule


