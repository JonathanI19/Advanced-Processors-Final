// multiplier module
// Accepts 64-bit inputs with 128-bit output
module multiplier(mcand, b, prod);

    // I/O
    input [63:0]mcand, b;
    output reg [127:0]prod;

    // Vars
    wire ovf;
    assign wire c_in = 0;
    reg [63:0]sum;
    reg [63:0]a_in, b_in;

    // Storing b in right half of product
    prod[63:0] = b;

    sixty_four_bit_adder s0(.a(mcand), .b(prod[127:64]), .c_in(c_in), .sum(sum), .ovf(ovf));

    initial begin
        for(integer i = 0; i < 64; i = i + 1) begin
            if(prod[0] == 1)
                prod[127:64] = sum;
            prod >> 1;
        end
    end

endmodule   :multiplier