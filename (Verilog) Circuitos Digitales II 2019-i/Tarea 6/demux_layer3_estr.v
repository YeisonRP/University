`include "cmos.v"
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* src = "demux_layer1_cond.v:1" *)
module demux_layer31_estr(clk, reset_L, data_out0, data_out1, data_in, valid_in, valid_out);
  (* src = "demux_layer1_cond.v:72" *)
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  (* src = "demux_layer1_cond.v:2" *)
  input clk;
  (* src = "demux_layer1_cond.v:6" *)
  input [3:0] data_in;
  (* src = "demux_layer1_cond.v:4" *)
  output [3:0] data_out0;
  (* src = "demux_layer1_cond.v:5" *)
  output [3:0] data_out1;
  (* src = "demux_layer1_cond.v:3" *)
  input reset_L;
  (* src = "demux_layer1_cond.v:11" *)
  wire selector;
  (* src = "demux_layer1_cond.v:7" *)
  input valid_in;
  (* src = "demux_layer1_cond.v:8" *)
  output valid_out;
  (* src = "demux_layer1_cond.v:12" *)
  wire [3:0] y_0;
  (* src = "demux_layer1_cond.v:13" *)
  wire [3:0] y_1;
  NOT _34_ (
    .A(valid_in),
    .Y(_01_)
  );
  NOT _35_ (
    .A(reset_L),
    .Y(_02_)
  );
  NOR _36_ (
    .A(_02_),
    .B(_01_),
    .Y(valid_out)
  );
  NOT _37_ (
    .A(selector),
    .Y(_03_)
  );
  NOR _38_ (
    .A(_01_),
    .B(_03_),
    .Y(_04_)
  );
  NOR _39_ (
    .A(_04_),
    .B(y_1[0]),
    .Y(_05_)
  );
  NOT _40_ (
    .A(data_in[0]),
    .Y(_06_)
  );
  NAND _41_ (
    .A(_04_),
    .B(_06_),
    .Y(_07_)
  );
  NAND _42_ (
    .A(_07_),
    .B(reset_L),
    .Y(_08_)
  );
  NOR _43_ (
    .A(_08_),
    .B(_05_),
    .Y(data_out1[0])
  );
  NOR _44_ (
    .A(_04_),
    .B(y_1[1]),
    .Y(_09_)
  );
  NOT _45_ (
    .A(data_in[1]),
    .Y(_10_)
  );
  NAND _46_ (
    .A(_04_),
    .B(_10_),
    .Y(_11_)
  );
  NAND _47_ (
    .A(_11_),
    .B(reset_L),
    .Y(_12_)
  );
  NOR _48_ (
    .A(_12_),
    .B(_09_),
    .Y(data_out1[1])
  );
  NOR _49_ (
    .A(_04_),
    .B(y_1[2]),
    .Y(_13_)
  );
  NOT _50_ (
    .A(data_in[2]),
    .Y(_14_)
  );
  NAND _51_ (
    .A(_04_),
    .B(_14_),
    .Y(_15_)
  );
  NAND _52_ (
    .A(_15_),
    .B(reset_L),
    .Y(_16_)
  );
  NOR _53_ (
    .A(_16_),
    .B(_13_),
    .Y(data_out1[2])
  );
  NOR _54_ (
    .A(_04_),
    .B(y_1[3]),
    .Y(_17_)
  );
  NOT _55_ (
    .A(data_in[3]),
    .Y(_18_)
  );
  NAND _56_ (
    .A(_04_),
    .B(_18_),
    .Y(_19_)
  );
  NAND _57_ (
    .A(_19_),
    .B(reset_L),
    .Y(_20_)
  );
  NOR _58_ (
    .A(_20_),
    .B(_17_),
    .Y(data_out1[3])
  );
  NOR _59_ (
    .A(_01_),
    .B(selector),
    .Y(_21_)
  );
  NOR _60_ (
    .A(_21_),
    .B(y_0[0]),
    .Y(_22_)
  );
  NAND _61_ (
    .A(_21_),
    .B(_06_),
    .Y(_23_)
  );
  NAND _62_ (
    .A(_23_),
    .B(reset_L),
    .Y(_24_)
  );
  NOR _63_ (
    .A(_24_),
    .B(_22_),
    .Y(data_out0[0])
  );
  NOR _64_ (
    .A(_21_),
    .B(y_0[1]),
    .Y(_25_)
  );
  NAND _65_ (
    .A(_21_),
    .B(_10_),
    .Y(_26_)
  );
  NAND _66_ (
    .A(_26_),
    .B(reset_L),
    .Y(_27_)
  );
  NOR _67_ (
    .A(_27_),
    .B(_25_),
    .Y(data_out0[1])
  );
  NOR _68_ (
    .A(_21_),
    .B(y_0[2]),
    .Y(_28_)
  );
  NAND _69_ (
    .A(_21_),
    .B(_14_),
    .Y(_29_)
  );
  NAND _70_ (
    .A(_29_),
    .B(reset_L),
    .Y(_30_)
  );
  NOR _71_ (
    .A(_30_),
    .B(_28_),
    .Y(data_out0[2])
  );
  NOR _72_ (
    .A(_21_),
    .B(y_0[3]),
    .Y(_31_)
  );
  NAND _73_ (
    .A(_21_),
    .B(_18_),
    .Y(_32_)
  );
  NAND _74_ (
    .A(_32_),
    .B(reset_L),
    .Y(_33_)
  );
  NOR _75_ (
    .A(_33_),
    .B(_31_),
    .Y(data_out0[3])
  );
  NOR _76_ (
    .A(_02_),
    .B(selector),
    .Y(_00_)
  );
  DFF _77_ (
    .C(clk),
    .D(_00_),
    .Q(selector)
  );
  DFF _78_ (
    .C(clk),
    .D(data_out0[0]),
    .Q(y_0[0])
  );
  DFF _79_ (
    .C(clk),
    .D(data_out0[1]),
    .Q(y_0[1])
  );
  DFF _80_ (
    .C(clk),
    .D(data_out0[2]),
    .Q(y_0[2])
  );
  DFF _81_ (
    .C(clk),
    .D(data_out0[3]),
    .Q(y_0[3])
  );
  DFF _82_ (
    .C(clk),
    .D(data_out1[0]),
    .Q(y_1[0])
  );
  DFF _83_ (
    .C(clk),
    .D(data_out1[1]),
    .Q(y_1[1])
  );
  DFF _84_ (
    .C(clk),
    .D(data_out1[2]),
    .Q(y_1[2])
  );
  DFF _85_ (
    .C(clk),
    .D(data_out1[3]),
    .Q(y_1[3])
  );
endmodule

(* src = "demux_layer2_cond.v:1" *)
module demux_layer32_estr(clk, reset_L, data_out0, data_out1, data_in, valid_in, valid_out);
  (* src = "demux_layer2_cond.v:73" *)
  wire _00_;
  (* src = "demux_layer2_cond.v:73" *)
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  (* src = "demux_layer2_cond.v:2" *)
  input clk;
  (* src = "demux_layer2_cond.v:6" *)
  input [3:0] data_in;
  (* src = "demux_layer2_cond.v:4" *)
  output [3:0] data_out0;
  (* src = "demux_layer2_cond.v:5" *)
  output [3:0] data_out1;
  (* src = "demux_layer2_cond.v:14" *)
  wire old_select;
  (* src = "demux_layer2_cond.v:3" *)
  input reset_L;
  (* src = "demux_layer2_cond.v:11" *)
  wire selector;
  (* src = "demux_layer2_cond.v:7" *)
  input valid_in;
  (* src = "demux_layer2_cond.v:8" *)
  output valid_out;
  (* src = "demux_layer2_cond.v:12" *)
  wire [3:0] y_0;
  (* src = "demux_layer2_cond.v:13" *)
  wire [3:0] y_1;
  NOR _38_ (
    .A(old_select),
    .B(selector),
    .Y(_02_)
  );
  NOT _39_ (
    .A(reset_L),
    .Y(_03_)
  );
  NOR _40_ (
    .A(_03_),
    .B(old_select),
    .Y(_00_)
  );
  NOR _41_ (
    .A(_03_),
    .B(selector),
    .Y(_04_)
  );
  NOR _42_ (
    .A(_04_),
    .B(_00_),
    .Y(_05_)
  );
  NOR _43_ (
    .A(_05_),
    .B(_02_),
    .Y(_01_)
  );
  NOT _44_ (
    .A(valid_in),
    .Y(_06_)
  );
  NOR _45_ (
    .A(_06_),
    .B(_03_),
    .Y(valid_out)
  );
  NOT _46_ (
    .A(selector),
    .Y(_07_)
  );
  NOR _47_ (
    .A(_06_),
    .B(_07_),
    .Y(_08_)
  );
  NOR _48_ (
    .A(_08_),
    .B(y_1[0]),
    .Y(_09_)
  );
  NOT _49_ (
    .A(data_in[0]),
    .Y(_10_)
  );
  NAND _50_ (
    .A(_08_),
    .B(_10_),
    .Y(_11_)
  );
  NAND _51_ (
    .A(_11_),
    .B(reset_L),
    .Y(_12_)
  );
  NOR _52_ (
    .A(_12_),
    .B(_09_),
    .Y(data_out1[0])
  );
  NOR _53_ (
    .A(_08_),
    .B(y_1[1]),
    .Y(_13_)
  );
  NOT _54_ (
    .A(data_in[1]),
    .Y(_14_)
  );
  NAND _55_ (
    .A(_08_),
    .B(_14_),
    .Y(_15_)
  );
  NAND _56_ (
    .A(_15_),
    .B(reset_L),
    .Y(_16_)
  );
  NOR _57_ (
    .A(_16_),
    .B(_13_),
    .Y(data_out1[1])
  );
  NOR _58_ (
    .A(_08_),
    .B(y_1[2]),
    .Y(_17_)
  );
  NOT _59_ (
    .A(data_in[2]),
    .Y(_18_)
  );
  NAND _60_ (
    .A(_08_),
    .B(_18_),
    .Y(_19_)
  );
  NAND _61_ (
    .A(_19_),
    .B(reset_L),
    .Y(_20_)
  );
  NOR _62_ (
    .A(_20_),
    .B(_17_),
    .Y(data_out1[2])
  );
  NOR _63_ (
    .A(_08_),
    .B(y_1[3]),
    .Y(_21_)
  );
  NOT _64_ (
    .A(data_in[3]),
    .Y(_22_)
  );
  NAND _65_ (
    .A(_08_),
    .B(_22_),
    .Y(_23_)
  );
  NAND _66_ (
    .A(_23_),
    .B(reset_L),
    .Y(_24_)
  );
  NOR _67_ (
    .A(_24_),
    .B(_21_),
    .Y(data_out1[3])
  );
  NOR _68_ (
    .A(_06_),
    .B(selector),
    .Y(_25_)
  );
  NOR _69_ (
    .A(_25_),
    .B(y_0[0]),
    .Y(_26_)
  );
  NAND _70_ (
    .A(_25_),
    .B(_10_),
    .Y(_27_)
  );
  NAND _71_ (
    .A(_27_),
    .B(reset_L),
    .Y(_28_)
  );
  NOR _72_ (
    .A(_28_),
    .B(_26_),
    .Y(data_out0[0])
  );
  NOR _73_ (
    .A(_25_),
    .B(y_0[1]),
    .Y(_29_)
  );
  NAND _74_ (
    .A(_25_),
    .B(_14_),
    .Y(_30_)
  );
  NAND _75_ (
    .A(_30_),
    .B(reset_L),
    .Y(_31_)
  );
  NOR _76_ (
    .A(_31_),
    .B(_29_),
    .Y(data_out0[1])
  );
  NOR _77_ (
    .A(_25_),
    .B(y_0[2]),
    .Y(_32_)
  );
  NAND _78_ (
    .A(_25_),
    .B(_18_),
    .Y(_33_)
  );
  NAND _79_ (
    .A(_33_),
    .B(reset_L),
    .Y(_34_)
  );
  NOR _80_ (
    .A(_34_),
    .B(_32_),
    .Y(data_out0[2])
  );
  NOR _81_ (
    .A(_25_),
    .B(y_0[3]),
    .Y(_35_)
  );
  NAND _82_ (
    .A(_25_),
    .B(_22_),
    .Y(_36_)
  );
  NAND _83_ (
    .A(_36_),
    .B(reset_L),
    .Y(_37_)
  );
  NOR _84_ (
    .A(_37_),
    .B(_35_),
    .Y(data_out0[3])
  );
  DFF _85_ (
    .C(clk),
    .D(_01_),
    .Q(selector)
  );
  DFF _86_ (
    .C(clk),
    .D(_00_),
    .Q(old_select)
  );
  DFF _87_ (
    .C(clk),
    .D(data_out0[0]),
    .Q(y_0[0])
  );
  DFF _88_ (
    .C(clk),
    .D(data_out0[1]),
    .Q(y_0[1])
  );
  DFF _89_ (
    .C(clk),
    .D(data_out0[2]),
    .Q(y_0[2])
  );
  DFF _90_ (
    .C(clk),
    .D(data_out0[3]),
    .Q(y_0[3])
  );
  DFF _91_ (
    .C(clk),
    .D(data_out1[0]),
    .Q(y_1[0])
  );
  DFF _92_ (
    .C(clk),
    .D(data_out1[1]),
    .Q(y_1[1])
  );
  DFF _93_ (
    .C(clk),
    .D(data_out1[2]),
    .Q(y_1[2])
  );
  DFF _94_ (
    .C(clk),
    .D(data_out1[3]),
    .Q(y_1[3])
  );
endmodule

(* top =  1  *)
(* src = "demux_layer3_cond.v:4" *)
module demux_layer3_estr(clk, reset_L, data_out00, data_out01, data_out10, data_out11, data_in, valid_in, valid_out);
  wire _0_;
  wire _1_;
  (* src = "demux_layer3_cond.v:5" *)
  input clk;
  (* src = "demux_layer3_cond.v:11" *)
  input [3:0] data_in;
  (* src = "demux_layer3_cond.v:7" *)
  output [3:0] data_out00;
  (* src = "demux_layer3_cond.v:8" *)
  output [3:0] data_out01;
  (* src = "demux_layer3_cond.v:31" *)
  wire [3:0] data_out0_demux1;
  (* src = "demux_layer3_cond.v:9" *)
  output [3:0] data_out10;
  (* src = "demux_layer3_cond.v:10" *)
  output [3:0] data_out11;
  (* src = "demux_layer3_cond.v:32" *)
  wire [3:0] data_out1_demux1;
  (* src = "demux_layer3_cond.v:6" *)
  input reset_L;
  (* src = "demux_layer3_cond.v:16" *)
  wire reset_demux3;
  (* src = "demux_layer3_cond.v:17" *)
  wire reset_retrasado;
  (* src = "demux_layer3_cond.v:12" *)
  input valid_in;
  (* src = "demux_layer3_cond.v:13" *)
  output [1:0] valid_out;
  (* src = "demux_layer3_cond.v:33" *)
  wire valido;
  NOT _2_ (
    .A(reset_retrasado),
    .Y(_0_)
  );
  NOT _3_ (
    .A(reset_L),
    .Y(_1_)
  );
  NOR _4_ (
    .A(_1_),
    .B(_0_),
    .Y(reset_demux3)
  );
  DFF _5_ (
    .C(clk),
    .D(reset_L),
    .Q(reset_retrasado)
  );
  (* src = "demux_layer3_cond.v:36" *)
  demux_layer31_estr demux1_layer1 (
    .clk(clk),
    .data_in(data_in),
    .data_out0(data_out0_demux1),
    .data_out1(data_out1_demux1),
    .reset_L(reset_L),
    .valid_in(valid_in),
    .valid_out(valido)
  );
  (* src = "demux_layer3_cond.v:47" *)
  demux_layer32_estr demux2_layer2 (
    .clk(clk),
    .data_in(data_out0_demux1),
    .data_out0(data_out00),
    .data_out1(data_out10),
    .reset_L(reset_L),
    .valid_in(valido),
    .valid_out(valid_out[0])
  );
  (* src = "demux_layer3_cond.v:58" *)
  demux_layer32_estr demux3_layer2 (
    .clk(clk),
    .data_in(data_out1_demux1),
    .data_out0(data_out01),
    .data_out1(data_out11),
    .reset_L(reset_demux3),
    .valid_in(valido),
    .valid_out(valid_out[1])
  );
endmodule
