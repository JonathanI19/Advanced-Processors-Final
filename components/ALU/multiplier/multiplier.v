// multiplier module
// Accepts 64-bit inputs with 128-bit output
module multiplier(a, b, prod, ovf);

    // I/O
    input [63:0]a, b;
    output reg [127:0]prod;
    output reg ovf;

    // Vars
    wire c_in = 0;
    wire [63:0]sum;
    integer i, num_neg; 
    reg [63:0]mcand, b_temp;       

    // Execute every time input values (a or b) are changed
    always @(a or b) begin

        // Variable declarations
        num_neg = 0;
        mcand = a;
        b_temp = b;
        ovf = 0;
        
        // Performing twos complement as needed and counting num of negatives
        if (mcand[63] == 1) begin
            mcand = ~mcand + 1;
            num_neg = num_neg + 1;
        end
        if (b_temp[63] == 1) begin
            b_temp = ~b_temp + 1;
            num_neg = num_neg + 1;
        end
        
        // Place b in right half of product
        prod = {64'h0000000000000000, b_temp};
                
        // Execute 64 times
        for(i = 0; i < 64; i = i + 1) begin

            // If LSB is 1, add left half of product and mcand and store in left half of product
            if(prod[0] == 1'b1) begin
                prod[127:64] = prod[127:64]+mcand;
            end

            // Bit shift product right 1
            prod = prod >> 1;
        end
        
        // twos complement if result should be negative
        if (num_neg == 1) begin
            prod = ~prod + 1;
        end
        
        // Overflow handling
        if (((num_neg == 0 || num_neg == 2) && prod[127] == 1) || (num_neg == 1 && prod[127] == 0)) begin
            ovf = 1;
        end
        
    end

endmodule   :multiplier