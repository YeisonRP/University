/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "demux_conductual.v:1" *)
module demux_estructural_sintetizado(clk, reset_L, data_out0, data_out1, data_in);
  (* src = "demux_conductual.v:62" *)
  wire _00_;
  (* src = "demux_conductual.v:15" *)
  wire [3:0] _01_;
  (* src = "demux_conductual.v:15" *)
  wire [3:0] _02_;
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
  (* src = "demux_conductual.v:2" *)
  input clk;
  (* src = "demux_conductual.v:6" *)
  input [3:0] data_in;
  (* src = "demux_conductual.v:4" *)
  output [3:0] data_out0;
  (* src = "demux_conductual.v:5" *)
  output [3:0] data_out1;
  (* src = "demux_conductual.v:3" *)
  input reset_L;
  (* src = "demux_conductual.v:8" *)
  reg selector;
  (* src = "demux_conductual.v:11" *)
  reg [3:0] y_0;
  (* src = "demux_conductual.v:12" *)
  reg [3:0] y_1;
  assign _03_ = ~reset_L;
  assign _00_ = ~(_03_ | selector);
  assign _04_ = ~y_1[2];
  assign _05_ = _03_ | selector;
  assign _06_ = ~(reset_L & selector);
  assign _07_ = ~(data_in[2] & selector);
  assign data_out1[2] = ~((_07_ | _06_) & (_05_ | _04_));
  assign _08_ = ~y_1[3];
  assign _09_ = ~(data_in[3] & selector);
  assign data_out1[3] = ~((_06_ | _09_) & (_05_ | _08_));
  assign _10_ = ~((_03_ | selector) & y_0[0]);
  assign _11_ = ~data_in[0];
  assign _12_ = selector | _11_;
  assign data_out0[0] = ~((_12_ | _05_) & (_10_ | _06_));
  assign _13_ = ~((_03_ | selector) & y_0[1]);
  assign _14_ = ~data_in[1];
  assign _15_ = _14_ | selector;
  assign data_out0[1] = ~((_15_ | _05_) & (_13_ | _06_));
  assign _16_ = ~((_03_ | selector) & y_0[2]);
  assign _17_ = ~data_in[2];
  assign _18_ = _17_ | selector;
  assign data_out0[2] = ~((_18_ | _05_) & (_16_ | _06_));
  assign _19_ = ~((_03_ | selector) & y_0[3]);
  assign _20_ = ~data_in[3];
  assign _21_ = _20_ | selector;
  assign data_out0[3] = ~((_21_ | _05_) & (_19_ | _06_));
  assign _22_ = selector ? data_in[0] : y_1[0];
  assign _02_[0] = _22_ & reset_L;
  assign _23_ = selector ? data_in[1] : y_1[1];
  assign _02_[1] = _23_ & reset_L;
  assign _24_ = selector ? data_in[2] : y_1[2];
  assign _02_[2] = _24_ & reset_L;
  assign _25_ = selector ? data_in[3] : y_1[3];
  assign _02_[3] = _25_ & reset_L;
  assign _26_ = selector ? y_0[0] : data_in[0];
  assign _01_[0] = _26_ & reset_L;
  assign _27_ = selector ? y_0[1] : data_in[1];
  assign _01_[1] = _27_ & reset_L;
  assign _28_ = selector ? y_0[2] : data_in[2];
  assign _01_[2] = _28_ & reset_L;
  assign _29_ = selector ? y_0[3] : data_in[3];
  assign _01_[3] = _29_ & reset_L;
  assign _30_ = ~y_1[0];
  assign _31_ = ~(selector & data_in[0]);
  assign data_out1[0] = ~((_31_ | _06_) & (_05_ | _30_));
  assign _32_ = ~y_1[1];
  assign _33_ = ~(data_in[1] & selector);
  assign data_out1[1] = ~((_33_ | _06_) & (_05_ | _32_));
  (* src = "demux_conductual.v:62" *)
  always @(posedge clk)
      selector <= _00_;
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_0[0] <= _01_[0];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_0[1] <= _01_[1];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_0[2] <= _01_[2];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_0[3] <= _01_[3];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_1[0] <= _02_[0];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_1[1] <= _02_[1];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_1[2] <= _02_[2];
  (* src = "demux_conductual.v:15" *)
  always @(posedge clk)
      y_1[3] <= _02_[3];
endmodule