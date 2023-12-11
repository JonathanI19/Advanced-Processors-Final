`timescale 1ns / 1ps

module ALU_control_tb();

    //inputs
    reg [1:0] ALU_op;
    reg [9:0] instruction;
    
    
    //Instantiate mux
    ALU_control A1(.instruction(instruction), .ALU_op(ALU_op), .ALU_out(ALU_out));
    
    //changing values every 10ns
    initial
    begin

        // Test various R-Type
        #10 ALU_op = 2'b10;

            // Nothing
            #10 instruction = 10'b1111111111;

            // Addition
            #10 instruction = 10'b0000000000;

            // Subtraction
            #10 instruction = 10'b0100000000;

            // Division
            #10 instruction = 10'b0000001100;

            // Multiplication
            #10 instruction = 10'b0000001000;

            // AND
            #10 instruction = 10'b0000000111;

            // OR
            #10 instruction = 10'b0000000110;

        // Test Load/Store
        #10 ALU_op = 2'b00;

            // Nothing
            #10 instruction = 10'b1111111111;

            // lw & sw
            #10 instruction = 10'b0000000001;

        // Test Branch
        #10 ALU_op = 2'b01;

            // Nothing
            #10 instruction = 10'b1111111111;

            // beq
            #10 instruction = 10'b0000000000;          

        // Test last ALU_op to verify it does nothing
        #10 ALU_op = 2'b11;

        #10 $finish;
    end
endmodule