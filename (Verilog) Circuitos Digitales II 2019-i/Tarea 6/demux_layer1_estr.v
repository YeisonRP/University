
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "demux_layer1_cond.v:1" *)
module demux_layer1_estr(clk, reset_L, data_out0, data_out1, data_in, valid_in, valid_out);
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