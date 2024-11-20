`timescale 1ns / 1ps

module InstructionDecode_tb;

    // Testbench signals
    reg [31:0] instruction;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [6:0] opcode;

    // Instantiate the Instruction Decode module
    InstructionDecode ID (
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("Time = %0t | Instruction = %h | Opcode = %b | rs1 = %b | rs2 = %b | rd = %b", 
                 $time, instruction, opcode, rs1, rs2, rd);

        // Test R-type instruction: add x5, x10, x15 (binary: 0000000_01010_01111_000_00101_0110011)
        instruction = 32'b00000000101001111000001010110011; 
        #10;

        // Test I-type instruction: addi x5, x10, 0xFF (binary: 1111111_01010_00001_000_00101_0010011)
        instruction = 32'b11111110101000001000001010010011; 
        #10;

        // Test load instruction: lw x5, 0x20(x10) (binary: 0000000_01010_00001_010_00101_0000011)
        instruction = 32'b00000000101000001010001010000011; 
        #10;

        // Test branch instruction: beq x5, x10, offset (binary: 0000000_01010_00101_000_01010_1100011)
        instruction = 32'b00000000101000101000001010110011; 
        #10;

        // Test J-type instruction (e.g., jal)
        instruction = 32'b00000000000100000000000010101111; 
        #10;

        // Stop the simulation
        #50;
        $stop;
    end

endmodule
