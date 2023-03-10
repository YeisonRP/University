/* Generated by Yosys 0.7+352 (git sha1 baddb01, clang 3.4-1ubuntu3 -fPIC -Os) */

(* top =  1  *)
(* src = "gray_counter_estr.v:1" *)
module gray_counter_estr(clk, reset_L, enable, salida_gray_e);
  (* src = "gray_counter_estr.v:10" *)
  wire [4:0] _000_;
  (* src = "gray_counter_estr.v:10" *)
  wire [1:0] _001_;
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
  (* src = "gray_counter_estr.v:2" *)
  input clk;
  (* src = "gray_counter_estr.v:7" *)
  wire [4:0] count;
  (* src = "gray_counter_estr.v:4" *)
  input enable;
  (* src = "gray_counter_estr.v:3" *)
  input reset_L;
  (* src = "gray_counter_estr.v:5" *)
  output [4:0] salida_gray_e;
  (* src = "gray_counter_estr.v:8" *)
  wire [1:0] xor_output_cnt;
  NOT _047_ (
    .A(count[3]),
    .Y(_002_)
  );
  NOT _048_ (
    .A(xor_output_cnt[0]),
    .Y(_003_)
  );
  NOT _049_ (
    .A(xor_output_cnt[1]),
    .Y(_004_)
  );
  NOT _050_ (
    .A(count[1]),
    .Y(_005_)
  );
  NOT _051_ (
    .A(count[2]),
    .Y(_006_)
  );
  NAND _052_ (
    .A(enable),
    .B(count[0]),
    .Y(_007_)
  );
  NOT _053_ (
    .A(_007_),
    .Y(_008_)
  );
  NOR _054_ (
    .A(_005_),
    .B(_006_),
    .Y(_009_)
  );
  NAND _055_ (
    .A(count[1]),
    .B(count[2]),
    .Y(_010_)
  );
  NAND _056_ (
    .A(_008_),
    .B(_009_),
    .Y(_011_)
  );
  NAND _057_ (
    .A(count[3]),
    .B(count[4]),
    .Y(_012_)
  );
  NOT _058_ (
    .A(_012_),
    .Y(_013_)
  );
  NAND _059_ (
    .A(count[0]),
    .B(count[1]),
    .Y(_014_)
  );
  NOR _060_ (
    .A(_005_),
    .B(_007_),
    .Y(_015_)
  );
  NAND _061_ (
    .A(count[3]),
    .B(count[2]),
    .Y(_016_)
  );
  NOT _062_ (
    .A(_016_),
    .Y(_017_)
  );
  NOR _063_ (
    .A(_002_),
    .B(_011_),
    .Y(_018_)
  );
  NOR _064_ (
    .A(_011_),
    .B(_012_),
    .Y(_019_)
  );
  NAND _065_ (
    .A(count[4]),
    .B(_018_),
    .Y(_020_)
  );
  NOR _066_ (
    .A(_003_),
    .B(_020_),
    .Y(_021_)
  );
  NAND _067_ (
    .A(xor_output_cnt[0]),
    .B(_019_),
    .Y(_022_)
  );
  NAND _068_ (
    .A(_003_),
    .B(_020_),
    .Y(_023_)
  );
  NAND _069_ (
    .A(reset_L),
    .B(_023_),
    .Y(_024_)
  );
  NOR _070_ (
    .A(_021_),
    .B(_024_),
    .Y(_001_[0])
  );
  NOR _071_ (
    .A(_004_),
    .B(_022_),
    .Y(_025_)
  );
  NAND _072_ (
    .A(_004_),
    .B(_022_),
    .Y(_026_)
  );
  NAND _073_ (
    .A(reset_L),
    .B(_026_),
    .Y(_027_)
  );
  NOR _074_ (
    .A(_025_),
    .B(_027_),
    .Y(_001_[1])
  );
  NOR _075_ (
    .A(enable),
    .B(count[0]),
    .Y(_028_)
  );
  NAND _076_ (
    .A(reset_L),
    .B(_007_),
    .Y(_029_)
  );
  NOR _077_ (
    .A(_028_),
    .B(_029_),
    .Y(_000_[0])
  );
  NAND _078_ (
    .A(_005_),
    .B(_007_),
    .Y(_030_)
  );
  NAND _079_ (
    .A(reset_L),
    .B(_030_),
    .Y(_031_)
  );
  NOR _080_ (
    .A(_015_),
    .B(_031_),
    .Y(_000_[1])
  );
  NOR _081_ (
    .A(count[2]),
    .B(_015_),
    .Y(_032_)
  );
  NAND _082_ (
    .A(reset_L),
    .B(_011_),
    .Y(_033_)
  );
  NOR _083_ (
    .A(_032_),
    .B(_033_),
    .Y(_000_[2])
  );
  NAND _084_ (
    .A(_002_),
    .B(_011_),
    .Y(_034_)
  );
  NAND _085_ (
    .A(reset_L),
    .B(_034_),
    .Y(_035_)
  );
  NOR _086_ (
    .A(_018_),
    .B(_035_),
    .Y(_000_[3])
  );
  NOR _087_ (
    .A(count[4]),
    .B(_018_),
    .Y(_036_)
  );
  NAND _088_ (
    .A(reset_L),
    .B(_020_),
    .Y(_037_)
  );
  NOR _089_ (
    .A(_036_),
    .B(_037_),
    .Y(_000_[4])
  );
  NOR _090_ (
    .A(count[0]),
    .B(count[1]),
    .Y(_038_)
  );
  NOR _091_ (
    .A(count[3]),
    .B(count[4]),
    .Y(_039_)
  );
  NAND _092_ (
    .A(_003_),
    .B(xor_output_cnt[1]),
    .Y(_040_)
  );
  NOR _093_ (
    .A(_010_),
    .B(_040_),
    .Y(_041_)
  );
  NAND _094_ (
    .A(_039_),
    .B(_041_),
    .Y(_042_)
  );
  NOT _095_ (
    .A(_042_),
    .Y(_043_)
  );
  NOR _096_ (
    .A(_014_),
    .B(_043_),
    .Y(_044_)
  );
  NOR _097_ (
    .A(_038_),
    .B(_044_),
    .Y(salida_gray_e[0])
  );
  NOR _098_ (
    .A(count[1]),
    .B(count[2]),
    .Y(_045_)
  );
  NOR _099_ (
    .A(_009_),
    .B(_045_),
    .Y(salida_gray_e[1])
  );
  NOR _100_ (
    .A(count[3]),
    .B(count[2]),
    .Y(_046_)
  );
  NOR _101_ (
    .A(_017_),
    .B(_046_),
    .Y(salida_gray_e[2])
  );
  NOR _102_ (
    .A(_013_),
    .B(_039_),
    .Y(salida_gray_e[3])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _103_ (
    .C(clk),
    .D(_000_[0]),
    .Q(count[0])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _104_ (
    .C(clk),
    .D(_000_[1]),
    .Q(count[1])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _105_ (
    .C(clk),
    .D(_000_[2]),
    .Q(count[2])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _106_ (
    .C(clk),
    .D(_000_[3]),
    .Q(count[3])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _107_ (
    .C(clk),
    .D(_000_[4]),
    .Q(count[4])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _108_ (
    .C(clk),
    .D(_001_[0]),
    .Q(xor_output_cnt[0])
  );
  (* src = "gray_counter_estr.v:10" *)
  DFF _109_ (
    .C(clk),
    .D(_001_[1]),
    .Q(xor_output_cnt[1])
  );
  assign salida_gray_e[4] = count[4];
endmodule

