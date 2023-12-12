// Program counter module
module program_counter(addr, new_addr, clk);

    // I/O
    input [31:0]new_addr;
    output reg [31:0]addr;
    input wire clk;

    // Start at 0 when instantiated
    initial begin
        addr = 32'b00000000000000000000000000000000;
    end

    // Update program counter on negedge
    always @ (negedge clk)
        begin
            // Update output address with new address (Incremented or result of branch)
            addr = new_addr;
        end

endmodule   :program_counter