`timescale 1ns / 1ps

module InstructionFetch_tb;

    // Inputs to the module
    reg clk;
    reg reset;
    reg [31:0] next_pc;

    // Outputs from the module
    wire [31:0] pc;

    // Instantiate the Instruction Fetch module
    InstructionFetch IF (
        .clk(clk),
        .reset(reset),
        //.next_pc(next_pc),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period (50 MHz)
    end

    // Test procedure
    initial begin
        // Monitor output
        $monitor("Time = %0t | Reset = %b | Next PC = %h | PC = %h", $time, reset, next_pc, pc);

        // Apply initial reset and check behavior
        reset = 1;
        next_pc = 32'h00000000;  // Initial PC value
        #10;  // Wait for reset to propagate

        // Release reset and check initial PC behavior
        reset = 0;
        #10;
        next_pc = 32'h00000004;  // Simulate PC incrementing by 4 (for 32-bit instructions)

        // Wait for some clock cycles and observe PC updates
        #10;
        next_pc = 32'h00000008;  // Increment again
        #10;
        next_pc = 32'h0000000C;  // Increment again

        // Apply another reset to check behavior during reset
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Test branching or non-sequential PC update
        #10;
        next_pc = 32'h00000100;  // Simulate jump to address 0x100
        #10;

        // Stop the simulation
        #100;
        $stop;
    end
endmodule
