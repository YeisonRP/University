`include "phy_rx_cond.v"
`include "phy_tx_cond.v"
`include "clkgen.v"

module phy_cond(
    input [7:0] data_in_0_c,
    input [7:0] data_in_1_c,
    input valid_in_0_c,
    input valid_in_1_c,
    input clk_8f_probador,
	input resetCLK,
    input reset,
	output 		clk_2f_to_prob, 		// cambiar en estru
    output      [7:0] data_out_c_0,
	output      [7:0] data_out_c_1,
    output      valid_out_c_0,
    output      valid_out_c_1);	// si agrego un output ponerlo en makefile que se cambie para el estruct


wire Paral_serial_out_0_c; 
wire Paral_serial_out_1_c;
assign clk_2f_to_prob = clk_2f;
wire clk_f_negado;
assign clk_f_negado = ~clk_f;
phy_tx_cond phy_tx_cond_( /*AUTOINST*/
			 // Outputs
			 .Paral_serial_out_0_c	(Paral_serial_out_0_c),
			 .Paral_serial_out_1_c	(Paral_serial_out_1_c),
			 // Inputs
			 .data_in_0_c		(data_in_0_c[7:0]),
			 .data_in_1_c		(data_in_1_c[7:0]),
			 .valid_in_0_c		(valid_in_0_c),
			 .valid_in_1_c		(valid_in_1_c),
			 .clk_f			(clk_f),
			 .clk_2f		(clk_2f),
			 .clk_8f		(clk_8f),
			 .reset			(reset));

phy_rx_cond phy_rx_cond_(
             // Inputs
			 .data_in_c_0		(Paral_serial_out_0_c),
			 .data_in_c_1		(Paral_serial_out_1_c),
			 .clk_f			(clk_f_negado),
    /*AUTOINST*/
			 // Outputs
			 .data_out_c_0		(data_out_c_0[7:0]),
			 .data_out_c_1		(data_out_c_1[7:0]),
			 .valid_out_c_0		(valid_out_c_0),
			 .valid_out_c_1		(valid_out_c_1),
			 // Inputs
			 .clk_2f		(clk_2f),
			 .clk_8f		(clk_8f),
			 .reset			(reset)); 

clkgen clkgen_cond_( 
		    // Inputs
		    .clk_8f_in		(clk_8f_probador),
			/*AUTOINST*/
		    // Outputs
		    .clk_f		(clk_f),
		    .clk_2f		(clk_2f),
		    .clk_8f		(clk_8f),
		    // Inputs
		    .resetCLK		(resetCLK));


endmodule
