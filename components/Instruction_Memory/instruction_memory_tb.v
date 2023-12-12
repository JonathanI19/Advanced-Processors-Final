`timescale 1ns / 1ps

module instruction_memory_tb();

    // I/O
    reg [31:0] address;
    wire [31:0] instruction;

    // Instantiate instruction memory
    instruction_memory I1(.address(address), .instruction(instruction));

    // Changes values every 10ns
    initial
        begin
            
            for (integer i = 0; i <= 60; i = i + 4) begin
                #10 address = i;
            end

            #10 $finish;
        end


endmodule:  instruction_memory_tb