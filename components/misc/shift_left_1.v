// shift left 1 module
module shift_left_1(in, out);

    // I/O
    input wire [63:0]in;
    output reg [63:0]out;

    always @ *
        begin
            out = in << 1;
        end

endmodule   :shift_left_1