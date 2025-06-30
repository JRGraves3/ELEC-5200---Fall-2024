`timescale 1ns / 1ps

module RegisterFile (
    input clk, reset, RegWrite,
    input [3:0] read_reg1, read_reg2, write_reg,
    input [15:0] write_data,
    output [15:0] read_data1, read_data2
    );
    reg [15:0] registers [0:15];
    integer i;
    
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1) begin
                registers[i] <= 16'b0;
            end
        end else if (RegWrite) begin
            registers[write_reg] <= write_data;
        end
    end
endmodule