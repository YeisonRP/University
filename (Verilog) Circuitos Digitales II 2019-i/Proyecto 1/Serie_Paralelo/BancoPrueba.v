`timescale 	1ns				/ 100ps
//escala de tiempo

//includes de archivos
`include "Paralelo_Serie_conductual.v"
`include "probador.v"
`include "S_P_Yosys.v"
`include "Serie_Paralelo.v"
 
module BancoPruebas; // Testbench

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire		clk_8f;			// From probador_ of probador.v
	wire		clk_f;			// From probador_ of probador.v
	wire [7:0]	data2send_c;		// From P_S_Cond of Paralelo_Serie_conductual.v
	wire [7:0]	Data2Send;		// From S_P_Cond of Serie_Paralelo_conductual.v
	wire [7:0]	parallel_out_e;		// From S_P_synth of S_P_Yosys.v
	wire [7:0]	parallel_out_c;		// From P_S_Cond of Paralelo_Serie_conductual.v
	wire [7:0]	data_in;		// From probador_ of probador.v
	wire		data_out_c;		// From P_S_Cond of Paralelo_Serie_conductual.v
	wire		valid_out_e;		// From S_P_synth of S_P_Yosys.v
	wire		reset;			// From probador_ of probador.v
	wire		valid_in;		// From probador_ of probador.v
	wire		valid_out_c;		// From probador_ of probador.v
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

	Serie_Paralelo	S_P_Cond(/*AUTOINST*/
						 // Outputs
						 .parallel_out_c   (parallel_out_c [7:0]),
						 .valid_out_c      (valid_out_c),
						 // Inputs
						 .clk_8f		(clk_8f),
						 .clk_f			(clk_f),
						 .data_in		(data_out_c),
						 .reset			(reset));					 

	// Descripción sintetizada del paralelo serie.
	S_P_Yosys	S_P_synth(/*AUTOINST*/
				  // Outputs
				  .valid_out_e			(valid_out_e),
				  .parallel_out_e		(parallel_out_e[7:0]),
				  // Inputs
				  .clk_8f				(clk_8f),
				  .clk_f				(clk_f),
				  .data_in				(data_out_c),
				  .reset				(reset));

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
			   .data2send_c		(data2send_c[7:0]));



	
endmodule
