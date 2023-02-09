module mux(
    output reg [7:0]        data_out_c,
    output reg              valid_out_c,
    input   [7:0]           data_in_0_c,
    input                   valid_in_0_c,
    input   [7:0]           data_in_1_c,
    input                   valid_in_1_c,
    input                   reset,
    input                   clk2f,
    input                   clk8f);

    reg  [5:0]          st, nxt_st; //Registros para los estados
    reg             reset2, resetm;

    parameter RESET = 1;        //Reset activo
    parameter INICIAL = 2;      //Esperando datos 
    parameter TRANS_0 = 4;      //Transmitiendo datos_in_0
    parameter TRANS_1 = 8;      //Transmitiendo datos_in_1
    parameter W_LST_DATA1 = 16;    //Esperando datos, último transmitido fue data_in_1
    parameter W_LST_DATA0 = 32;    //Esperando datos, último transmitido fue data_in_0



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

    always @(*) begin
        data_out_c = 0;
        valid_out_c = 0;
        nxt_st = st;

        case(st)

            RESET: begin
                if (reset == 0) begin
                    nxt_st = RESET;    
                end
                else begin
                    nxt_st = INICIAL;
                end
            end

            INICIAL: begin
                if (valid_in_0_c == 1 && valid_in_1_c == 0) begin
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end    
                else if (valid_in_0_c == 0 && valid_in_1_c == 1) begin
                    data_out_c = data_in_1_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_1;
                end 
                else if (valid_in_0_c == 1 && valid_in_1_c == 1) begin
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end
            end

            TRANS_0: begin
                if (valid_in_0_c == 0 && valid_in_1_c == 0) begin
                    nxt_st = W_LST_DATA0;
                end 
                else if (valid_in_0_c == 0 && valid_in_1_c == 1) begin
                    data_out_c = 0;
                    valid_out_c = 0;
                    nxt_st = TRANS_0; 
                end
                else if (valid_in_0_c == 1) begin 
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end
            end

            TRANS_1: begin
                if (valid_in_0_c == 0 && valid_in_1_c == 0) begin
                    nxt_st = W_LST_DATA1;
                end 
                else if (valid_in_0_c == 1 && valid_in_1_c == 0) begin
                    data_out_c = 0;
                    valid_out_c = 0;
                    nxt_st = TRANS_1; 
                end
                else if (valid_in_1_c == 1) begin 
                    data_out_c = data_in_1_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_1;
                end                
            end

            W_LST_DATA0: begin
                if (valid_in_0_c == 1 && valid_in_1_c == 0) begin
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end 
                else if (valid_in_0_c == 0 && valid_in_1_c == 1) begin
                    data_out_c = data_in_1_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_1;
                end
                else if (valid_in_0_c == 1 && valid_in_1_c == 1) begin
                    data_out_c = data_in_1_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_1;
                end 
            end

            W_LST_DATA1: begin
                if (valid_in_0_c == 1 && valid_in_1_c == 0) begin
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end 
                else if (valid_in_0_c == 0 && valid_in_1_c == 1) begin
                    data_out_c = data_in_1_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_1;
                end
                else if (valid_in_0_c == 1 && valid_in_1_c == 1) begin
                    data_out_c = data_in_0_c;
                    valid_out_c = 1;
                    nxt_st = TRANS_0;
                end 
            end
            //default: nxt_st = RESET;
        endcase
    end

endmodule
