// multiplier module
// Accepts 64-bit inputs with 128-bit output
module multiplier(mcand, b, prod);

    // I/O
    input [63:0]mcand;
    input wire [63:0]b;
    output reg [127:0]prod;

    // Vars
    wire ovf;
    wire c_in = 0;
    wire [63:0]sum;
    integer i;        

    // Execute every time input values (mcand or b) are changed
    always @(mcand or b) begin

        // Place b in right half of product
        prod = {64'h0000000000000000, b};
                
        // Execute 64 times
        for(i = 0; i < 64; i = i + 1) begin

            // If LSB is 1, add left half of product and mcand and store in left half of product
            if(prod[0] == 1'b1) begin
                prod[127:64] = prod[127:64]+mcand;
            end

            // Bit shift product right 1
            prod = prod >> 1;
        end
    end

endmodule   :multiplier