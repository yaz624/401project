`timescale 1ns / 1ps

module ControlUnit_tb;

    // Testbench signals
    reg [6:0] opcode;
    wire [1:0] ALUOp;
    wire reg_write;
    wire branch;
    wire mem_read;
    wire mem_write;

    // Instantiate the Control Unit module
    ControlUnit CU (
        .opcode(opcode),
        .ALUOp(ALUOp),
        .reg_write(reg_write),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    // Test procedure
    initial begin
        // Monitor output
        $monitor("Time = %0t | Opcode = %b | ALUOp = %b | reg_write = %b | branch = %b | mem_read = %b | mem_write = %b", 
                 $time, opcode, ALUOp, reg_write, branch, mem_read, mem_write);

        // Test case 1: R-type instruction (opcode = 0110011)
        opcode = 7'b0110011;  // R-type (e.g., add, sub)
        #10;

        // Test case 2: I-type instruction (opcode = 0010011)
        opcode = 7'b0010011;  // I-type (e.g., addi)
        #10;

        // Test case 3: Load instruction (opcode = 0000011)
        opcode = 7'b0000011;  // Load (e.g., lw)
        #10;

        // Test case 4: Store instruction (opcode = 0100011)
        opcode = 7'b0100011;  // Store (e.g., sw)
        #10;

        // Test case 5: Branch instruction (opcode = 1100011)
        opcode = 7'b1100011;  // Branch (e.g., beq)
        #10;

        // Test case 6: Jump instruction (opcode = 1101111)
        opcode = 7'b1101111;  // JAL (jump and link)
        #10;

        // Test case 7: U-type instruction (opcode = 0010111)
        opcode = 7'b0010111;  // AUIPC (Add Upper Immediate to PC)
        #10;

        // Test case 8: Default/unknown opcode
        opcode = 7'b1111111;  // Unknown opcode (test default handling)
        #10;

        // Stop the simulation
        #50;
        $stop;
    end

endmodule
