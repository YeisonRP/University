
`include "RAM_c.v"

`ifndef FIFO_C      //-- Para no tener problemas con los include, si el
 `define FIFO_C     //   modulo fifo_c ya estaba definido ignora el codigo


module fifo_c #(
    parameter AW = 3,   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 8)   //-- Cantidad de bits de datos (Data width) (ES FIJO 6 SIEMPRE)
    ( 
    input clk,                        //-- clock 
    input reset,                      //-- Reset 
    input [DW-1: 0] data_in,          //-- Entrada del FIFO de 6 bits 
    input pop,                        //-- 1 si se quiere hacer pop, 0 nada 
    input push,                       //-- 1 si se quiere hacer push, 0 nada 
    input [3:0] umbral_almost_full,   //-- Umbral de que el FIFO esta casi lleno
    input [3:0] umbral_almost_empty,  //-- Umbral de que el FIFO esta casi lleno
    output [DW-1: 0] data_out_c,      //-- Salida del FIFO 
    output reg valid_out_c,           //-- es 1 cuando la salida del FIFO es un dato valido 
    output reg almost_empty_full_c,   //-- 0 si esta casi vacio (aun le cabe), 1 si esta casi lleno (casi no le cabe)
    output reg fifo_empty_c,          //-- Entrada de la maquina de estados, Es 1 si el FIFO esta vacio, 0 en caso contrario
    output reg error_c                //-- Entrada de la maquina de estados, Es 1 solo si se pide hacer un push y el fifo estaba lleno o si se pide pop y el FIFO estaba vacio
    );


    //--PARAMETROS:
    localparam max_size_of_addr = 2 ** AW;  //-- Cantidad maxima de direcciones

    //--SEÑALES INTERNAS:
    reg [AW-1: 0] wr_ptr, rd_ptr;           //-- Punteros de escritura y lectura

    reg [1:0] rw; //-- 00 idle, 01 write, 10 read, 11 read and write

    reg [AW:0] contador_datos_en_FIFO;
    //--------------- LOGICA DE POP Y PUSH DEL FIFO--------------------
    always @(posedge clk) begin
        if (reset == 0) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            valid_out_c <= 0;
            contador_datos_en_FIFO <= 0;
        end
        if (reset == 1) begin
            //-- caso push
            if (push == 1) begin
                wr_ptr <= wr_ptr + 1; //-- si hay un push aumenta el puntero de escritura
            end
            //-- caso pop
            if (pop == 1 & fifo_empty_c != 1) begin
                rd_ptr <= rd_ptr + 1; //-- si hay un pop aumenta el puntero de lectura
                valid_out_c <= 1;
            end
            if (pop == 0 || fifo_empty_c == 1) begin
                valid_out_c <= 0;
            end

            if (push == 1 & pop == 0) begin
                contador_datos_en_FIFO <= contador_datos_en_FIFO + 1;
            end
            if (push == 0 & pop == 1 & fifo_empty_c != 1) begin
                contador_datos_en_FIFO <= contador_datos_en_FIFO - 1;
            end
            if (push == 1 & pop == 1 & fifo_empty_c == 1) begin
                contador_datos_en_FIFO <= contador_datos_en_FIFO + 1;
            end
        end
    end

    always @(*) begin
        rw[0] = push;
        rw[1] = pop;
    end


    RAM_c #(/*AUTOINSTPARAM*/
	    // Parameters
	    .AW				(AW),
	    .DW				(DW))
        RAM_c_instance0 (
             // Inputs
			 .addrr			(rd_ptr[AW-1:0]),
			 .addrw			(wr_ptr[AW-1:0]),
			   /*AUTOINST*/
			 // Outputs
			 .data_out_c		(data_out_c[DW-1:0]),
			 // Inputs
			 .clk			(clk),
			 .reset			(reset),
             .rw			(rw), 
			 .data_in		(data_in[DW-1:0]));


    //------------------------- LOGICA DE FLOW CONTROL---------------------------------

    //--SEÑALES INTERNAS:
    reg [4:0] estado;
    reg [4:0] estado_proximo;

    //--ESTADOS:
    localparam [4:0] RESET = 5'b00001, 
                    FIFO_VACIO = 5'b00010, 
                    CONTINUAR = 5'b00100, 
                    PAUSA = 5'b01000, 
                    ERROR =  5'b10000;
    always @(posedge clk) begin
        if (reset == 0) begin
            estado <= RESET;
        end
        if (reset == 1) begin
            estado <= estado_proximo;    
        end
    end

    always @(*) begin
        estado_proximo = estado;
        almost_empty_full_c = 0;
        fifo_empty_c = 0;
        error_c = 0;
        case (estado)
                
            RESET: begin
                fifo_empty_c = 1;
                if (reset == 1) begin
                    estado_proximo = FIFO_VACIO;
                end
            end
            
            FIFO_VACIO: begin //-- Estado que esta listo para recibir push pero no pops
                estado_proximo = FIFO_VACIO;
                fifo_empty_c = 1;
                if (wr_ptr != rd_ptr) begin
                    fifo_empty_c = 0;
                end
                if (push == 1) begin
                    estado_proximo = CONTINUAR;
                end
            end         

            CONTINUAR: begin    //-- Estado que esta listo para recibir pop o push
                estado_proximo = CONTINUAR;
                if (wr_ptr > rd_ptr ) begin //-- Caso I de los punteros 
                    if (wr_ptr - rd_ptr >= umbral_almost_full) begin //-- Si el FIFO tiene mas datos que los permitidos por el umbral
                        almost_empty_full_c = 1;
                        estado_proximo = PAUSA;
                    end
                end
                if (wr_ptr < rd_ptr ) begin //-- Caso II de los punteros 
                    if (max_size_of_addr - (rd_ptr - wr_ptr) >= umbral_almost_full) begin //-- Si el FIFO tiene mas datos que los permitidos por el umbral
                        almost_empty_full_c = 1;
                        estado_proximo = PAUSA;
                    end                    
                end
                if (wr_ptr == rd_ptr ) begin //-- Caso III de los punteros 
                    fifo_empty_c = 1;
                        estado_proximo = FIFO_VACIO;
                end
            end

            PAUSA: begin //-- Estado de en el que se avisa que el FIFO se esta llenando
                almost_empty_full_c = 1;
                estado_proximo = PAUSA;
                if (wr_ptr > rd_ptr ) begin //-- Caso I de los punteros 
                    if (wr_ptr - rd_ptr <= umbral_almost_empty) begin //-- Si el FIFO tiene menos datos que los permitidos por el umbral
                        almost_empty_full_c = 0;
                        estado_proximo = CONTINUAR;
                    end
                end
                if (wr_ptr < rd_ptr ) begin //-- Caso II de los punteros 
                    if (max_size_of_addr - (rd_ptr - wr_ptr) <= umbral_almost_empty) begin //-- Si el FIFO tiene menos datos que los permitidos por el umbral
                        almost_empty_full_c = 0;
                        estado_proximo = CONTINUAR;
                    end                    
                end
                if (wr_ptr == rd_ptr & contador_datos_en_FIFO != 0) begin //-- Caso III de los punteros 
                    if (push == 1) begin //-- Si se hace un push y el FIFO esta lleno (porque este estado no permite que el FIFO este vacio)
                        estado_proximo = ERROR;
                    end
                    else begin
                        estado_proximo = PAUSA;
                    end
                end
                if (wr_ptr == rd_ptr & contador_datos_en_FIFO == 0) begin //-- Caso III de los punteros 
                        fifo_empty_c = 1;
                        almost_empty_full_c = 0;
                        estado_proximo = FIFO_VACIO;
                end
            end

            ERROR: begin //-- ERror si se hace un push con el FIFO lleno o un pop con el FIFO vacio
                estado_proximo = ERROR;
                error_c = 1;
                if (reset == 0) begin
                    estado_proximo = RESET;
                    error_c = 0;
                end
            end

        endcase
    end

endmodule

`endif

/*
##########################################################################################################
######################### Explicacion detallada de entradas/salidas  #####################################
##########################################################################################################


input [DW-1: 0] data_in: Es la entrada del FIFO, asi que cuando se solicite un push el fifo va
                         a guardar esta entrada en la RAM segun corresponda con los punteros 
                         de escritura y lectura, que son regs internos del modulo. Cuando no se
                         solicite un push esta entrada es irrelevante.

input pop: Es una entrada de un bit que cuando se convierte en 1 indica que se debe hacer un pop
           en el FIFO, por lo que se debe mandar un dato a la salida data_out_c y levantar el bit
           de valid_out_c segun corresponda cuando el dato este listo. Cuando pop es 0 no se hace
           nada

input push: Es una entrada que cuando se convierte en 1 indica que se debe guardar un dato en el 
            FIFO, el dato a guardar es el que este en data_in en el momento en que se levante la
            senal de push. Cuando esta senal es 0 no se hace nada.

output reg [DW-1: 0] data_out_c: Esta es la salida del FIFO que es valida cuando se solicita un
                                 pop en el FIFO y libera un dato de la memoria. Se debe levantar
                                 la senal de valid_out_c cuando la salida data_out_c sea valida

output reg valid_out_c:  Esta senal indica con un 1 cuando la salida es valida.  


output reg almost_empty_full_c: Esta senal es parte del FLOW CONTROL. SI esta senal se pone en 1 significa
                          que el FIFO esta casi lleno, por lo que se debe hacer algo (logica fuera del FIFO),
                          ya sea en el round robin o en la logica que pide pops a los otros FIFOs. 
                          Si esta senal es 0 significa que el FIFO esta casi vacio por lo que se pueden hacer
                          pops, a menos que le FIFO tenga la senal fifo_empty_c en 1, ya que estaria vacio


output reg fifo_empty_c: Esta senal es una entrada para la MAQUINA DE ESTADOS. Si el FIFO esta vacio se pone en 1
                         en otro caso es 0

output reg error_c: Esta senal es una entrada para la MAQUINA DE ESTADOS. Si se realiza un push y el FIFO esta lleno
                    hay un error. O si se lee un FIFO vacio.            



*/
