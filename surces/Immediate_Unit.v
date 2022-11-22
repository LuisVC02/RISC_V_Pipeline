/******************************************************************
* Description
*	This module performs a sign extension operation that is need with
*	in instruction like andi and constructs the immediate constant.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
	module Immediate_Unit
(   
	input [6:0] op_i,
	input [31:0]  Instruction_bus_i,
	
   output reg [31:0] Immediate_o
);

localparam I_type = 7'h13;
localparam U_type = 7'h37;
localparam B_type = 7'h63;
localparam Jal_type = 7'h6f;
localparam Jalr_type = 7'h67;


always@(Instruction_bus_i) begin
	case(op_i)
		I_type, Jalr_type:
			begin
				Immediate_o = {{20{Instruction_bus_i[31]}},Instruction_bus_i[31:20]};// I format
			end
			
		U_type:
			begin
				Immediate_o = {12'h0000,Instruction_bus_i[31:12]};
			end
		B_type:
			begin
				//Immediate_o = {{10{Instruction_bus_i[31:25]}}, Instruction_bus_i[11:7]};
				Immediate_o = {{20{Instruction_bus_i[31]}},Instruction_bus_i[7], Instruction_bus_i[30:25], Instruction_bus_i[11:8], 1'b0};
			end
		Jal_type: //JAL
			begin
				Immediate_o = {{12{Instruction_bus_i[31]}}, Instruction_bus_i[19:12],Instruction_bus_i[20], Instruction_bus_i[30:21], 1'b0};
			end
		default:
			begin
				Immediate_o = 0;
			end
	endcase
end


endmodule // signExtend
