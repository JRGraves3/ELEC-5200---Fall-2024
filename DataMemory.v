`timescale 1ns / 1ps

module DataMemory (
    input clk, MemRead, MemWrite,
    input [15:0] address, write_data,
    output reg [15:0] read_data
    );
    
    reg [15:0] memory [0:255];
    
    /*always @(*) begin
        $readmemb("Data_Memory.mem", memory, 0, 63);
    end*/
    
    always @(posedge clk) begin
        if (MemWrite) memory[address[7:0]] <= write_data;
        if (MemRead) read_data = memory[address[7:0]];
        else read_data = 16'b0;
    end
    
    /* initial begin
        memory[0] = 16'hAAAA;
        memory[1] = 16'hBBBB;
    end */
endmodule