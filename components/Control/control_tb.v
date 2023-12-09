`timescale 1ns / 1ps

module control_tb();

    //inputs
    reg [6:0] in;
    wire branch, mem_read, mem_reg, mem_write, alu_src, reg_write;
    wire [1:0] ALU_op;
    
    
    //Instantiate mux
    control c1(.instruction(in), .branch(branch), .mem_read(mem_read), .mem_reg(mem_reg), .mem_write(mem_write), .alu_src(alu_src), .reg_write(reg_write), .ALU_op(ALU_op));
    
    //changing values every 10ns
    initial
    begin

        #10 in = 32'b0110011;
        #10 in = 32'b0000011;
        #10 in = 32'b0100011;
        #10 in = 32'b1100011;
    
        #10 $finish;
    end
endmodule