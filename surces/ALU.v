/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add

* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/

module ALU 
(
	input [3:0] ALU_Operation_i,
	input signed [31:0] A_i,
	input signed [31:0] B_i,
	output reg Zero_o,
	output reg Carry_o,
	output reg [31:0] ALU_Result_o
);

   localparam suma = 4'b0_000;
   localparam resta = 4'b0_001;
   localparam AND = 4'b0_010;
   localparam OR = 4'b0_011;
   localparam XOR = 4'b0_100;
   localparam NOT = 4'b0_101;
   localparam Corrimiento_Iz = 4'b0_110;
   localparam Corrimiento_De = 4'b0_111;
   localparam Corrimiento_De_S = 4'b1_000;
	localparam Corrimiento_lui = 4'b1_001;
   
   always @ (A_i or B_i or ALU_Operation_i)
     begin
		case (ALU_Operation_i)
			suma:
				begin
					ALU_Result_o = A_i + B_i;
					Carry_o = 1'b0;
				end
				
			resta:
				begin
					ALU_Result_o = A_i - B_i;
					Carry_o = (A_i < B_i) ? 1'b1 : 1'b0;
				end
				
			AND:
				begin
					ALU_Result_o = A_i & B_i;
					Carry_o = 1'b0;
				end
				
			OR:
				begin
					ALU_Result_o = A_i | B_i;
					Carry_o = 1'b0;
				end
				
			NOT:
				begin
					ALU_Result_o = ~A_i;
					Carry_o = 1'b0;
				end
				
			XOR:
				begin
					ALU_Result_o = A_i ^ B_i;
					Carry_o = 1'b0;
				end
			
			Corrimiento_Iz:
				begin
					case(B_i)
						6'h00: ALU_Result_o = A_i;
						6'h01: ALU_Result_o = {A_i[30:0], 1'h0};
						6'h02: ALU_Result_o = {A_i[29:0], 2'h0};
						6'h03: ALU_Result_o = {A_i[28:0], 3'h0};
						6'h04: ALU_Result_o = {A_i[27:0], 4'h0};
						6'h05: ALU_Result_o = {A_i[26:0], 5'h00};
						6'h06: ALU_Result_o = {A_i[25:0], 6'h00};
						6'h07: ALU_Result_o = {A_i[24:0], 7'h00};
						6'h08: ALU_Result_o = {A_i[23:0], 8'h00};
						6'h09: ALU_Result_o = {A_i[22:0], 9'h000};
						6'h0a: ALU_Result_o = {A_i[21:0], 10'h000};
						6'h0b: ALU_Result_o = {A_i[20:0], 11'h000};
						6'h0c: ALU_Result_o = {A_i[19:0], 12'h000};
						6'h0d: ALU_Result_o = {A_i[18:0], 13'h0000};
						6'h0e: ALU_Result_o = {A_i[17:0], 14'h0000};
						6'h0f: ALU_Result_o = {A_i[16:0], 15'h0000};
						6'h10: ALU_Result_o = {A_i[15:0], 16'h0000};
						6'h11: ALU_Result_o = {A_i[14:0], 17'h00000};
						6'h12: ALU_Result_o = {A_i[13:0], 18'h00000};
						6'h13: ALU_Result_o = {A_i[12:0], 19'h00000};
						6'h14: ALU_Result_o = {A_i[11:0], 20'h00000};
						6'h15: ALU_Result_o = {A_i[10:0], 21'h000000};
						6'h16: ALU_Result_o = {A_i[9:0], 22'h000000};
						6'h17: ALU_Result_o = {A_i[8:0], 23'h000000};
						6'h18: ALU_Result_o = {A_i[7:0], 24'h000000};
						6'h19: ALU_Result_o = {A_i[6:0], 25'h0000000};
						6'h1a: ALU_Result_o = {A_i[5:0], 26'h0000000};
						6'h1b: ALU_Result_o = {A_i[4:0], 27'h0000000};
						6'h1c: ALU_Result_o = {A_i[3:0], 28'h0000000};
						6'h1d: ALU_Result_o = {A_i[2:0], 29'h00000000};
						6'h1e: ALU_Result_o = {A_i[1:0], 30'h00000000};
						6'h1f: ALU_Result_o = {A_i[0], 31'h00000000};
						default: ALU_Result_o = 32'h00000000;
					endcase
					Carry_o = 1'b0;
				end
			
			Corrimiento_De:
				begin
					case(B_i)
						6'h00: ALU_Result_o = A_i;
						6'h01: ALU_Result_o = {1'h0, A_i[31:1]};
						6'h02: ALU_Result_o = {2'h0, A_i[31:2]};
						6'h03: ALU_Result_o = {3'h0, A_i[31:3]};
						6'h04: ALU_Result_o = {4'h0, A_i[31:4]};
						6'h05: ALU_Result_o = {5'h00, A_i[31:5]};
						6'h06: ALU_Result_o = {6'h00, A_i[31:6]};
						6'h07: ALU_Result_o = {7'h00, A_i[31:7]};
						6'h08: ALU_Result_o = {8'h00, A_i[31:8]};
						6'h09: ALU_Result_o = {9'h000, A_i[31:9]};
						6'h0a: ALU_Result_o = {10'h000, A_i[31:10]};
						6'h0b: ALU_Result_o = {11'h000, A_i[31:11]};
						6'h0c: ALU_Result_o = {12'h000, A_i[31:12]};
						6'h0d: ALU_Result_o = {13'h0000, A_i[31:13]};
						6'h0e: ALU_Result_o = {14'h0000, A_i[31:14]};
						6'h0f: ALU_Result_o = {15'h0000, A_i[31:15]};
						6'h10: ALU_Result_o = {16'h0000, A_i[31:16]};
						6'h11: ALU_Result_o = {17'h00000, A_i[31:17]};
						6'h12: ALU_Result_o = {18'h00000, A_i[31:18]};
						6'h13: ALU_Result_o = {19'h00000, A_i[31:19]};
						6'h14: ALU_Result_o = {20'h00000, A_i[31:20]};
						6'h15: ALU_Result_o = {21'h000000, A_i[31:21]};
						6'h16: ALU_Result_o = {22'h000000, A_i[31:22]};
						6'h17: ALU_Result_o = {23'h000000, A_i[31:23]};
						6'h18: ALU_Result_o = {24'h000000, A_i[31:24]};
						6'h19: ALU_Result_o = {25'h0000000, A_i[31:25]};
						6'h1a: ALU_Result_o = {26'h0000000, A_i[31:26]};
						6'h1b: ALU_Result_o = {27'h0000000, A_i[31:27]};
						6'h1c: ALU_Result_o = {28'h0000000, A_i[31:28]};
						6'h1d: ALU_Result_o = {29'h00000000, A_i[31:29]};
						6'h1e: ALU_Result_o = {30'h00000000, A_i[31:30]};
						6'h1f: ALU_Result_o = {31'h00000000, A_i[31]};
						default: ALU_Result_o = 32'h00000000;
					endcase
					Carry_o = 1'b0;
				end
				
			Corrimiento_lui:
				begin
					ALU_Result_o = {B_i[19:0],12'h000};
					Carry_o = 1'b0;
				end
		default:
			begin
				ALU_Result_o = 0;
				Carry_o = 1'b0;
			end
		endcase // case(control)
		
		Zero_o = (ALU_Result_o == 0) ? 1'b1 : 1'b0;
		
     end // always @ (A or B or control)
endmodule // ALU