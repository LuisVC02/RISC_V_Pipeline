module Fetch_register(
	input clk_i,
	input reset_i,
	input [31:0]PC_p4_i,
	input [31:0]PC_i,
	input [31:0]Instruction_i,
	output reg [31:0]PC_p4_o,
	output reg [31:0]PC_o,
	output reg [31:0]Instruction_o
);

/*reg [31:0]PC_p4_r;
reg [31:0]PC_r;
reg [31:0]Instruction_r;*/

always@(posedge clk_i)
	begin
		if(reset_i)
			begin
				PC_p4_o = PC_p4_i;
				PC_o = PC_i;
				Instruction_o = Instruction_i;
			end
		else
			begin
				PC_p4_o = 0;
				PC_o = 0;
				Instruction_o = 0;
			end
		/*if(clk_i)
			begin
				PC_p4_o = PC_p4_r;
				PC_o = PC_r;
				Instruction_o = Instruction_r;
				
				PC_p4_r = PC_p4_r;
				PC_r = PC_r;
				Instruction_r = Instruction_r;
			end
		else
			begin
				PC_p4_o = PC_p4_o;
				PC_o = PC_o;
				Instruction_o = Instruction_o;
				
				PC_p4_r = PC_p4_i;
				PC_r = PC_i;
				Instruction_r = Instruction_i;
			end*/
	end
endmodule