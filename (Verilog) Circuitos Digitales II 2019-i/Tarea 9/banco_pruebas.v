`timescale 	1ns				/ 100ps

`include "sumador_c.v" 	   
`include "sumador_e.v" 	   
`include "probador.v"
 	   
module banco_pruebas; 
 	   
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk;			// From probador_inst of probador.v
wire [3:0]		dataA;			// From probador_inst of probador.v
wire [3:0]		dataB;			// From probador_inst of probador.v
wire [3:0]		idx;			// From probador_inst of probador.v
wire [3:0]		idx_dd_c;		// From sumador_c_instance of sumador_c.v
wire [3:0]		idx_dd_e;		// From sumador_e_instance of sumador_e.v
wire			reset_L;		// From probador_inst of probador.v
wire [3:0]		sum30_dd_c;		// From sumador_c_instance of sumador_c.v
wire [3:0]		sum30_dd_e;		// From sumador_e_instance of sumador_e.v
// End of automatics
 	   
sumador_c  sumador_c_instance( /*AUTOINST*/
			      // Outputs
			      .sum30_dd_c	(sum30_dd_c[3:0]),
			      .idx_dd_c		(idx_dd_c[3:0]),
			      // Inputs
			      .idx		(idx[3:0]),
			      .dataA		(dataA[3:0]),
			      .dataB		(dataB[3:0]),
			      .clk		(clk),
			      .reset_L		(reset_L));
 	   
sumador_e  sumador_e_instance( /*AUTOINST*/
			      // Outputs
			      .idx_dd_e		(idx_dd_e[3:0]),
			      .sum30_dd_e	(sum30_dd_e[3:0]),
			      // Inputs
			      .clk		(clk),
			      .dataA		(dataA[3:0]),
			      .dataB		(dataB[3:0]),
			      .idx		(idx[3:0]),
			      .reset_L		(reset_L));
 	   
probador  probador_inst( /*AUTOINST*/
			// Outputs
			.idx		(idx[3:0]),
			.dataA		(dataA[3:0]),
			.dataB		(dataB[3:0]),
			.clk		(clk),
			.reset_L	(reset_L),
			// Inputs
			.sum30_dd_c	(sum30_dd_c[3:0]),
			.idx_dd_c	(idx_dd_c[3:0]),
			.sum30_dd_e	(sum30_dd_e[3:0]),
			.idx_dd_e	(idx_dd_e[3:0]));
 	   
endmodule
