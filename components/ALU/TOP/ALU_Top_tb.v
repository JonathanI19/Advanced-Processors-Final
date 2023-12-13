module ALU_TOP_tb();

    // I/O
    reg [63:0] input_1, input_2; 
    reg [3:0] ALU_ctrl;
    wire zero, ovf;
    wire [63:0] result;

    // Instantiate ALU Top
    ALU_Top A1(.input_1(input_1), .input_2(input_2), .ALU_ctrl(ALU_ctrl), .zero(zero), .result(result), .ovf(ovf));

    initial begin
        // Will use input of 6 (110) and 2 (010) for all operations
        input_1 <= 32'd6;
        input_2 <= 32'd2;

        // No Operation
        #10 ALU_ctrl = 4'b1111;
    
        // Addition
        #10 ALU_ctrl = 4'b0010;

        // Subtraction
        #10 ALU_ctrl = 4'b0110;

        // Multiplication
        #10 ALU_ctrl = 4'b0111;

        // Test No Operation after other ops have been performed
        #10 ALU_ctrl = 4'b1111;

        // Division
        #10 ALU_ctrl = 4'b0011;

        // AND
        #10 ALU_ctrl = 4'b0000;

        // OR
        #10 ALU_ctrl = 4'b0001;

        // Test 0 flag and signed addition
        #10 input_1 <= $signed(32'd2);
        input_2 <= $signed(-32'd2);
        ALU_ctrl = 4'b0010;

        #10 $finish;
    end

endmodule