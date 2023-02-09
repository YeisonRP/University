`timescale 	1ns				/ 100ps

`include "phy_rx_cond.v" 	   
`include "phy_rx_estr.v" 	   
`include "probador.v"
 	   
module banco_pruebas; 
 	   
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_2f;			// From probador_inst of probador.v
wire			clk_8f;			// From probador_inst of probador.v
wire			clk_f;			// From probador_inst of probador.v
wire			data_in_c_0;		// From probador_inst of probador.v
wire			data_in_c_1;		// From probador_inst of probador.v
wire [7:0]		data_out_c_0;		// From phy_rx_cond_instance of phy_rx_cond.v
wire [7:0]		data_out_c_1;		// From phy_rx_cond_instance of phy_rx_cond.v
wire [7:0]		data_out_e_0;		// From phy_rx_estr_instance of phy_rx_estr.v
wire [7:0]		data_out_e_1;		// From phy_rx_estr_instance of phy_rx_estr.v
wire			reset;			// From probador_inst of probador.v
wire			valid_out_c_0;		// From phy_rx_cond_instance of phy_rx_cond.v
wire			valid_out_c_1;		// From phy_rx_cond_instance of phy_rx_cond.v
wire			valid_out_e_0;		// From phy_rx_estr_instance of phy_rx_estr.v
wire			valid_out_e_1;		// From phy_rx_estr_instance of phy_rx_estr.v
// End of automatics
 	   
phy_rx_cond  phy_rx_cond_instance( /*AUTOINST*/
				  // Outputs
				  .data_out_c_0		(data_out_c_0[7:0]),
				  .data_out_c_1		(data_out_c_1[7:0]),
				  .valid_out_c_0	(valid_out_c_0),
				  .valid_out_c_1	(valid_out_c_1),
				  // Inputs
				  .data_in_c_0		(data_in_c_0),
				  .data_in_c_1		(data_in_c_1),
				  .clk_f		(clk_f),
				  .clk_2f		(clk_2f),
				  .clk_8f		(clk_8f),
				  .reset		(reset));
 	   
phy_rx_estr  phy_rx_estr_instance( /*AUTOINST*/
				  // Outputs
				  .data_out_e_0		(data_out_e_0[7:0]),
				  .data_out_e_1		(data_out_e_1[7:0]),
				  .valid_out_e_0	(valid_out_e_0),
				  .valid_out_e_1	(valid_out_e_1),
				  // Inputs
				  .clk_2f		(clk_2f),
				  .clk_8f		(clk_8f),
				  .clk_f		(clk_f),
				  .data_in_c_0		(data_in_c_0),
				  .data_in_c_1		(data_in_c_1),
				  .reset		(reset));
 	   
probador  probador_inst( /*AUTOINST*/
			// Outputs
			.data_in_c_0	(data_in_c_0),
			.data_in_c_1	(data_in_c_1),
			.clk_f		(clk_f),
			.clk_2f		(clk_2f),
			.clk_8f		(clk_8f),
			.reset		(reset),
			// Inputs
			.data_out_c_0	(data_out_c_0[7:0]),
			.data_out_c_1	(data_out_c_1[7:0]),
			.valid_out_c_0	(valid_out_c_0),
			.valid_out_e_0	(valid_out_e_0),
			.valid_out_c_1	(valid_out_c_1),
			.valid_out_e_1	(valid_out_e_1),
			.data_out_e_0	(data_out_e_0[7:0]),
			.data_out_e_1	(data_out_e_1[7:0]));
 	   
endmodule
