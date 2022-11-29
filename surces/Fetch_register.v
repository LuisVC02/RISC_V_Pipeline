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
	end
endmodule