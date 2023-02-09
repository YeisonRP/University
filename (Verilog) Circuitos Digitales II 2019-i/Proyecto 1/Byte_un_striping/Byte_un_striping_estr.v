`include "cmos.v"
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "Byte_un_striping_cond.v:1" *)
module Byte_un_striping_estr(clk_f, clk_2f, lane_0, lane_1, valid_0, valid_1, reset, data_out_e, valid_out_e);
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
  (* src = "Byte_un_striping_cond.v:3" *)
  input clk_2f;
  (* src = "Byte_un_striping_cond.v:2" *)
  input clk_f;
  (* src = "Byte_un_striping_cond.v:9" *)
  output [7:0] data_out_e;
  (* onehot = 32'd1 *)
  wire [2:0] estado;
  (* src = "Byte_un_striping_cond.v:4" *)
  input [7:0] lane_0;
  (* src = "Byte_un_striping_cond.v:5" *)
  input [7:0] lane_1;
  (* src = "Byte_un_striping_cond.v:8" *)
  input reset;
  (* src = "Byte_un_striping_cond.v:6" *)
  input valid_0;
  (* src = "Byte_un_striping_cond.v:7" *)
  input valid_1;
  (* src = "Byte_un_striping_cond.v:10" *)
  output valid_out_e;
  NOT _34_ (
    .A(valid_0),
    .Y(_01_)
  );
  NOT _35_ (
    .A(estado[1]),
    .Y(_02_)
  );
  NOT _36_ (
    .A(estado[0]),
    .Y(_03_)
  );
  NAND _37_ (
    .A(_03_),
    .B(_02_),
    .Y(_04_)
  );
  NAND _38_ (
    .A(_04_),
    .B(_01_),
    .Y(_05_)
  );
  NOT _39_ (
    .A(reset),
    .Y(_06_)
  );
  NOT _40_ (
    .A(estado[2]),
    .Y(_07_)
  );
  NOR _41_ (
    .A(_07_),
    .B(valid_1),
    .Y(_08_)
  );
  NOR _42_ (
    .A(_08_),
    .B(_06_),
    .Y(_09_)
  );
  NAND _43_ (
    .A(_09_),
    .B(_05_),
    .Y(_00_)
  );
  NAND _44_ (
    .A(estado[2]),
    .B(valid_1),
    .Y(_10_)
  );
  NAND _45_ (
    .A(_04_),
    .B(valid_0),
    .Y(_11_)
  );
  NAND _46_ (
    .A(_11_),
    .B(_10_),
    .Y(valid_out_e)
  );
  NOT _47_ (
    .A(valid_1),
    .Y(_12_)
  );
  NOR _48_ (
    .A(_07_),
    .B(_12_),
    .Y(_13_)
  );
  NAND _49_ (
    .A(_13_),
    .B(lane_1[0]),
    .Y(_14_)
  );
  NOR _50_ (
    .A(estado[0]),
    .B(estado[1]),
    .Y(_15_)
  );
  NOR _51_ (
    .A(_15_),
    .B(_01_),
    .Y(_16_)
  );
  NAND _52_ (
    .A(_16_),
    .B(lane_0[0]),
    .Y(_17_)
  );
  NAND _53_ (
    .A(_17_),
    .B(_14_),
    .Y(data_out_e[0])
  );
  NAND _54_ (
    .A(_13_),
    .B(lane_1[1]),
    .Y(_18_)
  );
  NAND _55_ (
    .A(_16_),
    .B(lane_0[1]),
    .Y(_19_)
  );
  NAND _56_ (
    .A(_19_),
    .B(_18_),
    .Y(data_out_e[1])
  );
  NAND _57_ (
    .A(_13_),
    .B(lane_1[2]),
    .Y(_20_)
  );
  NAND _58_ (
    .A(_16_),
    .B(lane_0[2]),
    .Y(_21_)
  );
  NAND _59_ (
    .A(_21_),
    .B(_20_),
    .Y(data_out_e[2])
  );
  NAND _60_ (
    .A(_13_),
    .B(lane_1[3]),
    .Y(_22_)
  );
  NAND _61_ (
    .A(_16_),
    .B(lane_0[3]),
    .Y(_23_)
  );
  NAND _62_ (
    .A(_23_),
    .B(_22_),
    .Y(data_out_e[3])
  );
  NAND _63_ (
    .A(_13_),
    .B(lane_1[4]),
    .Y(_24_)
  );
  NAND _64_ (
    .A(_16_),
    .B(lane_0[4]),
    .Y(_25_)
  );
  NAND _65_ (
    .A(_25_),
    .B(_24_),
    .Y(data_out_e[4])
  );
  NAND _66_ (
    .A(_13_),
    .B(lane_1[5]),
    .Y(_26_)
  );
  NAND _67_ (
    .A(_16_),
    .B(lane_0[5]),
    .Y(_27_)
  );
  NAND _68_ (
    .A(_27_),
    .B(_26_),
    .Y(data_out_e[5])
  );
  NAND _69_ (
    .A(_13_),
    .B(lane_1[6]),
    .Y(_28_)
  );
  NAND _70_ (
    .A(_16_),
    .B(lane_0[6]),
    .Y(_29_)
  );
  NAND _71_ (
    .A(_29_),
    .B(_28_),
    .Y(data_out_e[6])
  );
  NAND _72_ (
    .A(_13_),
    .B(lane_1[7]),
    .Y(_30_)
  );
  NAND _73_ (
    .A(_16_),
    .B(lane_0[7]),
    .Y(_31_)
  );
  NAND _74_ (
    .A(_31_),
    .B(_30_),
    .Y(data_out_e[7])
  );
  NOR _75_ (
    .A(_11_),
    .B(_06_),
    .Y(_32_)
  );
  NOR _76_ (
    .A(_10_),
    .B(_06_),
    .Y(_33_)
  );
  DFF _77_ (
    .C(clk_2f),
    .D(_00_),
    .Q(estado[0])
  );
  DFF _78_ (
    .C(clk_2f),
    .D(_33_),
    .Q(estado[1])
  );
  DFF _79_ (
    .C(clk_2f),
    .D(_32_),
    .Q(estado[2])
  );
endmodule