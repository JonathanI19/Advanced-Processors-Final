module instruction_memory(address, instruction);

    // Input from program counter
    input [31:0] address;

    // Output instruction
    output reg [31:0] instruction;

    // Generate 5KB of memory
    reg [7:0] memory [0:5119];

    // At initialization, set all memory bits to 0
    initial begin
        for (integer i = 0; i < 5120; i = i + 1) begin
            // Set memory bits to 0
            memory[i] = 8'b00000000;
        end

        // Load program instructions into memory

        // lw
        memory[3:0] = 32'b000000000000 00000 010 00001 0000011; // $1 = a
        memory[7:4] = 32'b000000000001 00000 010 00010 0000011; // $2 = b 
        memory[11:8] = 32'b000000000010 00000 010 00011 0000011; // $3 = c
        memory[15:12] = 32'b000000000011 00000 010 00100 0000011; // $4 = d
        memory[19:16] = 32'b000000000100 00000 010 00101 0000011; // $5 = e
        memory[23:20] = 32'b000000000101 00000 010 00110 0000011; // $6 = f

        // mul
        memory[27:24] = 32'b0000001 00010 00001 000 00001 0110011; // $1 = $1 * $2
        memory[35:32] = 32'b0000001 00101 00100 000 00100 0110011; // $4 = $4 * $5

        // sub
        memory[31:28] = 32'b0100000 00100 00011 000 00100 0110011; // $4 = $4 - $3

        // add
        memory[39:36] = 32'b0000000 00100 00001 000 00001 0110011; // $1 = $4 + $1

        // div
        memory[43:40] = 32'b0000001 00110 00001 100 00001 0110011; // $1 = $1 / $6

        //sw
        memory[47:44] = 32'b0000101 00000 00001 001 00000 0100011; // Store $1 at memory address 160

    end

    always @ * begin

        // Output instruction every time memory changes
        // Bit shifting 2 to the right allows us to account for the program
        // counter incrementing by 4, even though we haven't made the
        // instruction_memory byte addressable.
        instruction = memory[address>>2];

    end



endmodule: instruction_memory