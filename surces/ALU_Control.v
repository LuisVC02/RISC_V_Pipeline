/******************************************************************
* Description
*	This is the control unit for the ALU. It receves a signal called 
*	ALUOp from the control unit and signals called funct7 and funct3  from
*	the instruction bus.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module ALU_Control
(
	input funct7_i, 
	input [2:0] ALU_Op_i,
	input [2:0] funct3_i,
	

	output [3:0] ALU_Operation_o

);

reg [3:0] alu_control_values;
wire [6:0] selector;

assign selector = {funct7_i, ALU_Op_i, funct3_i};

localparam ADD = 7'b0_000_000;
localparam SUB = 7'b1_000_000;
localparam XOR = 7'b0_000_100;
localparam OR = 7'b0_000_110;
localparam AND = 7'b0_000_111;
localparam SLL = 7'b0_000_001;
localparam SRL = 7'b0_000_101;
localparam SLT = 7'b0_000_010;
localparam SLTU = 7'b0_000_011;


localparam ADDI = 7'bX_001_000;
localparam XORI = 7'bX_001_100;
localparam ORI = 7'bX_001_110;
localparam ANDI = 7'bX_001_111;
localparam SLLI = 7'bX_001_001;
localparam SRLI = 7'bX_001_101;
localparam SLTI = 7'bX_001_010;
localparam SLTUI = 7'bX_001_011;

localparam LW = 7'bX_010_010;
localparam SW = 7'bX_011_010;

localparam BEQ = 7'bX_100_000;
localparam BNE = 7'bX_100_001;
localparam BLT = 7'bX_100_100;
localparam BGE = 7'bX_100_101;

localparam JAL = 7'bX_110_XXX;
localparam JALR = 7'bX_111_000;

localparam LUI = 7'bX_101_XXX;

always@(selector)begin
	casex(selector)
		// SUMA
		ADD, ADDI, LW, SW, JAL, JALR:
			begin
				alu_control_values = 4'b0_000;
			end
		
		// RESTA
		SUB, BEQ, BNE, BLT, BGE: 
			begin
				alu_control_values = 4'b0_001;
			end
		
		// OR
		OR, ORI: 
			begin
				alu_control_values = 4'b0_011;
			end
			
		// AND
		AND, ANDI: 
			begin
				alu_control_values = 4'b0_010;
			end
			
		// XOR
		XOR, XORI: 
			begin
				alu_control_values = 4'b0_100;
			end
			
			
		// CORRIMIENTO IZQUIERDA
		SLL, SLLI: 
			begin
				alu_control_values = 4'b0_110;
			end
			
		// CORRIMIENTO DERECHA NORMAL
		SRL, SRLI: 
			begin
				alu_control_values = 4'b0_111;
			end
			
		// LUI
		LUI: 
			begin
				alu_control_values = 4'b1_001;
			end

		default: alu_control_values = 4'b00_00;
	endcase
end


assign ALU_Operation_o = alu_control_values;



endmodule
