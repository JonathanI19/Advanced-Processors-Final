// 64 bit subtractor module
module subtractor(a, b, dif, ovf);

    // I/O
    input [63:0]a, b;
    output [63:0]dif;
    output ovf;
    wire c_in = 1'b0;
    
    // Perform twos complement operation
    wire[63:0] twos_comp = ~b + 1'b1;
    
    // Instantiating sixty_four_bit_adder module
    sixty_four_bit_adder s1(.a(a), .b(twos_comp), .c_in(c_in), .sum(dif), .ovf(ovf));
    
endmodule   :subtractor