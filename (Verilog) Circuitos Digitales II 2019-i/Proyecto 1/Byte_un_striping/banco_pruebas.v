`timescale 	1ns				/ 100ps

`include "Byte_un_striping_cond.v"
`include "Byte_un_striping_estr.v"
`include "probador.v"

module banco_pruebas; 

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_2f;			// From probador_inst of probador.v
wire			clk_f;			// From probador_inst of probador.v
wire [7:0]		data_out_c;		// From Byte_un_striping_cond_instance of Byte_un_striping_cond.v
wire [7:0]		data_out_e;		// From Byte_un_striping_estr_instance of Byte_un_striping_estr.v
wire [7:0]		lane_0;			// From probador_inst of probador.v
wire [7:0]		lane_1;			// From probador_inst of probador.v
wire			reset;			// From probador_inst of probador.v
wire			valid_0;		// From probador_inst of probador.v
wire			valid_1;		// From probador_inst of probador.v
wire			valid_out_c;		// From Byte_un_striping_cond_instance of Byte_un_striping_cond.v
wire			valid_out_e;		// From Byte_un_striping_estr_instance of Byte_un_striping_estr.v
// End of automatics

Byte_un_striping_cond  Byte_un_striping_cond_instance( /*AUTOINST*/
						      // Outputs
						      .data_out_c	(data_out_c[7:0]),
						      .valid_out_c	(valid_out_c),
						      // Inputs
						      .clk_f		(clk_f),
						      .clk_2f		(clk_2f),
						      .lane_0		(lane_0[7:0]),
						      .lane_1		(lane_1[7:0]),
						      .valid_0		(valid_0),
						      .valid_1		(valid_1),
						      .reset		(reset));

 Byte_un_striping_estr  Byte_un_striping_estr_instance( /*AUTOINST*/
						       // Outputs
						       .data_out_e	(data_out_e[7:0]),
						       .valid_out_e	(valid_out_e),
						       // Inputs
						       .clk_2f		(clk_2f),
						       .clk_f		(clk_f),
						       .lane_0		(lane_0[7:0]),
						       .lane_1		(lane_1[7:0]),
						       .reset		(reset),
						       .valid_0		(valid_0),
						       .valid_1		(valid_1));

probador  probador_inst( /*AUTOINST*/
			// Outputs
			.clk_f		(clk_f),
			.clk_2f		(clk_2f),
			.lane_0		(lane_0[7:0]),
			.lane_1		(lane_1[7:0]),
			.valid_0	(valid_0),
			.valid_1	(valid_1),
			.reset		(reset),
			// Inputs
			.data_out_c	(data_out_c[7:0]),
			.data_out_e	(data_out_e[7:0]),
			.valid_out_c	(valid_out_c),
			.valid_out_e	(valid_out_e));

endmodule
