`timescale 	1ns				/ 100ps

`include "phy_tx_cond.v" 	   
`include "phy_tx_estr.v" 	   
`include "probador.v"
 	   
module banco_pruebas; 
 	   
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			Paral_serial_out_0_c;	// From phy_tx_cond_instance of phy_tx_cond.v
wire			Paral_serial_out_0_e;	// From phy_tx_estr_instance of phy_tx_estr.v
wire			Paral_serial_out_1_c;	// From phy_tx_cond_instance of phy_tx_cond.v
wire			Paral_serial_out_1_e;	// From phy_tx_estr_instance of phy_tx_estr.v
wire			clk_2f;			// From probador_inst of probador.v
wire			clk_8f;			// From probador_inst of probador.v
wire			clk_f;			// From probador_inst of probador.v
wire [7:0]		data_in_0_c;		// From probador_inst of probador.v
wire [7:0]		data_in_1_c;		// From probador_inst of probador.v
wire			reset;			// From probador_inst of probador.v
wire			valid_in_0_c;		// From probador_inst of probador.v
wire			valid_in_1_c;		// From probador_inst of probador.v
// End of automatics
 	   
phy_tx_cond  phy_tx_cond_instance( /*AUTOINST*/
				  // Outputs
				  .Paral_serial_out_0_c	(Paral_serial_out_0_c),
				  .Paral_serial_out_1_c	(Paral_serial_out_1_c),
				  // Inputs
				  .data_in_0_c		(data_in_0_c[7:0]),
				  .data_in_1_c		(data_in_1_c[7:0]),
				  .valid_in_0_c		(valid_in_0_c),
				  .valid_in_1_c		(valid_in_1_c),
				  .clk_f		(clk_f),
				  .clk_2f		(clk_2f),
				  .clk_8f		(clk_8f),
				  .reset		(reset));
 	   
phy_tx_estr  phy_tx_estr_instance( /*AUTOINST*/
				  // Outputs
				  .Paral_serial_out_0_e	(Paral_serial_out_0_e),
				  .Paral_serial_out_1_e	(Paral_serial_out_1_e),
				  // Inputs
				  .clk_2f		(clk_2f),
				  .clk_8f		(clk_8f),
				  .clk_f		(clk_f),
				  .data_in_0_c		(data_in_0_c[7:0]),
				  .data_in_1_c		(data_in_1_c[7:0]),
				  .reset		(reset),
				  .valid_in_0_c		(valid_in_0_c),
				  .valid_in_1_c		(valid_in_1_c));
 	   
probador  probador_inst( /*AUTOINST*/
			// Outputs
			.data_in_0_c	(data_in_0_c[7:0]),
			.data_in_1_c	(data_in_1_c[7:0]),
			.valid_in_0_c	(valid_in_0_c),
			.valid_in_1_c	(valid_in_1_c),
			.clk_f		(clk_f),
			.clk_2f		(clk_2f),
			.clk_8f		(clk_8f),
			.reset		(reset),
			// Inputs
			.Paral_serial_out_0_c(Paral_serial_out_0_c),
			.Paral_serial_out_1_c(Paral_serial_out_1_c),
			.Paral_serial_out_0_e(Paral_serial_out_0_e),
			.Paral_serial_out_1_e(Paral_serial_out_1_e));
 	   
endmodule
