`timescale 1ns / 1ps

module ControlUnit(
    input [3:0] opcode,
    output reg RegWrite, MemRead, MemWrite, MemToReg, ALU_Src, Branch,
    output reg [3:0] ALU_Op
    );
    
    always @(*) begin
        case(opcode)
            4'b0000:    begin // ADD
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0000;
            end
            4'b0001:    begin // SUB
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0001;
            end
            4'b0010:    begin // MUL
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0010;
            end
            4'b0011:    begin // DIV
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0011;
            end
            4'b0100:    begin // AND
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0100;
            end
            4'b0101:    begin // OR
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0101;
            end
            4'b0110:    begin // XOR
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0110;
            end
            4'b0111:    begin // NOT
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b0111;
            end
            4'b1000:    begin // BEQ
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 1;
                ALU_Op = 4'b0001;
            end
            4'b1001:    begin // BLT
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 1;
                ALU_Op = 4'b1000;
            end
            4'b1010:    begin // BGE
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 1;
                ALU_Op = 4'b1000;
            end
            4'b1011:    begin // LOAD
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                MemToReg = 1;
                ALU_Src = 1;
                Branch = 0;
                ALU_Op = 4'b0000;
            end
            4'b1100:    begin // STORE
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                MemToReg = 0;
                ALU_Src = 1;
                Branch = 0;
                ALU_Op = 4'b0000;
            end
            4'b1101:    begin // JAL
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 1;
                Branch = 1;
                ALU_Op = 4'b0000;
            end
            4'b1110:    begin // JALR
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 1;
                Branch = 1;
                ALU_Op = 4'b0000;
            end
            4'b1111:    begin // STOP
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b1111;
            end
            default:    begin
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALU_Src = 0;
                Branch = 0;
                ALU_Op = 4'b1111;
            end
        endcase
    end
endmodule
