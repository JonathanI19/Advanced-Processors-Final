module immediate_generator(in, out);
    input [31:0] in;
    output reg [63:0] out;

    always @ *
        begin
            // Looks at opcode, based off of risc-v encoding and Ch4 slide 18, slide 25
            // Provides sign extended output based off of the input immediate (left most 12 bits)
            // Also used https://five-embeddev.com/riscv-isa-manual/latest/instr-table.html 
            // Utilized by I-Type, S-Type, B-Type, J-Type, and U-Type
            // Only need lw, sw, and beq per project instructions
            case(in[6:0])

                // Load Instruction
                7'b0000011: out = $signed(in[31:20]);

                // Branch Instruction
                7'b1100111: out = $signed(in[31:20]);

                // Store Instruction
                7'b0100011: out = $signed({in[31:25], in[11:7]});
                
            endcase
        end

endmodule:  immediate_generator