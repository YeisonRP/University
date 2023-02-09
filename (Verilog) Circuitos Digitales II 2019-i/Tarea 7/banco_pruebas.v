`timescale 	1ns				/ 100ps

`include "FSM_cond.v"
`include "FSM_estr.v"
`include "probador.v"

module banco_pruebas; 
    parameter BUS_SIZE = 16;                     //-- tamano salida de datos
    parameter WORD_SIZE = 4;                    //-- 
    parameter WORD_NUM = BUS_SIZE/WORD_SIZE;    //-- tamano salida de control
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk;			// From probador2_inst of probador2.v
wire [WORD_NUM-1:0]	ctrl_out;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire [BUS_SIZE-1:0]	data_in;		// From probador2_inst of probador2.v
wire [BUS_SIZE-1:0]	data_out;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire			err;			// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado;			// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado_proximo;		// From FSM_cond_instance of FSM_cond.v, ...
wire			nxt_err;		// From FSM_cond_instance of FSM_cond.v, ...
wire			reset;			// From probador2_inst of probador2.v
// End of automatics
wire [WORD_NUM-1:0]	ctrl_out_C;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire [WORD_NUM-1:0]	ctrl_out_E;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire [BUS_SIZE-1:0]	data_out_C;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire [BUS_SIZE-1:0]	data_out_E;		// From FSM_cond_instance of FSM_cond.v, ..., Couldn't Merge
wire			err_C;			// From FSM_cond_instance of FSM_cond.v, ...
wire			err_E;			// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado_C;			// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado_E;			// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado_proximo_C;		// From FSM_cond_instance of FSM_cond.v, ...
wire [4:0]		estado_proximo_E;		// From FSM_cond_instance of FSM_cond.v, ...
wire			nxt_err_C;		// From FSM_cond_instance of FSM_cond.v, ...
wire			nxt_err_E;		// From FSM_cond_instance of FSM_cond.v, ...


FSM_cond  FSM_cond_instance( /*AUTOINST*/
			    // Outputs
			    .data_out		(data_out_C[BUS_SIZE-1:0]),
			    .ctrl_out		(ctrl_out_C[WORD_NUM-1:0]),
			    .nxt_err		(nxt_err_C),
			    .err		(err_C),
			    .estado		(estado_C[4:0]),
			    .estado_proximo	(estado_proximo_C[4:0]),
			    // Inputs
			    .data_in		(data_in[BUS_SIZE-1:0]),
			    .reset		(reset),
			    .clk		(clk));

 FSM_estr  FSM_estr_instance( /*AUTOINST*/
			     // Outputs
			     .ctrl_out		(ctrl_out_E[WORD_NUM-1:0]),
			     .data_out		(data_out_E[BUS_SIZE-1:0]),
			     .err		(err_E),
			     .estado		(estado_E[4:0]),
			     .estado_proximo	(estado_proximo_E[4:0]),
			     .nxt_err		(nxt_err_E),
			     // Inputs
			     .clk		(clk),
			     .data_in		(data_in[BUS_SIZE-1:0]),
			     .reset		(reset));

probador  probador_inst( /*AUTOINST*/
			// Outputs
			.data_in	(data_in[BUS_SIZE-1:0]),
			.reset		(reset),
			.clk		(clk),
			// Inputs
			.data_out_C	(data_out_C[BUS_SIZE-1:0]),
			.data_out_E	(data_out_E[BUS_SIZE-1:0]),
			.ctrl_out_C	(ctrl_out_C[WORD_NUM-1:0]),
			.ctrl_out_E	(ctrl_out_E[WORD_NUM-1:0]),
			.nxt_err_C	(nxt_err_C),
			.err_C		(err_C),
			.nxt_err_E	(nxt_err_E),
			.err_E		(err_E),
			.estado_C	(estado_C[4:0]),
			.estado_proximo_C(estado_proximo_C[4:0]),
			.estado_E	(estado_E[4:0]),
			.estado_proximo_E(estado_proximo_E[4:0]));

endmodule
