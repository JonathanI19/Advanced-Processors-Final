// Program counter module
module program_counter(in, out);

    // I/O
    input reg [63:0]in;
    output wire [63:0]out;

    initial begin
        in = 0;
    end

    // Increment every time input changes
    always @ (in)
        begin
            out = in;
        end

endmodule   :program_counter