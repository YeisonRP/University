module Byte_un_striping_cond(
    input clk_f,
    input clk_2f,
    input [7:0] lane_0,
    input [7:0] lane_1,
    input valid_0,
    input valid_1,
    input reset,
    output reg [7:0] data_out_c,
    output reg valid_out_c
);
//reg reset_mid, reset2;
reg [2:0] estado, prox_estado;    
parameter TRANSMITIENDO_DATOS_LANE_1 = 1;
parameter ESPERANDO_ENTRADA = 2;
parameter TRANSMITIENDO_DATOS_LANE_0 = 4;

// Maquina de estados
always @(posedge clk_2f) begin
    if (reset == 0) begin
        estado <= ESPERANDO_ENTRADA;
    end
    if (reset == 1) begin
        estado <= prox_estado;           
    end
end

always @(*) begin
    prox_estado = estado;
    data_out_c = 0;
    valid_out_c = 0;
    case (estado)
        ESPERANDO_ENTRADA: begin
            prox_estado = ESPERANDO_ENTRADA;
            if (valid_0 == 1) begin
                prox_estado = TRANSMITIENDO_DATOS_LANE_1;
                data_out_c = lane_0;
                valid_out_c = 1;
            end
            if (reset == 0) begin
                prox_estado = ESPERANDO_ENTRADA;
            end
        end

        TRANSMITIENDO_DATOS_LANE_0: begin
            prox_estado = TRANSMITIENDO_DATOS_LANE_1;
            data_out_c = lane_0;
            valid_out_c = 1;
            if ((!valid_0))   begin
                prox_estado = ESPERANDO_ENTRADA;
                data_out_c = 0;
                valid_out_c = 0;
            end
            if (reset == 0) begin
                prox_estado = ESPERANDO_ENTRADA;
            end            
        end

        TRANSMITIENDO_DATOS_LANE_1: begin
            prox_estado = TRANSMITIENDO_DATOS_LANE_0;
            data_out_c = lane_1;
            valid_out_c = 1;
            if ((!valid_1))   begin
                prox_estado = ESPERANDO_ENTRADA;
                data_out_c = 0;
                valid_out_c = 0;
            end
            if (reset == 0) begin
                prox_estado = ESPERANDO_ENTRADA;
            end                
        end
    endcase
end

endmodule