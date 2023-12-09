`timescale 1ns / 1ps

module registers_tb();

    // I/O
    reg [4:0] read_register_1, read_register_2, write_register;
    reg [63:0] write_data;
    reg clk, reg_write;
    wire [63:0] read_data_1, read_data_2;
    
    //Instantiate mux
    registers r1(.read_register_1(read_register_1), .read_register_2(read_register_2), .write_register(write_register), .write_data(write_data), .clk(clk), .reg_write(reg_write), .read_data_1(read_data_1), .read_data_2(read_data_2));
    
    //changing values every 10ns
    initial
    begin

        reg_write = 1;

        for (integer i = 0; i < 32; i = i + 1) begin
            #10 clk = 0;
            read_register_1 <= i;
            read_register_2 <= i + 1;
            write_register <= i + 1;
            #10 write_data = read_data_1 + 1;
            clk = 1;

        end

        reg_write = 0;
        clk = 0;

        #10 $finish;
        
    end
endmodule