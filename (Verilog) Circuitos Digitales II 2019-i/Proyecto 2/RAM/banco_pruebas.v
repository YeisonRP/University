`timescale 	1ns				/ 100ps

`include "RAM_c.v" 	   
`include "RAM_e.v" 	   
`include "probador.v"
 	   
module banco_pruebas; 
    parameter AW = 3;   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 4;	//-- Cantidad de bits de datos (Data width) 

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [AW-1:0]		addrr;			// From probador_inst of probador.v
wire [AW-1:0]		addrw;			// From probador_inst of probador.v
wire			clk;			// From probador_inst of probador.v
wire [DW-1:0]		data_in;		// From probador_inst of probador.v
wire [DW-1:0]		data_out_c;		// From RAM_c_instance of RAM_c.v
wire [3:0]		data_out_e;		// From RAM_e_instance of RAM_e.v
wire			reset;			// From probador_inst of probador.v
wire [1:0]		rw;			// From probador_inst of probador.v
// End of automatics
 	   
RAM_c #(/*AUTOINSTPARAM*/
	// Parameters
	.AW				(AW),
	.DW				(DW))
 	RAM_c_instance (  /*AUTOINST*/
			// Outputs
			.data_out_c	(data_out_c[DW-1:0]),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.addrr		(addrr[AW-1:0]),
			.addrw		(addrw[AW-1:0]),
			.rw		(rw[1:0]),
			.data_in	(data_in[DW-1:0]));
 	   
RAM_e  RAM_e_instance( /*AUTOINST*/
		      // Outputs
		      .data_out_e	(data_out_e[3:0]),
		      // Inputs
		      .addrr		(addrr[2:0]),
		      .addrw		(addrw[2:0]),
		      .clk		(clk),
		      .data_in		(data_in[3:0]),
		      .reset		(reset),
		      .rw		(rw[1:0]));
 	   
probador #(/*AUTOINSTPARAM*/
	   // Parameters
	   .AW				(AW),
	   .DW				(DW)) 
	probador_inst( /*AUTOINST*/
		      // Outputs
		      .clk		(clk),
		      .reset		(reset),
		      .addrr		(addrr[AW-1:0]),
		      .addrw		(addrw[AW-1:0]),
		      .rw		(rw[1:0]),
		      .data_in		(data_in[DW-1:0]),
		      // Inputs
		      .data_out_c	(data_out_c[DW-1:0]),
		      .data_out_e	(data_out_e[DW-1:0]));
 	   
endmodule
