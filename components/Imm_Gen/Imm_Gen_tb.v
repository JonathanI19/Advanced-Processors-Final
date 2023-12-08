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

            // Test opcode 7'b0000011
            #10 in = 32'b00111100100011100101001010000011;
            expected_out = $signed(in[31:20]);
            //expected_out = 12'b 0011 1100 1000;

            // Test opcode 7'b0010011
            #10 in = 32'b00101100100011100101001010010011;
            expected_out = $signed(in[31:20]);
            //expected_out = 12'b 0011 1100 1000;

            // Test opcode 7'b1100111 with func 3 = 3'b000 in[14:12]
            #10 in = 32'b00111000100011100000001011100111;
            expected_out = $signed(in[31:20]);
            //expected_out = 12'b 0011 1100 1000;

            // Test opcode 7'b0100011 imm = in[31:25] + in[11:7]
            #10 in = 32'b00111101100011100101001010100011;
            expected_out = $signed({in[31:25] , in[11:7]});
            //expected_out = 12'b 0011 1100 0101;

            // Test opcode 7'b1100111 imm = in[31] + in[7] + in[30:25] + in[11:8] + 1'b0
            #10 in = 32'bb01011011100011100101001011100111;
            expected_out = $signed({in[31], in[7], in[30:25], in[11:8], 1'b0});
            
            // Test opcode 7'b0110111 imm = in[31:12]
            #10 in = 32'bb01011011100111010101001010110111;
            expected_out = $signed(in[31:12]);

            // Test opcode 7'b1101111 imm = in[31] + in[19:12] + in[20] + in[30:21] + 1'b0
            #10 in = 32'bb11011000100011100101001011101111;
            expected_out = $signed({in[31], in[19:12], in[20], in[30:21], 1'b0});
            
            #10 $finish;
        end


endmodule:  immediate_generator_tb