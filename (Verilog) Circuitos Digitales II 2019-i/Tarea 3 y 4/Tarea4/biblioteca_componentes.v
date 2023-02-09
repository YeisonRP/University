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

module FF_4bits ( output[3:0] q, input[3:0] in, input clk);
    FF flopito1(q[0],in[0],clk);
    FF flopito2(q[1],in[1],clk);
    FF flopito3(q[2],in[2],clk);
    FF flopito4(q[3],in[3],clk);
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

module AND(output out, input i1, input i2);
    NAND nandd(x,i1,i2);
    NOT nott(out,x);
endmodule

module OR(output out, input i1, input i2);
    NOR norr(x,i1,i2);
    NOT nottr(out,x);
endmodule

module MUX(output o1, input i0, input i1, input select);
    NOT inversor(select_,select);
    AND compuertaAnd(z0,select_,i0);
    AND compuertaAnd2(z1,select,i1);
    OR compuertaOR(o1,z0,z1);
endmodule

module MUX_4_bits(output[3:0] o1, input[3:0] i0, input[3:0] i1, input select);
    MUX mux1(o1[0],i0[0],i1[0],select);
    MUX mux2(o1[1],i0[1],i1[1],select);
    MUX mux3(o1[2],i0[2],i1[2],select);
    MUX mux4(o1[3],i0[3],i1[3],select);
endmodule