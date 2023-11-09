`timescale 1ns / 1ps

module mux_tb();

    //inputs
    reg [63:0]a,b;
    reg sig;
    
    //outputs
    wire [63:0]out;
    
    //Instantiate mux
    mux m1(.in_0(a), .in_1(b), .sig(sig), .out(out));
    
    //changing values every 10ns
    initial
        begin
            a = 64'h0000000000000000;
            b = 64'hffffffffffffffff;

            #10 sig = 0;

            #10 sig = 1;
            
            #10 $finish;
        end
endmodule

