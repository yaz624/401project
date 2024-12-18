module InstructionFetch(
    input clk,
    input reset,
    output reg [31:0] pc,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:31]; // 简单指令存储器

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc + 4; // 每次递增4字节
    end
    
    initial begin
    /*
    *   R-type：用于算术运算、逻辑运算等。
	•	I-type：用于立即数运算、数据传送等。
	•	S-type：用于存储操作（如 SW 指令）。
	•	B-type：用于分支跳转操作。
	•	U-type：用于大立即数加载操作。
	•	J-type：用于跳转指令。
    */
    memory[0] = 32'b0000000_00001_00010_000_00011_0110011; // R型指令: x3 = x1 + x2
    memory[1] = 32'b0000000_00011_00001_000_00100_0110011; // R型指令: x4 = x3 + x1
    memory[2] = 32'b0000000_00100_00011_000_00101_0110011; // R型指令: x5 = x4 + x3
    memory[3] = 32'b0000000_00101_00001_000_00110_0110011; // R型指令: x6 = x5 + x1
    memory[4] = 32'b0000000_00000_00000_000_00000_0110011; // 停止指令
end

    always @(*) begin
        instruction = memory[pc >> 2]; // 从指令存储器读取当前指令
    end
endmodule
