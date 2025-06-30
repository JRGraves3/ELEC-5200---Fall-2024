`timescale 1ns / 1ps

module InstructionMemory (
    input [15:0] pc,
    output reg [15:0] instruction
    );
    
    reg [15:0] memory [0:63];
    
    initial begin
        $readmemb("Instruction_Memory.mem", memory, 0, 63);
    end
    
    always @(*) begin
        // instruction = memory[address >> 1];
        instruction = memory[pc[7:0]];
    end
    
    /* initial begin
        memory[0] = 16'h0000;
        memory[1] = 16'h0001;
        memory[2] = 16'h0002;
        memory[3] = 16'h0003;
        memory[4] = 16'h0004;
        memory[5] = 16'h0005;
    end */
endmodule