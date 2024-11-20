module RiscVCPU(
    input clk,
    input reset
);
    // 内部信号定义
    wire [31:0] pc, instruction, read_data1, read_data2, alu_result, mem_data;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire [3:0] ALUControl; // 新增 ALUControl 信号
    wire [1:0] ALUOp;
    wire mem_read, mem_write, reg_write, branch, Zero;

    // 模块实例化
    InstructionFetch IF (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    InstructionDecode ID (
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode)
    );

    RegisterFile RF (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(rs1),
        .read_reg2(rs2),
        .write_reg(rd),
        .write_data(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ControlUnit CU (
        .opcode(opcode),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .reg_write(reg_write),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl) // 新增连接
    );

    ALU ALU (
        .A(read_data1),
        .B(read_data2),
        .ALUControl(ALUControl), // 使用 ControlUnit 生成的 ALUControl
        .Result(alu_result),
        .Zero(Zero)
    );

endmodule