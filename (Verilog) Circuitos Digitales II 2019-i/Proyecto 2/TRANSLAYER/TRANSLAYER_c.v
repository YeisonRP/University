
`include "RAM_c.v"
`include "fifo_c.v"
`include "FSM_c.v"


`ifndef TRANSLAYER_C      //-- Para no tener problemas con los include, si el
 `define TRANSLAYER_C     //   modulo fifo_c ya estaba definido ignora el codigo


module TRANSLAYER_c ( 
    input clk,                          //-- clock 
    input reset,                        //-- Reset 
    input init, 
    input [7:0] UMF,                    // [3:0] UMBRAL BAJO, [7:4] UMBRAL ALTO
    input [7:0] UVC, 
    input [7:0] UD, 
    input [5:0] data_in,                //-- Entrada del FIFO de 6 bits 
    input push_main,
    input pop_d0,
    input pop_d1,

    output error_out_c,
    output active_out_c,
    output idle_out_c,
    output [5:0] data_out_0_c,      //-- Salida del fifo D0 
    output [5:0] data_out_1_c,
    output valid_out_0_c, 
    output valid_out_1_c);

    parameter AWMD = 2;                         //Parametros
    parameter AWVC = 4;
    parameter DW = 6;


    wire [4:0] FIFO_ERROR;                      //Error y Empty de fifos                          
    wire [4:0] FIFO_EMPTY;

    wire [7:0] UMF_OUT_c;                       //Umbrales de los fifos
    wire [7:0] UVC_OUT_c;
    wire [7:0] UD_OUT_c;

    wire [5:0] data_out_main;                   //Datos de salidas
    wire [5:0] data_out_vc0, data_out_vc1;
    reg [5:0] data_mid;
    
    wire valid_out_main;                        //Valids de salidas
    wire valid_out_vc0, valid_out_vc1;
    reg valid_mid;
    wire valid_out_0_c, valid_out_1_c;

    wire pause_main;                            //Señales de pausa
    wire pause_vc0, pause_vc1;
    wire pause_d0, pause_d1;                  
        
    reg [5:0] data_in_vc0, data_in_vc1;         //Datos en entradas
    reg [5:0] data_in_d0, data_in_d1;

    reg valid_in_vc0, valid_in_vc1;             //Valids en entradas
    reg valid_in_d0, valid_in_d1;

    reg pop_main, pop_main_d;                   //Señales de pop
    reg pop_vc0, pop_vc1;


    ///////////////////////////////MAQUINA DE ESTADOS///////////////////////////////////////

    FSM_c fsm_cond(
        //Inputs
        .clk                (clk),
        .reset              (reset),
        .init               (init),
        .UMF                (UMF[7:0]),
        .UVC                (UVC[7:0]),
        .UD                 (UD[7:0]),
        .FIFO_ERROR         (FIFO_ERROR[4:0]),
        .FIFO_EMPTY         (FIFO_EMPTY[4:0]),
        //Outputs
        .error_out_c		(error_out_c),
		.active_out_c		(active_out_c),
		.idle_out_c		    (idle_out_c),
        .UMF_OUT_c		    (UMF_OUT_c[7:0]),
		.UVC_OUT_c		    (UVC_OUT_c[7:0]),
		.UD_OUT_c		    (UD_OUT_c[7:0])

    );

    /////////////////////////////////////FIFO MAIN///////////////////////////////

    fifo_c  #(
	  // Parameters
	  .AW				(AWMD),
	  .DW				(DW))

	main_fifo_c(
			// Outputs
			.data_out_c	            (data_out_main[DW-1:0]),
			.valid_out_c	        (valid_out_main),
			.almost_empty_full_c    (pause_main),
			.fifo_empty_c	        (FIFO_EMPTY[4]),
			.error_c	            (FIFO_ERROR[4]),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in[DW-1:0]),
			.pop		(pop_main),              
			.push		(push_main),
			.umbral_almost_full     (UMF[7:4]),
			.umbral_almost_empty    (UMF[3:0])
            );


    /////////////////////////////////////FIFO VC0////////////////////////////////////////
    fifo_c  #(
	  // Parameters
	  .AW				(AWVC),
	  .DW				(DW))

	vc0_fifo_c(
			// Outputs
			.data_out_c	            (data_out_vc0[DW-1:0]),
			.valid_out_c	        (valid_out_vc0),
			.almost_empty_full_c    (pause_vc0),
			.fifo_empty_c	        (FIFO_EMPTY[3]),
			.error_c	            (FIFO_ERROR[3]),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in_vc0[DW-1:0]),
			.pop		(pop_vc0),                                   
			.push		(valid_in_vc0),
			.umbral_almost_full     (UVC[7:4]),
			.umbral_almost_empty    (UVC[3:0])
            );

    //////////////////////////////////////FIFO VC1////////////////////////////////////////

    fifo_c  #(
	  // Parameters
	  .AW				(AWVC),
	  .DW				(DW))
	vc1_fifo_c(
			// Outputs
			.data_out_c	            (data_out_vc1[DW-1:0]),
			.valid_out_c	        (valid_out_vc1),
			.almost_empty_full_c    (pause_vc1),
			.fifo_empty_c	        (FIFO_EMPTY[2]),
			.error_c	            (FIFO_ERROR[2]),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in_vc1[DW-1:0]),
			.pop		(pop_vc1),                                    //Temporal para prueba
			.push		(valid_in_vc1),
			.umbral_almost_full     (UVC[7:4]),
			.umbral_almost_empty    (UVC[3:0])
            );

    //////////////////////////////////////FIFO D0////////////////////////////////////////

    fifo_c  #(
	  // Parameters
	  .AW				(AWMD),
	  .DW				(DW))

	d0_fifo_c(
			// Outputs
			.data_out_c	            (data_out_0_c[DW-1:0]),
			.valid_out_c	        (valid_out_0_c),
			.almost_empty_full_c    (pause_d0),
			.fifo_empty_c	        (FIFO_EMPTY[1]),
			.error_c	            (FIFO_ERROR[1]),
			// Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in_d0[DW-1:0]),
			.pop		(pop_d0),                                    //Temporal para prueba
			.push		(valid_in_d0),
			.umbral_almost_full     (UD[7:4]),
			.umbral_almost_empty    (UD[3:0])
            );

    //////////////////////////////////////FIFO D1////////////////////////////////////////

    fifo_c  #(
	  // Parameters
	  .AW				(AWMD),
	  .DW				(DW))

	d1_fifo_c(
			//Outputs
			.data_out_c	            (data_out_1_c[DW-1:0]),
			.valid_out_c	        (valid_out_1_c),
			.almost_empty_full_c    (pause_d1),
			.fifo_empty_c	        (FIFO_EMPTY[0]),
			.error_c	            (FIFO_ERROR[0]),
			//Inputs
			.clk		(clk),
			.reset		(reset),
			.data_in	(data_in_d1[DW-1:0]),
			.pop		(pop_d1),                                    //Temporal para prueba
			.push		(valid_in_d1),
			.umbral_almost_full     (UD[7:4]),
			.umbral_almost_empty    (UD[3:0])
            );


    ///////////////////PIPELINE////////////////////////////
    always @(posedge clk) begin
        pop_main_d <= pop_main;
    end


    //////////////////MUX, DEMUX y COMPUERTAS//////////////////////
    always @(*) begin 

        //Logica de pop de main
        if (pause_vc0 == 0 && pause_vc1 == 0 && FIFO_EMPTY[4]==0) begin
            pop_main = 'b1;
        end else begin
            pop_main = 'b0;
        end

        //Lógica de pop de vc0

        if (pause_d0 == 0 && pause_d1 == 0 && FIFO_EMPTY[3] == 0) begin
            pop_vc0 = 'b1; 
        end else begin
            pop_vc0 = 'b0;
        end

        //Lógica de pop de vc1

        if (pause_d0 == 0 && pause_d1 == 0 && FIFO_EMPTY[2] == 0 && FIFO_EMPTY[3] == 1) begin
            pop_vc1 = 'b1;
        end else begin
            pop_vc1 = 'b0;
        end   

        //Demux VC
        if (valid_out_main == 1) begin
            if (data_out_main[5] == 0) begin 
                data_in_vc0 = data_out_main;
                data_in_vc1 = 0;
                valid_in_vc0 = 1;
                valid_in_vc1 = 0;
            end else begin
                data_in_vc1 = data_out_main;
                data_in_vc0 = 0;
                valid_in_vc1 = 1;
                valid_in_vc0 = 0;
            end
        end else begin
            data_in_vc1 = 0;
            data_in_vc0 = 0;
            valid_in_vc1 = 0;
            valid_in_vc0 = 0;
        end

        //Mux 

        if (valid_out_vc0 == 1) begin
            data_mid = data_out_vc0;
            valid_mid = 'b1;
        end
        if (valid_out_vc0 == 0 && valid_out_vc1 == 1) begin
            data_mid = data_out_vc1;
            valid_mid = 'b1;
        end
        if (valid_out_vc0 == 0 && valid_out_vc1 == 0) begin
            data_mid = 0;
            valid_mid = 'b0;
        end

        //Demux D

        if (valid_mid == 1) begin
            if (data_mid[4] == 0) begin
                data_in_d0 = data_mid;
                data_in_d1 = 0;
                valid_in_d0 = 'b1;
                valid_in_d1 = 'b0;
            end else begin
                data_in_d1 = data_mid;
                data_in_d0 = 0;
                valid_in_d1 = 'b1;
                valid_in_d0 = 'b0;
            end
        end else begin
            data_in_d1 = 0;
            data_in_d0 = 0;
            valid_in_d1 = 'b0;
            valid_in_d0 = 'b0;
        end
    end
endmodule

`endif
