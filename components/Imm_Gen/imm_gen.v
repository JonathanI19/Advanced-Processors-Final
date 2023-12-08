module immediate_generator(in, out);
    input [31:0] in;
    output reg [63:0] out;

    always @ *
        begin
            // Looks at opcode, based off of risc-v encoding and Ch4 slide 18, slide 25
            // Provides sign extended output based off of the input immediate (left most 12 bits)
            // Also used https://five-embeddev.com/riscv-isa-manual/latest/instr-table.html 
            // Utilized by I-Type, S-Type, B-Type, J-Type, and U-Type
            case(in[6:0])
                // I-Type sign extensions
                7'b0000011: out = $signed(in[31:20]); // lb, lh, lw, lbu, lhu
                7'b0010011: out = $signed(in[31:20]); // addi, slli, xori, srli, srai, ori, andi

                7'b1100111: // Opcode for JALR if func3 is 000
                begin
                    if (in[14:12] == 3'b000)
                        out = $signed(in[31:20]);
                        
                    // SB-Type sign extensions
                    else 
                        out = $signed({in[31], in[7], in[30:25], in[11:8], 1'b0}); // beq, bne, blt, bge, bltu, bgeu
                end
                
                // S-Type sign extensions
                7'b0100011: out = $signed({in[31:25], in[11:7]}); //sb, sh, sw

                // U-Type sign extensions
                7'b0110111: out = $signed(in[31:12]); // lui

                // UJ-Type sign extensions
                7'b1101111: out = $signed({in[31], in[19:12], in[20], in[30:21], 1'b0}); // jal

            endcase
        end

endmodule   :immediate_generator