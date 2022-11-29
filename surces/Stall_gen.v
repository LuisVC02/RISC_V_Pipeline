module Stall_gen(
	input Mem_Rd_i,
	input Mem_W_i,
	input clk_i,
	input [4:0]Reg1_i,
	input [4:0]Reg2_i,
	input [4:0]RegD_i,
	
	output clk_pc_o,
	output clk_reg_o,
	output reg reset_ER_o
	
);

reg pc_clk;
reg reg_clk;

assign clk_reg_o = clk_i & reg_clk;
assign clk_pc_o = clk_i | pc_clk;

always@(Mem_Rd_i or Mem_W_i or RegD_i or Reg2_i)
	begin
		if(Mem_Rd_i)
			begin
				if(Mem_W_i && (RegD_i == Reg2_i))
					begin
						pc_clk = 1'b0;
						reg_clk = 1'b1;
						reset_ER_o = 1'b0;
					end
				else
					begin
						if(RegD_i == 0)
							begin
								pc_clk = 1'b0;
								reg_clk = 1'b1;
								reset_ER_o = 1'b0;
							end
						else
							begin
								if(Reg1_i == RegD_i || Reg2_i == RegD_i)
									begin
										pc_clk = 1'b1;
										reg_clk = 1'b0;
										reset_ER_o = 1'b1;
									end
								else
									begin
										reg_clk = 1'b1;
										pc_clk = 1'b0;
										reset_ER_o = 1'b0;
									end
							end
					end
			end
		else
			begin
				pc_clk = 1'b0;
				reg_clk = 1'b1;
				reset_ER_o = 1'b0;
			end
	end


endmodule