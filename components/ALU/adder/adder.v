// Half adder module
module half_adder(a, b, sum, c_out);
    
    // I/O
    input a, b;
    output sum, c_out;

    // Logic to perform addition
    assign sum = a ^ b;
    assign c_out = a & b;

endmodule   :half_adder

// Full adder module
module full_adder(a, b, c_in, sum, c_out);
    
    // I/O
    input a, b, c_in;
    output sum, c_out;
    wire w1, w2, w3;

    // Instantiating 2 x half_adder modules
    half_adder h1(.a(a), .b(b), .sum(w1), .c_out(w2));
    half_adder h2(.a(c_in), .b(w1), .sum(sum), .c_out(w3));

    // Determining c_out
    assign c_out = w2 | w3;

endmodule   :full_adder

// Four bit adder module
module four_bit_adder(a, b, c_in, sum, c_out);
    
    // I/O
    input c_in;
    input [3:0]a, b;
    output [3:0] sum;
    output c_out;
    wire w1, w2, w3;

    // Instantiating 4 x full_adder modules
    full_adder a0(.a(a[0]), .b(b[0]), .c_in(c_in), .c_out(w1), .sum(sum[0]));
    full_adder a1(.a(a[1]), .b(b[1]), .c_in(w1), .c_out(w2), .sum(sum[1]));
    full_adder a2(.a(a[2]), .b(b[2]), .c_in(w2), .c_out(w3), .sum(sum[2]));
    full_adder a3(.a(a[3]), .b(b[3]), .c_in(w3), .c_out(c_out), .sum(sum[3]));

endmodule   :four_bit_adder

// 16 bit adder module
module sixteen_bit_adder(a, b, c_in, sum, c_out);

    // I/O
    input c_in;
    input [15:0]a, b;
    output [15:0]sum;
    output c_out;
    wire w1, w2, w3;

    // Instantiating 4 x four_bit_adder modules
    four_bit_adder f0(.a(a[3:0]), .b(b[3:0]), .c_in(c_in), .c_out(w1), .sum(sum[3:0]));
    four_bit_adder f1(.a(a[7:4]), .b(b[7:4]), .c_in(w1), .c_out(w2), .sum(sum[7:4]));
    four_bit_adder f2(.a(a[11:8]), .b(b[11:8]), .c_in(w2), .c_out(w3), .sum(sum[11:8]));
    four_bit_adder f3(.a(a[15:12]), .b(b[15:12]), .c_in(w3), .c_out(c_out), .sum(sum[15:12]));

endmodule   :sixteen_bit_adder

// 32 bit adder module
module thirty_two_bit_adder(a, b, c_in, sum, c_out);

    // I/O
    input c_in;
    input [31:0]a, b;
    output [31:0]sum;
    output c_out;
    wire w1;

    // Instantiating 2 x sixteen_bit_adder modules
    sixteen_bit_adder s0(.a(a[15:0]), .b(b[15:0]), .c_in(c_in), .c_out(w1), .sum(sum[15:0]));
    sixteen_bit_adder s1(.a(a[31:16]), .b(b[31:16]), .c_in(w1), .c_out(c_out), .sum(sum[31:16]));

endmodule   :thirty_two_bit_adder

// 64 bit adder module
module sixty_four_bit_adder(a, b, c_in, sum, ovf);

    // I/O
    input c_in;
    input [63:0]a, b;
    output [63:0]sum;
    wire w1,c_out;
    output reg ovf;

    // Instantiating 2 x thirty_two_bit_adder modules
    thirty_two_bit_adder t0(.a(a[31:0]), .b(b[31:0]), .c_in(c_in), .c_out(w1), .sum(sum[31:0]));
    thirty_two_bit_adder t1(.a(a[63:32]), .b(b[63:32]), .c_in(w1), .c_out(c_out), .sum(sum[63:32]));
    
    // Logic block to determine overflow bit
    // - Overflow if result sign is 1 when adding 2 positive operands
    // - Overflow if result sign is 0 when adding 2 negative operands
    // - Otherwise, no overflow
    always @ *
        begin
            if((a[63] == 0 && b[63] == 0 && sum[63] == 1) || (a[63] == 1 && b[63] == 1 && sum[63] == 0))
                ovf = 1;
            else 
                ovf = 0;
        end

endmodule   :sixty_four_bit_adder