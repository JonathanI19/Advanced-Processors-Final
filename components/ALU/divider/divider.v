// divisor module
// Accepts 64-bit inputs with 64-bit output
module divider(a, div, r, quo);

    // I/O
    input [63:0]a, div;
    output reg [63:0]r, quo;
    
    // reg and wire declarations
    reg [127:0] rem;
    integer i;


    // Execute every time input values (a or div) are changed
    always @(a or div) begin

        // Place a in right half of rem
        rem = {64'h0000000000000000, a};

        // Start by shifting rem left 1 bit
        rem = rem << 1;              

        // Execute 64 times
        for(i = 0; i < 64; i = i + 1) begin
                
            // Subtract div from left half of rem and store in left half of rem
            rem[127:64] = rem[127:64] - div;

            // Check if rem is positive
            if(rem[127] == 1'b0) begin

                // Shift right and add 1
                rem = rem << 1;
                rem = rem + 1'b1;
            end
            else if (rem[127] == 1'b1) begin

                // Restore original value to left half of rem
                rem[127:64] = rem[127:64] + div;

                // Shift rem to left with new bit being 0
                rem = rem << 1;
            end
        end

        // Store left half of rem in r
        r = rem[127:64];

        // Shift r left 1 bit
        r = r << 1;

        // Store right half of rem in quo
        quo = rem[63:0];

    end

endmodule   :divider