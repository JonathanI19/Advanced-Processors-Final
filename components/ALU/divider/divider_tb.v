`timescale 1ns / 1ps

module divider_tb();

    //inputs
    reg[63:0] a,b;
    
    //outputs
    wire[63:0] r, quo;
    
    // Additional vars
    reg[63:0] expected_rem, expected_quo;
    wire ovf;
    

    //Instantiate divider
    divider d0(.a(a), .b(b), .r(r), .quo(quo), .ovf(ovf));
    
   
    
    //changing values every 10ns
    initial
        begin

            #10 a=64'd8; b=64'd2;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);

            #10 a=64'd9; b=64'd2;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);

            #10 a=64'd42398284; b=64'd54389;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);

            #10 a=64'd34224; b=64'd789799;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);
            
            #10 a=-64'd78443; b=64'd799;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);
                         
            #10 a=64'd34287624; b=-64'd75439;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);
            
            #10 a=-64'd534224; b=-64'd9799;
            expected_quo = $signed(a/b);
            expected_rem = $signed(a%b);
            
            #10 $finish;
        end
endmodule