// AND module
module AND(a, b, result);

    // I/O
    input [63:0]a, b;
    output wire [63:0]result;

    assign result = a & b;

endmodule   :AND

// OR module
module OR(a, b, result);

    // I/O
    input [63:0]a, b;
    output wire [63:0]result;

    assign result = a | b;

endmodule   :OR