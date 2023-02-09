`include "cmos.v"
/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* src = "FSM_cond.v:210" *)
module \$paramod\bitwiseOr\WORD_SIZE=4 (entrada, reset, bit_salida);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  (* src = "FSM_cond.v:215" *)
  output bit_salida;
  (* src = "FSM_cond.v:213" *)
  input [3:0] entrada;
  (* src = "FSM_cond.v:214" *)
  input reset;
  NOT _05_ (
    .A(reset),
    .Y(_02_)
  );
  NOT _06_ (
    .A(entrada[0]),
    .Y(_03_)
  );
  NOR _07_ (
    .A(entrada[2]),
    .B(entrada[1]),
    .Y(_04_)
  );
  NAND _08_ (
    .A(_04_),
    .B(_03_),
    .Y(_00_)
  );
  NOR _09_ (
    .A(_00_),
    .B(entrada[3]),
    .Y(_01_)
  );
  NOR _10_ (
    .A(_01_),
    .B(_02_),
    .Y(bit_salida)
  );
endmodule

(* src = "FSM_cond.v:231" *)
module \$paramod\inversor\WORD_SIZE=4 (entrada_datos, reset, salida_datos);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  (* src = "FSM_cond.v:234" *)
  input [3:0] entrada_datos;
  (* src = "FSM_cond.v:235" *)
  input reset;
  (* src = "FSM_cond.v:236" *)
  output [3:0] salida_datos;
  NOT _05_ (
    .A(entrada_datos[0]),
    .Y(_00_)
  );
  NOT _06_ (
    .A(reset),
    .Y(_01_)
  );
  NOR _07_ (
    .A(_01_),
    .B(_00_),
    .Y(salida_datos[0])
  );
  NOT _08_ (
    .A(entrada_datos[1]),
    .Y(_02_)
  );
  NOR _09_ (
    .A(_02_),
    .B(_01_),
    .Y(salida_datos[1])
  );
  NOT _10_ (
    .A(entrada_datos[2]),
    .Y(_03_)
  );
  NOR _11_ (
    .A(_03_),
    .B(_01_),
    .Y(salida_datos[2])
  );
  NOT _12_ (
    .A(entrada_datos[3]),
    .Y(_04_)
  );
  NOR _13_ (
    .A(_04_),
    .B(_01_),
    .Y(salida_datos[3])
  );
endmodule

(* top =  1  *)
(* src = "FSM_cond.v:2" *)
module FSM_estr(data_in, reset, clk, data_out, ctrl_out, nxt_err, err, estado, estado_proximo);
  (* src = "FSM_cond.v:32" *)
  wire [3:0] _000_;
  (* src = "FSM_cond.v:77" *)
  wire _001_;
  (* src = "FSM_cond.v:77" *)
  wire [4:0] _002_;
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
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  (* src = "FSM_cond.v:14" *)
  input clk;
  (* src = "FSM_cond.v:22" *)
  wire [3:0] contador;
  (* src = "FSM_cond.v:16" *)
  output [3:0] ctrl_out;
  (* src = "FSM_cond.v:12" *)
  input [15:0] data_in;
  (* src = "FSM_cond.v:15" *)
  output [15:0] data_out;
  (* src = "FSM_cond.v:18" *)
  output err;
  (* src = "FSM_cond.v:19" *)
  output [4:0] estado;
  (* src = "FSM_cond.v:20" *)
  output [4:0] estado_proximo;
  (* src = "FSM_cond.v:17" *)
  output nxt_err;
  (* src = "FSM_cond.v:13" *)
  input reset;
  NOT _124_ (
    .A(estado[0]),
    .Y(_060_)
  );
  NOT _125_ (
    .A(estado[1]),
    .Y(_061_)
  );
  NAND _126_ (
    .A(_061_),
    .B(_060_),
    .Y(_062_)
  );
  NOR _127_ (
    .A(estado[3]),
    .B(estado[2]),
    .Y(_063_)
  );
  NAND _128_ (
    .A(_063_),
    .B(estado[4]),
    .Y(_064_)
  );
  NOR _129_ (
    .A(_064_),
    .B(_062_),
    .Y(_065_)
  );
  NOR _130_ (
    .A(_063_),
    .B(estado[4]),
    .Y(_066_)
  );
  NOT _131_ (
    .A(estado[2]),
    .Y(_067_)
  );
  NOT _132_ (
    .A(estado[3]),
    .Y(_068_)
  );
  NOR _133_ (
    .A(_068_),
    .B(_067_),
    .Y(_069_)
  );
  NOR _134_ (
    .A(_069_),
    .B(_062_),
    .Y(_070_)
  );
  NAND _135_ (
    .A(_070_),
    .B(_066_),
    .Y(_071_)
  );
  NAND _136_ (
    .A(_068_),
    .B(_067_),
    .Y(_072_)
  );
  NOR _137_ (
    .A(_072_),
    .B(estado[4]),
    .Y(_073_)
  );
  NOR _138_ (
    .A(estado[1]),
    .B(estado[0]),
    .Y(_074_)
  );
  NOR _139_ (
    .A(_061_),
    .B(_060_),
    .Y(_075_)
  );
  NOR _140_ (
    .A(_075_),
    .B(_074_),
    .Y(_076_)
  );
  NAND _141_ (
    .A(_076_),
    .B(_073_),
    .Y(_077_)
  );
  NAND _142_ (
    .A(_077_),
    .B(_071_),
    .Y(_078_)
  );
  NOR _143_ (
    .A(_078_),
    .B(_065_),
    .Y(_079_)
  );
  NOT _144_ (
    .A(data_in[1]),
    .Y(_080_)
  );
  NAND _145_ (
    .A(_080_),
    .B(contador[1]),
    .Y(_081_)
  );
  NOT _146_ (
    .A(contador[1]),
    .Y(_082_)
  );
  NAND _147_ (
    .A(data_in[1]),
    .B(_082_),
    .Y(_083_)
  );
  NAND _148_ (
    .A(_083_),
    .B(_081_),
    .Y(_084_)
  );
  NOT _149_ (
    .A(data_in[0]),
    .Y(_085_)
  );
  NAND _150_ (
    .A(_085_),
    .B(contador[0]),
    .Y(_086_)
  );
  NOT _151_ (
    .A(contador[0]),
    .Y(_087_)
  );
  NAND _152_ (
    .A(data_in[0]),
    .B(_087_),
    .Y(_088_)
  );
  NAND _153_ (
    .A(_088_),
    .B(_086_),
    .Y(_089_)
  );
  NOR _154_ (
    .A(_089_),
    .B(_084_),
    .Y(_090_)
  );
  NOT _155_ (
    .A(data_in[3]),
    .Y(_091_)
  );
  NAND _156_ (
    .A(_091_),
    .B(contador[3]),
    .Y(_092_)
  );
  NOT _157_ (
    .A(contador[3]),
    .Y(_093_)
  );
  NAND _158_ (
    .A(data_in[3]),
    .B(_093_),
    .Y(_094_)
  );
  NAND _159_ (
    .A(_094_),
    .B(_092_),
    .Y(_095_)
  );
  NOT _160_ (
    .A(data_in[2]),
    .Y(_096_)
  );
  NAND _161_ (
    .A(_096_),
    .B(contador[2]),
    .Y(_097_)
  );
  NOT _162_ (
    .A(contador[2]),
    .Y(_098_)
  );
  NAND _163_ (
    .A(data_in[2]),
    .B(_098_),
    .Y(_099_)
  );
  NAND _164_ (
    .A(_099_),
    .B(_097_),
    .Y(_100_)
  );
  NOR _165_ (
    .A(_100_),
    .B(_095_),
    .Y(_101_)
  );
  NAND _166_ (
    .A(_101_),
    .B(_090_),
    .Y(_102_)
  );
  NOT _167_ (
    .A(reset),
    .Y(_103_)
  );
  NAND _168_ (
    .A(data_in[15]),
    .B(data_in[14]),
    .Y(_104_)
  );
  NAND _169_ (
    .A(data_in[13]),
    .B(data_in[12]),
    .Y(_105_)
  );
  NOR _170_ (
    .A(_105_),
    .B(_104_),
    .Y(_106_)
  );
  NOR _171_ (
    .A(_106_),
    .B(_103_),
    .Y(_107_)
  );
  NOR _172_ (
    .A(_107_),
    .B(_102_),
    .Y(_108_)
  );
  NOR _173_ (
    .A(_108_),
    .B(_079_),
    .Y(_109_)
  );
  NAND _174_ (
    .A(_065_),
    .B(reset),
    .Y(_110_)
  );
  NAND _175_ (
    .A(_110_),
    .B(_071_),
    .Y(_111_)
  );
  NOR _176_ (
    .A(_078_),
    .B(_060_),
    .Y(_112_)
  );
  NOR _177_ (
    .A(_112_),
    .B(_111_),
    .Y(_113_)
  );
  NOR _178_ (
    .A(_113_),
    .B(_109_),
    .Y(estado_proximo[0])
  );
  NOT _179_ (
    .A(estado[4]),
    .Y(_114_)
  );
  NOR _180_ (
    .A(_072_),
    .B(_114_),
    .Y(_115_)
  );
  NAND _181_ (
    .A(_115_),
    .B(_074_),
    .Y(_116_)
  );
  NAND _182_ (
    .A(_072_),
    .B(_114_),
    .Y(_117_)
  );
  NAND _183_ (
    .A(estado[3]),
    .B(estado[2]),
    .Y(_118_)
  );
  NAND _184_ (
    .A(_118_),
    .B(_074_),
    .Y(_119_)
  );
  NOR _185_ (
    .A(_119_),
    .B(_117_),
    .Y(_120_)
  );
  NAND _186_ (
    .A(_063_),
    .B(_114_),
    .Y(_121_)
  );
  NAND _187_ (
    .A(estado[1]),
    .B(estado[0]),
    .Y(_122_)
  );
  NAND _188_ (
    .A(_122_),
    .B(_062_),
    .Y(_123_)
  );
  NOR _189_ (
    .A(_123_),
    .B(_121_),
    .Y(_003_)
  );
  NOR _190_ (
    .A(_003_),
    .B(_120_),
    .Y(_004_)
  );
  NAND _191_ (
    .A(_004_),
    .B(_116_),
    .Y(_005_)
  );
  NOR _192_ (
    .A(data_in[1]),
    .B(_082_),
    .Y(_006_)
  );
  NOR _193_ (
    .A(_080_),
    .B(contador[1]),
    .Y(_007_)
  );
  NOR _194_ (
    .A(_007_),
    .B(_006_),
    .Y(_008_)
  );
  NOR _195_ (
    .A(data_in[0]),
    .B(_087_),
    .Y(_009_)
  );
  NOR _196_ (
    .A(_085_),
    .B(contador[0]),
    .Y(_010_)
  );
  NOR _197_ (
    .A(_010_),
    .B(_009_),
    .Y(_011_)
  );
  NAND _198_ (
    .A(_011_),
    .B(_008_),
    .Y(_012_)
  );
  NOR _199_ (
    .A(data_in[3]),
    .B(_093_),
    .Y(_013_)
  );
  NOR _200_ (
    .A(_091_),
    .B(contador[3]),
    .Y(_014_)
  );
  NOR _201_ (
    .A(_014_),
    .B(_013_),
    .Y(_015_)
  );
  NOR _202_ (
    .A(data_in[2]),
    .B(_098_),
    .Y(_016_)
  );
  NOR _203_ (
    .A(_096_),
    .B(contador[2]),
    .Y(_017_)
  );
  NOR _204_ (
    .A(_017_),
    .B(_016_),
    .Y(_018_)
  );
  NAND _205_ (
    .A(_018_),
    .B(_015_),
    .Y(_019_)
  );
  NOR _206_ (
    .A(_019_),
    .B(_012_),
    .Y(_020_)
  );
  NOT _207_ (
    .A(_107_),
    .Y(_021_)
  );
  NAND _208_ (
    .A(_021_),
    .B(_020_),
    .Y(_022_)
  );
  NAND _209_ (
    .A(_022_),
    .B(_005_),
    .Y(_023_)
  );
  NAND _210_ (
    .A(_023_),
    .B(reset),
    .Y(_024_)
  );
  NOR _211_ (
    .A(_024_),
    .B(_113_),
    .Y(_002_[0])
  );
  NAND _212_ (
    .A(_108_),
    .B(_003_),
    .Y(_025_)
  );
  NOR _213_ (
    .A(_078_),
    .B(_061_),
    .Y(_026_)
  );
  NOT _214_ (
    .A(_026_),
    .Y(_027_)
  );
  NAND _215_ (
    .A(_027_),
    .B(_025_),
    .Y(estado_proximo[1])
  );
  NOR _216_ (
    .A(_022_),
    .B(_077_),
    .Y(_028_)
  );
  NOR _217_ (
    .A(_026_),
    .B(_028_),
    .Y(_029_)
  );
  NOR _218_ (
    .A(_029_),
    .B(_103_),
    .Y(_002_[1])
  );
  NAND _219_ (
    .A(_079_),
    .B(estado[2]),
    .Y(_030_)
  );
  NAND _220_ (
    .A(_110_),
    .B(_004_),
    .Y(_031_)
  );
  NOR _221_ (
    .A(_107_),
    .B(_020_),
    .Y(_032_)
  );
  NAND _222_ (
    .A(_032_),
    .B(_031_),
    .Y(_033_)
  );
  NAND _223_ (
    .A(_033_),
    .B(_030_),
    .Y(estado_proximo[2])
  );
  NOR _224_ (
    .A(_005_),
    .B(_067_),
    .Y(_034_)
  );
  NOR _225_ (
    .A(_116_),
    .B(_103_),
    .Y(_035_)
  );
  NOR _226_ (
    .A(_035_),
    .B(_078_),
    .Y(_036_)
  );
  NAND _227_ (
    .A(_021_),
    .B(_102_),
    .Y(_037_)
  );
  NOR _228_ (
    .A(_037_),
    .B(_036_),
    .Y(_038_)
  );
  NOR _229_ (
    .A(_038_),
    .B(_034_),
    .Y(_039_)
  );
  NOR _230_ (
    .A(_039_),
    .B(_103_),
    .Y(_002_[2])
  );
  NAND _231_ (
    .A(_079_),
    .B(estado[3]),
    .Y(_040_)
  );
  NAND _232_ (
    .A(_107_),
    .B(_005_),
    .Y(_041_)
  );
  NAND _233_ (
    .A(_041_),
    .B(_040_),
    .Y(estado_proximo[3])
  );
  NOR _234_ (
    .A(_005_),
    .B(_068_),
    .Y(_042_)
  );
  NOR _235_ (
    .A(_021_),
    .B(_079_),
    .Y(_043_)
  );
  NOR _236_ (
    .A(_043_),
    .B(_042_),
    .Y(_044_)
  );
  NOR _237_ (
    .A(_044_),
    .B(_103_),
    .Y(_002_[3])
  );
  NAND _238_ (
    .A(_079_),
    .B(estado[4]),
    .Y(_045_)
  );
  NAND _239_ (
    .A(_065_),
    .B(_103_),
    .Y(_046_)
  );
  NAND _240_ (
    .A(_046_),
    .B(_045_),
    .Y(estado_proximo[4])
  );
  NAND _241_ (
    .A(_045_),
    .B(reset),
    .Y(_002_[4])
  );
  NOR _242_ (
    .A(_036_),
    .B(_108_),
    .Y(nxt_err)
  );
  NOR _243_ (
    .A(_023_),
    .B(_103_),
    .Y(_001_)
  );
  NOR _244_ (
    .A(_087_),
    .B(_082_),
    .Y(_047_)
  );
  NOT _245_ (
    .A(_047_),
    .Y(_048_)
  );
  NOR _246_ (
    .A(_048_),
    .B(_098_),
    .Y(_049_)
  );
  NOR _247_ (
    .A(_049_),
    .B(_093_),
    .Y(_050_)
  );
  NOT _248_ (
    .A(_049_),
    .Y(_051_)
  );
  NOR _249_ (
    .A(_051_),
    .B(contador[3]),
    .Y(_052_)
  );
  NOR _250_ (
    .A(_052_),
    .B(_050_),
    .Y(_053_)
  );
  NOR _251_ (
    .A(_053_),
    .B(_024_),
    .Y(_000_[3])
  );
  NAND _252_ (
    .A(_048_),
    .B(_098_),
    .Y(_054_)
  );
  NOR _253_ (
    .A(_049_),
    .B(_103_),
    .Y(_055_)
  );
  NAND _254_ (
    .A(_055_),
    .B(_054_),
    .Y(_056_)
  );
  NOR _255_ (
    .A(_056_),
    .B(nxt_err),
    .Y(_000_[2])
  );
  NAND _256_ (
    .A(_087_),
    .B(_082_),
    .Y(_057_)
  );
  NOR _257_ (
    .A(_047_),
    .B(_103_),
    .Y(_058_)
  );
  NAND _258_ (
    .A(_058_),
    .B(_057_),
    .Y(_059_)
  );
  NOR _259_ (
    .A(_059_),
    .B(nxt_err),
    .Y(_000_[1])
  );
  NOR _260_ (
    .A(_024_),
    .B(contador[0]),
    .Y(_000_[0])
  );
  DFF _261_ (
    .C(clk),
    .D(_001_),
    .Q(err)
  );
  DFF _262_ (
    .C(clk),
    .D(_002_[0]),
    .Q(estado[0])
  );
  DFF _263_ (
    .C(clk),
    .D(_002_[1]),
    .Q(estado[1])
  );
  DFF _264_ (
    .C(clk),
    .D(_002_[2]),
    .Q(estado[2])
  );
  DFF _265_ (
    .C(clk),
    .D(_002_[3]),
    .Q(estado[3])
  );
  DFF _266_ (
    .C(clk),
    .D(_002_[4]),
    .Q(estado[4])
  );
  DFF _267_ (
    .C(clk),
    .D(_000_[0]),
    .Q(contador[0])
  );
  DFF _268_ (
    .C(clk),
    .D(_000_[1]),
    .Q(contador[1])
  );
  DFF _269_ (
    .C(clk),
    .D(_000_[2]),
    .Q(contador[2])
  );
  DFF _270_ (
    .C(clk),
    .D(_000_[3]),
    .Q(contador[3])
  );
  (* src = "FSM_cond.v:196" *)
  \$paramod\bitwiseOr\WORD_SIZE=4  \ASD[0].bitwiseOr_units  (
    .bit_salida(ctrl_out[0]),
    .entrada(data_in[3:0]),
    .reset(reset)
  );
  (* src = "FSM_cond.v:188" *)
  \$paramod\inversor\WORD_SIZE=4  \ASD[0].inversor_units  (
    .entrada_datos(data_in[3:0]),
    .reset(reset),
    .salida_datos(data_out[15:12])
  );
  (* src = "FSM_cond.v:196" *)
  \$paramod\bitwiseOr\WORD_SIZE=4  \ASD[1].bitwiseOr_units  (
    .bit_salida(ctrl_out[1]),
    .entrada(data_in[7:4]),
    .reset(reset)
  );
  (* src = "FSM_cond.v:188" *)
  \$paramod\inversor\WORD_SIZE=4  \ASD[1].inversor_units  (
    .entrada_datos(data_in[7:4]),
    .reset(reset),
    .salida_datos(data_out[11:8])
  );
  (* src = "FSM_cond.v:196" *)
  \$paramod\bitwiseOr\WORD_SIZE=4  \ASD[2].bitwiseOr_units  (
    .bit_salida(ctrl_out[2]),
    .entrada(data_in[11:8]),
    .reset(reset)
  );
  (* src = "FSM_cond.v:188" *)
  \$paramod\inversor\WORD_SIZE=4  \ASD[2].inversor_units  (
    .entrada_datos(data_in[11:8]),
    .reset(reset),
    .salida_datos(data_out[7:4])
  );
  (* src = "FSM_cond.v:196" *)
  \$paramod\bitwiseOr\WORD_SIZE=4  \ASD[3].bitwiseOr_units  (
    .bit_salida(ctrl_out[3]),
    .entrada(data_in[15:12]),
    .reset(reset)
  );
  (* src = "FSM_cond.v:188" *)
  \$paramod\inversor\WORD_SIZE=4  \ASD[3].inversor_units  (
    .entrada_datos(data_in[15:12]),
    .reset(reset),
    .salida_datos(data_out[3:0])
  );
endmodule