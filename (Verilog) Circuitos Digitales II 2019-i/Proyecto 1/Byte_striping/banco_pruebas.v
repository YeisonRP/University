`timescale 	1ns				/ 100ps

`include "Byte_striping_cond.v"
`include "Byte_striping_estr.v"
`include "probador.v"

module banco_pruebas; 

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_2f;			// From probador_inst of probador.v
wire [7:0]		data_in;		// From probador_inst of probador.v
wire [7:0]		lane_0_c;		// From Byte_striping_cond_instance of Byte_striping_cond.v
wire [7:0]		lane_0_e;		// From Byte_striping_estr_instance of Byte_striping_estr.v
wire [7:0]		lane_1_c;		// From Byte_striping_cond_instance of Byte_striping_cond.v
wire [7:0]		lane_1_e;		// From Byte_striping_estr_instance of Byte_striping_estr.v
wire			reset;			// From probador_inst of probador.v
wire			valid_0_c;		// From Byte_striping_cond_instance of Byte_striping_cond.v
wire			valid_0_e;		// From Byte_striping_estr_instance of Byte_striping_estr.v
wire			valid_1_c;		// From Byte_striping_cond_instance of Byte_striping_cond.v
wire			valid_1_e;		// From Byte_striping_estr_instance of Byte_striping_estr.v
wire			valid_in;		// From probador_inst of probador.v
// End of automatics

Byte_striping_cond  Byte_striping_cond_instance( /*AUTOINST*/
						// Outputs
						.lane_0_c	(lane_0_c[7:0]),
						.lane_1_c	(lane_1_c[7:0]),
						.valid_0_c	(valid_0_c),
						.valid_1_c	(valid_1_c),
						// Inputs
						.clk_2f		(clk_2f),
						.valid_in	(valid_in),
						.data_in	(data_in[7:0]),
						.reset		(reset));

 Byte_striping_estr  Byte_striping_estr_instance( /*AUTOINST*/
						 // Outputs
						 .lane_0_e		(lane_0_e[7:0]),
						 .lane_1_e		(lane_1_e[7:0]),
						 .valid_0_e		(valid_0_e),
						 .valid_1_e		(valid_1_e),
						 // Inputs
						 .clk_2f		(clk_2f),
						 .data_in		(data_in[7:0]),
						 .reset			(reset),
						 .valid_in		(valid_in));

probador  probador_inst( /*AUTOINST*/
			// Outputs
			.clk_2f		(clk_2f),
			.data_in	(data_in[7:0]),
			.valid_in	(valid_in),
			.reset		(reset),
			// Inputs
			.lane_0_c	(lane_0_c[7:0]),
			.lane_1_c	(lane_1_c[7:0]),
			.valid_0_c	(valid_0_c),
			.valid_1_c	(valid_1_c),
			.lane_0_e	(lane_0_e[7:0]),
			.lane_1_e	(lane_1_e[7:0]),
			.valid_0_e	(valid_0_e),
			.valid_1_e	(valid_1_e));

endmodule
