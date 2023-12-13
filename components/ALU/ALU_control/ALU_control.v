module ALU_control(ALU_op, instruction, ALU_out);

    // I/O

    input [1:0] ALU_op;

    // Func7, Func3
    input [9:0] instruction;
    
    // Controls ALU unit
    // 4'bxxxx - No Op
    // 4'b0010 - Addition
    // 4'b0110 - Subtraction
    // 4'b0011 - Division
    // 4'b0111 - Multiplication
    // 4'b0000 - AND
    // 4'b0001 - OR
    output reg [3:0] ALU_out;

    always @ * begin

        case (ALU_op)

            //  R-Type
            2'b10: begin

                case(instruction)

                    // Do Nothing
                    default:
                        ALU_out = 4'bxxxx;

                    // Addition
                    10'b0000000000:
                        ALU_out = 4'b0010;

                    // Subtraction
                    10'b0100000000:
                        ALU_out = 4'b0110;

                    // Division
                    10'b0000001100:
                        ALU_out = 4'b0011;

                    // Multiplication
                    10'b0000001000:
                        ALU_out = 4'b0111;

                    // AND
                    10'b0000000111:
                        ALU_out = 4'b0000;

                    // OR
                    10'b0000000110:
                        ALU_out = 4'b0001;

                endcase
            end

            // Load/Store
            2'b00: begin
                case(instruction[2:0])
                
                    // Do Nothing
                    default:
                        ALU_out = 3'b000;

                    // lw & sw
                    3'b010:
                        ALU_out = 3'b001;

                endcase
            end

            // Branch
            2'b01: begin
                case(instruction[2:0])

                    // Do Nothing
                    default:
                        ALU_out = 3'b000;

                    // beq
                    3'b000:
                        ALU_out = 3'b010;

                endcase
            end

            default:
                ALU_out = 3'b000;
        endcase
    end

endmodule:  ALU_control