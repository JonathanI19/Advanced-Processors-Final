module ALU_control(ALU_op, instruction, ALU_out);

    // I/O

    input [1:0] ALU_op;

    // Func7, Func3
    input [9:0] instruction;
    
    // Controls ALU unit
    // 3'b000 - No Op
    // 3'b001 - Addition
    // 3'b010 - Subtraction
    // 3'b100 - Division
    // 3'b011 - Multiplication
    // 3'b101 - AND
    // 3'b110 - OR
    output reg [2:0] ALU_out;

    always @ * begin

        case (ALU_op)

            //  R-Type
            2'b10: begin

                case(instruction)

                    // Do Nothing
                    default:
                        ALU_out = 3'b000;

                    // Addition
                    10'b0000000000:
                        ALU_out = 3'b001;

                    // Subtraction
                    10'b0100000000:
                        ALU_out = 3'b010;

                    // Division
                    10'b0000001100:
                        ALU_out = 3'b100;

                    // Multiplication
                    10'b0000001000:
                        ALU_out = 3'b011;

                    // AND
                    10'b0000000111:
                        ALU_out = 3'b101;

                    // OR
                    10'b0000000110:
                        ALU_out = 3'b110;

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