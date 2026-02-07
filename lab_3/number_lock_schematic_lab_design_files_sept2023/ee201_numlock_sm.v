// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Aug 28 20:33:38 2020
// Host        : LAPTOP-9MMTPK8V running 64-bit major release  (build 9200)
// Command     : write_verilog ./ee201_numlock_sm.v -force
// Design      : ee201_numlock_sm
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* QBad = "11'b10000000000" *) (* QG1 = "11'b00000000100" *) (* QG10 = "11'b00000010000" *) 
(* QG101 = "11'b00001000000" *) (* QG1011 = "11'b00100000000" *) (* QG1011get = "11'b00010000000" *) 
(* QG101get = "11'b00000100000" *) (* QG10get = "11'b00000001000" *) (* QG1get = "11'b00000000010" *) 
(* QI = "11'b00000000001" *) (* QOpening = "11'b01000000000" *) (* UNK = "11'bxxxxxxxxxxx" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module ee201_numlock_sm
   (clk,
    reset,
    U,
    Z,
    q_I,
    q_G1get,
    q_G1,
    q_G10get,
    q_G10,
    q_G101get,
    q_G101,
    q_G1011get,
    q_G1011,
    q_Opening,
    q_Bad,
    Unlock);
  input clk;
  input reset;
  input U;
  input Z;
  output q_I;
  output q_G1get;
  output q_G1;
  output q_G10get;
  output q_G10;
  output q_G101get;
  output q_G101;
  output q_G1011get;
  output q_G1011;
  output q_Opening;
  output q_Bad;
  output Unlock;

  wire \<const1> ;
  wire [3:0]Timerout_count;
  wire \Timerout_count[2]_i_2_n_0 ;
  wire \Timerout_count[3]_i_2_n_0 ;
  wire \Timerout_count[3]_i_3_n_0 ;
  wire \Timerout_count_reg_n_0_[0] ;
  wire \Timerout_count_reg_n_0_[3] ;
  wire U;
  wire U_IBUF;
  wire Unlock;
  wire Unlock_OBUF;
  wire Z;
  wire Z_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire p_0_in;
  wire p_1_in0_in;
  wire [10:0]p_1_in__0;
  wire q_Bad;
  wire q_Bad_OBUF;
  wire q_G1;
  wire q_G10;
  wire q_G101;
  wire q_G1011;
  wire q_G1011_OBUF;
  wire q_G1011get;
  wire q_G1011get_OBUF;
  wire q_G101_OBUF;
  wire q_G101get;
  wire q_G101get_OBUF;
  wire q_G10_OBUF;
  wire q_G10get;
  wire q_G10get_OBUF;
  wire q_G1_OBUF;
  wire q_G1get;
  wire q_G1get_OBUF;
  wire q_I;
  wire q_I_OBUF;
  wire q_Opening;
  wire reset;
  wire reset_IBUF;
  wire \state[10]_i_1_n_0 ;
  wire \state[10]_i_3_n_0 ;
  wire \state[10]_i_4_n_0 ;
  wire \state[10]_i_5_n_0 ;
  wire \state[10]_i_6_n_0 ;
  wire \state[10]_i_7_n_0 ;
  wire \state[1]_i_2_n_0 ;

  LUT5 #(
    .INIT(32'h00000080)) 
    \Timerout_count[0]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\state[1]_i_2_n_0 ),
        .I2(Unlock_OBUF),
        .I3(q_I_OBUF),
        .I4(\Timerout_count_reg_n_0_[0] ),
        .O(Timerout_count[0]));
  LUT6 #(
    .INIT(64'h0000008000800000)) 
    \Timerout_count[1]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\state[1]_i_2_n_0 ),
        .I2(Unlock_OBUF),
        .I3(q_I_OBUF),
        .I4(p_1_in0_in),
        .I5(\Timerout_count_reg_n_0_[0] ),
        .O(Timerout_count[1]));
  LUT6 #(
    .INIT(64'h0080000000000080)) 
    \Timerout_count[2]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\state[1]_i_2_n_0 ),
        .I2(Unlock_OBUF),
        .I3(q_I_OBUF),
        .I4(p_0_in),
        .I5(\Timerout_count[2]_i_2_n_0 ),
        .O(Timerout_count[2]));
  LUT2 #(
    .INIT(4'h7)) 
    \Timerout_count[2]_i_2 
       (.I0(\Timerout_count_reg_n_0_[0] ),
        .I1(p_1_in0_in),
        .O(\Timerout_count[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000080)) 
    \Timerout_count[3]_i_1 
       (.I0(\Timerout_count[3]_i_2_n_0 ),
        .I1(\state[1]_i_2_n_0 ),
        .I2(Unlock_OBUF),
        .I3(q_I_OBUF),
        .I4(\Timerout_count_reg_n_0_[3] ),
        .I5(\Timerout_count[3]_i_3_n_0 ),
        .O(Timerout_count[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \Timerout_count[3]_i_2 
       (.I0(q_G1011_OBUF),
        .I1(q_G10get_OBUF),
        .I2(q_Bad_OBUF),
        .O(\Timerout_count[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \Timerout_count[3]_i_3 
       (.I0(p_1_in0_in),
        .I1(\Timerout_count_reg_n_0_[0] ),
        .I2(p_0_in),
        .O(\Timerout_count[3]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(reset_IBUF),
        .D(Timerout_count[0]),
        .Q(\Timerout_count_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(reset_IBUF),
        .D(Timerout_count[1]),
        .Q(p_1_in0_in));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(reset_IBUF),
        .D(Timerout_count[2]),
        .Q(p_0_in));
  FDCE #(
    .INIT(1'b0)) 
    \Timerout_count_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(reset_IBUF),
        .D(Timerout_count[3]),
        .Q(\Timerout_count_reg_n_0_[3] ));
  IBUF U_IBUF_inst
       (.I(U),
        .O(U_IBUF));
  OBUF Unlock_OBUF_inst
       (.I(Unlock_OBUF),
        .O(Unlock));
  VCC VCC
       (.P(\<const1> ));
  IBUF Z_IBUF_inst
       (.I(Z),
        .O(Z_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  OBUF q_Bad_OBUF_inst
       (.I(q_Bad_OBUF),
        .O(q_Bad));
  OBUF q_G1011_OBUF_inst
       (.I(q_G1011_OBUF),
        .O(q_G1011));
  OBUF q_G1011get_OBUF_inst
       (.I(q_G1011get_OBUF),
        .O(q_G1011get));
  OBUF q_G101_OBUF_inst
       (.I(q_G101_OBUF),
        .O(q_G101));
  OBUF q_G101get_OBUF_inst
       (.I(q_G101get_OBUF),
        .O(q_G101get));
  OBUF q_G10_OBUF_inst
       (.I(q_G10_OBUF),
        .O(q_G10));
  OBUF q_G10get_OBUF_inst
       (.I(q_G10get_OBUF),
        .O(q_G10get));
  OBUF q_G1_OBUF_inst
       (.I(q_G1_OBUF),
        .O(q_G1));
  OBUF q_G1get_OBUF_inst
       (.I(q_G1get_OBUF),
        .O(q_G1get));
  OBUF q_I_OBUF_inst
       (.I(q_I_OBUF),
        .O(q_I));
  OBUF q_Opening_OBUF_inst
       (.I(Unlock_OBUF),
        .O(q_Opening));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  LUT2 #(
    .INIT(4'hE)) 
    \state[0]_i_1 
       (.I0(Unlock_OBUF),
        .I1(q_Bad_OBUF),
        .O(p_1_in__0[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEA)) 
    \state[10]_i_1 
       (.I0(\state[10]_i_3_n_0 ),
        .I1(q_I_OBUF),
        .I2(\state[10]_i_4_n_0 ),
        .I3(\state[10]_i_5_n_0 ),
        .I4(\state[10]_i_6_n_0 ),
        .I5(\state[10]_i_7_n_0 ),
        .O(\state[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hAAFFFC54)) 
    \state[10]_i_2 
       (.I0(U_IBUF),
        .I1(q_G10_OBUF),
        .I2(q_G101_OBUF),
        .I3(Z_IBUF),
        .I4(q_G1_OBUF),
        .O(p_1_in__0[10]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \state[10]_i_3 
       (.I0(\Timerout_count_reg_n_0_[3] ),
        .I1(Unlock_OBUF),
        .I2(p_0_in),
        .I3(\Timerout_count_reg_n_0_[0] ),
        .I4(p_1_in0_in),
        .O(\state[10]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \state[10]_i_4 
       (.I0(U_IBUF),
        .I1(Z_IBUF),
        .O(\state[10]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0B0A)) 
    \state[10]_i_5 
       (.I0(q_G10get_OBUF),
        .I1(U_IBUF),
        .I2(Z_IBUF),
        .I3(q_Bad_OBUF),
        .O(\state[10]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \state[10]_i_6 
       (.I0(q_G1get_OBUF),
        .I1(q_G101get_OBUF),
        .I2(q_G1011get_OBUF),
        .I3(U_IBUF),
        .O(\state[10]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFEFE00)) 
    \state[10]_i_7 
       (.I0(q_G101_OBUF),
        .I1(q_G10_OBUF),
        .I2(q_G1_OBUF),
        .I3(U_IBUF),
        .I4(Z_IBUF),
        .I5(q_G1011_OBUF),
        .O(\state[10]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \state[1]_i_1 
       (.I0(\state[1]_i_2_n_0 ),
        .I1(q_G1011_OBUF),
        .I2(q_G10get_OBUF),
        .I3(q_Bad_OBUF),
        .I4(Unlock_OBUF),
        .O(p_1_in__0[1]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \state[1]_i_2 
       (.I0(q_G1get_OBUF),
        .I1(q_G101get_OBUF),
        .I2(q_G1011get_OBUF),
        .I3(q_G1_OBUF),
        .I4(q_G10_OBUF),
        .I5(q_G101_OBUF),
        .O(\state[1]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \state[3]_i_1 
       (.I0(q_G1_OBUF),
        .I1(Z_IBUF),
        .I2(U_IBUF),
        .O(p_1_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \state[5]_i_1 
       (.I0(Z_IBUF),
        .I1(U_IBUF),
        .I2(q_G10_OBUF),
        .O(p_1_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \state[7]_i_1 
       (.I0(Z_IBUF),
        .I1(U_IBUF),
        .I2(q_G101_OBUF),
        .O(p_1_in__0[7]));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .D(p_1_in__0[0]),
        .PRE(reset_IBUF),
        .Q(q_I_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(p_1_in__0[10]),
        .Q(q_Bad_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(p_1_in__0[1]),
        .Q(q_G1get_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(q_G1get_OBUF),
        .Q(q_G1_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(p_1_in__0[3]),
        .Q(q_G10get_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(q_G10get_OBUF),
        .Q(q_G10_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(p_1_in__0[5]),
        .Q(q_G101get_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(q_G101get_OBUF),
        .Q(q_G101_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(p_1_in__0[7]),
        .Q(q_G1011get_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(q_G1011get_OBUF),
        .Q(q_G1011_OBUF));
  (* FSM_ENCODED_STATES = "QBad:10000000000,QG101get:00000100000,QI:00000000001,QG1011:00100000000,QG10get:00000001000,QG1011get:00010000000,QG1:00000000100,QG1get:00000000010,QG101:00001000000,QOpening:01000000000,QG10:00000010000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \state_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\state[10]_i_1_n_0 ),
        .CLR(reset_IBUF),
        .D(q_G1011_OBUF),
        .Q(Unlock_OBUF));
endmodule
