`timescale 	1ns				/ 100ps

`include "fifo_c.v" 	   
`include "fifo_e.v" 	   
`include "probador.v"
 	   
module banco_pruebas; 

    parameter AW = 3;
    parameter DW = 8;

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			almost_empty_full_c;	// From fifo_c_instance of fifo_c.v
wire			almost_empty_full_e;	// From fifo_e_instance of fifo_e.v
wire			clk;			// From probador_inst of probador.v
wire [DW-1:0]		data_in;		// From probador_inst of probador.v
wire [DW-1:0]		data_out_c;		// From fifo_c_instance of fifo_c.v
wire [7:0]		data_out_e;		// From fifo_e_instance of fifo_e.v
wire			error_c;		// From fifo_c_instance of fifo_c.v
wire			error_e;		// From fifo_e_instance of fifo_e.v
wire			fifo_empty_c;		// From fifo_c_instance of fifo_c.v
wire			fifo_empty_e;		// From fifo_e_instance of fifo_e.v
wire			pop;			// From probador_inst of probador.v
wire			push;			// From probador_inst of probador.v
wire			reset;			// From probador_inst of probador.v
wire [3:0]		umbral_almost_empty;	// From probador_inst of probador.v
wire [3:0]		umbral_almost_full;	// From probador_inst of probador.v
wire			valid_out_c;		// From fifo_c_instance of fifo_c.v
wire			valid_out_e;		// From fifo_e_instance of fifo_e.v
// End of automatics
 	   
fifo_c  #(/*AUTOINSTPARAM*/
	  // Parameters
	  .AW				(AW),
	  .DW				(DW))
	fifo_c_instance( /*AUTOINST*/
			// Outputs
			.data_out_c	(data_out_c[DW-1:0]),
			.valid_out_c	(valid_out_c),
			.almost_empty_full_c(almost_empty_full_c),
			.fifo_empty_c	(fifo_empty_c),
			.error_c	(error_c),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in[DW-1:0]),
			.pop		(pop),
			.push		(push),
			.umbral_almost_full(umbral_almost_full[3:0]),
			.umbral_almost_empty(umbral_almost_empty[3:0]));
 	   
fifo_e  fifo_e_instance( /*AUTOINST*/
			// Outputs
			.almost_empty_full_e(almost_empty_full_e),
			.data_out_e	(data_out_e[7:0]),
			.error_e	(error_e),
			.fifo_empty_e	(fifo_empty_e),
			.valid_out_e	(valid_out_e),
			// Inputs
			.clk		(clk),
			.data_in	(data_in[7:0]),
			.pop		(pop),
			.push		(push),
			.reset		(reset),
			.umbral_almost_empty(umbral_almost_empty[3:0]),
			.umbral_almost_full(umbral_almost_full[3:0]));
 	   
probador #(/*AUTOINSTPARAM*/
	   // Parameters
	   .AW				(AW),
	   .DW				(DW))
  		probador_inst( /*AUTOINST*/
			      // Outputs
			      .clk		(clk),
			      .reset		(reset),
			      .data_in		(data_in[DW-1:0]),
			      .pop		(pop),
			      .push		(push),
			      .umbral_almost_full(umbral_almost_full[3:0]),
			      .umbral_almost_empty(umbral_almost_empty[3:0]),
			      // Inputs
			      .data_out_c	(data_out_c[DW-1:0]),
			      .valid_out_c	(valid_out_c),
			      .almost_empty_full_c(almost_empty_full_c),
			      .fifo_empty_c	(fifo_empty_c),
			      .error_c		(error_c),
			      .data_out_e	(data_out_e[DW-1:0]),
			      .valid_out_e	(valid_out_e),
			      .almost_empty_full_e(almost_empty_full_e),
			      .fifo_empty_e	(fifo_empty_e),
			      .error_e		(error_e));
 	   
endmodule
