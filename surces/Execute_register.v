module Execute_register(
	input clk_i,
	input reset_i,

	input Reg_w_i,
	input M_to_R_i,
	input Mem_W_i,
	input Mem_Rd_i,
	input Jal_i,
	input Branch_i,
	input Jal_Alu_i,
	input [31:0]Inm_result_i,
	input [31:0]PC_i,
	input [31:0]PC_p4_i,
	input [31:0]Reg2_data_i,
	input [4:0]Reg2_i,
	input [4:0]RegD_i,
	input [31:0]ALU_result_i,
	
	output reg Reg_w_o,
	output reg M_to_R_o,
	output reg Mem_W_o,
	output reg Mem_Rd_o,
	output reg Jal_o,
	output reg Branch_o,
	output reg Jal_Alu_o,
	output reg [31:0]Inm_result_o,
	output reg [31:0]PC_o,
	output reg [31:0]PC_p4_o,
	output reg [31:0]Reg2_data_o,
	output reg [4:0]Reg2_o,
	output reg [4:0]RegD_o,
	output reg [31:0]ALU_result_o
);


always@(posedge clk_i)
	begin
		if(reset_i)
			begin
				Reg_w_o = 1'b0;
				M_to_R_o = 1'b0;
				Mem_W_o = 1'b0;
				Mem_Rd_o = 1'b0;
				Jal_Alu_o = 1'b0;
				Inm_result_o = 0;
				PC_o = 0;
				PC_p4_o = 0;
				Reg2_data_o = 0;
				Reg2_o = 5'b00000;
				RegD_o = 5'b00000;
				ALU_result_o = 0;
				Jal_o = 1'b0;
				Branch_o = 1'b0;
			end
		else
			begin
				Reg_w_o = Reg_w_i;
				M_to_R_o = M_to_R_i;
				Mem_W_o = Mem_W_i;
				Mem_Rd_o = Mem_Rd_i;
				Jal_o = Jal_i;
				Branch_o = Branch_i;
				Jal_Alu_o = Jal_Alu_i;
				Inm_result_o = Inm_result_i;
				PC_o = PC_i;
				PC_p4_o = PC_p4_i;
				Reg2_data_o = Reg2_data_i;
				Reg2_o = Reg2_i;
				RegD_o = RegD_i;
				ALU_result_o = ALU_result_i;
			end	
	end
endmodule