`timescale 	1ns				/ 100ps

`include "biblioteca_componentes.v"
`include "probador.v"

module banco_pruebas_conductual; // Testbench

    wire [3:0] bus, deMux_4_bits_0, deMux_4_bits_1;
	wire clk, reset_L;


	// Descripci�n conductual de alarma
	biblioteca_componentes	biblioteca_prueba_comp(	/*AUTOINST*/
						       // Outputs
						       .Nand		(Nand),
						       .Not		(Not),
						       .Nor		(Nor),
						       .deMux_0		(deMux_0),
						       .deMux_1		(deMux_1),
						       .deMux_4_bits_0	(deMux_4_bits_0[3:0]),
						       .deMux_4_bits_1	(deMux_4_bits_1[3:0]),
						       // Inputs
						       .bus		(bus[3:0]),
						       .entrada1	(entrada1),
						       .entrada2	(entrada2),
						       .clk		(clk));

	// Probador: generador de se�ales y monitor
	probador probador_(     /*AUTOINST*/
			   // Outputs
			   .bus			(bus[3:0]),
			   .entrada1		(entrada1),
			   .entrada2		(entrada2),
			   .clk			(clk),
			   // Inputs
			   .Nand		(Nand),
			   .Not			(Not),
			   .Nor			(Nor),
			   .deMux_0		(deMux_0),
			   .deMux_1		(deMux_1),
			   .deMux_4_bits_0	(deMux_4_bits_0[3:0]),
			   .deMux_4_bits_1	(deMux_4_bits_1[3:0]));
endmodule
