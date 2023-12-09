`timescale 1ns / 1ps

module immediate_generator_tb();

    // I/O
    reg [31:0] in;
    wire [63:0] out;
    reg [63:0] expected_out;

    // Instantiate imm gen
    immediate_generator I1(.in(in), .out(out));

    // Changes values every 10ns
    initial
        begin

            // Test Load Instruction
            #10 in = 32'b00111100100011100101001010000011;
            expected_out = $signed(in[31:20]);

            // Test Branch Instruction
            #10 in = 32'b00111000100011100000001011100111;
            expected_out = $signed(in[31:20]);

            // Test Store Instruction imm = in[31:25] + in[11:7]
            #10 in = 32'b00111101100011100101001010100011;
            expected_out = $signed({in[31:25] , in[11:7]});

            #10 $finish;
        end


endmodule:  immediate_generator_tb