module half_adder(a, b, sum, c_out);
    input a, b;
    output sum, c_out;

    assign sum = a ^ b;
    assign c_out = a & b;

endmodule   :half_adder


module full_adder(a, b, c_in, sum, c_out);
    input a, b, c_in;
    output sum, c_out;
    wire w1, w2, w3;

    half_adder h1(.a(a), .b(b), .sum(w1), .c_out(w2));
    half_adder h2(.a(c_in), .b(w1), .sum(sum), .c_out(w3));

    assign c_out = w2 | w3;

endmodule   :full_adder


module four_bit_adder(a, b, c_in, sum, c_out);
    input c_in;
    input [3:0]a, b;
    output [3:0] sum;
    output c_out;
    wire w1, w2, w3;

    full_adder a0(.a(a[0]), .b(b[0]), .c_in(c_in), .c_out(w1), .sum(sum[0]));
    full_adder a1(.a(a[1]), .b(b[1]), .c_in(w1), .c_out(w2), .sum(sum[1]));
    full_adder a2(.a(a[2]), .b(b[2]), .c_in(w2), .c_out(w3), .sum(sum[2]));
    full_adder a3(.a(a[3]), .b(b[3]), .c_in(w3), .c_out(c_out), .sum(sum[3]));

endmodule   :four_bit_adder


module sixteen_bit_adder(a, b, c_in, sum, c_out);
    input c_in;
    input [15:0]a, b;
    output [15:0]sum;
    output c_out;
    wire w1, w2, w3;

    four_bit_adder f0(.a[3:0](a[3:0]), .b[3:0](b[3:0]), .c_in(c_in), .c_out(w1), .sum[3:0](sum[3:0]));
    four_bit_adder f1(.a[3:0](a[7:4]), .b[3:0](b[7:4]), .c_in(w1), .c_out(w2), .sum[3:0](sum[7:4]));
    four_bit_adder f2(.a[3:0](a[11:8]), .b[3:0](b[11:8]), .c_in(w2), .c_out(w3), .sum[3:0](sum[11:8]));
    four_bit_adder f3(.a[3:0](a[15:12]), .b[3:0](b[15:12]), .c_in(w3), .c_out(c_out), .sum[3:0](sum[15:12]));

endmodule   :sixteen_bit_adder


module thirty_two_bit_adder(a, b, c_in, sum, c_out);
    input c_in;
    input [31:0]a, b;
    output [31:0]sum;
    output c_out;
    wire w1;

    sixteen_bit_adder s0(.a[15:0](a[15:0]), .b[15:0](b[15:0]), .c_in(c_in), .c_out(w1), .sum[15:0](sum[15:0]));
    sixteen_bit_adder s1(.a[15:0](a[31:16]), .b[15:0](b[31:16]), .c_in(w1), .c_out(c_out), .sum[15:0](sum[31:16]));

endmodule   :thirty_two_bit_adder


module sixty_four_bit_adder(a, b, c_in, sum, c_out);
    input c_in;
    input [63:0]a, b;
    output [63:0]sum;
    wire w1,w2;

    thirty_two_bit_adder t0(.a[31:0](a[31:0]), .b[31:0](b[31:0]), .c_in(c_in), .c_out(w1), .sum[31:0](sum[31:0]));
    thirty_two_bit_adder t1(.a[31:0](a[63:32]), .b[31:0](b[63:32]), .c_in(w1), .c_out(w2), .sum[31:0](sum[63:32]));

endmodule   :sixty_four_bit_adder