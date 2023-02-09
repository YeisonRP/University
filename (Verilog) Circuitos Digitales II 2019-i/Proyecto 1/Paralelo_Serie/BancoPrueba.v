`timescale 	1ns				/ 100ps
//escala de tiempo

//includes de archivos
`include "Paralelo_Serie_conductual.v"
`include "probador.v"
`include "P_S_Yosys.v"
 
module BancoPruebas; // Testbench

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire		clk_8f;			// From probador_ of probador.v
	wire		clk_f;			// From probador_ of probador.v
	wire [7:0]	data2send_c;		// From P_S_Cond of Paralelo_Serie_conductual.v
	wire [7:0]	data2send_e;		// From P_S_synth of P_S_Yosys.v
	wire [7:0]	data_in;		// From probador_ of probador.v
	wire		data_out_c;		// From P_S_Cond of Paralelo_Serie_conductual.v
	wire		data_out_e;		// From P_S_synth of P_S_Yosys.v
	wire		reset;			// From probador_ of probador.v
	wire		valid_in;		// From probador_ of probador.v
	// End of automatics
	
	// Descripción conductual del paralelo serie.
	Paralelo_Serie_conductual	P_S_Cond(/*AUTOINST*/
						 // Outputs
						 .data2send_c		(data2send_c[7:0]),
						 .data_out_c		(data_out_c),
						 // Inputs
						 .clk_8f		(clk_8f),
						 .clk_f			(clk_f),
						 .data_in		(data_in[7:0]),
						 .valid_in		(valid_in),
						 .reset			(reset));

	// Descripción sintetizada del paralelo serie.
	P_S_Yosys	P_S_synth(/*AUTOINST*/
				  // Outputs
				  .data2send_e		(data2send_e[7:0]),
				  .data_out_e		(data_out_e),
				  // Inputs
				  .clk_8f		(clk_8f),
				  .clk_f		(clk_f),
				  .data_in		(data_in[7:0]),
				  .reset		(reset),
				  .valid_in		(valid_in));

	// Probador: generador de señales y monitor
	probador probador_(/*AUTOINST*/
			   // Outputs
			   .data_in		(data_in[7:0]),
			   .valid_in		(valid_in),
			   .clk_f		(clk_f),
			   .clk_8f		(clk_8f),
			   .reset		(reset),
			   // Inputs
			   .data_out_c		(data_out_c),
			   .data2send_c		(data2send_c[7:0]),
			   .data_out_e		(data_out_e),
			   .data2send_e		(data2send_e[7:0]));


	
endmodule
