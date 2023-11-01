`timescale 1ns / 1ps

module divider_tb();

    //inputs
    reg[63:0] a,b;
    
    //outputs
    wire[63:0] r, quo;
    
    // Additional vars
    reg[63:0] expected_rem, expected_quo;

    //Instantiate divider
    divider d0(.a(a), .div(b), .r(r), .quo(quo));
    
    
    
    //changing values every 10ns
    initial
        begin

            #10 a=64'd8; b=64'd2;
            expected_quo = a/b;
            expected_rem = a%b;

            #10 a=64'd9; b=64'd2;
            expected_quo = a/b;
            expected_rem = a%b;

            #10 a=64'd42398284; b=64'd54389;
            expected_quo = a/b;
            expected_rem = a%b;

            #10 a=64'd34224; b=64'd789799;
            expected_quo = a/b;
            expected_rem = a%b;
 
            
            #10 $finish;
        end
endmodule