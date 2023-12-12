module data_memory(address, write_data, mem_write, mem_read, read_data, clk);

    // I/O
    input [63:0] address;
    input mem_write, mem_read, clk;
    output reg [31:0] read_data; 
    input [31:0] write_data;

   
    // Generate 5KB of memory
    reg [31:0] memory [0:1279];

    // At initialization, set all memory bits to 0
    initial begin
        for (integer i = 0; i < 1280; i = i + 1) begin
            // Set memory bits to 0
            memory[i] = 32'b00000000000000000000000000000000;
        end

        // Load variables from prompt
        memory[0] = $signed(32'd1000);  // a = 1000
        memory[1] = $signed(32'd200);   // b = 200
        memory[2] = $signed(32'd300);   // c = 300
        memory[3] = $signed(32'd500);   // d = 500
        memory[4] = $signed(-32'd1500); // e = -1500
        memory[5] = $signed(32'd3);     // f = 3

    end

    // Execute on neg edge not pos edge (Needs time for operations to occur)
    always @(negedge clk) begin

        // If mem_write control signal received, write input
        // data to specified address
        if (mem_write == 1'b1) begin
            memory[address] = write_data;
        end

        // If mem_read control signal received, output
        // data located at specified address
        if (mem_read == 1'b1) begin
            read_data = memory[address];
        end

    end



endmodule: data_memory