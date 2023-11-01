`timescale 1ns / 1ps

module multiplier_tb();

    //inputs
    reg[63:0] a,b;
    
    //outputs
    wire[127:0] prod;
    wire ovf;
    // Additional vars
    reg[127:0] expected_val;

    //Instantiate multiplier
    multiplier m0(.a(a), .b(b), .prod(prod), .ovf(ovf));
    
    
    
    //changing values every 10ns
    initial
        begin

            #10 a=64'd345; b=64'd922;
            expected_val = a*b;
 
            #10 a=64'd3; b=64'd5;
            expected_val = a*b;

            #10 a=-64'd345; b=64'd22;
            expected_val = a*b;

            #10 a=-64'd345; b=-64'd22;
            expected_val = a*b;
            
            #10 a=64'hFFFFFFFFFFFFFFFF; b=64'hFFFFFFFFFFFFFFFF;
            expected_val = $signed(a*b);
            
            #10 a=64'd4567889; b=64'd23482390;
            expected_val = a*b;
            
            #10 $finish;
        end
endmodule