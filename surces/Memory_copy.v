module Memory_copy(
	input Mem_R_i,
	input Mem_W_i,
	input [4:0] Reg2_i,
	input [4:0] RegD_i,
	input [31:0] RegD_data_i,
	input [31:0] Reg2_data_i,
	
	output reg [31:0] Data_to_memory
);

always@(Reg2_data_i, RegD_data_i)
	begin
		if(Mem_R_i && Mem_W_i)
			begin
				if(Reg2_i == RegD_i)
					Data_to_memory <= RegD_data_i;
				else
					Data_to_memory <= Reg2_data_i;
			end
		else
			Data_to_memory <= Reg2_data_i;
	end

endmodule