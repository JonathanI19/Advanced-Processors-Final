// mux module
module mux(in_0, in_1, sig, out);

    // I/O
    input sig;
    input [63:0]in_0, in_1;
    output reg [63:0]out;

    always @ *
        begin
            if (sig == 0) begin
                out = in_0;
            end else if (sig == 1) begin
                out = in_1;
            end
        end

endmodule   :sixty_four_bit_adder