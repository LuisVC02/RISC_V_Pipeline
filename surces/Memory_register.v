module Memory_register(
	input clk_i,
	input reset_i,
	
	input [31:0]Data_to_reg_i,
	input Reg_W_i,
	input [4:0]Reg_D_i,
	
	output reg [31:0]Data_to_reg_o,
	output reg Reg_W_o,
	output reg [4:0]Reg_D_o
);

/*reg [31:0]Data_to_reg_r;
reg Reg_W_r;
reg [3:0]Reg_D_r;*/

always@(posedge clk_i)
	begin
		if(reset_i)
			begin
				Data_to_reg_o = Data_to_reg_i;
				Reg_W_o = Reg_W_i;
				Reg_D_o = Reg_D_i;
			end
		else
			begin
				Data_to_reg_o = 0;
				Reg_W_o = 1'b0;
				Reg_D_o = 4'b0000;
			end
		/*if(clk_i)
			begin
				Data_to_reg_o = Data_to_reg_r;
				Reg_W_o = Reg_W_r;
				Reg_D_o = Reg_D_r;
				
				Data_to_reg_r = Data_to_reg_r;
				Reg_W_r = Reg_W_r;
				Reg_D_r = Reg_D_r;
			end
		else
			begin
				Data_to_reg_r = Data_to_reg_i;
				Reg_W_r = Reg_W_i;
				Reg_D_r = Reg_D_i;
				
				Data_to_reg_o = Data_to_reg_o;
				Reg_W_o = Reg_W_o;
				Reg_D_o = Reg_D_o;
			end*/
	end
endmodule