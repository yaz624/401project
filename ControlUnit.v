module ControlUnit(
    input [6:0] opcode,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg reg_write,
    output reg [3:0] ALUControl,
    output reg [1:0] ALUOp
);
    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-Type (ADD, SUB, etc.)
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                reg_write = 1;
                ALUOp = 2'b10; // R-Type运算
            end
            7'b0000011: begin // Load (LW)
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                reg_write = 1;
                ALUOp = 2'b00; // Load使用加法计算地址
            end
            7'b0100011: begin // Store (SW)
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                reg_write = 0;
                ALUOp = 2'b00; // Store使用加法计算地址
            end
            7'b1100011: begin // Branch (BEQ)
                mem_read = 0;
                mem_write = 0;
                branch = 1;
                reg_write = 0;
                ALUOp = 2'b01; // 分支需要比较操作
            end
            default: begin
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                reg_write = 0;
                ALUOp = 2'b00;
            end
        endcase
    end
endmodule