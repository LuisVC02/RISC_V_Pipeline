module Forward_unit(
	input reset_i,
	input [4:0]R1_i,
	input [4:0]R2_i,
	input [4:0]RD_i,
	input [31:0]Reg1_i,
	input [31:0]Reg2_i,
	input [31:0]ALU_result,

	output reg [31:0]Reg1_o,
	output reg [31:0]Reg2_o

);
	always@(R1_i or R2_i or RD_i or Reg1_i or Reg2_i or ALU_result or reset_i)
		begin
			if(reset_i)
				begin
					if(RD_i == 5'b00000)
						begin
							Reg1_o = Reg1_i;
							Reg2_o = Reg2_i;
						end
					else
						begin
							if(R1_i == RD_i)
								begin
									Reg1_o = ALU_result;
								end
							else
								begin
									Reg1_o = Reg1_i;
								end
							if(R2_i == RD_i)
								begin
									Reg2_o = ALU_result;	
								end
							else
								begin
									Reg2_o = Reg2_i;
								end
						end
				end
			else
				begin
					Reg1_o = 0;
					Reg2_o = 0;
				end
		end


endmodule