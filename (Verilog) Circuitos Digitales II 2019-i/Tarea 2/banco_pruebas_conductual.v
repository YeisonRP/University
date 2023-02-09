`timescale 	1ns				/ 100ps

`include "demux_conductual.v"
`include "probador.v"

module banco_pruebas_conductual; // Testbench

    wire [3:0] data_out0, data_out1, data_in;
	wire clk, reset_L;


	// Descripci�n conductual de alarma
	demux_conductual	demux_conduc(	/*AUTOINST*/
					     // Outputs
					     .data_out0		(data_out0),
					     .data_out1		(data_out1),
					     // Inputs
					     .clk		(clk),
					     .reset_L		(reset_L),
					     .data_in		(data_in)
                         );

	// Probador: generador de se�ales y monitor
	probador probador_(     /*AUTOINST*/
			   // Outputs
			   .clk			(clk),
			   .reset_L		(reset_L),
			   .data_in		(data_in),
			   // Inputs
			   .data_out0		(data_out0),
			   .data_out1		(data_out1));
endmodule
