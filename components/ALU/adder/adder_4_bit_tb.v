`timescale 1ns / 1ps

module adder_4_bit_tb();

    //inputs
    reg[3:0] a,b;
    reg c_in;
    
    //outputs
    wire c_out;
    wire[3:0]   sum;
    reg[3:0] expected_val;
    
    //Instantiate 64 bit adder
    four_bit_adder a1(.a(a), .b(b), .sum(sum), .c_in(c_in), .c_out(c_out));
    
    //changing values every 10ns
    initial
        begin
            // Check Min signed + max signed
            #10 a=-4'd8; b=4'd7; c_in=0;
            expected_val = a+b+c_in;
            
            // Checking random addition w/both positive
            #10 a=4'd3;b=4'd10;c_in=1;
            expected_val = a+b+c_in;
            
            // Checking random addition w/one negative, one positive
            #10 a=-4'd9;b=4'd2;c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with carry in
            #10 a=4'd15 ; b=4'd15; c_in=1;
            expected_val = a+b+c_in;
            
            // Testing adding 2 max values with no carry in
            #10 a=4'd15; b=4'd15; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with no carry in
            #10 a=-4'd8; b=-4'd8; c_in=0;
            expected_val = a+b+c_in;
            
            // Testing adding 2 min values with carry in
            #10 a=4'd8; b=-4'd8; c_in=1;
            expected_val = a+b+c_in;
            
            
            #10 $finish;
        end
endmodule
