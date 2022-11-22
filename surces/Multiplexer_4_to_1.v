module Multiplexer_4_to_1
(
	input [1:0]selector,
	input a,
	input b,
	input c,
	input d,
	
	output reg out
);

always@(selector, a, b, c, d)begin
	case (selector)
		2'b00:
			out = a;
		2'b01:
			out = b;
		2'b10:
			out = c;
		default:
			out = d;
	endcase
end


endmodule