// *****************************************************************
// Luis Roberto Vega Campos - 734209
// 20/11/2022
// Arquitectura computacional
// ITESO
// *****************************************************************

module RISC_V_pipeline
#(
	parameter PROGRAM_MEMORY_DEPTH = 64,
	parameter DATA_MEMORY_DEPTH = 256
)

(
	// Inputs
	input clk,
	input reset
	
	//output [31:0]     Write_Data_out

);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/

// Wires generales -------------------------------------------------
wire [31:0]Inmediate_data_for_PC_ER;
wire [31:0]PC_ER;
wire [31:0]ALU_result_ER;
wire Branch_ER;
wire Jal_inm_ER;
wire Jal_ALU_ER;
wire Hazzard_Control_ER;

wire [31:0]Write_back_data_MR;
wire Reg_Write_MR;
wire [4:0]RegD_MR;

// -----------------------------------------------------------------

assign Hazzard_Control_ER = Jal_inm_ER | Branch_ER | ~reset; 

// *****************************************************************
// ********************                       **********************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************              *******************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ***************************FETCH*********************************

// Wires -----------------------------------------------------------
wire [31:0] PC_p4_w;
wire [31:0] PC_p_inm_w;
wire [31:0] PC_w;
wire Inm_select;
wire [31:0]PC_p4_or_pInm;
wire [31:0]PC_p_or_pAlu;
wire [31:0]Instruction;
// -----------------------------------------------------------------

// Fetch to decode wires -------------------------------------------
wire [31:0]PC_p4_FR;
wire [31:0]PC_FR;
wire [31:0]Instruction_FR;
// -----------------------------------------------------------------

// Sumadores de programm counter -----------------------------------
Adder_32_Bits
PC_PLUS_4
(
	.Data0(PC_w),
	.Data1(4),
	
	.Result(PC_p4_w)
);

Adder_32_Bits //  Sumador de inmediatos al program counter
PC_PLUS_INM
(
	.Data0(PC_ER),
	.Data1(Inmediate_data_for_PC_ER),
	
	.Result(PC_p_inm_w)
);
// ------------------------------------------------------------------

// Multiplexores para suma de inmediatos y brincos daodos por la alu
assign Inm_select = Branch_ER | Jal_inm_ER;
Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_FOR_4_INM_REG
(
	.Selector_i(Inm_select),
	.Mux_Data_0_i(PC_p4_w),
	.Mux_Data_1_i(PC_p_inm_w),
	
	.Mux_Output_o(PC_p4_or_pInm)

);

// Multiplexor de inmediato y registro ----------------------------
Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_FOR_INM_REG
(
	.Selector_i(Jal_ALU_ER),
	.Mux_Data_0_i(PC_p4_or_pInm),
	.Mux_Data_1_i(ALU_result_ER),
	
	.Mux_Output_o(PC_p_or_pAlu)

);
// -----------------------------------------------------------------

// PC -------------------
PC_Register
PC(
	.clk(clk),
	.reset(reset),
	.Next_PC(PC_p_or_pAlu),
	.PC_Value(PC_w)
);
// ---------------------

// ROM ------------------
Program_Memory
#(
	.MEMORY_DEPTH(PROGRAM_MEMORY_DEPTH)
)
PROGRAM_MEMORY
(
	.Address_i(PC_w),
	.Instruction_o(Instruction)
);
// ----------------------

// Pipeline register ----------------------------
Fetch_register
F_to_D_reg
(
	// input --------
	.clk_i(clk),
	.reset_i(reset),
	.PC_p4_i(PC_p4_w),
	.PC_i(PC_w),
	.Instruction_i(Instruction),
	// output -------
	.PC_p4_o(PC_p4_FR),
	.PC_o(PC_FR),
	.Instruction_o(Instruction_FR)
);
// ----------------------------------------------


// *****************************************************************
// *******************                     *************************
// *******************     ***************   ***********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ****************   **********************
// *******************     ***************   ***********************
// *******************                      ************************
// *******************************DECODE****************************

// Wires -----------------------------------------------------------
wire Mul_c;
wire Jal_c;
wire Branch_c;
wire [2:0]ALU_op_c;
wire ALU_src_c;
wire Reg_Write_c;
wire M_to_R_c;
wire Mem_Rd_c;
wire Mem_W_c;

wire [3:0]ALU_operation;

wire [31:0]Reg_1;
wire [31:0]Reg_2;
wire [4:0]NR1_DR;
wire [4:0]NR2_DR;

wire [31:0]Inm_result;
// -----------------------------------------------------------------

// Decode to execute registers -------------------------------------
wire Mul_DR;
wire Mul_r_DR;
wire Reg_W_DR;
wire M_to_R_DR;
wire Mem_W_DR;
wire Mem_Rd_DR;
wire Jal_DR;
wire Branch_DR;
wire ALU_src_DR;
wire [3:0]ALU_op_DR;
wire Jal_select_DR;
wire [31:0]Inm_result_DR;
wire [31:0]PC_DR;
wire [31:0]PC_p4_DR;
wire [31:0]Reg1_DR;
wire [31:0]Reg2_DR;
wire [4:0]RegD_DR;
wire [1:0]Branch_mux_DR;
// -----------------------------------------------------------------

// Control Unit ----------------------------------------------------
Control
CONTROL_UNIT
(
	/****/
	.OP_i(Instruction_FR[6:0]),
	/** outputus**/
	.Mul_o(Mul_c),
	.Jal_o(Jal_c),
	.Branch_o(Branch_c),
	.ALU_Op_o(ALU_op_c),
	.ALU_Src_o(ALU_src_c),
	.Reg_Write_o(Reg_Write_c),
	.Mem_to_Reg_o(M_to_R_c),
	.Mem_Read_o(Mem_Rd_c),
	.Mem_Write_o(Mem_W_c)
);
// -----------------------------------------------------------------

// ALU Control -----------------------------------------------------
ALU_Control
ALU_CONTROL_UNIT
(
	// input 
	.funct7_i(Instruction_FR[30]),
	.ALU_Op_i(ALU_op_c),
	.funct3_i(Instruction_FR[14:12]),
	
	// output
	.ALU_Operation_o(ALU_operation)

);
// -----------------------------------------------------------------

// Register File ---------------------------------------------------
Register_File
REGISTER_FILE_UNIT
(
	// inputs
	.clk(clk),
	.reset(reset),
	.Reg_Write_i(Reg_Write_MR), // Espera a write back
	.Write_Register_i(RegD_MR),// Espera a wite back
	.Read_Register_1_i(Instruction_FR[19:15]),
	.Read_Register_2_i(Instruction_FR[24:20]),
	.Write_Data_i(Write_back_data_MR), // Espera a wite back
	
	// outputs
	.Read_Data_1_o(Reg_1),
	.Read_Data_2_o(Reg_2)

);
// ----------------------------------------------------------------

// Inmedeate Unit -------------------------------------------------
Immediate_Unit
IMM_UNIT
(  
	// inputs 
	.op_i(Instruction_FR[6:0]),
   .Instruction_bus_i(Instruction_FR),
	
	// output
   .Immediate_o(Inm_result)
);
// ----------------------------------------------------------------

// Decode register ------------------------------------------------
Decode_register
Decode
(
	.clk_i(clk),
	.reset_i(Hazzard_Control_ER),

	.Mul_i(Mul_c),
	.Mul_r_i(Instruction_FR[25]),
	.Reg_w_i(Reg_Write_c),
	.M_to_R_i(M_to_R_c),
	.Mem_W_i(Mem_W_c),
	.Mem_Rd_i(Mem_Rd_c),
	.Jal_i(Jal_c),
	.Branch_i(Branch_c),
	.ALU_src_i(ALU_src_c),
	.ALU_op_i(ALU_operation),
	.Jal_select_i(Instruction_FR[3]),
	.Inm_result_i(Inm_result),
	.PC_i(PC_FR),
	.PC_p4_i(PC_p4_FR),
	.Reg1_i(Reg_1),
	.Reg2_i(Reg_2),
	.NR1_i(Instruction_FR[19:15]),
	.NR2_i(Instruction_FR[24:20]),
	.RegD_i(Instruction_FR[11:7]),
	.Branch_mux_i({Instruction_FR[14], Instruction_FR[12]}),
	
	.Mul_o(Mul_DR),
	.Mul_r_o(Mul_r_DR),
	.Reg_w_o(Reg_W_DR),
	.M_to_R_o(M_to_R_DR),
	.Mem_W_o(Mem_W_DR),
	.Mem_Rd_o(Mem_Rd_DR),
	.Jal_o(Jal_DR),
	.Branch_o(Branch_DR),
	.ALU_src_o(ALU_src_DR),
	.ALU_op_o(ALU_op_DR),
	.Jal_select_o(Jal_select_DR),
	.Inm_result_o(Inm_result_DR),
	.PC_o(PC_DR),
	.PC_p4_o(PC_p4_DR),
	.Reg1_o(Reg1_DR),
	.Reg2_o(Reg2_DR),
	.NR1_o(NR1_DR),
	.NR2_o(NR2_DR),
	.RegD_o(RegD_DR),
	.Branch_mux_o(Branch_mux_DR)
);
// -----------------------------------------------------------------

// *****************************************************************
// ********************                       **********************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************              *******************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************    *****************************************
// ********************                       **********************
// ***************************EXECUTE*******************************

// Wires -----------------------------------------------------------
wire [31:0]ALU_data;
wire Zero_o;
wire Carry_o;
wire [31:0]ALU_result;
wire [31:0]MUL_result;
wire [31:0]Result;
wire Jal_ALU;
// -----------------------------------------------------------------

// Wires branch ----------------------------------------------------
wire not_Zero;
wire not_Carry;
wire and_branch;
wire Branch_result;
// -----------------------------------------------------------------

// Wires Execute register ------------------------------------------
wire Reg_W_ER;
wire M_to_R_ER;
wire Mem_W_ER;
wire Mem_Rd_ER;
wire [31:0]PC_p4_ER;
wire [31:0]Reg2_ER;
wire [4:0]RegD_ER;
// -----------------------------------------------------------------

// Wires of fordward unit ------------------------------------------

wire [31:0] Fwd_E_to_MA_r1;
wire [31:0] Fwd_E_to_MA_r2;
wire [31:0] Fwd_to_ALU_r1;
wire [31:0] Fwd_to_ALU_r2;
// -----------------------------------------------------------------

assign Jal_ALU = Jal_DR & (~Jal_select_DR);

// Fordward unit ---------------------------------------------------
Forward_unit
Fordward_Execute
(
	.reset_i(reset),
	.R1_i(NR1_DR),
	.R2_i(NR2_DR),
	.RD_i(RegD_ER),
	.Reg1_i(Fwd_E_to_MA_r1),
	.Reg2_i(Fwd_E_to_MA_r2),
	.ALU_result(ALU_result_ER),
	
	.Reg1_o(Fwd_to_ALU_r1),
	.Reg2_o(Fwd_to_ALU_r2)

);
Forward_unit
Fordward_MemoryAccess
(
	.reset_i(reset),
	.R1_i(NR1_DR),
	.R2_i(NR2_DR),
	.RD_i(RegD_MR),
	.Reg1_i(Reg1_DR),
	.Reg2_i(Reg2_DR),
	.ALU_result(Write_back_data_MR),
	
	.Reg1_o(Fwd_E_to_MA_r1),
	.Reg2_o(Fwd_E_to_MA_r2)

);
// -----------------------------------------------------------------

// Branch mux ------------------------------------------------------
assign not_Zero = ~Zero_o;
assign not_Carry = ~Carry_o;
assign and_branch = Branch_DR & Branch_result;

Multiplexer_4_to_1
Branch_mux
(
	.selector(Branch_mux_DR),
	.a(Zero_o),
	.b(not_Zero),
	.c(Carry_o),
	.d(not_Carry),
	.out(Branch_result)
);
// -----------------------------------------------------------------

// Multiplexor de registro o inmediato -----------------------------
Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_REG_OR_IMM_FOR_ALU
(
	.Selector_i(ALU_src_DR),
	.Mux_Data_0_i(Fwd_to_ALU_r2),
	.Mux_Data_1_i(Inm_result_DR),
	
	.Mux_Output_o(ALU_data)

);
// -----------------------------------------------------------------

// ALU -------------------------------------------------------------
ALU
ALU_UNIT
(
	.ALU_Operation_i(ALU_op_DR),
	.Zero_o(Zero_o),
	.Carry_o(Carry_o),
	.A_i(Fwd_to_ALU_r1),
	.B_i(ALU_data),
	.ALU_Result_o(ALU_result)
);
// -----------------------------------------------------------------

//*************************** Modulo multiplicador ******************************************
wire mul_and;
assign mul_and = Mul_DR & Mul_r_DR;
Multiplicador 
Multiplicator
(
	.a_i(Fwd_to_ALU_r1),
	.b_i(Fwd_to_ALU_r2),
	
	.result(MUL_result)
);

mulSelector
mux_for_mul
(
	.selection(mul_and),
	.data_1(ALU_result),
	.data_2(MUL_result),
	
	.data_out(Result)

);

// -----------------------------------------------------------------

// Execute register ------------------------------------------------
Execute_register
Execute
(
	.clk_i(clk),
	.reset_i(Hazzard_Control_ER),

	.Reg_w_i(Reg_W_DR),
	.M_to_R_i(M_to_R_DR),
	.Mem_W_i(Mem_W_DR),
	.Mem_Rd_i(Mem_Rd_DR),
	.Jal_i(Jal_DR),
	.Branch_i(and_branch),
	.Jal_Alu_i(Jal_ALU),
	.Inm_result_i(Inm_result_DR),
	.PC_i(PC_DR),
	.PC_p4_i(PC_p4_DR),
	.Reg2_i(Fwd_to_ALU_r2),
	.RegD_i(RegD_DR),
	.ALU_result_i(Result),
	
	.Reg_w_o(Reg_W_ER),
	.M_to_R_o(M_to_R_ER),
	.Mem_W_o(Mem_W_ER),
	.Mem_Rd_o(Mem_Rd_ER),
	.Jal_o(Jal_inm_ER),
	.Branch_o(Branch_ER),
	.Jal_Alu_o(Jal_ALU_ER),
	.Inm_result_o(Inmediate_data_for_PC_ER),
	.PC_o(PC_ER),
	.PC_p4_o(PC_p4_ER),
	.Reg2_o(Reg2_ER),
	.RegD_o(RegD_ER),
	.ALU_result_o(ALU_result_ER)
);
// -----------------------------------------------------------------


// *****************************************************************
// *******************    *****************    *********************
// *******************     ***************     *********************
// *******************   *   ************   *  *********************
// *******************   **   **********   **  *********************
// *******************   ***   ********   ***  *********************
// *******************   ****   ******   ****  *********************
// *******************   *****   ****   *****  *********************
// *******************   ******   **   ******  *********************
// *******************   *******      *******  *********************
// *******************   ********    ********  *********************
// *******************   *********  *********  *********************
// *******************   ********************  *********************
// *******************   ********************  *********************
// *******************   ********************  *********************
// **************************MEMORY ACCESS**************************

// Wires -----------------------------------------------------------
wire [31:0]Data_to_reg;
wire [31:0]Mem_or_alu;
wire [31:0]Memory_data;
// -----------------------------------------------------------------

// Selector de guardar en registros para el jal --------------------

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_RESULT_OR_PCp4_TO_REG
(
	.Selector_i(Jal_inm_ER),
	.Mux_Data_0_i(Mem_or_alu),
	.Mux_Data_1_i(PC_p4_ER),
	
	.Mux_Output_o(Data_to_reg)

);

// Guardar resultado o memoria de datos ----------------------------
Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_FOR_ALU_OR_MEM_TO_REG
(
	.Selector_i(M_to_R_ER),
	.Mux_Data_0_i(ALU_result_ER),
	.Mux_Data_1_i(Memory_data),
	
	.Mux_Output_o(Mem_or_alu)

);
// -----------------------------------------------------------------

// Memoria de datos ------------------------------------------------
Data_Memory
#(
	.MEMORY_DEPTH(DATA_MEMORY_DEPTH)
)
RAM
(
	.clk(clk),
	.Mem_Write_i(Mem_W_ER),
	.Mem_Read_i(Mem_Rd_ER),
	.Write_Data_i(Reg2_ER),
	.Address_i(ALU_result_ER),

	.Read_Data_o(Memory_data)
);
// -----------------------------------------------------------------

// Memory access register -------------------------------------------
Memory_register
Memory_access
(
	.clk_i(clk),
	.reset_i(reset),
	
	.Data_to_reg_i(Data_to_reg),
	.Reg_W_i(Reg_W_ER),
	.Reg_D_i(RegD_ER),
	
	.Data_to_reg_o(Write_back_data_MR),
	.Reg_W_o(Reg_Write_MR),
	.Reg_D_o(RegD_MR)
);
// -----------------------------------------------------------------


// Salida para calculo de clk_rate
//assign Write_Data_out = RegD_MR;

endmodule