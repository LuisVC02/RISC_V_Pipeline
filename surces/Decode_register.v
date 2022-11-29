module Decode_register(
	input clk_i,
	input reset_i,

	input Mul_i,
	input Mul_r_i,
	input Reg_w_i,
	input M_to_R_i,
	input Mem_W_i,
	input Mem_Rd_i,
	input Jal_i,
	input Branch_i,
	input ALU_src_i,
	input [3:0]ALU_op_i,
	input Jal_select_i,
	input [31:0]Inm_result_i,
	input [31:0]PC_i,
	input [31:0]PC_p4_i,
	input [31:0]Reg1_i,
	input [31:0]Reg2_i,
	input [4:0]NR1_i,
	input [4:0]NR2_i,
	input [4:0]RegD_i,
	input [1:0]Branch_mux_i,
	
	output reg Mul_o,
	output reg Mul_r_o,
	output reg Reg_w_o,
	output reg M_to_R_o,
	output reg Mem_W_o,
	output reg Mem_Rd_o,
	output reg Jal_o,
	output reg Branch_o,
	output reg ALU_src_o,
	output reg [3:0]ALU_op_o,
	output reg Jal_select_o,
	output reg [31:0]Inm_result_o,
	output reg [31:0]PC_o,
	output reg [31:0]PC_p4_o,
	output reg [31:0]Reg1_o,
	output reg [31:0]Reg2_o,
	output reg [4:0]NR1_o,
	output reg [4:0]NR2_o,
	output reg [4:0]RegD_o,
	output reg [1:0]Branch_mux_o
);


always@(posedge clk_i)
	begin
		if(reset_i)
			begin
				Mul_o = 1'b0;
				Mul_r_o = 1'b0;
				Reg_w_o = 1'b0;
				M_to_R_o = 1'b0;
				Mem_W_o = 1'b0;
				Mem_Rd_o = 1'b0;
				Jal_o = 1'b0;
				Branch_o = 1'b0;
				ALU_src_o = 1'b0;
				ALU_op_o = 3'b000;
				Jal_select_o = 1'b0;
				Inm_result_o = 0;
				PC_o = 0;
				PC_p4_o = 0;
				Reg1_o = 0;
				Reg2_o = 0;
				NR1_o = 5'b00000;
				NR2_o = 5'b00000;
				RegD_o = 5'b00000;
				Branch_mux_o = 2'b00;
			end
		else
			begin
				Mul_o = Mul_i;
				Mul_r_o = Mul_r_i;
				Reg_w_o = Reg_w_i;
				M_to_R_o = M_to_R_i;
				Mem_W_o = Mem_W_i;
				Mem_Rd_o = Mem_Rd_i;
				Jal_o = Jal_i;
				Branch_o = Branch_i;
				ALU_src_o = ALU_src_i;
				ALU_op_o = ALU_op_i;
				Jal_select_o = Jal_select_i;
				Inm_result_o = Inm_result_i;
				PC_o = PC_i;
				PC_p4_o = PC_p4_i;
				Reg1_o = Reg1_i;
				Reg2_o = Reg2_i;
				NR1_o = NR1_i;
				NR2_o = NR2_i;
				RegD_o = RegD_i;
				Branch_mux_o = Branch_mux_i;
			end
	end
endmodule