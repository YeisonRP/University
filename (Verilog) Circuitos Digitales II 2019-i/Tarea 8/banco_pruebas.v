`timescale 	1ns				/ 100ps

`include "gray_counter_cond.v"
`include "cmos.v"
`include "gray_counter_estr.v"
`include "probador.v"

module banco_pruebas; 

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk;			// From probador_inst of probador.v
wire			enable;			// From probador_inst of probador.v
wire			reset_L;		// From probador_inst of probador.v
wire [4:0]		salida_gray_c;		// From gray_counter_cond_instance of gray_counter_cond.v
wire [4:0]		salida_gray_e;		// From gray_counter_estr_instance of gray_counter_estr.v
// End of automatics

gray_counter_cond  gray_counter_cond_instance( /*AUTOINST*/
					      // Outputs
					      .salida_gray_c	(salida_gray_c[4:0]),
					      // Inputs
					      .clk		(clk),
					      .enable		(enable),
					      .reset_L		(reset_L));

gray_counter_estr  gray_counter_estr_instance( /*AUTOINST*/
					      // Outputs
					      .salida_gray_e	(salida_gray_e[4:0]),
					      // Inputs
					      .clk		(clk),
					      .enable		(enable),
					      .reset_L		(reset_L));

probador  probador_inst( /*AUTOINST*/
			// Outputs
			.clk		(clk),
			.enable		(enable),
			.reset_L	(reset_L),
			// Inputs
			.salida_gray_c	(salida_gray_c[4:0]),
			.salida_gray_e	(salida_gray_e[4:0]));

endmodule
