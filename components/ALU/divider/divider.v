// divisor module
// Accepts 64-bit inputs with 64-bit output
module divider(a, b, r, quo, ovf);

    // I/O
    input [63:0]a, b;
    output reg [63:0]r, quo;
    output reg ovf;
    
    // reg and wire declarations
    reg [127:0] rem;
    integer i;
    integer num_neg;
    reg [63:0]div, a_temp;

    // Execute every time input values (a or b) are changed
    always @(a or b) begin

        // Variable declarations
        div = b;
        a_temp = a;
        num_neg = 0;
        ovf = 0;

        // Performing twos complement as needed and counting num of negatives
        if (div[63] == 1) begin
            div = ~div + 1;
            num_neg = num_neg + 1;
        end
        if (a_temp[63] == 1) begin
            a_temp = ~a_temp + 1;
            num_neg = num_neg + 1;
        end


        // Place a in right half of rem
        rem = {64'h0000000000000000, a_temp};

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

                // Restore original value to left half of rem and shift left
                rem[127:64] = rem[127:64] + div;
                rem = rem << 1;
            end
        end


        // Store left half of rem in r and shift left 1
        r = rem[127:64];
        r = r << 1;

        // Store right half of rem in quo
        quo = rem[63:0];

        // twos complement if result should be negative
        if (num_neg == 1) begin
            r = ~r + 1;
            quo = ~quo + 1;
        end

        // Overflow handling
        if (((num_neg == 0 || num_neg == 2) && quo[127] == 1) || (num_neg == 1 && quo[127] == 0)) begin
            ovf = 1;
        end

    end

endmodule   :divider