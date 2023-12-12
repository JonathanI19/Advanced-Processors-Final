`timescale 1ns / 1ps

module data_memory_tb();

    //inputs
    reg [63:0] address;
    reg mem_write, mem_read, clk;
    wire [31:0] read_data; 
    reg [31:0] write_data;
    
    
    //Instantiate mux
    data_memory dm(.address(address), .mem_write(mem_write), .mem_read(mem_read), .clk(clk), .read_data(read_data), .write_data(write_data));
    
    //changing values every 10ns
    initial
    begin


        mem_read <= 0;
        mem_write <= 1;
        write_data <= 32'd12345;
        clk <= 1'b1;
        // Test writing to data memory
        #10 address = 32'd7;       
        #10 clk = 1'b0;

        #10 mem_read <= 1;
        mem_write <= 0;

        // Test to see if preloaded vars are loaded correctly as well as newly written data
        for (integer i = 0; i < 8; i = i + 1) begin
            #10 clk = 1;
            address = i;
            #10 clk = 0; 
        end

        #10 $finish;

    end
endmodule