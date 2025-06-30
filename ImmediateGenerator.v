`timescale 1ns / 1ps

module ImmediateGenerator (
    input [15:0] instruction,
    output reg [15:0] immediate_out
    );
    
    always @(*) begin
        case(instruction[15:12])
            4'b0000:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0001:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0010:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0011:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0100:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0101:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0110:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b0111:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b1000:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b1001:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b1100:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            4'b1110:    immediate_out = {{8{instruction[7]}}, instruction[7:0]};
            default:    immediate_out = 16'b0;
        endcase
    end
    
    /*always @(*) begin
        immediate_out = {{8{immediate_in[7]}}, immediate_in};
    end*/
endmodule