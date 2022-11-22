module mulSelector
(
	input selection,
	input [31:0] data_1,
	input [31:0] data_2,
	
	output reg [31:0] data_out

);

always@(selection or data_1 or data_2)
begin
	if(selection == 1'b1)
		data_out = data_2;
	else
		data_out = data_1;
end

endmodule