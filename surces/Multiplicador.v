module Multiplicador 
(
	input [31:0] a_i,
	input [31:0] b_i,
	
	output reg [31:0] result
);

wire [31:0]r1;
wire [31:0]r2;
wire [31:0]r3;
wire [31:0]r4;
wire [31:0]r5;
wire [31:0]r6;
wire [31:0]r7;
wire [31:0]r8;
wire [31:0]r9;
wire [31:0]r10;
wire [31:0]r11;
wire [31:0]r12;
wire [31:0]r13;
wire [31:0]r14;
wire [31:0]r15;
wire [31:0]r16;
wire [31:0]r17;
wire [31:0]r18;
wire [31:0]r19;
wire [31:0]r20;
wire [31:0]r21;
wire [31:0]r22;
wire [31:0]r23;
wire [31:0]r24;
wire [31:0]r25;
wire [31:0]r26;
wire [31:0]r27;
wire [31:0]r28;
wire [31:0]r29;
wire [31:0]r30;
wire [31:0]r31;
wire [31:0]r32;

wire [31:0] carry;
wire [31:0] results[31:0];


assign r1 = a_i & {32{b_i[0]}};
assign r2 = {a_i[30:0], 1'h0} & {32{b_i[1]}};
assign r3 = {a_i[29:0], 2'h0} & {32{b_i[2]}};
assign r4 = {a_i[28:0], 3'h0} & {32{b_i[3]}};
assign r5 = {a_i[27:0], 4'h0} & {32{b_i[4]}};
assign r6 = {a_i[26:0], 5'h00} & {32{b_i[5]}};
assign r7 = {a_i[25:0], 6'h00} & {32{b_i[6]}};
assign r8 = {a_i[24:0], 7'h00} & {32{b_i[7]}};
assign r9 = {a_i[23:0], 8'h00} & {32{b_i[8]}};
assign r10 = {a_i[22:0], 9'h000} & {32{b_i[9]}};
assign r11 = {a_i[21:0], 10'h000} & {32{b_i[10]}};
assign r12 = {a_i[20:0], 11'h000} & {32{b_i[11]}};
assign r13 = {a_i[19:0], 12'h000} & {32{b_i[12]}};
assign r14 = {a_i[18:0], 13'h0000} & {32{b_i[13]}};
assign r15 = {a_i[17:0], 14'h0000} & {32{b_i[14]}};
assign r16 = {a_i[16:0], 15'h0000} & {32{b_i[15]}};
assign r17 = {a_i[15:0], 16'h0000} & {32{b_i[16]}};
assign r18 = {a_i[14:0], 17'h00000} & {32{b_i[17]}};
assign r19 = {a_i[13:0], 18'h00000} & {32{b_i[18]}};
assign r20 = {a_i[12:0], 19'h00000} & {32{b_i[19]}};
assign r21 = {a_i[11:0], 20'h00000} & {32{b_i[20]}};
assign r22 = {a_i[10:0], 21'h000000} & {32{b_i[21]}};
assign r23 = {a_i[9:0], 22'h000000} & {32{b_i[22]}};
assign r24 = {a_i[8:0], 23'h000000} & {32{b_i[23]}};
assign r25 = {a_i[7:0], 24'h000000} & {32{b_i[24]}};
assign r26 = {a_i[6:0], 25'h0000000} & {32{b_i[25]}};
assign r27 = {a_i[5:0], 26'h0000000} & {32{b_i[26]}};
assign r28 = {a_i[4:0], 27'h0000000} & {32{b_i[27]}};
assign r29 = {a_i[3:0], 28'h0000000} & {32{b_i[28]}};
assign r30 = {a_i[2:0], 29'h00000000} & {32{b_i[29]}};
assign r31 = {a_i[1:0], 30'h00000000} & {32{b_i[30]}};
assign r32 = {a_i[0], 31'h00000000} & {32{b_i[31]}};



always@(a_i or b_i)
begin
	result = r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12+r13+r14+r15+r16+r17+r18+r19+r20+r21+r22+r23+r24+r25+r26+r27+r28+r29+r30+r31+r32;
end




endmodule