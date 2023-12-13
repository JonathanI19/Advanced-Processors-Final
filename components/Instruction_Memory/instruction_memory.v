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
        memory[0] = 32'b00000000000000000010000010000011; // $1 = a
        memory[1] = 32'b00000000000100000010000100000011; // $2 = b 
        memory[2] = 32'b00000000001000000010000110000011; // $3 = c
        memory[3] = 32'b00000000001100000010001000000011; // $4 = d
        memory[4] = 32'b00000000010000000010001010000011; // $5 = e
        memory[5] = 32'b00000000010100000010001100000011; // $6 = f

        // mul
        memory[6] = 32'b00000010001000001000000010110011; // $1 = $1 * $2
        memory[8] = 32'b00000010010100100000001000110011; // $4 = $4 * $5

        // sub
        memory[7] = 32'b01000000001100100000001000110011; // $4 = $4 - $3

        // add
        memory[9] = 32'b00000000010000001000000010110011; // $1 = $4 + $1

        // div
        memory[10] = 32'b00000010011000001100000010110011; // $1 = $1 / $6

        //sw
        memory[11] = 32'b00001010000100000001000000100011; // Store $1 at memory address 160

    end

    always @ * begin

        // Output instruction every time memory changes
        // Bit shift 2 ensures that standard PC increment of 4 still works
        // despite not using individually addressable bytes in 
        // instruction memory. 
        instruction = memory[address>>2];

    end



endmodule: instruction_memory