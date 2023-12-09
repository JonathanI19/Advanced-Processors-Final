module registers(clk, read_register_1, read_register_2, write_register, write_data, read_data_1, read_data_2, reg_write);

    // I/O
    input [4:0] read_register_1, read_register_2, write_register;
    input [63:0] write_data;
    input clk, reg_write;
    output reg [63:0] read_data_1, read_data_2;

    // Declaring 32 32-bit registers
    reg [31:0] r [0:31];

    // Set all registers to 0 at module initialization
    initial begin
        for (integer i = 0; i < 32; i = i + 1) begin
            r[i] = 32'b00000000000000000000000000000000;
        end
    end

    // Always block that executes when new indexes are passed in via read_register1/2
    always @(read_register_1, read_register_2) begin

        // Assign read_data_1/2 in parallel and ensure that they are treated as signed values
        read_data_1 <= $signed(r[read_register_1]);
        read_data_2 <= $signed(r[read_register_2]);

    end

    // On rising edge, check if we need to write to a register
    always @(posedge clk) begin

        // Check if write control signal is present
        if (reg_write == 1) begin

            // Write data to register
            r[write_register] = write_data;

        end

    end


endmodule: registers