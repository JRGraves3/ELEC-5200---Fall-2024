`timescale 1ns / 1ps

module ALU (
    input [15:0] operand1, operand2,
    input [3:0] ALU_Op,
    output reg [15:0] ALU_Result,
    output zero
    );

    assign zero = (ALU_Result == 16'b0);
    
    always @(*) begin
        case(ALU_Op)
            4'b0000:    ALU_Result = operand1 + operand2; // ADD
            4'b0001:    ALU_Result = operand1 - operand2; // SUB
            4'b0010:    ALU_Result = operand1 * operand2; // MUL
            4'b0011:    ALU_Result = operand1 / operand2; // DIV
            4'b0100:    ALU_Result = operand1 & operand2; // AND
            4'b0101:    ALU_Result = operand1 | operand2; // OR
            4'b0110:    ALU_Result = operand1 ^ operand2; // XOR
            4'b0111:    ALU_Result = ~operand1; // NOT
            4'b1000:    ALU_Result = (operand1 < operand2) ? 16'b1 : 16'b0; // SLT
            default:    ALU_Result = 16'b0;
        endcase
    end
endmodule