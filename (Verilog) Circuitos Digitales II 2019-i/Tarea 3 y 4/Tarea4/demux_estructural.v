`include "biblioteca_componentes.v"

module demux_estructural(
    input clk,
    input reset_L,
    output [3:0] data_out0,
    output [3:0] data_out1,
    input [3:0] data_in  
);
    wire[3:0] D0,D1,D01,Q0,x0,D11,x1,Q1;
    wire[3:0] nulo = 'h0;
// Inicio: senal de select
    AND ga1(a0,a2,reset_L);
    FF Fa1(select,a0,clk);
    NOT ga2(a2,select);
// Fin: senal de select


    // demux
    demux1_2_4bit demux1(D0,D1,data_in,select);

    //logica FFs y comb select 0
    MUX_4_bits mux1(D01,D0,Q0,select);
    MUX_4_bits mux2(data_out0,nulo,D01,reset_L);
    MUX_4_bits mux22(x0,nulo,D01,reset_L);
    FF_4bits FF4bots(Q0,x0,clk);

    //logica FFs y comb select 1
    MUX_4_bits mux11(D11,Q1,D1,select);
    MUX_4_bits mux12(data_out1,nulo,D11,reset_L);
    MUX_4_bits mux212(x1,nulo,D11,reset_L);
    FF_4bits FF4bot1(Q1,x1,clk);

endmodule