// 64 bit subtractor module
module subtractor(a, b, dif, ovf);

    // I/O
    input [63:0]a, b;
    output [63:0]dif;
    output reg ovf;

    assign reg c_in = 1;

    // Instantiating sixty_four_bit_adder module
    // Note that b is inverted and c_in will always be 1
    sixty_four_bit_adder s1(.a(b), .b(~b), .c_in(c_in), .sum(dif), .ovf(ovf));
    
endmodule   :subtractor