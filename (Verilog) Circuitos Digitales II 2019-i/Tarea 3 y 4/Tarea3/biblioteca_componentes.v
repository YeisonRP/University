`timescale 	1ns				/ 100ps

//  FF

module FF ( output reg q, input in, input clk);

realtime time_a , time_b ,time_c, time_width;

    always @ (posedge clk)
        begin
                q <= in;
                time_a <= $realtime;
        end

//Codigo de instrumentacion
    always @ (negedge clk)
        begin
                time_c <= $realtime;
        end

    always @ (in)    
        begin
            if(time_c<time_a)   //Codigo para averiguar el ancho del reloj
                time_width = time_a - time_c;
            else   
                time_width = time_c - time_a;
            time_b= $realtime;

            if(time_a != 0) //evita que haga el calculo antes del primer ciclo de reloj
            begin
                //Codigo para averiguar si es una violacion de set o hold
                if( ( 2*(time_width) - (time_b - time_a)) < 9  )
                    begin
                        $display ("Violacion de tiempo de Set ");
                        $display ("La violacion se dio entre el tiempo ");
                        $display ("%d y %d", time_a,time_b);
                        $finish;
                    end
                    
                if((time_b - time_a) < 5 )
                    begin
                        $display ("Violacion de tiempo de hold");
                        $display ("La violacion se dio entre el tiempo ");
                        $display ("%d y %d", time_a,time_b);
                        $finish;
                    end
            end            
        end
endmodule


//  NOT
module NOT (output out, input in);

    assign #(0:35:60,0:35:60) out = ~in;

endmodule


//  NAND
module NAND (output out,input i1, input i2);

    assign #(0:40:60,0:40:60) out = ~(i1 & i2);

endmodule

module NOR (output out,input i1, input i2);

    assign #(0:9:23,0:9:23) out = ~(i1 | i2);

endmodule

//  DEMUX 1 a 2 bit 1 lines
module demux1_2_1bit (output o0, output o1, input i1, input select);

    NOT gate112(select_,select);
    NAND asd(y0, select_, i1);
    NOT gate3(o0,y0);

    NAND gate4(y1,select,i1);
    NOT gate5(o1,y1);

endmodule

// DEMUX 1 a 2 bit 4 lines
module demux1_2_4bit (output[3:0] o0, output[3:0] o1, input[3:0] i1, input select);

    demux1_2_1bit demux12(o0[0],o1[0],i1[0],select);
    demux1_2_1bit demux13(o0[1],o1[1],i1[1],select);
    demux1_2_1bit demux114(o0[2],o1[2],i1[2],select);
    demux1_2_1bit demux112(o0[3],o1[3],i1[3],select);
  
endmodule 

module biblioteca_componentes(
    output Nand, 
    output Not,
    output Nor, 
    output deMux_0, 
    output deMux_1, 
    output[3:0] deMux_4_bits_0, 
    output[3:0] deMux_4_bits_1, 
    input[3:0] bus, 
    input entrada1,
    input entrada2,
    input clk);


NAND CompuertaNand(Nand, entrada1, entrada2);
//FF flopNAND5(FF_nand, Nand, clk);

NOT CompuertaNot(Not, entrada1);
FF flipFlop4(Fnot,Not,clk);

NOR CompuertaNor(Nor, entrada1, entrada2);
//FF flipFlop3(Fnor, Nor,clk);

demux1_2_1bit mux1bit(deMux_0,deMux_1,entrada1, entrada2);
/*FF flipFlop1(Fmux0, deMux_0,clk);
FF flipFlop2(Fmux1, deMux_1,clk);*/


demux1_2_4bit mux4bit(deMux_4_bits_0,deMux_4_bits_1,bus,entrada2);
/*FF flipFlop11(Fmux00, deMux_4_bits_0[0],clk);
FF flipFlop21(Fmux10, deMux_4_bits_1[0],clk);
FF flipFlop31(Fmux01, deMux_4_bits_0[1],clk);
FF flipFlop41(Fmux11, deMux_4_bits_1[1],clk);
FF flipFlop51(Fmux02, deMux_4_bits_0[2],clk);
FF flipFlop61(Fmux12, deMux_4_bits_1[2],clk);
FF flipFlop71(Fmux03, deMux_4_bits_0[3],clk);
FF flipFlop81(Fmux13, deMux_4_bits_1[3],clk);*/
endmodule
