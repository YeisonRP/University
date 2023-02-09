`include "demux_layer1_cond.v"
`include "demux_layer2_cond.v"

module demux_layer3_cond(
    input clk,
    input reset_L,
    output [3:0] data_out00,
    output [3:0] data_out01,
    output [3:0] data_out10,
    output [3:0] data_out11,
    input [3:0] data_in,
    input valid_in,
    output [1:0] valid_out
);

wire reset_demux3;  //reset para el tercer demux, sincronizacion
reg reset_retrasado;	
wire [3:0] salida0_demux1, salida1_demux1;	

always @(posedge clk) 	//reset que funciona un ciclo despues de la senal de reset original
begin					//usado para sincronizar los demux
	if (reset_L == 0) 
		reset_retrasado <= 0;
	else
		reset_retrasado <= 1;
end

assign reset_demux3 = reset_retrasado & reset_L; //log combinacional del reset del demux 3


wire [3:0]		data_out0_demux1;
wire [3:0]		data_out1_demux1;
wire 		valido;


demux_layer1_cond demux1_layer1 (/*AUTOINST*/
				 // Outputs
				 .data_out0		(data_out0_demux1[3:0]),
				 .data_out1		(data_out1_demux1[3:0]),
				 .valid_out		(valido),
				 // Inputs
				 .clk			(clk),
				 .reset_L		(reset_L),
				 .data_in		(data_in[3:0]),
				 .valid_in		(valid_in)); //esta conexion es para poner el valido de salida siempre en 1 cuando el circuito funcione

demux_layer2_cond demux2_layer2 (/*AUTOINST*/
				 // Outputs
				 .data_out0		(data_out00[3:0]),
				 .data_out1		(data_out10[3:0]),
				 .valid_out		(valid_out[0]),
				 // Inputs
				 .clk			(clk),
				 .reset_L		(reset_L),
				 .data_in		(data_out0_demux1[3:0]),
				 .valid_in		(valido));

demux_layer2_cond demux3_layer2 (/*AUTOINST*/
				 // Outputs
				 .data_out0		(data_out01[3:0]),
				 .data_out1		(data_out11[3:0]),
				 .valid_out		(valid_out[1]),
				 // Inputs
				 .clk			(clk),
				 .reset_L		(reset_demux3),
				 .data_in		(data_out1_demux1[3:0]),
				 .valid_in		(valido));

endmodule
