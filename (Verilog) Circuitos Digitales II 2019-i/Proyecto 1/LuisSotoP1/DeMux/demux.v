module demux(
    output reg [7:0]        data_out_0_c,   //Salida 0 y valid de salida 0
    output reg              valid_out_0_c,
    output reg [7:0]        data_out_1_c,   //Salida 1 y valid de salida 1
    output reg              valid_out_1_c,
    input   [7:0]           data_in_c,      //Entrada de datos y bit de valid
    input                   valid_in_c,
    input                   reset,          //Señal de reset
    input                   clk2f,
    input                   clk8f);         //Reloj a 2f Hz

    reg [5:0]       st, nxt_st;
    reg             reset2, resetm;

    parameter RESET = 1;        //Reset activo
    parameter INICIAL = 2;      //Esperando datos 
    parameter TRANS_0 = 4;      //Transmitiendo a datos_out_0
    parameter TRANS_1 = 8;      //Transmitiendo a datos_out_1
    parameter W_LST_DATA1 = 16;    //Esperando datos, último transmitido fue a data_out_1
    parameter W_LST_DATA0 = 32;    //Esperando datos, último transmitido fue a data_out_0


    always @(posedge clk8f) begin
        resetm <= reset;
        reset2 <= resetm;            
    end

    always @(posedge clk2f) begin
        if (reset2 == 0) begin
            st <= RESET;
        end
        else begin
            st <= nxt_st;
        end
    end

    always  @(*) begin
        data_out_0_c = 0;
        valid_out_0_c = 0;
        data_out_1_c = 0;
        valid_out_1_c = 0;
        nxt_st = st;
        
        case (st)

            RESET: 
            if (reset == 1) begin
                nxt_st = INICIAL;
            end 

            INICIAL: 
            if (valid_in_c == 1) begin
                data_out_0_c = data_in_c;
                valid_out_0_c = 1;
                nxt_st = TRANS_0;    
            end 

            TRANS_0:
            if (valid_in_c == 0) begin
                nxt_st = W_LST_DATA0;
            end 
            else begin
                data_out_0_c = data_in_c;
                valid_out_0_c = 1;
                nxt_st = TRANS_0;
            end

            TRANS_1:
            if (valid_in_c == 0) begin
                nxt_st = W_LST_DATA1;
            end 
            else begin
                data_out_1_c = data_in_c;
                valid_out_1_c = 1;
                nxt_st = TRANS_1;
            end

            W_LST_DATA0: 
            if (valid_in_c == 1) begin
                data_out_1_c = data_in_c;
                valid_out_1_c = 1;
                nxt_st = TRANS_1;
            end

            W_LST_DATA1: 
            if (valid_in_c == 1) begin
                data_out_0_c = data_in_c;
                valid_out_0_c = 1;
                nxt_st = TRANS_0;
            end

            //default: nxt_st = RESET;
        endcase
    end

endmodule