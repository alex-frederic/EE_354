// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Aug 31 15:46:11 2020
// Host        : DESKTOP-JS3JO0N running 64-bit major release  (build 9200)
// Command     : write_verilog C:/Xilinx_Projects/numlock_verilog/extra/ee201_numlock_complete
// Design      : ee201_numlock_top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ee201_numlock_sm
   (Cf_OBUF,
    Cg_OBUF,
    Ce_OBUF,
    Cd_OBUF,
    Cc_OBUF,
    Cb_OBUF,
    Ca_OBUF,
    Ld6_OBUF,
    Ld4_OBUF,
    Ld5_OBUF,
    Ld2_OBUF,
    Ld7_OBUF,
    Ld3_OBUF,
    sys_clk,
    Ca_OBUF_inst_i_2_0,
    p_0_in0_in,
    An0_OBUF,
    Ld1_OBUF,
    Ld0_OBUF,
    Sw3_IBUF,
    Ld3,
    Sw1_IBUF,
    Sw2_IBUF,
    Sw0_IBUF,
    AR);
  output Cf_OBUF;
  output Cg_OBUF;
  output Ce_OBUF;
  output Cd_OBUF;
  output Cc_OBUF;
  output Cb_OBUF;
  output Ca_OBUF;
  output Ld6_OBUF;
  output Ld4_OBUF;
  output Ld5_OBUF;
  output Ld2_OBUF;
  output Ld7_OBUF;
  output Ld3_OBUF;
  input sys_clk;
  input Ca_OBUF_inst_i_2_0;
  input p_0_in0_in;
  input An0_OBUF;
  input Ld1_OBUF;
  input Ld0_OBUF;
  input Sw3_IBUF;
  input Ld3;
  input Sw1_IBUF;
  input Sw2_IBUF;
  input Sw0_IBUF;
  input [0:0]AR;

  wire \<const1> ;
  wire [0:0]AR;
  wire An0_OBUF;
  wire Ca_OBUF;
  wire Ca_OBUF_inst_i_2_0;
  wire Ca_OBUF_inst_i_2_n_0;
  wire Ca_OBUF_inst_i_3_n_0;
  wire Ca_OBUF_inst_i_4_n_0;
  wire Ca_OBUF_inst_i_5_n_0;
  wire Ca_OBUF_inst_i_6_n_0;
  wire Cb_OBUF;
  wire Cc_OBUF;
  wire Cd_OBUF;
  wire Ce_OBUF;
  wire Cf_OBUF;
  wire Cg_OBUF;
  wire Ld0_OBUF;
  wire Ld1_OBUF;
  wire Ld2_OBUF;
  wire Ld2_OBUF_inst_i_2_n_0;
  wire Ld2_OBUF_inst_i_3_n_0;
  wire Ld2_OBUF_inst_i_4_n_0;
  wire Ld2_OBUF_inst_i_5_n_0;
  wire Ld2_OBUF_inst_i_6_n_0;
  wire Ld2_OBUF_inst_i_7_n_0;
  wire Ld2_OBUF_inst_i_8_n_0;
  wire Ld2_OBUF_inst_i_9_n_0;
  wire Ld3;
  wire Ld3_OBUF;
  wire Ld3_OBUF_inst_i_2_n_0;
  wire Ld3_OBUF_inst_i_3_n_0;
  wire Ld3_OBUF_inst_i_4_n_0;
  wire Ld4_OBUF;
  wire Ld5_OBUF;
  wire Ld6_OBUF;
  wire Ld7_OBUF;
  wire Ld7_OBUF_inst_i_2_n_0;
  wire Sw0_IBUF;
  wire Sw1_IBUF;
  wire Sw2_IBUF;
  wire Sw3_IBUF;
  wire [3:0]Timerout_count;
  wire \Timerout_count[3]_i_2_n_0 ;
  wire \Timerout_count[3]_i_3_n_0 ;
  wire \Timerout_count_reg_n_0_[0] ;
  wire \Timerout_count_reg_n_0_[3] ;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_1_in0_in;
  wire [10:0]p_1_in__0;
  wire q_Bad;
  wire q_G1;
  wire q_G10;
  wire q_G101;
  wire q_G1011;
  wire q_G1011get;
  wire q_G101get;
  wire q_G10get;
  wire q_G1get;
  wire q_I;
  wire q_Opening;
  wire \state[10]_i_1_n_0 ;
  wire \state[10]_i_3_n_0 ;
  wire \state[10]_i_4_n_0 ;
  wire \state[10]_i_5_n_0 ;
  wire \state[10]_i_6_n_0 ;
  wire \state[10]_i_7_n_0 ;
  wire sys_clk;

  LUT6 #(
    .INIT(64'h88F8F88F88888F88)) 
    Ca_OBUF_inst_i_1
       (.I0(sys_clk),
        .I1(q_Opening),
        .I2(Ca_OBUF_inst_i_2_n_0),
        .I3(Ca_OBUF_inst_i_3_n_0),
        .I4(Ca_OBUF_inst_i_4_n_0),
        .I5(Ca_OBUF_inst_i_5_n_0),
        .O(Ca_OBUF));
  LUT6 #(
    .INIT(64'hBBBBBBBBAAAAAAAB)) 
    Ca_OBUF_inst_i_2
       (.I0(Ca_OBUF_inst_i_6_n_0),
        .I1(An0_OBUF),
        .I2(Ld7_OBUF_inst_i_2_n_0),
        .I3(q_I),
        .I4(q_G1get),
        .I5(p_1_in__0[0]),
        .O(Ca_OBUF_inst_i_2_n_0));
  LUT6 #(
    .INIT(64'hF0FFAACCF000AACC)) 
    Ca_OBUF_inst_i_3
       (.I0(q_G1),
        .I1(Ld6_OBUF),
        .I2(q_Bad),
        .I3(Ca_OBUF_inst_i_2_0),
        .I4(p_0_in0_in),
        .I5(q_G101),
        .O(Ca_OBUF_inst_i_3_n_0));
  LUT6 #(
    .INIT(64'hF0AACCFFF0AACC00)) 
    Ca_OBUF_inst_i_4
       (.I0(q_G1get),
        .I1(q_G101get),
        .I2(q_Opening),
        .I3(p_0_in0_in),
        .I4(Ca_OBUF_inst_i_2_0),
        .I5(Ld5_OBUF),
        .O(Ca_OBUF_inst_i_4_n_0));
  LUT6 #(
    .INIT(64'hF0AACCFFF0AACC00)) 
    Ca_OBUF_inst_i_5
       (.I0(q_I),
        .I1(q_G10),
        .I2(q_G1011),
        .I3(p_0_in0_in),
        .I4(Ca_OBUF_inst_i_2_0),
        .I5(Ld4_OBUF),
        .O(Ca_OBUF_inst_i_5_n_0));
  LUT4 #(
    .INIT(16'h3808)) 
    Ca_OBUF_inst_i_6
       (.I0(q_G1011get),
        .I1(p_0_in0_in),
        .I2(Ca_OBUF_inst_i_2_0),
        .I3(q_G10get),
        .O(Ca_OBUF_inst_i_6_n_0));
  LUT6 #(
    .INIT(64'hFFFFB680B680B680)) 
    Cb_OBUF_inst_i_1
       (.I0(Ca_OBUF_inst_i_2_n_0),
        .I1(Ca_OBUF_inst_i_5_n_0),
        .I2(Ca_OBUF_inst_i_4_n_0),
        .I3(Ca_OBUF_inst_i_3_n_0),
        .I4(sys_clk),
        .I5(q_Opening),
        .O(Cb_OBUF));
  LUT6 #(
    .INIT(64'hF8F888F8888F8888)) 
    Cc_OBUF_inst_i_1
       (.I0(q_Opening),
        .I1(sys_clk),
        .I2(Ca_OBUF_inst_i_2_n_0),
        .I3(Ca_OBUF_inst_i_5_n_0),
        .I4(Ca_OBUF_inst_i_4_n_0),
        .I5(Ca_OBUF_inst_i_3_n_0),
        .O(Cc_OBUF));
  LUT6 #(
    .INIT(64'hFFFFC124C124C124)) 
    Cd_OBUF_inst_i_1
       (.I0(Ca_OBUF_inst_i_2_n_0),
        .I1(Ca_OBUF_inst_i_5_n_0),
        .I2(Ca_OBUF_inst_i_4_n_0),
        .I3(Ca_OBUF_inst_i_3_n_0),
        .I4(sys_clk),
        .I5(q_Opening),
        .O(Cd_OBUF));
  LUT6 #(
    .INIT(64'hC0EAC0EAC0FFEAEA)) 
    Ce_OBUF_inst_i_1
       (.I0(Ca_OBUF_inst_i_5_n_0),
        .I1(q_Opening),
        .I2(sys_clk),
        .I3(Ca_OBUF_inst_i_2_n_0),
        .I4(Ca_OBUF_inst_i_3_n_0),
        .I5(Ca_OBUF_inst_i_4_n_0),
        .O(Ce_OBUF));
  LUT6 #(
    .INIT(64'h8F88F8888F8F8F88)) 
    Cf_OBUF_inst_i_1
       (.I0(sys_clk),
        .I1(q_Opening),
        .I2(Ca_OBUF_inst_i_2_n_0),
        .I3(Ca_OBUF_inst_i_5_n_0),
        .I4(Ca_OBUF_inst_i_4_n_0),
        .I5(Ca_OBUF_inst_i_3_n_0),
        .O(Cf_OBUF));
  LUT6 #(
    .INIT(64'h888F8888F88888FF)) 
    Cg_OBUF_inst_i_1
       (.I0(q_Opening),
        .I1(sys_clk),
        .I2(Ca_OBUF_inst_i_5_n_0),
        .I3(Ca_OBUF_inst_i_4_n_0),
        .I4(Ca_OBUF_inst_i_3_n_0),
        .I5(Ca_OBUF_inst_i_2_n_0),
        .O(Cg_OBUF));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFEFF)) 
    Ld2_OBUF_inst_i_1
       (.I0(Ld2_OBUF_inst_i_2_n_0),
        .I1(Ld2_OBUF_inst_i_3_n_0),
        .I2(Ld2_OBUF_inst_i_4_n_0),
        .I3(Ld2_OBUF_inst_i_5_n_0),
        .I4(Ld2_OBUF_inst_i_6_n_0),
        .I5(Ld2_OBUF_inst_i_7_n_0),
        .O(Ld2_OBUF));
  LUT6 #(
    .INIT(64'h9600FF96FF969600)) 
    Ld2_OBUF_inst_i_2
       (.I0(q_G101get),
        .I1(q_G10),
        .I2(q_G101),
        .I3(Ld2_OBUF_inst_i_8_n_0),
        .I4(q_I),
        .I5(q_Bad),
        .O(Ld2_OBUF_inst_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    Ld2_OBUF_inst_i_3
       (.I0(q_G1get),
        .I1(q_G1),
        .I2(q_G10get),
        .O(Ld2_OBUF_inst_i_3_n_0));
  LUT6 #(
    .INIT(64'hE817171717E8E8E8)) 
    Ld2_OBUF_inst_i_4
       (.I0(q_G101),
        .I1(q_G10),
        .I2(q_G101get),
        .I3(q_Bad),
        .I4(q_I),
        .I5(Ld2_OBUF_inst_i_9_n_0),
        .O(Ld2_OBUF_inst_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h96)) 
    Ld2_OBUF_inst_i_5
       (.I0(q_G10get),
        .I1(q_G1get),
        .I2(q_G1),
        .O(Ld2_OBUF_inst_i_5_n_0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    Ld2_OBUF_inst_i_6
       (.I0(q_G101get),
        .I1(q_G10),
        .I2(q_G101),
        .I3(q_I),
        .I4(q_Bad),
        .I5(Ld2_OBUF_inst_i_8_n_0),
        .O(Ld2_OBUF_inst_i_6_n_0));
  LUT6 #(
    .INIT(64'hFFE8E800E800E800)) 
    Ld2_OBUF_inst_i_7
       (.I0(q_G101),
        .I1(q_G10),
        .I2(q_G101get),
        .I3(Ld2_OBUF_inst_i_9_n_0),
        .I4(q_Bad),
        .I5(q_I),
        .O(Ld2_OBUF_inst_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h96)) 
    Ld2_OBUF_inst_i_8
       (.I0(q_Opening),
        .I1(q_G1011get),
        .I2(q_G1011),
        .O(Ld2_OBUF_inst_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    Ld2_OBUF_inst_i_9
       (.I0(q_Opening),
        .I1(q_G1011),
        .I2(q_G1011get),
        .O(Ld2_OBUF_inst_i_9_n_0));
  LUT6 #(
    .INIT(64'hFCFCFA0AFC0CFA0A)) 
    Ld3_OBUF_inst_i_1
       (.I0(Ld3_OBUF_inst_i_2_n_0),
        .I1(Ld3_OBUF_inst_i_3_n_0),
        .I2(Sw3_IBUF),
        .I3(Ld3_OBUF_inst_i_4_n_0),
        .I4(Ld3),
        .I5(q_Bad),
        .O(Ld3_OBUF));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    Ld3_OBUF_inst_i_2
       (.I0(q_G1),
        .I1(q_G10get),
        .I2(Sw1_IBUF),
        .I3(q_I),
        .I4(Sw0_IBUF),
        .I5(q_G1get),
        .O(Ld3_OBUF_inst_i_2_n_0));
  LUT6 #(
    .INIT(64'hCFCFAFA0C0C0AFA0)) 
    Ld3_OBUF_inst_i_3
       (.I0(q_G101),
        .I1(q_G1011get),
        .I2(Sw1_IBUF),
        .I3(q_G10),
        .I4(Sw0_IBUF),
        .I5(q_G101get),
        .O(Ld3_OBUF_inst_i_3_n_0));
  LUT6 #(
    .INIT(64'h202A202A303F0000)) 
    Ld3_OBUF_inst_i_4
       (.I0(q_Opening),
        .I1(Sw1_IBUF),
        .I2(Sw3_IBUF),
        .I3(Sw2_IBUF),
        .I4(q_G1011),
        .I5(Sw0_IBUF),
        .O(Ld3_OBUF_inst_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    Ld4_OBUF_inst_i_1
       (.I0(q_Opening),
        .I1(q_G10get),
        .I2(q_G101get),
        .I3(q_G1011get),
        .I4(q_G1get),
        .O(Ld4_OBUF));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    Ld5_OBUF_inst_i_1
       (.I0(q_G101),
        .I1(q_Bad),
        .I2(q_G10get),
        .I3(q_G1),
        .I4(q_G1011get),
        .O(Ld5_OBUF));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    Ld6_OBUF_inst_i_1
       (.I0(q_G1011get),
        .I1(q_G101get),
        .I2(q_G101),
        .I3(q_G10),
        .O(Ld6_OBUF));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFFFF01)) 
    Ld7_OBUF_inst_i_1
       (.I0(Ld7_OBUF_inst_i_2_n_0),
        .I1(q_I),
        .I2(q_G1get),
        .I3(q_Bad),
        .I4(q_Opening),
        .O(Ld7_OBUF));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    Ld7_OBUF_inst_i_2
       (.I0(q_G10),
        .I1(q_G101),
        .I2(q_G101get),
        .I3(q_G1011get),
        .I4(q_G1),
        .I5(q_G10get),
        .O(Ld7_OBUF_inst_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \Timerout_count[0]_i_1 
       (.I0(\Timerout_count_reg_n_0_[0] ),
        .I1(q_G1get),
        .I2(q_Bad),
        .I3(q_G1011),
        .I4(q_I),
        .I5(\Timerout_count[3]_i_3_n_0 ),
        .O(Timerout_count[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0110)) 
    \Timerout_count[1]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\Timerout_count[3]_i_3_n_0 ),
        .I2(p_1_in0_in),
        .I3(\Timerout_count_reg_n_0_[0] ),
        .O(Timerout_count[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h01101010)) 
    \Timerout_count[2]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\Timerout_count[3]_i_3_n_0 ),
        .I2(p_0_in),
        .I3(\Timerout_count_reg_n_0_[0] ),
        .I4(p_1_in0_in),
        .O(Timerout_count[2]));
  LUT6 #(
    .INIT(64'h0111111110000000)) 
    \Timerout_count[3]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\Timerout_count[3]_i_3_n_0 ),
        .I2(p_1_in0_in),
        .I3(\Timerout_count_reg_n_0_[0] ),
        .I4(p_0_in),
        .I5(\Timerout_count_reg_n_0_[3] ),
        .O(Timerout_count[3]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \Timerout_count[3]_i_2 
       (.I0(q_G1get),
        .I1(q_Bad),
        .I2(q_G1011),
        .I3(q_I),
        .O(\Timerout_count[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \Timerout_count[3]_i_3 
       (.I0(q_G10get),
        .I1(q_G1),
        .I2(q_G1011get),
        .I3(q_G101get),
        .I4(\state[10]_i_6_n_0 ),
        .I5(q_Opening),
        .O(\Timerout_count[3]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[0] 
       (.C(sys_clk),
        .CE(\<const1> ),
        .CLR(AR),
        .D(Timerout_count[0]),
        .Q(\Timerout_count_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[1] 
       (.C(sys_clk),
        .CE(\<const1> ),
        .CLR(AR),
        .D(Timerout_count[1]),
        .Q(p_1_in0_in));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[2] 
       (.C(sys_clk),
        .CE(\<const1> ),
        .CLR(AR),
        .D(Timerout_count[2]),
        .Q(p_0_in));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[3] 
       (.C(sys_clk),
        .CE(\<const1> ),
        .CLR(AR),
        .D(Timerout_count[3]),
        .Q(\Timerout_count_reg_n_0_[3] ));
  VCC VCC
       (.P(\<const1> ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \state[0]_i_1 
       (.I0(q_Opening),
        .I1(q_Bad),
        .O(p_1_in__0[0]));
  LUT5 #(
    .INIT(32'hFFFFFFF8)) 
    \state[10]_i_1 
       (.I0(Ld1_OBUF),
        .I1(q_G1),
        .I2(\state[10]_i_3_n_0 ),
        .I3(\state[10]_i_4_n_0 ),
        .I4(\state[10]_i_5_n_0 ),
        .O(\state[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFF0FE0EE)) 
    \state[10]_i_2 
       (.I0(q_G10),
        .I1(q_G101),
        .I2(Ld0_OBUF),
        .I3(Ld1_OBUF),
        .I4(q_G1),
        .O(p_1_in__0[10]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \state[10]_i_3 
       (.I0(\Timerout_count_reg_n_0_[0] ),
        .I1(p_1_in0_in),
        .I2(p_0_in),
        .I3(q_Opening),
        .I4(\Timerout_count_reg_n_0_[3] ),
        .O(\state[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00FF00FFFFFFE2)) 
    \state[10]_i_4 
       (.I0(q_Bad),
        .I1(Ld1_OBUF),
        .I2(\state[10]_i_6_n_0 ),
        .I3(q_G1011),
        .I4(q_G10get),
        .I5(Ld0_OBUF),
        .O(\state[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCCFECCFEFFF000F0)) 
    \state[10]_i_5 
       (.I0(q_G1),
        .I1(\state[10]_i_6_n_0 ),
        .I2(\state[10]_i_7_n_0 ),
        .I3(Ld1_OBUF),
        .I4(q_I),
        .I5(Ld0_OBUF),
        .O(\state[10]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \state[10]_i_6 
       (.I0(q_G10),
        .I1(q_G101),
        .O(\state[10]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \state[10]_i_7 
       (.I0(q_G1get),
        .I1(q_G1011get),
        .I2(q_G101get),
        .O(\state[10]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \state[1]_i_1 
       (.I0(q_Opening),
        .I1(q_Bad),
        .I2(q_G1get),
        .I3(q_G1011),
        .I4(Ld7_OBUF_inst_i_2_n_0),
        .O(p_1_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \state[3]_i_1 
       (.I0(q_G1),
        .I1(Ld1_OBUF),
        .I2(Ld0_OBUF),
        .O(p_1_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \state[5]_i_1 
       (.I0(q_G10),
        .I1(Ld0_OBUF),
        .I2(Ld1_OBUF),
        .O(p_1_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \state[7]_i_1 
       (.I0(q_G101),
        .I1(Ld0_OBUF),
        .I2(Ld1_OBUF),
        .O(p_1_in__0[7]));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \state_reg[0] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .D(p_1_in__0[0]),
        .PRE(AR),
        .Q(q_I));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[10] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(p_1_in__0[10]),
        .Q(q_Bad));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[1] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(p_1_in__0[1]),
        .Q(q_G1get));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[2] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(q_G1get),
        .Q(q_G1));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[3] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(p_1_in__0[3]),
        .Q(q_G10get));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[4] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(q_G10get),
        .Q(q_G10));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[5] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(p_1_in__0[5]),
        .Q(q_G101get));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[6] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(q_G101get),
        .Q(q_G101));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[7] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(p_1_in__0[7]),
        .Q(q_G1011get));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[8] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(q_G1011get),
        .Q(q_G1011));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[9] 
       (.C(sys_clk),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(AR),
        .D(q_G1011),
        .Q(q_Opening));
endmodule

(* ECO_CHECKSUM = "6c73cbdd" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module ee201_numlock_top
   (MemOE,
    MemWR,
    RamCS,
    QuadSpiFlashCS,
    ClkPort,
    BtnL,
    BtnR,
    BtnC,
    Sw3,
    Sw2,
    Sw1,
    Sw0,
    Ld7,
    Ld6,
    Ld5,
    Ld4,
    Ld3,
    Ld2,
    Ld1,
    Ld0,
    An7,
    An6,
    An5,
    An4,
    An3,
    An2,
    An1,
    An0,
    Ca,
    Cb,
    Cc,
    Cd,
    Ce,
    Cf,
    Cg,
    Dp);
  output MemOE;
  output MemWR;
  output RamCS;
  output QuadSpiFlashCS;
  input ClkPort;
  input BtnL;
  input BtnR;
  input BtnC;
  input Sw3;
  input Sw2;
  input Sw1;
  input Sw0;
  output Ld7;
  output Ld6;
  output Ld5;
  output Ld4;
  output Ld3;
  output Ld2;
  output Ld1;
  output Ld0;
  output An7;
  output An6;
  output An5;
  output An4;
  output An3;
  output An2;
  output An1;
  output An0;
  output Ca;
  output Cb;
  output Cc;
  output Cd;
  output Ce;
  output Cf;
  output Cg;
  output Dp;

  wire \<const0> ;
  wire \<const1> ;
  wire An0;
  wire An0_OBUF;
  wire An1;
  wire An1_OBUF;
  wire An2;
  wire An2_OBUF;
  wire An3;
  wire An3_OBUF;
  wire An4;
  wire An5;
  wire An6;
  wire An7;
  wire BtnC;
  wire BtnC_IBUF;
  wire BtnL;
  wire BtnR;
  wire Ca;
  wire Ca_OBUF;
  wire Cb;
  wire Cb_OBUF;
  wire Cc;
  wire Cc_OBUF;
  wire Cd;
  wire Cd_OBUF;
  wire Ce;
  wire Ce_OBUF;
  wire Cf;
  wire Cf_OBUF;
  wire Cg;
  wire Cg_OBUF;
  wire ClkPort;
  wire \DIV_CLK[0]_i_2_n_0 ;
  wire \DIV_CLK_reg[0]_i_1_n_0 ;
  wire \DIV_CLK_reg[0]_i_1_n_4 ;
  wire \DIV_CLK_reg[0]_i_1_n_5 ;
  wire \DIV_CLK_reg[0]_i_1_n_6 ;
  wire \DIV_CLK_reg[0]_i_1_n_7 ;
  wire \DIV_CLK_reg[12]_i_1_n_0 ;
  wire \DIV_CLK_reg[12]_i_1_n_4 ;
  wire \DIV_CLK_reg[12]_i_1_n_5 ;
  wire \DIV_CLK_reg[12]_i_1_n_6 ;
  wire \DIV_CLK_reg[12]_i_1_n_7 ;
  wire \DIV_CLK_reg[16]_i_1_n_0 ;
  wire \DIV_CLK_reg[16]_i_1_n_4 ;
  wire \DIV_CLK_reg[16]_i_1_n_5 ;
  wire \DIV_CLK_reg[16]_i_1_n_6 ;
  wire \DIV_CLK_reg[16]_i_1_n_7 ;
  wire \DIV_CLK_reg[20]_i_1_n_0 ;
  wire \DIV_CLK_reg[20]_i_1_n_4 ;
  wire \DIV_CLK_reg[20]_i_1_n_5 ;
  wire \DIV_CLK_reg[20]_i_1_n_6 ;
  wire \DIV_CLK_reg[20]_i_1_n_7 ;
  wire \DIV_CLK_reg[24]_i_1_n_6 ;
  wire \DIV_CLK_reg[24]_i_1_n_7 ;
  wire \DIV_CLK_reg[4]_i_1_n_0 ;
  wire \DIV_CLK_reg[4]_i_1_n_4 ;
  wire \DIV_CLK_reg[4]_i_1_n_5 ;
  wire \DIV_CLK_reg[4]_i_1_n_6 ;
  wire \DIV_CLK_reg[4]_i_1_n_7 ;
  wire \DIV_CLK_reg[8]_i_1_n_0 ;
  wire \DIV_CLK_reg[8]_i_1_n_4 ;
  wire \DIV_CLK_reg[8]_i_1_n_5 ;
  wire \DIV_CLK_reg[8]_i_1_n_6 ;
  wire \DIV_CLK_reg[8]_i_1_n_7 ;
  wire \DIV_CLK_reg_n_0_[0] ;
  wire \DIV_CLK_reg_n_0_[10] ;
  wire \DIV_CLK_reg_n_0_[11] ;
  wire \DIV_CLK_reg_n_0_[12] ;
  wire \DIV_CLK_reg_n_0_[13] ;
  wire \DIV_CLK_reg_n_0_[14] ;
  wire \DIV_CLK_reg_n_0_[15] ;
  wire \DIV_CLK_reg_n_0_[16] ;
  wire \DIV_CLK_reg_n_0_[17] ;
  wire \DIV_CLK_reg_n_0_[18] ;
  wire \DIV_CLK_reg_n_0_[1] ;
  wire \DIV_CLK_reg_n_0_[20] ;
  wire \DIV_CLK_reg_n_0_[21] ;
  wire \DIV_CLK_reg_n_0_[22] ;
  wire \DIV_CLK_reg_n_0_[23] ;
  wire \DIV_CLK_reg_n_0_[24] ;
  wire \DIV_CLK_reg_n_0_[2] ;
  wire \DIV_CLK_reg_n_0_[3] ;
  wire \DIV_CLK_reg_n_0_[4] ;
  wire \DIV_CLK_reg_n_0_[5] ;
  wire \DIV_CLK_reg_n_0_[6] ;
  wire \DIV_CLK_reg_n_0_[7] ;
  wire \DIV_CLK_reg_n_0_[8] ;
  wire \DIV_CLK_reg_n_0_[9] ;
  wire Dp;
  wire Ld0;
  wire Ld0_OBUF;
  wire Ld1;
  wire Ld1_OBUF;
  wire Ld2;
  wire Ld2_OBUF;
  wire Ld3;
  wire Ld3_OBUF;
  wire Ld3_OBUF_inst_i_5_n_0;
  wire Ld4;
  wire Ld4_OBUF;
  wire Ld5;
  wire Ld5_OBUF;
  wire Ld6;
  wire Ld6_OBUF;
  wire Ld7;
  wire Ld7_OBUF;
  wire MemOE;
  wire MemWR;
  wire QuadSpiFlashCS;
  wire RamCS;
  wire Sw0;
  wire Sw0_IBUF;
  wire Sw1;
  wire Sw1_IBUF;
  wire Sw2;
  wire Sw2_IBUF;
  wire Sw3;
  wire Sw3_IBUF;
  wire board_clk;
  wire p_0_in0_in;
  wire sys_clk;
  wire [3:0]\NLW_DIV_CLK_reg[0]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_DIV_CLK_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_DIV_CLK_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_DIV_CLK_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_DIV_CLK_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_DIV_CLK_reg[8]_i_1_CO_UNCONNECTED ;

  OBUF An0_OBUF_inst
       (.I(An0_OBUF),
        .O(An0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'hE)) 
    An0_OBUF_inst_i_1
       (.I0(p_0_in0_in),
        .I1(\DIV_CLK_reg_n_0_[18] ),
        .O(An0_OBUF));
  OBUF An1_OBUF_inst
       (.I(An1_OBUF),
        .O(An1));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'hB)) 
    An1_OBUF_inst_i_1
       (.I0(p_0_in0_in),
        .I1(\DIV_CLK_reg_n_0_[18] ),
        .O(An1_OBUF));
  OBUF An2_OBUF_inst
       (.I(An2_OBUF),
        .O(An2));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'hB)) 
    An2_OBUF_inst_i_1
       (.I0(\DIV_CLK_reg_n_0_[18] ),
        .I1(p_0_in0_in),
        .O(An2_OBUF));
  OBUF An3_OBUF_inst
       (.I(An3_OBUF),
        .O(An3));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h7)) 
    An3_OBUF_inst_i_1
       (.I0(p_0_in0_in),
        .I1(\DIV_CLK_reg_n_0_[18] ),
        .O(An3_OBUF));
  OBUF An4_OBUF_inst
       (.I(\<const1> ),
        .O(An4));
  OBUF An5_OBUF_inst
       (.I(\<const1> ),
        .O(An5));
  OBUF An6_OBUF_inst
       (.I(\<const1> ),
        .O(An6));
  OBUF An7_OBUF_inst
       (.I(\<const1> ),
        .O(An7));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  BUFGP BUFGP1
       (.I(ClkPort),
        .O(board_clk));
  IBUF BtnC_IBUF_inst
       (.I(BtnC),
        .O(BtnC_IBUF));
  IBUF BtnL_IBUF_inst
       (.I(BtnL),
        .O(Ld1_OBUF));
  IBUF BtnR_IBUF_inst
       (.I(BtnR),
        .O(Ld0_OBUF));
  OBUF Ca_OBUF_inst
       (.I(Ca_OBUF),
        .O(Ca));
  OBUF Cb_OBUF_inst
       (.I(Cb_OBUF),
        .O(Cb));
  OBUF Cc_OBUF_inst
       (.I(Cc_OBUF),
        .O(Cc));
  OBUF Cd_OBUF_inst
       (.I(Cd_OBUF),
        .O(Cd));
  OBUF Ce_OBUF_inst
       (.I(Ce_OBUF),
        .O(Ce));
  OBUF Cf_OBUF_inst
       (.I(Cf_OBUF),
        .O(Cf));
  OBUF Cg_OBUF_inst
       (.I(Cg_OBUF),
        .O(Cg));
  LUT1 #(
    .INIT(2'h1)) 
    \DIV_CLK[0]_i_2 
       (.I0(\DIV_CLK_reg_n_0_[0] ),
        .O(\DIV_CLK[0]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[0] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[0]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[0] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[0]_i_1 
       (.CI(\<const0> ),
        .CO({\DIV_CLK_reg[0]_i_1_n_0 ,\NLW_DIV_CLK_reg[0]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\DIV_CLK_reg[0]_i_1_n_4 ,\DIV_CLK_reg[0]_i_1_n_5 ,\DIV_CLK_reg[0]_i_1_n_6 ,\DIV_CLK_reg[0]_i_1_n_7 }),
        .S({\DIV_CLK_reg_n_0_[3] ,\DIV_CLK_reg_n_0_[2] ,\DIV_CLK_reg_n_0_[1] ,\DIV_CLK[0]_i_2_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[10] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[8]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[11] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[8]_i_1_n_4 ),
        .Q(\DIV_CLK_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[12] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[12]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[12] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[12]_i_1 
       (.CI(\DIV_CLK_reg[8]_i_1_n_0 ),
        .CO({\DIV_CLK_reg[12]_i_1_n_0 ,\NLW_DIV_CLK_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[12]_i_1_n_4 ,\DIV_CLK_reg[12]_i_1_n_5 ,\DIV_CLK_reg[12]_i_1_n_6 ,\DIV_CLK_reg[12]_i_1_n_7 }),
        .S({\DIV_CLK_reg_n_0_[15] ,\DIV_CLK_reg_n_0_[14] ,\DIV_CLK_reg_n_0_[13] ,\DIV_CLK_reg_n_0_[12] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[13] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[12]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[14] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[12]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[15] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[12]_i_1_n_4 ),
        .Q(\DIV_CLK_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[16] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[16]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[16] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[16]_i_1 
       (.CI(\DIV_CLK_reg[12]_i_1_n_0 ),
        .CO({\DIV_CLK_reg[16]_i_1_n_0 ,\NLW_DIV_CLK_reg[16]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[16]_i_1_n_4 ,\DIV_CLK_reg[16]_i_1_n_5 ,\DIV_CLK_reg[16]_i_1_n_6 ,\DIV_CLK_reg[16]_i_1_n_7 }),
        .S({p_0_in0_in,\DIV_CLK_reg_n_0_[18] ,\DIV_CLK_reg_n_0_[17] ,\DIV_CLK_reg_n_0_[16] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[17] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[16]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[18] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[16]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[19] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[16]_i_1_n_4 ),
        .Q(p_0_in0_in));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[1] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[0]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[20] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[20]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[20] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[20]_i_1 
       (.CI(\DIV_CLK_reg[16]_i_1_n_0 ),
        .CO({\DIV_CLK_reg[20]_i_1_n_0 ,\NLW_DIV_CLK_reg[20]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[20]_i_1_n_4 ,\DIV_CLK_reg[20]_i_1_n_5 ,\DIV_CLK_reg[20]_i_1_n_6 ,\DIV_CLK_reg[20]_i_1_n_7 }),
        .S({\DIV_CLK_reg_n_0_[23] ,\DIV_CLK_reg_n_0_[22] ,\DIV_CLK_reg_n_0_[21] ,\DIV_CLK_reg_n_0_[20] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[21] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[20]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[22] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[20]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[23] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[20]_i_1_n_4 ),
        .Q(\DIV_CLK_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[24] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[24]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[24] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[24]_i_1 
       (.CI(\DIV_CLK_reg[20]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[24]_i_1_n_6 ,\DIV_CLK_reg[24]_i_1_n_7 }),
        .S({\<const0> ,\<const0> ,sys_clk,\DIV_CLK_reg_n_0_[24] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[25] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[24]_i_1_n_6 ),
        .Q(sys_clk));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[2] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[0]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[3] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[0]_i_1_n_4 ),
        .Q(\DIV_CLK_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[4] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[4]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[4] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[4]_i_1 
       (.CI(\DIV_CLK_reg[0]_i_1_n_0 ),
        .CO({\DIV_CLK_reg[4]_i_1_n_0 ,\NLW_DIV_CLK_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[4]_i_1_n_4 ,\DIV_CLK_reg[4]_i_1_n_5 ,\DIV_CLK_reg[4]_i_1_n_6 ,\DIV_CLK_reg[4]_i_1_n_7 }),
        .S({\DIV_CLK_reg_n_0_[7] ,\DIV_CLK_reg_n_0_[6] ,\DIV_CLK_reg_n_0_[5] ,\DIV_CLK_reg_n_0_[4] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[5] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[4]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[6] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[4]_i_1_n_5 ),
        .Q(\DIV_CLK_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[7] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[4]_i_1_n_4 ),
        .Q(\DIV_CLK_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[8] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[8]_i_1_n_7 ),
        .Q(\DIV_CLK_reg_n_0_[8] ));
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \DIV_CLK_reg[8]_i_1 
       (.CI(\DIV_CLK_reg[4]_i_1_n_0 ),
        .CO({\DIV_CLK_reg[8]_i_1_n_0 ,\NLW_DIV_CLK_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\DIV_CLK_reg[8]_i_1_n_4 ,\DIV_CLK_reg[8]_i_1_n_5 ,\DIV_CLK_reg[8]_i_1_n_6 ,\DIV_CLK_reg[8]_i_1_n_7 }),
        .S({\DIV_CLK_reg_n_0_[11] ,\DIV_CLK_reg_n_0_[10] ,\DIV_CLK_reg_n_0_[9] ,\DIV_CLK_reg_n_0_[8] }));
  FDCE #(
    .INIT(1'b0)) 
    \DIV_CLK_reg[9] 
       (.C(board_clk),
        .CE(\<const1> ),
        .CLR(BtnC_IBUF),
        .D(\DIV_CLK_reg[8]_i_1_n_6 ),
        .Q(\DIV_CLK_reg_n_0_[9] ));
  OBUF Dp_OBUF_inst
       (.I(\<const0> ),
        .O(Dp));
  GND GND
       (.G(\<const0> ));
  OBUF Ld0_OBUF_inst
       (.I(Ld0_OBUF),
        .O(Ld0));
  OBUF Ld1_OBUF_inst
       (.I(Ld1_OBUF),
        .O(Ld1));
  OBUF Ld2_OBUF_inst
       (.I(Ld2_OBUF),
        .O(Ld2));
  OBUF Ld3_OBUF_inst
       (.I(Ld3_OBUF),
        .O(Ld3));
  LUT3 #(
    .INIT(8'hB8)) 
    Ld3_OBUF_inst_i_5
       (.I0(Sw1_IBUF),
        .I1(Sw3_IBUF),
        .I2(Sw2_IBUF),
        .O(Ld3_OBUF_inst_i_5_n_0));
  OBUF Ld4_OBUF_inst
       (.I(Ld4_OBUF),
        .O(Ld4));
  OBUF Ld5_OBUF_inst
       (.I(Ld5_OBUF),
        .O(Ld5));
  OBUF Ld6_OBUF_inst
       (.I(Ld6_OBUF),
        .O(Ld6));
  OBUF Ld7_OBUF_inst
       (.I(Ld7_OBUF),
        .O(Ld7));
  OBUF MemOE_OBUF_inst
       (.I(\<const1> ),
        .O(MemOE));
  OBUF MemWR_OBUF_inst
       (.I(\<const1> ),
        .O(MemWR));
  OBUF QuadSpiFlashCS_OBUF_inst
       (.I(\<const1> ),
        .O(QuadSpiFlashCS));
  OBUF RamCS_OBUF_inst
       (.I(\<const1> ),
        .O(RamCS));
  ee201_numlock_sm SM1
       (.AR(BtnC_IBUF),
        .An0_OBUF(An0_OBUF),
        .Ca_OBUF(Ca_OBUF),
        .Ca_OBUF_inst_i_2_0(\DIV_CLK_reg_n_0_[18] ),
        .Cb_OBUF(Cb_OBUF),
        .Cc_OBUF(Cc_OBUF),
        .Cd_OBUF(Cd_OBUF),
        .Ce_OBUF(Ce_OBUF),
        .Cf_OBUF(Cf_OBUF),
        .Cg_OBUF(Cg_OBUF),
        .Ld0_OBUF(Ld0_OBUF),
        .Ld1_OBUF(Ld1_OBUF),
        .Ld2_OBUF(Ld2_OBUF),
        .Ld3(Ld3_OBUF_inst_i_5_n_0),
        .Ld3_OBUF(Ld3_OBUF),
        .Ld4_OBUF(Ld4_OBUF),
        .Ld5_OBUF(Ld5_OBUF),
        .Ld6_OBUF(Ld6_OBUF),
        .Ld7_OBUF(Ld7_OBUF),
        .Sw0_IBUF(Sw0_IBUF),
        .Sw1_IBUF(Sw1_IBUF),
        .Sw2_IBUF(Sw2_IBUF),
        .Sw3_IBUF(Sw3_IBUF),
        .p_0_in0_in(p_0_in0_in),
        .sys_clk(sys_clk));
  IBUF Sw0_IBUF_inst
       (.I(Sw0),
        .O(Sw0_IBUF));
  IBUF Sw1_IBUF_inst
       (.I(Sw1),
        .O(Sw1_IBUF));
  IBUF Sw2_IBUF_inst
       (.I(Sw2),
        .O(Sw2_IBUF));
  IBUF Sw3_IBUF_inst
       (.I(Sw3),
        .O(Sw3_IBUF));
  VCC VCC
       (.P(\<const1> ));
endmodule
