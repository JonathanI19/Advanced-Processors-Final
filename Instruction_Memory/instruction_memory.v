module instruction_memory(address, instruction);

    // Input from program counter
    input [31:0] address;

    // Output instruction
    output reg [31:0] instruction;

    // Generate 5KB of memory
    reg [31:0] memory [0:1279];

    // At initialization, set all memory bits to 0
    initial begin
        for (integer i = 0; i < 1280; i = i + 1) begin
            // Set memory bits to 0
            memory[i] = 32'b00000000000000000000000000000000;
        end

        // Load program instructions into memory

        // lw
        memory[0] = 32'b000000000000 00000 010 00001 0000011; // $1 = a
        memory[1] = 32'b000000000001 00000 010 00010 0000011; // $2 = b 
        memory[2] = 32'b000000000010 00000 010 00011 0000011; // $3 = c
        memory[3] = 32'b000000000011 00000 010 00100 0000011; // $4 = d
        memory[4] = 32'b000000000100 00000 010 00101 0000011; // $5 = e
        memory[5] = 32'b000000000101 00000 010 00110 0000011; // $6 = f

        // mul
        memory[6] = 32'b0000001 00010 00001 000 00001 0110011; // $1 = $1 * $2
        memory[8] = 32'b0000001 00101 00100 000 00100 0110011; // $4 = $4 * $5

        // sub
        memory[7] = 32'b0100000 00100 00011 000 00100 0110011; // $4 = $4 - $3

        // add
        memory[9] = 32'b0000000 00100 00001 000 00001 0110011; // $1 = $4 + $1

        // div
        memory[10] = 32'b0000001 00110 00001 100 00001 0110011; // $1 = $1 / $6

        //sw
        memory[11] = 32'b0000101 00000 00001 001 00000 0100011; // Store $1 at memory address 160


    end




endmodule: instruction_memory