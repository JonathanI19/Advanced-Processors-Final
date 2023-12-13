module Processor_Top();

    // Will be used to toggle our clock signal as needed
    reg clk;

    // Program Counter output wire
    wire [31:0] pc_out;

    // Instruction memory output wire
    wire [31:0] instruction_mem_out;

    // Control module output wires
    wire branch, mem_read, mem_reg, ALU_src, mem_write, reg_write;
    wire [1:0] ALU_op;

    // Immediate Generator Output Wire
    wire [63:0] imm_gen_out;

    // Register Output Wire
    wire [63:0] reg_data_1_out, reg_data_2_out;

    // ALU Control Output Wire
    wire [3:0] ALU_ctrl_out;

    // Mux Output Wires
    wire [63:0] mux_1_out, mux_2_out, mux_3_out;

    // Standalone Adder Output Wires
    wire [63:0] add_1_out, add_2_out;

    // Shift Left Output Wires
    wire [63:0] shift_left_out;

    // Data Memory Output Wires
    wire [31:0] data_mem_out;

    // ALU Output Wires
    wire [63:0] alu_out, remainder;
    wire zero;


    // Program Counter Instantiation
    program_counter PC(.new_addr(mux_3_out[31:0]), .clk(clk), .addr(pc_out));

    // Instruction Memory Instantiation
    instruction_memory IM(.address(pc_out), .instruction(instruction_mem_out));

    // Control Instantiation
    control C(.instruction(instruction_mem_out[6:0]), .branch(branch), .mem_read(mem_read), .mem_reg(mem_reg), .ALU_op(ALU_op), .mem_write(mem_write), .alu_src(ALU_src), .reg_write(reg_write));

    // Register Instantiation
    registers R(.clk(clk), .read_register_1(instruction_mem_out[19:15]), .read_register_2(instruction_mem_out[24:20]), .write_register(instruction_mem_out[11:7]), .write_data(mux_2_out), .reg_write(reg_write), .read_data_1(reg_data_1_out), .read_data_2(reg_data_2_out));

    // Imm Gen Instantiation
    immediate_generator IG(.in(instruction_mem_out), .out(imm_gen_out));

    // Shift Left Instantiation
    shift_left_1 s1(.in(imm_gen_out), .out(shift_left_out));

    // ALU Top Instantiation
    ALU_Top ALU(.input_1(reg_data_1_out), .input_2(mux_1_out), .ALU_ctrl(ALU_ctrl_out), .result(alu_out), .zero(zero), .remainder(remainder));

    // ALU Control Instantiation
    ALU_control AC(.ALU_op(ALU_op), .instruction({instruction_mem_out[31:25], instruction_mem_out[14:12]}), .ALU_out(ALU_ctrl_out));

    // Data Memory Instantiation
    data_memory DM(.address(alu_out), .write_data(reg_data_2_out[31:0]), .mem_write(mem_write), .mem_read(mem_read), .read_data(data_mem_out), .clk(clk));

    // Mux Instantiations
    mux M1(.in_0(reg_data_2_out), .in_1(imm_gen_out), .sig(ALU_src), .out(mux_1_out));
    mux M2(.in_0(alu_out), .in_1({32'h00000000, data_mem_out}), .sig(mem_reg), .out(mux_2_out));
    mux M3(.in_0(add_1_out), .in_1(add_2_out), .sig(zero & branch), .out(mux_3_out));

    // Standalone Adder Instantiations
    sixty_four_bit_adder A1(.a({32'h00000000, pc_out}), .b(64'd4), .c_in(1'b0), .sum(add_1_out));
    sixty_four_bit_adder A2(.a({32'h00000000, pc_out}), .b(shift_left_out), .c_in(1'b0), .sum(add_2_out));


    // Run Clock for 20 cycles
    initial begin
        // Delay at start
        #10;
        for(integer i = 0; i < 20; i = i + 1) begin
            #10 clk = 0;
            #10 clk = 1;

        end
    end

endmodule:  Processor_Top