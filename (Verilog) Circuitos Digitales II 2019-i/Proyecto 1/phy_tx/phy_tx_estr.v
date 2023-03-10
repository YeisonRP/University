`include "cmos.v"
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* src = "Byte_striping_estr.v:1" *)
module Byte_striping_estr(clk_2f, valid_in, data_in, reset, lane_0_c, lane_1_c, valid_0_c, valid_1_c);
  (* src = "Byte_striping_estr.v:80" *)
  wire _000_;
  (* src = "Byte_striping_estr.v:20" *)
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  (* src = "Byte_striping_estr.v:2" *)
  input clk_2f;
  (* src = "Byte_striping_estr.v:4" *)
  input [7:0] data_in;
  (* src = "Byte_striping_estr.v:6" *)
  output [7:0] lane_0_c;
  (* src = "Byte_striping_estr.v:7" *)
  output [7:0] lane_1_c;
  (* src = "Byte_striping_estr.v:5" *)
  input reset;
  (* src = "Byte_striping_estr.v:12" *)
  wire selector;
  (* src = "Byte_striping_estr.v:8" *)
  output valid_0_c;
  (* src = "Byte_striping_estr.v:9" *)
  output valid_1_c;
  (* src = "Byte_striping_estr.v:14" *)
  wire valid_atrasado;
  (* src = "Byte_striping_estr.v:3" *)
  input valid_in;
  (* src = "Byte_striping_estr.v:13" *)
  wire [7:0] y_0;
  (* src = "Byte_striping_estr.v:13" *)
  wire [7:0] y_1;
  NOT _065_ (
    .A(reset),
    .Y(_026_)
  );
  NOR _066_ (
    .A(valid_in),
    .B(selector),
    .Y(_027_)
  );
  NOR _067_ (
    .A(_027_),
    .B(_026_),
    .Y(valid_0_c)
  );
  NOT _068_ (
    .A(valid_in),
    .Y(_028_)
  );
  NOR _069_ (
    .A(_028_),
    .B(selector),
    .Y(_000_)
  );
  NOR _070_ (
    .A(_000_),
    .B(y_0[0]),
    .Y(_029_)
  );
  NOT _071_ (
    .A(data_in[0]),
    .Y(_030_)
  );
  NAND _072_ (
    .A(_000_),
    .B(_030_),
    .Y(_031_)
  );
  NAND _073_ (
    .A(_031_),
    .B(reset),
    .Y(_032_)
  );
  NOR _074_ (
    .A(_032_),
    .B(_029_),
    .Y(lane_0_c[0])
  );
  NOR _075_ (
    .A(_000_),
    .B(y_0[1]),
    .Y(_033_)
  );
  NOT _076_ (
    .A(data_in[1]),
    .Y(_034_)
  );
  NAND _077_ (
    .A(_000_),
    .B(_034_),
    .Y(_035_)
  );
  NAND _078_ (
    .A(_035_),
    .B(reset),
    .Y(_036_)
  );
  NOR _079_ (
    .A(_036_),
    .B(_033_),
    .Y(lane_0_c[1])
  );
  NOR _080_ (
    .A(_000_),
    .B(y_0[2]),
    .Y(_037_)
  );
  NOT _081_ (
    .A(data_in[2]),
    .Y(_038_)
  );
  NAND _082_ (
    .A(_000_),
    .B(_038_),
    .Y(_039_)
  );
  NAND _083_ (
    .A(_039_),
    .B(reset),
    .Y(_040_)
  );
  NOR _084_ (
    .A(_040_),
    .B(_037_),
    .Y(lane_0_c[2])
  );
  NOR _085_ (
    .A(_000_),
    .B(y_0[3]),
    .Y(_041_)
  );
  NOT _086_ (
    .A(data_in[3]),
    .Y(_042_)
  );
  NAND _087_ (
    .A(_000_),
    .B(_042_),
    .Y(_043_)
  );
  NAND _088_ (
    .A(_043_),
    .B(reset),
    .Y(_044_)
  );
  NOR _089_ (
    .A(_044_),
    .B(_041_),
    .Y(lane_0_c[3])
  );
  NOR _090_ (
    .A(_000_),
    .B(y_0[4]),
    .Y(_045_)
  );
  NOT _091_ (
    .A(data_in[4]),
    .Y(_046_)
  );
  NAND _092_ (
    .A(_000_),
    .B(_046_),
    .Y(_047_)
  );
  NAND _093_ (
    .A(_047_),
    .B(reset),
    .Y(_048_)
  );
  NOR _094_ (
    .A(_048_),
    .B(_045_),
    .Y(lane_0_c[4])
  );
  NOR _095_ (
    .A(_000_),
    .B(y_0[5]),
    .Y(_049_)
  );
  NOT _096_ (
    .A(data_in[5]),
    .Y(_050_)
  );
  NAND _097_ (
    .A(_000_),
    .B(_050_),
    .Y(_051_)
  );
  NAND _098_ (
    .A(_051_),
    .B(reset),
    .Y(_052_)
  );
  NOR _099_ (
    .A(_052_),
    .B(_049_),
    .Y(lane_0_c[5])
  );
  NOR _100_ (
    .A(_000_),
    .B(y_0[6]),
    .Y(_053_)
  );
  NOT _101_ (
    .A(data_in[6]),
    .Y(_054_)
  );
  NAND _102_ (
    .A(_000_),
    .B(_054_),
    .Y(_055_)
  );
  NAND _103_ (
    .A(_055_),
    .B(reset),
    .Y(_056_)
  );
  NOR _104_ (
    .A(_056_),
    .B(_053_),
    .Y(lane_0_c[6])
  );
  NOR _105_ (
    .A(_000_),
    .B(y_0[7]),
    .Y(_057_)
  );
  NOT _106_ (
    .A(data_in[7]),
    .Y(_058_)
  );
  NAND _107_ (
    .A(_000_),
    .B(_058_),
    .Y(_059_)
  );
  NAND _108_ (
    .A(_059_),
    .B(reset),
    .Y(_060_)
  );
  NOR _109_ (
    .A(_060_),
    .B(_057_),
    .Y(lane_0_c[7])
  );
  NOT _110_ (
    .A(selector),
    .Y(_061_)
  );
  NOR _111_ (
    .A(valid_in),
    .B(_061_),
    .Y(_062_)
  );
  NAND _112_ (
    .A(reset),
    .B(valid_atrasado),
    .Y(_063_)
  );
  NOR _113_ (
    .A(_063_),
    .B(_062_),
    .Y(valid_1_c)
  );
  NOR _114_ (
    .A(_026_),
    .B(_028_),
    .Y(_001_)
  );
  NOR _115_ (
    .A(_028_),
    .B(_061_),
    .Y(_064_)
  );
  NOR _116_ (
    .A(_064_),
    .B(y_1[0]),
    .Y(_002_)
  );
  NAND _117_ (
    .A(_064_),
    .B(_030_),
    .Y(_003_)
  );
  NAND _118_ (
    .A(_003_),
    .B(reset),
    .Y(_004_)
  );
  NOR _119_ (
    .A(_004_),
    .B(_002_),
    .Y(lane_1_c[0])
  );
  NOR _120_ (
    .A(_064_),
    .B(y_1[1]),
    .Y(_005_)
  );
  NAND _121_ (
    .A(_064_),
    .B(_034_),
    .Y(_006_)
  );
  NAND _122_ (
    .A(_006_),
    .B(reset),
    .Y(_007_)
  );
  NOR _123_ (
    .A(_007_),
    .B(_005_),
    .Y(lane_1_c[1])
  );
  NOR _124_ (
    .A(_064_),
    .B(y_1[2]),
    .Y(_008_)
  );
  NAND _125_ (
    .A(_064_),
    .B(_038_),
    .Y(_009_)
  );
  NAND _126_ (
    .A(_009_),
    .B(reset),
    .Y(_010_)
  );
  NOR _127_ (
    .A(_010_),
    .B(_008_),
    .Y(lane_1_c[2])
  );
  NOR _128_ (
    .A(_064_),
    .B(y_1[3]),
    .Y(_011_)
  );
  NAND _129_ (
    .A(_064_),
    .B(_042_),
    .Y(_012_)
  );
  NAND _130_ (
    .A(_012_),
    .B(reset),
    .Y(_013_)
  );
  NOR _131_ (
    .A(_013_),
    .B(_011_),
    .Y(lane_1_c[3])
  );
  NOR _132_ (
    .A(_064_),
    .B(y_1[4]),
    .Y(_014_)
  );
  NAND _133_ (
    .A(_064_),
    .B(_046_),
    .Y(_015_)
  );
  NAND _134_ (
    .A(_015_),
    .B(reset),
    .Y(_016_)
  );
  NOR _135_ (
    .A(_016_),
    .B(_014_),
    .Y(lane_1_c[4])
  );
  NOR _136_ (
    .A(_064_),
    .B(y_1[5]),
    .Y(_017_)
  );
  NAND _137_ (
    .A(_064_),
    .B(_050_),
    .Y(_018_)
  );
  NAND _138_ (
    .A(_018_),
    .B(reset),
    .Y(_019_)
  );
  NOR _139_ (
    .A(_019_),
    .B(_017_),
    .Y(lane_1_c[5])
  );
  NOR _140_ (
    .A(_064_),
    .B(y_1[6]),
    .Y(_020_)
  );
  NAND _141_ (
    .A(_064_),
    .B(_054_),
    .Y(_021_)
  );
  NAND _142_ (
    .A(_021_),
    .B(reset),
    .Y(_022_)
  );
  NOR _143_ (
    .A(_022_),
    .B(_020_),
    .Y(lane_1_c[6])
  );
  NOR _144_ (
    .A(_064_),
    .B(y_1[7]),
    .Y(_023_)
  );
  NAND _145_ (
    .A(_064_),
    .B(_058_),
    .Y(_024_)
  );
  NAND _146_ (
    .A(_024_),
    .B(reset),
    .Y(_025_)
  );
  NOR _147_ (
    .A(_025_),
    .B(_023_),
    .Y(lane_1_c[7])
  );
  DFF _148_ (
    .C(clk_2f),
    .D(_000_),
    .Q(selector)
  );
  DFF _149_ (
    .C(clk_2f),
    .D(lane_0_c[0]),
    .Q(y_0[0])
  );
  DFF _150_ (
    .C(clk_2f),
    .D(lane_0_c[1]),
    .Q(y_0[1])
  );
  DFF _151_ (
    .C(clk_2f),
    .D(lane_0_c[2]),
    .Q(y_0[2])
  );
  DFF _152_ (
    .C(clk_2f),
    .D(lane_0_c[3]),
    .Q(y_0[3])
  );
  DFF _153_ (
    .C(clk_2f),
    .D(lane_0_c[4]),
    .Q(y_0[4])
  );
  DFF _154_ (
    .C(clk_2f),
    .D(lane_0_c[5]),
    .Q(y_0[5])
  );
  DFF _155_ (
    .C(clk_2f),
    .D(lane_0_c[6]),
    .Q(y_0[6])
  );
  DFF _156_ (
    .C(clk_2f),
    .D(lane_0_c[7]),
    .Q(y_0[7])
  );
  DFF _157_ (
    .C(clk_2f),
    .D(lane_1_c[0]),
    .Q(y_1[0])
  );
  DFF _158_ (
    .C(clk_2f),
    .D(lane_1_c[1]),
    .Q(y_1[1])
  );
  DFF _159_ (
    .C(clk_2f),
    .D(lane_1_c[2]),
    .Q(y_1[2])
  );
  DFF _160_ (
    .C(clk_2f),
    .D(lane_1_c[3]),
    .Q(y_1[3])
  );
  DFF _161_ (
    .C(clk_2f),
    .D(lane_1_c[4]),
    .Q(y_1[4])
  );
  DFF _162_ (
    .C(clk_2f),
    .D(lane_1_c[5]),
    .Q(y_1[5])
  );
  DFF _163_ (
    .C(clk_2f),
    .D(lane_1_c[6]),
    .Q(y_1[6])
  );
  DFF _164_ (
    .C(clk_2f),
    .D(lane_1_c[7]),
    .Q(y_1[7])
  );
  DFF _165_ (
    .C(clk_2f),
    .D(_001_),
    .Q(valid_atrasado)
  );
endmodule

(* src = "Paralelo_Serie_estructural.v:2" *)
module Paralelo_Serie_estructural(clk_8f, clk_f, data_in, valid_in, reset, data2send_c, data_out_c);
  (* src = "Paralelo_Serie_estructural.v:30" *)
  wire [2:0] _000_;
  (* src = "Paralelo_Serie_estructural.v:39" *)
  wire [2:0] _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  (* src = "Paralelo_Serie_estructural.v:2" *)
  input clk_8f;
  (* src = "Paralelo_Serie_estructural.v:3" *)
  input clk_f;
  (* src = "Paralelo_Serie_estructural.v:7" *)
  output [7:0] data2send_c;
  (* src = "Paralelo_Serie_estructural.v:4" *)
  input [7:0] data_in;
  (* src = "Paralelo_Serie_estructural.v:8" *)
  output data_out_c;
  (* src = "Paralelo_Serie_estructural.v:11" *)
  wire [2:0] j;
  (* src = "Paralelo_Serie_estructural.v:11" *)
  wire [2:0] k;
  (* src = "Paralelo_Serie_estructural.v:6" *)
  input reset;
  (* src = "Paralelo_Serie_estructural.v:5" *)
  input valid_in;
  NOT _062_ (
    .A(data_in[1]),
    .Y(_007_)
  );
  NOT _063_ (
    .A(valid_in),
    .Y(_008_)
  );
  NOR _064_ (
    .A(_008_),
    .B(_007_),
    .Y(data2send_c[1])
  );
  NOT _065_ (
    .A(data_in[2]),
    .Y(_009_)
  );
  NAND _066_ (
    .A(_009_),
    .B(valid_in),
    .Y(data2send_c[2])
  );
  NOT _067_ (
    .A(data_in[3]),
    .Y(_010_)
  );
  NAND _068_ (
    .A(_010_),
    .B(valid_in),
    .Y(data2send_c[3])
  );
  NOT _069_ (
    .A(data_in[4]),
    .Y(_011_)
  );
  NAND _070_ (
    .A(_011_),
    .B(valid_in),
    .Y(data2send_c[4])
  );
  NOT _071_ (
    .A(data_in[5]),
    .Y(_012_)
  );
  NAND _072_ (
    .A(_012_),
    .B(valid_in),
    .Y(data2send_c[5])
  );
  NOT _073_ (
    .A(data_in[6]),
    .Y(_013_)
  );
  NOR _074_ (
    .A(_013_),
    .B(_008_),
    .Y(data2send_c[6])
  );
  NOT _075_ (
    .A(data_in[7]),
    .Y(_014_)
  );
  NAND _076_ (
    .A(_014_),
    .B(valid_in),
    .Y(data2send_c[7])
  );
  NAND _077_ (
    .A(reset),
    .B(valid_in),
    .Y(_015_)
  );
  NOT _078_ (
    .A(_015_),
    .Y(_016_)
  );
  NAND _079_ (
    .A(_016_),
    .B(k[0]),
    .Y(_001_[0])
  );
  NOR _080_ (
    .A(k[0]),
    .B(k[1]),
    .Y(_017_)
  );
  NOT _081_ (
    .A(_017_),
    .Y(_018_)
  );
  NAND _082_ (
    .A(k[0]),
    .B(k[1]),
    .Y(_019_)
  );
  NOT _083_ (
    .A(_019_),
    .Y(_020_)
  );
  NOR _084_ (
    .A(_020_),
    .B(_015_),
    .Y(_021_)
  );
  NAND _085_ (
    .A(_021_),
    .B(_018_),
    .Y(_001_[1])
  );
  NOT _086_ (
    .A(k[2]),
    .Y(_022_)
  );
  NAND _087_ (
    .A(_017_),
    .B(_022_),
    .Y(_023_)
  );
  NOR _088_ (
    .A(_017_),
    .B(_022_),
    .Y(_024_)
  );
  NOR _089_ (
    .A(_024_),
    .B(_015_),
    .Y(_025_)
  );
  NAND _090_ (
    .A(_025_),
    .B(_023_),
    .Y(_001_[2])
  );
  NAND _091_ (
    .A(j[0]),
    .B(reset),
    .Y(_000_[0])
  );
  NOR _092_ (
    .A(j[1]),
    .B(j[0]),
    .Y(_026_)
  );
  NOT _093_ (
    .A(_026_),
    .Y(_027_)
  );
  NOT _094_ (
    .A(reset),
    .Y(_028_)
  );
  NOT _095_ (
    .A(j[0]),
    .Y(_029_)
  );
  NOT _096_ (
    .A(j[1]),
    .Y(_030_)
  );
  NOR _097_ (
    .A(_030_),
    .B(_029_),
    .Y(_031_)
  );
  NOR _098_ (
    .A(_031_),
    .B(_028_),
    .Y(_032_)
  );
  NAND _099_ (
    .A(_032_),
    .B(_027_),
    .Y(_000_[1])
  );
  NOT _100_ (
    .A(j[2]),
    .Y(_033_)
  );
  NAND _101_ (
    .A(_026_),
    .B(_033_),
    .Y(_034_)
  );
  NOR _102_ (
    .A(_026_),
    .B(_033_),
    .Y(_035_)
  );
  NOR _103_ (
    .A(_035_),
    .B(_028_),
    .Y(_036_)
  );
  NAND _104_ (
    .A(_036_),
    .B(_034_),
    .Y(_000_[2])
  );
  NOR _105_ (
    .A(_033_),
    .B(j[0]),
    .Y(_037_)
  );
  NAND _106_ (
    .A(_037_),
    .B(j[1]),
    .Y(_038_)
  );
  NOR _107_ (
    .A(j[1]),
    .B(j[2]),
    .Y(_039_)
  );
  NAND _108_ (
    .A(reset),
    .B(_008_),
    .Y(_040_)
  );
  NOR _109_ (
    .A(_040_),
    .B(_039_),
    .Y(_041_)
  );
  NAND _110_ (
    .A(_041_),
    .B(_038_),
    .Y(_042_)
  );
  NAND _111_ (
    .A(_022_),
    .B(_010_),
    .Y(_043_)
  );
  NAND _112_ (
    .A(k[2]),
    .B(_014_),
    .Y(_044_)
  );
  NAND _113_ (
    .A(_044_),
    .B(_043_),
    .Y(_045_)
  );
  NOR _114_ (
    .A(_045_),
    .B(_019_),
    .Y(_046_)
  );
  NAND _115_ (
    .A(k[2]),
    .B(_011_),
    .Y(_047_)
  );
  NOT _116_ (
    .A(data_in[0]),
    .Y(_048_)
  );
  NAND _117_ (
    .A(_048_),
    .B(_022_),
    .Y(_049_)
  );
  NAND _118_ (
    .A(_049_),
    .B(_047_),
    .Y(_050_)
  );
  NOR _119_ (
    .A(_050_),
    .B(_018_),
    .Y(_051_)
  );
  NOR _120_ (
    .A(_051_),
    .B(_046_),
    .Y(_052_)
  );
  NOT _121_ (
    .A(k[1]),
    .Y(_053_)
  );
  NAND _122_ (
    .A(k[0]),
    .B(_053_),
    .Y(_054_)
  );
  NAND _123_ (
    .A(_022_),
    .B(_007_),
    .Y(_055_)
  );
  NAND _124_ (
    .A(k[2]),
    .B(_012_),
    .Y(_056_)
  );
  NAND _125_ (
    .A(_056_),
    .B(_055_),
    .Y(_057_)
  );
  NOR _126_ (
    .A(_057_),
    .B(_054_),
    .Y(_058_)
  );
  NOR _127_ (
    .A(_022_),
    .B(data_in[6]),
    .Y(_059_)
  );
  NOR _128_ (
    .A(k[0]),
    .B(_053_),
    .Y(_060_)
  );
  NAND _129_ (
    .A(_022_),
    .B(_009_),
    .Y(_061_)
  );
  NAND _130_ (
    .A(_061_),
    .B(_060_),
    .Y(_002_)
  );
  NOR _131_ (
    .A(_002_),
    .B(_059_),
    .Y(_003_)
  );
  NOR _132_ (
    .A(_003_),
    .B(_058_),
    .Y(_004_)
  );
  NAND _133_ (
    .A(_004_),
    .B(_052_),
    .Y(_005_)
  );
  NAND _134_ (
    .A(_005_),
    .B(_016_),
    .Y(_006_)
  );
  NAND _135_ (
    .A(_006_),
    .B(_042_),
    .Y(data_out_c)
  );
  NOR _136_ (
    .A(_048_),
    .B(_008_),
    .Y(data2send_c[0])
  );
  DFF _137_ (
    .C(clk_8f),
    .D(_001_[0]),
    .Q(k[0])
  );
  DFF _138_ (
    .C(clk_8f),
    .D(_001_[1]),
    .Q(k[1])
  );
  DFF _139_ (
    .C(clk_8f),
    .D(_001_[2]),
    .Q(k[2])
  );
  DFF _140_ (
    .C(clk_8f),
    .D(_000_[0]),
    .Q(j[0])
  );
  DFF _141_ (
    .C(clk_8f),
    .D(_000_[1]),
    .Q(j[1])
  );
  DFF _142_ (
    .C(clk_8f),
    .D(_000_[2]),
    .Q(j[2])
  );
endmodule

(* src = "mux_estr.v:1" *)
module mux_estr(data_out_c, valid_out_c, data_in_0_c, valid_in_0_c, data_in_1_c, valid_in_1_c, reset, clk_2f, clk_8f);
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  (* src = "mux_estr.v:9" *)
  input clk_2f;
  (* src = "mux_estr.v:10" *)
  input clk_8f;
  (* src = "mux_estr.v:4" *)
  input [7:0] data_in_0_c;
  (* src = "mux_estr.v:6" *)
  input [7:0] data_in_1_c;
  (* src = "mux_estr.v:2" *)
  output [7:0] data_out_c;
  (* src = "mux_estr.v:8" *)
  input reset;
  (* src = "mux_estr.v:13" *)
  wire reset2;
  (* src = "mux_estr.v:13" *)
  wire resetm;
  (* onehot = 32'd1 *)
  wire [5:0] st;
  (* src = "mux_estr.v:5" *)
  input valid_in_0_c;
  (* src = "mux_estr.v:7" *)
  input valid_in_1_c;
  (* src = "mux_estr.v:3" *)
  output valid_out_c;
  NOT _079_ (
    .A(st[1]),
    .Y(_027_)
  );
  NOR _080_ (
    .A(st[2]),
    .B(st[5]),
    .Y(_028_)
  );
  NAND _081_ (
    .A(_028_),
    .B(_027_),
    .Y(_029_)
  );
  NOT _082_ (
    .A(reset2),
    .Y(_030_)
  );
  NOT _083_ (
    .A(valid_in_0_c),
    .Y(_031_)
  );
  NAND _084_ (
    .A(valid_in_1_c),
    .B(_031_),
    .Y(_032_)
  );
  NOR _085_ (
    .A(_032_),
    .B(_030_),
    .Y(_033_)
  );
  NAND _086_ (
    .A(_033_),
    .B(_029_),
    .Y(_034_)
  );
  NOT _087_ (
    .A(st[3]),
    .Y(_036_)
  );
  NOT _088_ (
    .A(valid_in_1_c),
    .Y(_037_)
  );
  NAND _089_ (
    .A(_037_),
    .B(_031_),
    .Y(_038_)
  );
  NAND _090_ (
    .A(_038_),
    .B(reset2),
    .Y(_039_)
  );
  NOR _091_ (
    .A(_039_),
    .B(_036_),
    .Y(_040_)
  );
  NOR _092_ (
    .A(_030_),
    .B(_031_),
    .Y(_041_)
  );
  NAND _093_ (
    .A(_041_),
    .B(valid_in_1_c),
    .Y(_042_)
  );
  NOR _094_ (
    .A(_042_),
    .B(_027_),
    .Y(_043_)
  );
  NOR _095_ (
    .A(_043_),
    .B(_040_),
    .Y(_044_)
  );
  NAND _096_ (
    .A(_044_),
    .B(_034_),
    .Y(_025_)
  );
  NOT _097_ (
    .A(reset),
    .Y(_045_)
  );
  NAND _098_ (
    .A(st[0]),
    .B(_045_),
    .Y(_046_)
  );
  NAND _099_ (
    .A(_046_),
    .B(reset2),
    .Y(_035_)
  );
  NOT _100_ (
    .A(st[0]),
    .Y(_047_)
  );
  NOR _101_ (
    .A(_047_),
    .B(_045_),
    .Y(_048_)
  );
  NOT _102_ (
    .A(st[5]),
    .Y(_049_)
  );
  NOR _103_ (
    .A(_038_),
    .B(_049_),
    .Y(_050_)
  );
  NOR _104_ (
    .A(_050_),
    .B(_048_),
    .Y(_051_)
  );
  NOR _105_ (
    .A(_051_),
    .B(_030_),
    .Y(_011_)
  );
  NOR _106_ (
    .A(valid_in_1_c),
    .B(valid_in_0_c),
    .Y(_052_)
  );
  NOR _107_ (
    .A(_052_),
    .B(_030_),
    .Y(_053_)
  );
  NAND _108_ (
    .A(_053_),
    .B(st[4]),
    .Y(_054_)
  );
  NOR _109_ (
    .A(_042_),
    .B(_028_),
    .Y(_055_)
  );
  NOT _110_ (
    .A(st[2]),
    .Y(_056_)
  );
  NAND _111_ (
    .A(_056_),
    .B(_049_),
    .Y(_057_)
  );
  NOR _112_ (
    .A(_057_),
    .B(st[1]),
    .Y(_058_)
  );
  NOR _113_ (
    .A(valid_in_1_c),
    .B(_031_),
    .Y(_059_)
  );
  NAND _114_ (
    .A(_059_),
    .B(reset2),
    .Y(_060_)
  );
  NOR _115_ (
    .A(_060_),
    .B(_058_),
    .Y(_061_)
  );
  NOR _116_ (
    .A(_061_),
    .B(_055_),
    .Y(_062_)
  );
  NAND _117_ (
    .A(_062_),
    .B(_054_),
    .Y(_026_)
  );
  NAND _118_ (
    .A(_052_),
    .B(reset2),
    .Y(_063_)
  );
  NOR _119_ (
    .A(st[3]),
    .B(st[2]),
    .Y(_064_)
  );
  NOR _120_ (
    .A(_064_),
    .B(_063_),
    .Y(_003_)
  );
  NOT _121_ (
    .A(st[4]),
    .Y(_065_)
  );
  NAND _122_ (
    .A(_027_),
    .B(_065_),
    .Y(_066_)
  );
  NOT _123_ (
    .A(_066_),
    .Y(_067_)
  );
  NOR _124_ (
    .A(_067_),
    .B(_063_),
    .Y(_007_)
  );
  NOR _125_ (
    .A(_031_),
    .B(_065_),
    .Y(_068_)
  );
  NAND _126_ (
    .A(valid_in_1_c),
    .B(st[3]),
    .Y(_069_)
  );
  NAND _127_ (
    .A(_069_),
    .B(_058_),
    .Y(_070_)
  );
  NOR _128_ (
    .A(_070_),
    .B(_068_),
    .Y(_071_)
  );
  NOR _129_ (
    .A(_066_),
    .B(_057_),
    .Y(_072_)
  );
  NAND _130_ (
    .A(_072_),
    .B(_036_),
    .Y(_073_)
  );
  NAND _131_ (
    .A(_073_),
    .B(_038_),
    .Y(_074_)
  );
  NOR _132_ (
    .A(_074_),
    .B(_071_),
    .Y(valid_out_c)
  );
  NOR _133_ (
    .A(_037_),
    .B(_027_),
    .Y(_075_)
  );
  NOR _134_ (
    .A(_037_),
    .B(_036_),
    .Y(_076_)
  );
  NOR _135_ (
    .A(_076_),
    .B(_075_),
    .Y(_077_)
  );
  NOR _136_ (
    .A(_037_),
    .B(valid_in_0_c),
    .Y(_078_)
  );
  NAND _137_ (
    .A(_078_),
    .B(_057_),
    .Y(_000_)
  );
  NAND _138_ (
    .A(_000_),
    .B(_077_),
    .Y(_001_)
  );
  NAND _139_ (
    .A(_001_),
    .B(data_in_1_c[0]),
    .Y(_002_)
  );
  NAND _140_ (
    .A(_059_),
    .B(st[1]),
    .Y(_004_)
  );
  NOR _141_ (
    .A(_028_),
    .B(_031_),
    .Y(_005_)
  );
  NOR _142_ (
    .A(_005_),
    .B(_068_),
    .Y(_006_)
  );
  NAND _143_ (
    .A(_006_),
    .B(_004_),
    .Y(_008_)
  );
  NAND _144_ (
    .A(_008_),
    .B(data_in_0_c[0]),
    .Y(_009_)
  );
  NAND _145_ (
    .A(_009_),
    .B(_002_),
    .Y(data_out_c[0])
  );
  NAND _146_ (
    .A(_008_),
    .B(data_in_0_c[1]),
    .Y(_010_)
  );
  NAND _147_ (
    .A(_001_),
    .B(data_in_1_c[1]),
    .Y(_012_)
  );
  NAND _148_ (
    .A(_012_),
    .B(_010_),
    .Y(data_out_c[1])
  );
  NAND _149_ (
    .A(_008_),
    .B(data_in_0_c[2]),
    .Y(_013_)
  );
  NAND _150_ (
    .A(_001_),
    .B(data_in_1_c[2]),
    .Y(_014_)
  );
  NAND _151_ (
    .A(_014_),
    .B(_013_),
    .Y(data_out_c[2])
  );
  NAND _152_ (
    .A(_008_),
    .B(data_in_0_c[3]),
    .Y(_015_)
  );
  NAND _153_ (
    .A(_001_),
    .B(data_in_1_c[3]),
    .Y(_016_)
  );
  NAND _154_ (
    .A(_016_),
    .B(_015_),
    .Y(data_out_c[3])
  );
  NAND _155_ (
    .A(_008_),
    .B(data_in_0_c[4]),
    .Y(_017_)
  );
  NAND _156_ (
    .A(_001_),
    .B(data_in_1_c[4]),
    .Y(_018_)
  );
  NAND _157_ (
    .A(_018_),
    .B(_017_),
    .Y(data_out_c[4])
  );
  NAND _158_ (
    .A(_008_),
    .B(data_in_0_c[5]),
    .Y(_019_)
  );
  NAND _159_ (
    .A(_001_),
    .B(data_in_1_c[5]),
    .Y(_020_)
  );
  NAND _160_ (
    .A(_020_),
    .B(_019_),
    .Y(data_out_c[5])
  );
  NAND _161_ (
    .A(_008_),
    .B(data_in_0_c[6]),
    .Y(_021_)
  );
  NAND _162_ (
    .A(_001_),
    .B(data_in_1_c[6]),
    .Y(_022_)
  );
  NAND _163_ (
    .A(_022_),
    .B(_021_),
    .Y(data_out_c[6])
  );
  NAND _164_ (
    .A(_008_),
    .B(data_in_0_c[7]),
    .Y(_023_)
  );
  NAND _165_ (
    .A(_001_),
    .B(data_in_1_c[7]),
    .Y(_024_)
  );
  NAND _166_ (
    .A(_024_),
    .B(_023_),
    .Y(data_out_c[7])
  );
  DFF _167_ (
    .C(clk_2f),
    .D(_035_),
    .Q(st[0])
  );
  DFF _168_ (
    .C(clk_2f),
    .D(_007_),
    .Q(st[1])
  );
  DFF _169_ (
    .C(clk_2f),
    .D(_003_),
    .Q(st[2])
  );
  DFF _170_ (
    .C(clk_2f),
    .D(_025_),
    .Q(st[3])
  );
  DFF _171_ (
    .C(clk_2f),
    .D(_026_),
    .Q(st[4])
  );
  DFF _172_ (
    .C(clk_2f),
    .D(_011_),
    .Q(st[5])
  );
  DFF _173_ (
    .C(clk_8f),
    .D(resetm),
    .Q(reset2)
  );
  DFF _174_ (
    .C(clk_8f),
    .D(reset),
    .Q(resetm)
  );
endmodule

(* top =  1  *)
(* src = "phy_tx_cond.v:5" *)
module phy_tx_estr(data_in_0_c, data_in_1_c, valid_in_0_c, valid_in_1_c, clk_f, clk_2f, clk_8f, reset, Paral_serial_out_0_e, Paral_serial_out_1_e);
  (* src = "phy_tx_cond.v:26" *)
  wire [7:0] _00_;
  (* src = "phy_tx_cond.v:26" *)
  wire [7:0] _01_;
  (* src = "phy_tx_cond.v:26" *)
  wire _02_;
  (* src = "phy_tx_cond.v:26" *)
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
  (* src = "phy_tx_cond.v:14" *)
  output Paral_serial_out_0_e;
  (* src = "phy_tx_cond.v:15" *)
  output Paral_serial_out_1_e;
  (* src = "phy_tx_cond.v:11" *)
  input clk_2f;
  (* src = "phy_tx_cond.v:12" *)
  input clk_8f;
  (* src = "phy_tx_cond.v:10" *)
  input clk_f;
  (* src = "phy_tx_cond.v:45" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] data2send_c0;
  (* src = "phy_tx_cond.v:46" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] data2send_c1;
  (* src = "phy_tx_cond.v:18" *)
  wire [7:0] data_in_0_FF;
  (* src = "phy_tx_cond.v:6" *)
  input [7:0] data_in_0_c;
  (* src = "phy_tx_cond.v:18" *)
  wire [7:0] data_in_1_FF;
  (* src = "phy_tx_cond.v:7" *)
  input [7:0] data_in_1_c;
  (* src = "phy_tx_cond.v:47" *)
  wire [7:0] data_out_c_mux_estr;
  (* src = "phy_tx_cond.v:48" *)
  wire [7:0] lane_0_c;
  (* src = "phy_tx_cond.v:49" *)
  wire [7:0] lane_1_c;
  (* src = "phy_tx_cond.v:13" *)
  input reset;
  (* src = "phy_tx_cond.v:22" *)
  wire reset0;
  (* src = "phy_tx_cond.v:23" *)
  wire reset1;
  (* src = "phy_tx_cond.v:50" *)
  wire valid_0_c_BS;
  (* src = "phy_tx_cond.v:51" *)
  wire valid_1_c_BS;
  (* src = "phy_tx_cond.v:19" *)
  wire valid_in_0_FF;
  (* src = "phy_tx_cond.v:8" *)
  input valid_in_0_c;
  (* src = "phy_tx_cond.v:19" *)
  wire valid_in_1_FF;
  (* src = "phy_tx_cond.v:9" *)
  input valid_in_1_c;
  (* src = "phy_tx_cond.v:52" *)
  wire valid_mux_estr;
  NOT _23_ (
    .A(valid_in_0_c),
    .Y(_04_)
  );
  NOT _24_ (
    .A(reset),
    .Y(_05_)
  );
  NOR _25_ (
    .A(_05_),
    .B(_04_),
    .Y(_02_)
  );
  NOT _26_ (
    .A(data_in_1_c[0]),
    .Y(_06_)
  );
  NOR _27_ (
    .A(_06_),
    .B(_05_),
    .Y(_01_[0])
  );
  NOT _28_ (
    .A(data_in_1_c[1]),
    .Y(_07_)
  );
  NOR _29_ (
    .A(_07_),
    .B(_05_),
    .Y(_01_[1])
  );
  NOT _30_ (
    .A(data_in_1_c[2]),
    .Y(_08_)
  );
  NOR _31_ (
    .A(_08_),
    .B(_05_),
    .Y(_01_[2])
  );
  NOT _32_ (
    .A(data_in_1_c[3]),
    .Y(_09_)
  );
  NOR _33_ (
    .A(_09_),
    .B(_05_),
    .Y(_01_[3])
  );
  NOT _34_ (
    .A(data_in_1_c[4]),
    .Y(_10_)
  );
  NOR _35_ (
    .A(_10_),
    .B(_05_),
    .Y(_01_[4])
  );
  NOT _36_ (
    .A(data_in_1_c[5]),
    .Y(_11_)
  );
  NOR _37_ (
    .A(_11_),
    .B(_05_),
    .Y(_01_[5])
  );
  NOT _38_ (
    .A(data_in_1_c[6]),
    .Y(_12_)
  );
  NOR _39_ (
    .A(_12_),
    .B(_05_),
    .Y(_01_[6])
  );
  NOT _40_ (
    .A(data_in_1_c[7]),
    .Y(_13_)
  );
  NOR _41_ (
    .A(_13_),
    .B(_05_),
    .Y(_01_[7])
  );
  NOT _42_ (
    .A(data_in_0_c[0]),
    .Y(_14_)
  );
  NOR _43_ (
    .A(_14_),
    .B(_05_),
    .Y(_00_[0])
  );
  NOT _44_ (
    .A(data_in_0_c[1]),
    .Y(_15_)
  );
  NOR _45_ (
    .A(_15_),
    .B(_05_),
    .Y(_00_[1])
  );
  NOT _46_ (
    .A(data_in_0_c[2]),
    .Y(_16_)
  );
  NOR _47_ (
    .A(_16_),
    .B(_05_),
    .Y(_00_[2])
  );
  NOT _48_ (
    .A(data_in_0_c[3]),
    .Y(_17_)
  );
  NOR _49_ (
    .A(_17_),
    .B(_05_),
    .Y(_00_[3])
  );
  NOT _50_ (
    .A(data_in_0_c[4]),
    .Y(_18_)
  );
  NOR _51_ (
    .A(_18_),
    .B(_05_),
    .Y(_00_[4])
  );
  NOT _52_ (
    .A(data_in_0_c[5]),
    .Y(_19_)
  );
  NOR _53_ (
    .A(_19_),
    .B(_05_),
    .Y(_00_[5])
  );
  NOT _54_ (
    .A(data_in_0_c[6]),
    .Y(_20_)
  );
  NOR _55_ (
    .A(_20_),
    .B(_05_),
    .Y(_00_[6])
  );
  NOT _56_ (
    .A(data_in_0_c[7]),
    .Y(_21_)
  );
  NOR _57_ (
    .A(_21_),
    .B(_05_),
    .Y(_00_[7])
  );
  NOT _58_ (
    .A(valid_in_1_c),
    .Y(_22_)
  );
  NOR _59_ (
    .A(_22_),
    .B(_05_),
    .Y(_03_)
  );
  DFF _60_ (
    .C(clk_2f),
    .D(_00_[0]),
    .Q(data_in_0_FF[0])
  );
  DFF _61_ (
    .C(clk_2f),
    .D(_00_[1]),
    .Q(data_in_0_FF[1])
  );
  DFF _62_ (
    .C(clk_2f),
    .D(_00_[2]),
    .Q(data_in_0_FF[2])
  );
  DFF _63_ (
    .C(clk_2f),
    .D(_00_[3]),
    .Q(data_in_0_FF[3])
  );
  DFF _64_ (
    .C(clk_2f),
    .D(_00_[4]),
    .Q(data_in_0_FF[4])
  );
  DFF _65_ (
    .C(clk_2f),
    .D(_00_[5]),
    .Q(data_in_0_FF[5])
  );
  DFF _66_ (
    .C(clk_2f),
    .D(_00_[6]),
    .Q(data_in_0_FF[6])
  );
  DFF _67_ (
    .C(clk_2f),
    .D(_00_[7]),
    .Q(data_in_0_FF[7])
  );
  DFF _68_ (
    .C(clk_2f),
    .D(_01_[0]),
    .Q(data_in_1_FF[0])
  );
  DFF _69_ (
    .C(clk_2f),
    .D(_01_[1]),
    .Q(data_in_1_FF[1])
  );
  DFF _70_ (
    .C(clk_2f),
    .D(_01_[2]),
    .Q(data_in_1_FF[2])
  );
  DFF _71_ (
    .C(clk_2f),
    .D(_01_[3]),
    .Q(data_in_1_FF[3])
  );
  DFF _72_ (
    .C(clk_2f),
    .D(_01_[4]),
    .Q(data_in_1_FF[4])
  );
  DFF _73_ (
    .C(clk_2f),
    .D(_01_[5]),
    .Q(data_in_1_FF[5])
  );
  DFF _74_ (
    .C(clk_2f),
    .D(_01_[6]),
    .Q(data_in_1_FF[6])
  );
  DFF _75_ (
    .C(clk_2f),
    .D(_01_[7]),
    .Q(data_in_1_FF[7])
  );
  DFF _76_ (
    .C(clk_2f),
    .D(_02_),
    .Q(valid_in_0_FF)
  );
  DFF _77_ (
    .C(clk_2f),
    .D(_03_),
    .Q(valid_in_1_FF)
  );
  DFF _78_ (
    .C(clk_2f),
    .D(reset),
    .Q(reset1)
  );
  (* src = "phy_tx_cond.v:70" *)
  Byte_striping_estr Byte_striping_instance0 (
    .clk_2f(clk_2f),
    .data_in(data_out_c_mux_estr),
    .lane_0_c(lane_0_c),
    .lane_1_c(lane_1_c),
    .reset(reset),
    .valid_0_c(valid_0_c_BS),
    .valid_1_c(valid_1_c_BS),
    .valid_in(valid_mux_estr)
  );
  (* src = "phy_tx_cond.v:92" *)
  Paralelo_Serie_estructural Paralelo_Serie_estructural_instance0 (
    .clk_8f(clk_8f),
    .clk_f(clk_f),
    .data2send_c(data2send_c0),
    .data_in(lane_0_c),
    .data_out_c(Paral_serial_out_0_e),
    .reset(reset),
    .valid_in(valid_0_c_BS)
  );
  (* src = "phy_tx_cond.v:103" *)
  Paralelo_Serie_estructural Paralelo_Serie_estructural_instance1 (
    .clk_8f(clk_8f),
    .clk_f(clk_f),
    .data2send_c(data2send_c1),
    .data_in(lane_1_c),
    .data_out_c(Paral_serial_out_1_e),
    .reset(reset1),
    .valid_in(valid_1_c_BS)
  );
  (* src = "phy_tx_cond.v:55" *)
  mux_estr mux_estr_instance0 (
    .clk_2f(clk_2f),
    .clk_8f(clk_8f),
    .data_in_0_c(data_in_0_FF),
    .data_in_1_c(data_in_1_FF),
    .data_out_c(data_out_c_mux_estr),
    .reset(reset),
    .valid_in_0_c(valid_in_0_FF),
    .valid_in_1_c(valid_in_1_FF),
    .valid_out_c(valid_mux_estr)
  );
  assign reset0 = reset;
endmodule
