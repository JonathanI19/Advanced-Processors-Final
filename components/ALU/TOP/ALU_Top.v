module ALU_Top(input_1, input_2, result, zero, ALU_ctrl, ovf, remainder);

    // I/O
    input [63:0] input_1, input_2;
    input [3:0] ALU_ctrl;
    output wire ovf;
    output wire [63:0] remainder;
    output reg zero;
    output reg [63:0] result;

    // Store results of each module
    wire [63:0] add_result, sub_result, mul_result, div_result, and_result, or_result;

    // Instantiate each ALU module
        sixty_four_bit_adder ALU_add(.a(input_1), .b(input_2), .c_in(1'b0), .sum(add_result), .ovf(ovf));
        subtractor ALU_sub(.a(input_1), .b(input_2), .dif(sub_result), .ovf(ovf));
        multiplier ALU_mul(.a(input_1), .b(input_2), .prod(mul_result), .ovf(ovf));
        divider ALU_div(.a(input_1), .b(input_2), .quo(div_result), .ovf(ovf), .r(remainder));
        AND ALU_and(.a(input_1), .b(input_2), .result(and_result));
        OR ALU_or(.a(input_1), .b(input_2), .result(or_result));

    always @ * begin
        
        // Switch statement for opcode
        case(ALU_ctrl)

            // No Operation
            default: begin
                result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; 
            end

            // Addition
            4'b0010: begin
                result = add_result;
            end

            // Subtraction/branch
            4'b0110: begin
                result = sub_result;
            end

            // Division
            4'b0011: begin
                result = div_result;
            end

            // Multiplication
            4'b0111: begin
                result = mul_result;
            end

            // AND
            4'b0000: begin
                result = and_result;
            end

            // OR
            4'b0001: begin
                result = or_result;
            end

        endcase

        // Outputs 1 if result is 0, otherwise 1
        zero = ~| result;

    end

endmodule:  ALU_Top