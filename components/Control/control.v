module control(instruction, branch, mem_read, mem_reg, ALU_op, mem_write, alu_src, reg_write);

    // I/O
    input [6:0] instruction;
    output reg branch, mem_read, mem_reg, mem_write, alu_src, reg_write;
    output reg [1:0] ALU_op;

    // Stores data in format:
    // alu_src
    // mem_reg
    // reg_write
    // mem_read
    // mem_write
    // branch
    // ALU_op 2'b
    reg [7:0] container;

    always @ * begin
        
        // Switch statement for opcode
        case(instruction)

            // R-Type instructions
            7'b0110011: 
                container = 8'b00100010;
            
            // Load instruction
            7'b0000011:
                container = 8'b11110000;

            // Store instruction
            7'b0100011:
                container = 8'b1x001000;

            // BEQ instruction
            // May be 7'b1100011 - Conflicting info in canvas modules
            7'b1100011:
                container = 8'b0x000101;

        endcase

        alu_src = container[7];
        mem_reg = container[6];
        reg_write = container[5];
        mem_read = container[4];
        mem_write = container[3];
        branch = container[2];
        ALU_op[1:0] = container[1:0];

    end

endmodule:  control