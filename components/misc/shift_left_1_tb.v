`timescale 1ns / 1ps

module shift_left_1_tb();

    //inputs
    reg [63:0] in;

    //outputs
    wire [63:0] out;
    
    //Instantiate mux
    shift_left_1 s1(.in(in), .out(out));
    
    //changing values every 10ns
    initial
        begin
            
            #10 in = 64'b000111111111001;

            #10 in = 64'b110101010011010;
            
            #10 $finish;
        end
endmodule

