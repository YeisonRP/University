`timescale 	1ns				/ 100ps

`include "demux_layer3_cond.v"
`include "demux_layer1_estr.v"
`include "demux_layer2_estr.v"
`include "demux_layer3_estr.v"
`include "probador.v"

module banco_pruebas; 

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk;			// From probador_inst of probador.v
wire [3:0]		data_in;		// From probador_inst of probador.v
wire [3:0]		data_out0;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...
wire [3:0]		data_out00;		// From demux_layer3_cond_instance of demux_layer3_cond.v, ...
wire [3:0]		data_out01;		// From demux_layer3_cond_instance of demux_layer3_cond.v, ...
wire [3:0]		data_out1;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...
wire [3:0]		data_out10;		// From demux_layer3_cond_instance of demux_layer3_cond.v, ...
wire [3:0]		data_out11;		// From demux_layer3_cond_instance of demux_layer3_cond.v, ...
wire			reset_L;		// From probador_inst of probador.v
wire			valid_in;		// From probador_inst of probador.v
wire [1:0]		valid_out_E_l3;	// From demux_layer1_cond_instance of demux_layer1_cond.v, ...
wire [1:0]		valid_out_C_l3;	// From demux_layer1_cond_instance of demux_layer1_cond.v, ...

// End of automatics

wire [3:0]		data_out0_E_l1;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out1_E_l1;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out0_C_l1;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out1_C_l1;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire 			valid_out_E_l1;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...
wire 			valid_out_C_l1;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...

wire [3:0]		data_out0_E_l2;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out1_E_l2;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out0_C_l2;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out1_C_l2;		// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire 			valid_out_E_l2;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...
wire 			valid_out_C_l2;		// From demux_layer1_cond_instance of demux_layer1_cond.v, ...

wire [3:0]		data_out00_E_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out01_E_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out10_E_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out11_E_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out00_C_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out01_C_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out10_C_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...
wire [3:0]		data_out11_C_l3;	// From demux_frecuencia_normal_instance of demux_frecuencia_normal.v, ...



demux_layer1_cond  demux_layer1_cond_instance( /*AUTOINST*/
					      // Outputs
					      .data_out0	(data_out0_C_l1[3:0]),
					      .data_out1	(data_out1_C_l1[3:0]),
					      .valid_out	(valid_out_C_l1),
					      // Inputs
					      .clk		(clk),
					      .reset_L		(reset_L),
					      .data_in		(data_in[3:0]),
					      .valid_in		(valid_in));

demux_layer1_estr  demux_layer1_estr_instance( /*AUTOINST*/
					      // Outputs
					      .data_out0	(data_out0_E_l1[3:0]),
					      .data_out1	(data_out1_E_l1[3:0]),
					      .valid_out	(valid_out_E_l1),
					      // Inputs
					      .clk		(clk),
					      .data_in		(data_in[3:0]),
					      .reset_L		(reset_L),
					      .valid_in		(valid_in));

demux_layer2_cond  demux_layer2_cond_instance( /*AUTOINST*/
					      // Outputs
					      .data_out0	(data_out0_C_l2[3:0]),
					      .data_out1	(data_out1_C_l2[3:0]),
					      .valid_out	(valid_out_C_l2),
					      // Inputs
					      .clk		(clk),
					      .reset_L		(reset_L),
					      .data_in		(data_in[3:0]),
					      .valid_in		(valid_in));

demux_layer2_estr  demux_layer2_estr_instance( /*AUTOINST*/
					      // Outputs
					      .data_out0	(data_out0_E_l2[3:0]),
					      .data_out1	(data_out1_E_l2[3:0]),
					      .valid_out	(valid_out_E_l2),
					      // Inputs
					      .clk		(clk),
					      .data_in		(data_in[3:0]),
					      .reset_L		(reset_L),
					      .valid_in		(valid_in));

demux_layer3_cond demux_layer3_cond_instance(/*AUTOINST*/
					     // Outputs
					     .data_out00	(data_out00_C_l3[3:0]),
					     .data_out01	(data_out01_C_l3[3:0]),
					     .data_out10	(data_out10_C_l3[3:0]),
					     .data_out11	(data_out11_C_l3[3:0]),
					     .valid_out		(valid_out_C_l3[1:0]),
					     // Inputs
					     .clk		(clk),
					     .reset_L		(reset_L),
					     .data_in		(data_in[3:0]),
					     .valid_in		(valid_in));

demux_layer3_estr demux_layer3_estr_instance(/*AUTOINST*/
					     // Outputs
					     .data_out00	(data_out00_E_l3[3:0]),
					     .data_out01	(data_out01_E_l3[3:0]),
					     .data_out10	(data_out10_E_l3[3:0]),
					     .data_out11	(data_out11_E_l3[3:0]),
					     .valid_out		(valid_out_E_l3[1:0]),
					     // Inputs
					     .clk		(clk),
					     .data_in		(data_in[3:0]),
					     .reset_L		(reset_L),
					     .valid_in		(valid_in));

probador  probador_inst( /*AUTOINST*/
			// Outputs
			.data_in	(data_in[3:0]),
			.reset_L	(reset_L),
			.clk		(clk),
			.valid_in	(valid_in),
			// Inputs
			.data_out0_ESTRUC_layer1(data_out0_E_l1[3:0]),
			.data_out1_ESTRUC_layer1(data_out1_E_l1[3:0]),
			.data_out0_COND_layer1(data_out0_C_l1[3:0]),
			.data_out1_COND_layer1(data_out1_C_l1[3:0]),
			.data_out0_ESTRUC_layer2(data_out0_E_l2[3:0]),
			.data_out1_ESTRUC_layer2(data_out1_E_l2[3:0]),
			.data_out0_COND_layer2(data_out0_C_l2[3:0]),
			.data_out1_COND_layer2(data_out1_C_l2[3:0]),
			.data_out00_ESTRUC_layer3(data_out00_E_l3[3:0]),
			.data_out01_ESTRUC_layer3(data_out01_E_l3[3:0]),
			.data_out10_ESTRUC_layer3(data_out10_E_l3[3:0]),
			.data_out11_ESTRUC_layer3(data_out11_E_l3[3:0]),
			.data_out00_COND_layer3(data_out00_C_l3[3:0]),
			.data_out01_COND_layer3(data_out01_C_l3[3:0]),
			.data_out10_COND_layer3(data_out10_C_l3[3:0]),
			.data_out11_COND_layer3(data_out11_C_l3[3:0]));

endmodule
