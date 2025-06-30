`timescale 1ns / 1ps

module ProgramCounter (
    input clk, reset, Branch,
    input [15:0] branch_target,
    output reg [15:0] pc
    );

    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 16'b0;
        else if (Branch) pc <= branch_target;
        else pc <= pc + 16'b1;
    end
endmodule