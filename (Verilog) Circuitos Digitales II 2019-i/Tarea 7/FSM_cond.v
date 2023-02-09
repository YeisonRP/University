
module FSM_cond #(
    parameter BUS_SIZE = 16,                    //-- tamano salida de datos
    parameter WORD_SIZE = 4,                    //-- tamano de la palabra
    parameter WORD_NUM = BUS_SIZE/WORD_SIZE,    //-- tamano salida de control
    parameter First_PKT = 1,                    //-- Estado
    parameter REG_PKT = 2,                      //-- Estado
    parameter SEQ_ERR = 4,                      //-- Estado
    parameter F_ERR = 8,                        //-- Estado
    parameter RESET = 16                         //-- Estado
    )   (
    input [BUS_SIZE-1:0] data_in,
    input reset,
    input clk,
    output [BUS_SIZE-1:0] data_out,
    output [WORD_NUM-1:0] ctrl_out,
    output reg nxt_err,
    output reg err,
    output reg [4:0] estado,
    output reg [4:0] estado_proximo
);
    reg [WORD_SIZE-1:0] contador;





    // --------------------------Contador PARAMETRIZADO---------------------------
    integer j = 0;
    integer pow2 = 4;
    reg reset_counter ;
    always @(posedge clk ) begin
        if(reset == 0)
            begin 
                contador <= 0;
            end 
        else
            begin
                if (!reset_counter) begin
                    contador <= 0;
                end
                else     begin
                    contador[0] <= ~contador[0];
                    pow2 = 2;      // pow2 = 4
                    for (j = 0;j < (WORD_SIZE-1 ); j = j + 1) begin
                        if (contador % pow2 == pow2 - 1)
                            begin
                                contador[j+1] <= ~contador[j+1];
                            end               //si el contador es igual a una potencia de 2 menos 1  
                        else
                            begin
                                contador[j+1] <= contador[j+1];    
                            end
                        pow2 =  pow2 * 2 ;                  
                    end
                                    
                end   
            end
    end

    // --------------------------Encontrando si todos los numeros son 1, PARAMETRIZADO---------------------------
    integer k = 0;
    reg bits_unos ;
    always @(*) begin 
        bits_unos = 1;        
        if(reset == 1)begin
            for(k = 0; k < WORD_SIZE; k = k + 1) begin
                bits_unos = bits_unos & data_in[BUS_SIZE - WORD_SIZE + k];
            end
        end
    end 


    // --------------------------Maquina de estados, PARAMETRIZADO---------------------------


    always @ (posedge clk) begin
        if(reset == 0) 
        begin
            estado <= RESET;
            err    <= 0;
        end     
        if(reset == 1)         
            begin
                err    <= nxt_err;
                estado <= estado_proximo;                
            end    
    end

    always @(*) begin

            estado_proximo = estado;
            nxt_err = 0;
            reset_counter = 1;                

            case (estado)
                First_PKT: begin

                    if(!bits_unos)begin         // si no todos son 1s
                        estado_proximo = F_ERR;
                        nxt_err = 1;
                        reset_counter = 0;
                    end
                    else if(data_in[WORD_SIZE-1:0] != contador)begin  // si no coincide el contador
                        estado_proximo = SEQ_ERR;
                        nxt_err = 1;
                        reset_counter = 0;  
                    end
                    else
                       estado_proximo = REG_PKT;   //Si todo esta bien 
                end

                REG_PKT: begin
                    
                    if(!bits_unos)begin         // si no todos son 1s
                        estado_proximo = F_ERR;
                        nxt_err = 1;
                        reset_counter = 0;
                    end
                    else if(data_in[WORD_SIZE-1:0] != contador)begin  // si no coincide el contador
                        estado_proximo = SEQ_ERR;
                        nxt_err = 1;
                        reset_counter = 0;  
                    end 
                    else
                        estado_proximo = REG_PKT;               

                end
                SEQ_ERR: begin
                    
                    if(!bits_unos)begin         // si no todos son 1s
                        estado_proximo = F_ERR;
                        nxt_err = 1;
                        reset_counter = 0;
                    end
                    else if(data_in[WORD_SIZE-1:0] != contador)begin  // si no coincide el contador
                        estado_proximo = SEQ_ERR;
                        nxt_err = 1;
                        reset_counter = 0;  
                    end
                    else    
                        estado_proximo = First_PKT;
                end
                F_ERR: begin
                    
                    if(!bits_unos)begin         // si no todos son 1s
                        estado_proximo = F_ERR;
                        nxt_err = 1;
                        reset_counter = 0;
                    end
                    else if(data_in[WORD_SIZE-1:0] != contador)begin  // si no coincide el contador
                        estado_proximo = SEQ_ERR;
                        nxt_err = 1;
                        reset_counter = 0;  
                    end
                    else 
                        estado_proximo = First_PKT;
                end
                RESET: begin    //pasar a todos menos regp

                    if (reset == 1)  begin
                        if(!bits_unos)begin         // si no todos son 1s
                            estado_proximo = F_ERR;
                            nxt_err = 1;
                            reset_counter = 0;
                        end
                        else if(data_in[WORD_SIZE-1:0] != contador)begin  // si no coincide el contador
                            estado_proximo = SEQ_ERR;
                            nxt_err = 1;
                            reset_counter = 0;  
                        end
                        else
                            estado_proximo = First_PKT;                        
                    end
                    else
                        estado_proximo = RESET;
                end
            endcase
    end




    //--------------------------- Genvar y etc PARAMETRIZADO---------------------------------
    genvar i;
    generate
        for (i=0; i < WORD_NUM; i=i+1) begin : ASD // Etiqueta
            inversor    #(
                .WORD_SIZE (WORD_SIZE)
            ) inversor_units(
                .entrada_datos        (data_in[i*WORD_SIZE+:WORD_SIZE]),
                .reset              (reset),
                .salida_datos       (data_out[(WORD_SIZE*(WORD_NUM-1) - i*WORD_SIZE)+:WORD_SIZE])
            );

            bitwiseOr #(
                .WORD_SIZE (WORD_SIZE)
            )   bitwiseOr_units(
                .entrada        (data_in[i*WORD_SIZE+:WORD_SIZE]),
                .reset          (reset),
                .bit_salida     (ctrl_out[i])
            );
        end
    endgenerate

endmodule



module bitwiseOr #(
    parameter WORD_SIZE = 0
    )   (
        input [WORD_SIZE - 1: 0] entrada,
        input reset,
        output reg bit_salida
    );
    integer i = 0;

    always @(*) begin 

        bit_salida = 0;        
        if(reset == 1)begin
            for(i = 0; i < WORD_SIZE; i = i + 1) begin
                bit_salida = bit_salida | entrada[i];
            end
        end
    end

endmodule 

module inversor #(                     //-- tamano salida de datos
    parameter WORD_SIZE = 0  
    )   (
    input [WORD_SIZE-1:0] entrada_datos,
    input reset,
    output [WORD_SIZE-1:0] salida_datos
);

assign salida_datos = (reset == 1)? entrada_datos:'b0;

endmodule


