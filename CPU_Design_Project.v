`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2024 10:43:51 AM
// Design Name: 
// Module Name: CPU_Design_Project
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_Design_Project(
    input clk, reset,
    output RegWrite, MemRead, MemWrite, MemToReg, ALU_Src, Branch,
    output [3:0] ALU_Op,
    output [15:0] pc, instruction, imm, alu_in2, alu_result, mem_read_data
    );
    // wire [15:0] pc, next_pc, instruction, imm, alu_in2, alu_result, mem_read_data;
    wire [15:0] next_pc;
    wire [15:0] reg_read1, reg_read2, write_data;
    // wire RegWrite, MemRead, MemWrite, MemToReg, ALU_Src, Branch;
    // wire [3:0] ALU_Op;
    
    // Program Counter
    ProgramCounter pc_unit (
        .clk(clk), .reset(reset), .Branch(Branch),
        .branch_target(pc + imm), .pc(pc)
    );
    
    // Instruction Memory
    InstructionMemory instr_mem_unit (
        .pc(pc), .instruction(instruction)
    );
    
    // Control Unit
    ControlUnit ctrl_unit (
        .opcode(instruction[15:12]),
        .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
        .MemToReg(MemToReg), .ALU_Src(ALU_Src), .Branch(Branch),
        .ALU_Op(ALU_Op)
    );
    
    // Immediate Generator
    ImmediateGenerator imm_gen_unit (
        .instruction(instruction), .immediate_out(imm)
    );
    
    // Register File
    RegisterFile reg_file_unit (
        .clk(clk), .reset(reset), .RegWrite(RegWrite), .read_reg1(instruction[11:8]),
        .read_reg2(instruction[7:4]), .write_reg(instruction[3:0]), .write_data(write_data),
        .read_data1(reg_read1), .read_data2(reg_read2)
    );
    
    // ALU Input Multiplexing
    assign alu_in2 = ALU_Src ? imm : reg_read2;
    
    // ALU
    ALU alu_unit (
        .operand1(reg_read1), .operand2(alu_in2),
        .ALU_Op(ALU_Op), .ALU_Result(alu_result)
    );
    
    // Data Memory
    DataMemory data_mem_unit (
        .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .address(alu_result),
        .write_data(reg_read2), .read_data(mem_read_data)
    );
    
    // Write Back Multiplexing
    assign write_data = MemToReg ? mem_read_data : alu_result;
    
    
    
    /*input clk, reset,
    input [15:0] ReadData,
    output [15:0] WriteData,
    output [9:0] address,
    input [15:0] next_pc,
    output [15:0] pc_out,
    output [3:0] opcode, reg1, reg2, dest_reg,
    output [7:0] immediate_in,
    output [15:0] reg_data1, reg_data2, alu_src_data, alu_result, mem_data, write_data,
    output [15:0] branch_target, //jump_target,
    output zero, branch_taken,
        
    // Control Signals
    output RegWrite, MemRead, MemWrite, MemToReg, ALU_Src, Branch,
    output [3:0] ALU_Op
    );
    
    // Internal wires and signals
    // wire [15:0] pc_out, next_pc, instruction;
    // wire [3:0] opcode, reg1, reg2, dest_reg;
    // wire [7:0] immediate_in;
    // wire [15:0] immediate, reg_data1, reg_data2, alu_src_data, alu_result, mem_data, write_data;
    // wire [15:0] branch_target, jump_target;
    // wire zero, branch_taken;
    wire [15:0] instruction, immediate;
    // Control Signals
    // wire RegWrite, MemRead, MemWrite, MemToReg, ALU_Src, Branch;
    // wire [3:0] ALU_Op;
    
    // Instruction Decode
    assign opcode = instruction[15:12];
    assign reg1 = instruction[11:8];
    assign reg2 = instruction[7:4];
    assign dest_reg = instruction[3:0];
    assign immediate_in = instruction[7:0];
    
    // Branching Logic
    assign branch_target = pc_out + (immediate << 1);
    assign branch_taken = Branch && zero;
    assign next_pc = branch_taken ? branch_target : pc_out + 16'b10; // Increment PC by 2 for word-aligned instructions
    
    // External memory connections
    assign address = alu_result[9:0];
    assign WriteData = reg_data2;   // Data to write to external memory
    
    // Datapath Components
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .branch_target(branch_target),
        .pc_out(pc_out)
    );
    
    InstructionMemory InstrMem (
        .address(pc_out),
        .instruction(instruction)
    );
    
    RegisterFile RegFile (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(reg1),
        .read_reg2(reg2),
        .write_reg(dest_reg),
        .write_data(WriteData),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );
    
    ImmediateGenerator ImmGen (
        .immediate_in(immediate_in),
        .immediate_out(immediate)
    );
    
    ALU ALU (
        .operand1(reg_data1),
        .operand2(alu_src_data),
        .ALU_Op(ALU_Op),
        .ALU_Result(alu_result),
        .zero(zero)
    );
    
    DataMemory DataMem (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(alu_result),
        .write_data(reg_data2),
        .read_data(mem_data)
    );
    
    ControlUnit Control (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .ALU_Src(ALU_Src),
        .Branch(Branch),
        .ALU_Op(ALU_Op)
    );
    
    // ALU Source Selection
    assign alu_src_data = ALU_Src ? immediate : reg_data2;
    
    // Write Data Selection
    assign WriteData = MemToReg ? mem_data : alu_result;*/
endmodule
