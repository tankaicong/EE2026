// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Fri Oct  3 18:01:53 2025
// Host        : kc-ThinkPad-T14-Gen-5 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /media/kc/Data/EE2026/FDP/FDP.sim/sim_1/impl/func/xsim/taskR_sim_func_impl.v
// Design      : Top_Student
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Oled_Display
   (JB_OBUF,
    oled_frame_begin,
    O,
    CLK,
    btnU_IBUF,
    clk_6p25MHz_reg,
    Q,
    \c_offset_zero_reg[7] ,
    clk_6p25MHz,
    p_0_in,
    S,
    \frame_counter_reg[12]_0 );
  output [5:0]JB_OBUF;
  output oled_frame_begin;
  output [2:0]O;
  input CLK;
  input btnU_IBUF;
  input clk_6p25MHz_reg;
  input [7:0]Q;
  input [7:0]\c_offset_zero_reg[7] ;
  input clk_6p25MHz;
  input [1:0]p_0_in;
  input [0:0]S;
  input [2:0]\frame_counter_reg[12]_0 ;

  wire CLK;
  wire \FSM_onehot_state[13]_i_1_n_0 ;
  wire \FSM_onehot_state[13]_i_2_n_0 ;
  wire \FSM_onehot_state[13]_i_3_n_0 ;
  wire \FSM_onehot_state[13]_i_4_n_0 ;
  wire \FSM_onehot_state[15]_i_1_n_0 ;
  wire \FSM_onehot_state[15]_i_2_n_0 ;
  wire \FSM_onehot_state[15]_i_3_n_0 ;
  wire \FSM_onehot_state[15]_i_4_n_0 ;
  wire \FSM_onehot_state[15]_i_7_n_0 ;
  wire \FSM_onehot_state[31]_i_1_n_0 ;
  wire \FSM_onehot_state[31]_i_3_n_0 ;
  wire \FSM_onehot_state[31]_i_4_n_0 ;
  wire \FSM_onehot_state[31]_i_5_n_0 ;
  wire \FSM_onehot_state[31]_i_6_n_0 ;
  wire \FSM_onehot_state[9]_i_1_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[0] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[11] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[12] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[14] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[15] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[16] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[17] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[18] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[19] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[1] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[20] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[21] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[22] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[23] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[24] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[25] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[26] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[27] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[28] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[29] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[2] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[30] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[31] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[3] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[4] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[5] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[6] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[7] ;
  wire [5:0]JB_OBUF;
  wire \JB_OBUF[3]_inst_i_2_n_0 ;
  wire \JB_OBUF[6]_inst_i_2_n_0 ;
  wire [2:0]O;
  wire [7:0]Q;
  wire [0:0]S;
  wire btnU_IBUF;
  wire [7:0]\c_offset_zero_reg[7] ;
  wire clk_6p25MHz;
  wire clk_6p25MHz_reg;
  wire [16:1]data0;
  wire \delay[0]_i_10_n_0 ;
  wire \delay[0]_i_11_n_0 ;
  wire \delay[0]_i_12_n_0 ;
  wire \delay[0]_i_13_n_0 ;
  wire \delay[0]_i_1_n_0 ;
  wire \delay[0]_i_4_n_0 ;
  wire \delay[0]_i_8_n_0 ;
  wire \delay[0]_i_9_n_0 ;
  wire \delay[12]_i_10_n_0 ;
  wire \delay[12]_i_5_n_0 ;
  wire \delay[12]_i_6_n_0 ;
  wire \delay[12]_i_7_n_0 ;
  wire \delay[12]_i_8_n_0 ;
  wire \delay[12]_i_9_n_0 ;
  wire \delay[16]_i_3_n_0 ;
  wire \delay[16]_i_4_n_0 ;
  wire \delay[16]_i_5_n_0 ;
  wire \delay[16]_i_6_n_0 ;
  wire \delay[16]_i_7_n_0 ;
  wire \delay[4]_i_5_n_0 ;
  wire \delay[4]_i_6_n_0 ;
  wire \delay[4]_i_7_n_0 ;
  wire \delay[4]_i_8_n_0 ;
  wire \delay[4]_i_9_n_0 ;
  wire \delay[8]_i_4_n_0 ;
  wire \delay[8]_i_5_n_0 ;
  wire \delay[8]_i_6_n_0 ;
  wire \delay[8]_i_7_n_0 ;
  wire [19:0]delay_reg;
  wire \delay_reg[0]_i_2_n_0 ;
  wire \delay_reg[0]_i_2_n_4 ;
  wire \delay_reg[0]_i_2_n_5 ;
  wire \delay_reg[0]_i_2_n_6 ;
  wire \delay_reg[0]_i_2_n_7 ;
  wire \delay_reg[12]_i_1_n_0 ;
  wire \delay_reg[12]_i_1_n_4 ;
  wire \delay_reg[12]_i_1_n_5 ;
  wire \delay_reg[12]_i_1_n_6 ;
  wire \delay_reg[12]_i_1_n_7 ;
  wire \delay_reg[16]_i_1_n_4 ;
  wire \delay_reg[16]_i_1_n_5 ;
  wire \delay_reg[16]_i_1_n_6 ;
  wire \delay_reg[16]_i_1_n_7 ;
  wire \delay_reg[4]_i_1_n_0 ;
  wire \delay_reg[4]_i_1_n_4 ;
  wire \delay_reg[4]_i_1_n_5 ;
  wire \delay_reg[4]_i_1_n_6 ;
  wire \delay_reg[4]_i_1_n_7 ;
  wire \delay_reg[8]_i_1_n_0 ;
  wire \delay_reg[8]_i_1_n_4 ;
  wire \delay_reg[8]_i_1_n_5 ;
  wire \delay_reg[8]_i_1_n_6 ;
  wire \delay_reg[8]_i_1_n_7 ;
  wire frame_counter1_carry__0_n_0;
  wire frame_counter1_carry__1_n_0;
  wire frame_counter1_carry_n_0;
  wire \frame_counter[0]_i_1_n_0 ;
  wire \frame_counter[10]_i_1_n_0 ;
  wire \frame_counter[11]_i_1_n_0 ;
  wire \frame_counter[12]_i_1_n_0 ;
  wire \frame_counter[13]_i_1_n_0 ;
  wire \frame_counter[14]_i_1_n_0 ;
  wire \frame_counter[15]_i_1_n_0 ;
  wire \frame_counter[16]_i_1_n_0 ;
  wire \frame_counter[16]_i_2_n_0 ;
  wire \frame_counter[16]_i_3_n_0 ;
  wire \frame_counter[16]_i_4_n_0 ;
  wire \frame_counter[1]_i_1_n_0 ;
  wire \frame_counter[2]_i_1_n_0 ;
  wire \frame_counter[3]_i_1_n_0 ;
  wire \frame_counter[4]_i_1_n_0 ;
  wire \frame_counter[5]_i_1_n_0 ;
  wire \frame_counter[6]_i_1_n_0 ;
  wire \frame_counter[7]_i_1_n_0 ;
  wire \frame_counter[8]_i_1_n_0 ;
  wire \frame_counter[9]_i_1_n_0 ;
  wire [2:0]\frame_counter_reg[12]_0 ;
  wire \frame_counter_reg_n_0_[0] ;
  wire \frame_counter_reg_n_0_[1] ;
  wire \frame_counter_reg_n_0_[2] ;
  wire \frame_counter_reg_n_0_[3] ;
  wire oled_data410_in;
  wire oled_data42_in;
  wire oled_data66_in;
  wire oled_frame_begin;
  wire oled_frame_begin_BUFG_inst_i_2_n_0;
  wire oled_frame_begin_BUFG_inst_i_3_n_0;
  wire oled_frame_begin_BUFG_inst_i_4_n_0;
  wire [12:0]oled_pixel_index;
  wire [1:0]p_0_in;
  wire [12:0]p_0_in_0;
  wire [5:1]p_0_in__0;
  (* RTL_KEEP = "yes" *) wire p_2_in;
  (* RTL_KEEP = "yes" *) wire p_3_in;
  (* RTL_KEEP = "yes" *) wire p_4_in;
  wire \spi_word[0]_i_1_n_0 ;
  wire \spi_word[10]_i_1_n_0 ;
  wire \spi_word[11]_i_1_n_0 ;
  wire \spi_word[12]_i_1_n_0 ;
  wire \spi_word[13]_i_1_n_0 ;
  wire \spi_word[14]_i_1_n_0 ;
  wire \spi_word[14]_i_2_n_0 ;
  wire \spi_word[14]_i_3_n_0 ;
  wire \spi_word[14]_i_4_n_0 ;
  wire \spi_word[14]_i_5_n_0 ;
  wire \spi_word[14]_i_6_n_0 ;
  wire \spi_word[14]_i_7_n_0 ;
  wire \spi_word[14]_i_8_n_0 ;
  wire \spi_word[14]_i_9_n_0 ;
  wire \spi_word[15]_i_1_n_0 ;
  wire \spi_word[16]_i_1_n_0 ;
  wire \spi_word[17]_i_1_n_0 ;
  wire \spi_word[18]_i_1_n_0 ;
  wire \spi_word[19]_i_1_n_0 ;
  wire \spi_word[1]_i_1_n_0 ;
  wire \spi_word[20]_i_1_n_0 ;
  wire \spi_word[21]_i_1_n_0 ;
  wire \spi_word[21]_i_2_n_0 ;
  wire \spi_word[22]_i_1_n_0 ;
  wire \spi_word[22]_i_2_n_0 ;
  wire \spi_word[22]_i_3_n_0 ;
  wire \spi_word[22]_i_4_n_0 ;
  wire \spi_word[22]_i_5_n_0 ;
  wire \spi_word[22]_i_6_n_0 ;
  wire \spi_word[22]_i_7_n_0 ;
  wire \spi_word[23]_i_1_n_0 ;
  wire \spi_word[24]_i_1_n_0 ;
  wire \spi_word[24]_i_2_n_0 ;
  wire \spi_word[24]_i_3_n_0 ;
  wire \spi_word[24]_i_4_n_0 ;
  wire \spi_word[25]_i_1_n_0 ;
  wire \spi_word[25]_i_2_n_0 ;
  wire \spi_word[25]_i_3_n_0 ;
  wire \spi_word[25]_i_4_n_0 ;
  wire \spi_word[26]_i_1_n_0 ;
  wire \spi_word[26]_i_2_n_0 ;
  wire \spi_word[26]_i_3_n_0 ;
  wire \spi_word[27]_i_1_n_0 ;
  wire \spi_word[27]_i_2_n_0 ;
  wire \spi_word[27]_i_3_n_0 ;
  wire \spi_word[28]_i_1_n_0 ;
  wire \spi_word[28]_i_2_n_0 ;
  wire \spi_word[28]_i_3_n_0 ;
  wire \spi_word[28]_i_4_n_0 ;
  wire \spi_word[29]_i_1_n_0 ;
  wire \spi_word[29]_i_2_n_0 ;
  wire \spi_word[2]_i_1_n_0 ;
  wire \spi_word[30]_i_1_n_0 ;
  wire \spi_word[30]_i_2_n_0 ;
  wire \spi_word[30]_i_3_n_0 ;
  wire \spi_word[30]_i_4_n_0 ;
  wire \spi_word[31]_i_1_n_0 ;
  wire \spi_word[31]_i_2_n_0 ;
  wire \spi_word[32]_i_1_n_0 ;
  wire \spi_word[32]_i_2_n_0 ;
  wire \spi_word[32]_i_3_n_0 ;
  wire \spi_word[32]_i_4_n_0 ;
  wire \spi_word[33]_i_1_n_0 ;
  wire \spi_word[33]_i_2_n_0 ;
  wire \spi_word[33]_i_3_n_0 ;
  wire \spi_word[33]_i_4_n_0 ;
  wire \spi_word[33]_i_5_n_0 ;
  wire \spi_word[33]_i_6_n_0 ;
  wire \spi_word[33]_i_7_n_0 ;
  wire \spi_word[33]_i_8_n_0 ;
  wire \spi_word[34]_i_1_n_0 ;
  wire \spi_word[34]_i_2_n_0 ;
  wire \spi_word[34]_i_3_n_0 ;
  wire \spi_word[34]_i_4_n_0 ;
  wire \spi_word[35]_i_100_n_0 ;
  wire \spi_word[35]_i_101_n_0 ;
  wire \spi_word[35]_i_102_n_0 ;
  wire \spi_word[35]_i_10_n_0 ;
  wire \spi_word[35]_i_16_n_0 ;
  wire \spi_word[35]_i_18_n_0 ;
  wire \spi_word[35]_i_19_n_0 ;
  wire \spi_word[35]_i_1_n_0 ;
  wire \spi_word[35]_i_20_n_0 ;
  wire \spi_word[35]_i_21_n_0 ;
  wire \spi_word[35]_i_22_n_0 ;
  wire \spi_word[35]_i_23_n_0 ;
  wire \spi_word[35]_i_24_n_0 ;
  wire \spi_word[35]_i_25_n_0 ;
  wire \spi_word[35]_i_27_n_0 ;
  wire \spi_word[35]_i_28_n_0 ;
  wire \spi_word[35]_i_29_n_0 ;
  wire \spi_word[35]_i_2_n_0 ;
  wire \spi_word[35]_i_30_n_0 ;
  wire \spi_word[35]_i_31_n_0 ;
  wire \spi_word[35]_i_32_n_0 ;
  wire \spi_word[35]_i_33_n_0 ;
  wire \spi_word[35]_i_34_n_0 ;
  wire \spi_word[35]_i_35_n_0 ;
  wire \spi_word[35]_i_36_n_0 ;
  wire \spi_word[35]_i_37_n_0 ;
  wire \spi_word[35]_i_38_n_0 ;
  wire \spi_word[35]_i_3_n_0 ;
  wire \spi_word[35]_i_44_n_0 ;
  wire \spi_word[35]_i_45_n_0 ;
  wire \spi_word[35]_i_46_n_0 ;
  wire \spi_word[35]_i_47_n_0 ;
  wire \spi_word[35]_i_48_n_0 ;
  wire \spi_word[35]_i_49_n_0 ;
  wire \spi_word[35]_i_4_n_0 ;
  wire \spi_word[35]_i_51_n_0 ;
  wire \spi_word[35]_i_52_n_0 ;
  wire \spi_word[35]_i_53_n_0 ;
  wire \spi_word[35]_i_54_n_0 ;
  wire \spi_word[35]_i_55_n_0 ;
  wire \spi_word[35]_i_56_n_0 ;
  wire \spi_word[35]_i_57_n_0 ;
  wire \spi_word[35]_i_59_n_0 ;
  wire \spi_word[35]_i_5_n_0 ;
  wire \spi_word[35]_i_60_n_0 ;
  wire \spi_word[35]_i_61_n_0 ;
  wire \spi_word[35]_i_62_n_0 ;
  wire \spi_word[35]_i_63_n_0 ;
  wire \spi_word[35]_i_64_n_0 ;
  wire \spi_word[35]_i_68_n_0 ;
  wire \spi_word[35]_i_69_n_0 ;
  wire \spi_word[35]_i_6_n_0 ;
  wire \spi_word[35]_i_70_n_0 ;
  wire \spi_word[35]_i_71_n_0 ;
  wire \spi_word[35]_i_72_n_0 ;
  wire \spi_word[35]_i_73_n_0 ;
  wire \spi_word[35]_i_74_n_0 ;
  wire \spi_word[35]_i_75_n_0 ;
  wire \spi_word[35]_i_76_n_0 ;
  wire \spi_word[35]_i_78_n_0 ;
  wire \spi_word[35]_i_79_n_0 ;
  wire \spi_word[35]_i_7_n_0 ;
  wire \spi_word[35]_i_80_n_0 ;
  wire \spi_word[35]_i_81_n_0 ;
  wire \spi_word[35]_i_83_n_0 ;
  wire \spi_word[35]_i_84_n_0 ;
  wire \spi_word[35]_i_85_n_0 ;
  wire \spi_word[35]_i_87_n_0 ;
  wire \spi_word[35]_i_88_n_0 ;
  wire \spi_word[35]_i_89_n_0 ;
  wire \spi_word[35]_i_8_n_0 ;
  wire \spi_word[35]_i_90_n_0 ;
  wire \spi_word[35]_i_92_n_0 ;
  wire \spi_word[35]_i_93_n_0 ;
  wire \spi_word[35]_i_94_n_0 ;
  wire \spi_word[35]_i_95_n_0 ;
  wire \spi_word[35]_i_96_n_0 ;
  wire \spi_word[35]_i_97_n_0 ;
  wire \spi_word[35]_i_98_n_0 ;
  wire \spi_word[35]_i_99_n_0 ;
  wire \spi_word[35]_i_9_n_0 ;
  wire \spi_word[36]_i_1_n_0 ;
  wire \spi_word[36]_i_2_n_0 ;
  wire \spi_word[36]_i_3_n_0 ;
  wire \spi_word[36]_i_4_n_0 ;
  wire \spi_word[37]_i_1_n_0 ;
  wire \spi_word[37]_i_2_n_0 ;
  wire \spi_word[37]_i_3_n_0 ;
  wire \spi_word[37]_i_4_n_0 ;
  wire \spi_word[37]_i_5_n_0 ;
  wire \spi_word[37]_i_6_n_0 ;
  wire \spi_word[37]_i_7_n_0 ;
  wire \spi_word[37]_i_8_n_0 ;
  wire \spi_word[37]_i_9_n_0 ;
  wire \spi_word[38]_i_1_n_0 ;
  wire \spi_word[38]_i_2_n_0 ;
  wire \spi_word[38]_i_3_n_0 ;
  wire \spi_word[38]_i_4_n_0 ;
  wire \spi_word[38]_i_5_n_0 ;
  wire \spi_word[38]_i_6_n_0 ;
  wire \spi_word[38]_i_7_n_0 ;
  wire \spi_word[39]_i_100_n_0 ;
  wire \spi_word[39]_i_101_n_0 ;
  wire \spi_word[39]_i_103_n_0 ;
  wire \spi_word[39]_i_104_n_0 ;
  wire \spi_word[39]_i_105_n_0 ;
  wire \spi_word[39]_i_106_n_0 ;
  wire \spi_word[39]_i_107_n_0 ;
  wire \spi_word[39]_i_108_n_0 ;
  wire \spi_word[39]_i_109_n_0 ;
  wire \spi_word[39]_i_10_n_0 ;
  wire \spi_word[39]_i_110_n_0 ;
  wire \spi_word[39]_i_111_n_0 ;
  wire \spi_word[39]_i_112_n_0 ;
  wire \spi_word[39]_i_113_n_0 ;
  wire \spi_word[39]_i_114_n_0 ;
  wire \spi_word[39]_i_115_n_0 ;
  wire \spi_word[39]_i_116_n_0 ;
  wire \spi_word[39]_i_117_n_0 ;
  wire \spi_word[39]_i_118_n_0 ;
  wire \spi_word[39]_i_119_n_0 ;
  wire \spi_word[39]_i_11_n_0 ;
  wire \spi_word[39]_i_120_n_0 ;
  wire \spi_word[39]_i_121_n_0 ;
  wire \spi_word[39]_i_122_n_0 ;
  wire \spi_word[39]_i_123_n_0 ;
  wire \spi_word[39]_i_125_n_0 ;
  wire \spi_word[39]_i_126_n_0 ;
  wire \spi_word[39]_i_127_n_0 ;
  wire \spi_word[39]_i_128_n_0 ;
  wire \spi_word[39]_i_129_n_0 ;
  wire \spi_word[39]_i_12_n_0 ;
  wire \spi_word[39]_i_130_n_0 ;
  wire \spi_word[39]_i_131_n_0 ;
  wire \spi_word[39]_i_132_n_0 ;
  wire \spi_word[39]_i_133_n_0 ;
  wire \spi_word[39]_i_134_n_0 ;
  wire \spi_word[39]_i_135_n_0 ;
  wire \spi_word[39]_i_136_n_0 ;
  wire \spi_word[39]_i_137_n_0 ;
  wire \spi_word[39]_i_138_n_0 ;
  wire \spi_word[39]_i_139_n_0 ;
  wire \spi_word[39]_i_13_n_0 ;
  wire \spi_word[39]_i_140_n_0 ;
  wire \spi_word[39]_i_141_n_0 ;
  wire \spi_word[39]_i_142_n_0 ;
  wire \spi_word[39]_i_143_n_0 ;
  wire \spi_word[39]_i_144_n_0 ;
  wire \spi_word[39]_i_145_n_0 ;
  wire \spi_word[39]_i_146_n_0 ;
  wire \spi_word[39]_i_147_n_0 ;
  wire \spi_word[39]_i_148_n_0 ;
  wire \spi_word[39]_i_149_n_0 ;
  wire \spi_word[39]_i_14_n_0 ;
  wire \spi_word[39]_i_150_n_0 ;
  wire \spi_word[39]_i_151_n_0 ;
  wire \spi_word[39]_i_153_n_0 ;
  wire \spi_word[39]_i_155_n_0 ;
  wire \spi_word[39]_i_156_n_0 ;
  wire \spi_word[39]_i_157_n_0 ;
  wire \spi_word[39]_i_159_n_0 ;
  wire \spi_word[39]_i_15_n_0 ;
  wire \spi_word[39]_i_160_n_0 ;
  wire \spi_word[39]_i_16_n_0 ;
  wire \spi_word[39]_i_17_n_0 ;
  wire \spi_word[39]_i_18_n_0 ;
  wire \spi_word[39]_i_19_n_0 ;
  wire \spi_word[39]_i_1_n_0 ;
  wire \spi_word[39]_i_23_n_0 ;
  wire \spi_word[39]_i_28_n_0 ;
  wire \spi_word[39]_i_29_n_0 ;
  wire \spi_word[39]_i_2_n_0 ;
  wire \spi_word[39]_i_30_n_0 ;
  wire \spi_word[39]_i_31_n_0 ;
  wire \spi_word[39]_i_33_n_0 ;
  wire \spi_word[39]_i_34_n_0 ;
  wire \spi_word[39]_i_35_n_0 ;
  wire \spi_word[39]_i_36_n_0 ;
  wire \spi_word[39]_i_37_n_0 ;
  wire \spi_word[39]_i_38_n_0 ;
  wire \spi_word[39]_i_39_n_0 ;
  wire \spi_word[39]_i_3_n_0 ;
  wire \spi_word[39]_i_40_n_0 ;
  wire \spi_word[39]_i_41_n_0 ;
  wire \spi_word[39]_i_43_n_0 ;
  wire \spi_word[39]_i_44_n_0 ;
  wire \spi_word[39]_i_45_n_0 ;
  wire \spi_word[39]_i_46_n_0 ;
  wire \spi_word[39]_i_47_n_0 ;
  wire \spi_word[39]_i_48_n_0 ;
  wire \spi_word[39]_i_49_n_0 ;
  wire \spi_word[39]_i_4_n_0 ;
  wire \spi_word[39]_i_50_n_0 ;
  wire \spi_word[39]_i_53_n_0 ;
  wire \spi_word[39]_i_54_n_0 ;
  wire \spi_word[39]_i_55_n_0 ;
  wire \spi_word[39]_i_56_n_0 ;
  wire \spi_word[39]_i_57_n_0 ;
  wire \spi_word[39]_i_58_n_0 ;
  wire \spi_word[39]_i_59_n_0 ;
  wire \spi_word[39]_i_5_n_0 ;
  wire \spi_word[39]_i_60_n_0 ;
  wire \spi_word[39]_i_62_n_0 ;
  wire \spi_word[39]_i_64_n_0 ;
  wire \spi_word[39]_i_65_n_0 ;
  wire \spi_word[39]_i_66_n_0 ;
  wire \spi_word[39]_i_67_n_0 ;
  wire \spi_word[39]_i_6_n_0 ;
  wire \spi_word[39]_i_70_n_0 ;
  wire \spi_word[39]_i_71_n_0 ;
  wire \spi_word[39]_i_72_n_0 ;
  wire \spi_word[39]_i_73_n_0 ;
  wire \spi_word[39]_i_74_n_0 ;
  wire \spi_word[39]_i_75_n_0 ;
  wire \spi_word[39]_i_76_n_0 ;
  wire \spi_word[39]_i_78_n_0 ;
  wire \spi_word[39]_i_79_n_0 ;
  wire \spi_word[39]_i_7_n_0 ;
  wire \spi_word[39]_i_80_n_0 ;
  wire \spi_word[39]_i_81_n_0 ;
  wire \spi_word[39]_i_82_n_0 ;
  wire \spi_word[39]_i_83_n_0 ;
  wire \spi_word[39]_i_84_n_0 ;
  wire \spi_word[39]_i_85_n_0 ;
  wire \spi_word[39]_i_86_n_0 ;
  wire \spi_word[39]_i_87_n_0 ;
  wire \spi_word[39]_i_88_n_0 ;
  wire \spi_word[39]_i_89_n_0 ;
  wire \spi_word[39]_i_8_n_0 ;
  wire \spi_word[39]_i_91_n_0 ;
  wire \spi_word[39]_i_92_n_0 ;
  wire \spi_word[39]_i_93_n_0 ;
  wire \spi_word[39]_i_94_n_0 ;
  wire \spi_word[39]_i_95_n_0 ;
  wire \spi_word[39]_i_96_n_0 ;
  wire \spi_word[39]_i_97_n_0 ;
  wire \spi_word[39]_i_98_n_0 ;
  wire \spi_word[39]_i_99_n_0 ;
  wire \spi_word[39]_i_9_n_0 ;
  wire \spi_word[3]_i_1_n_0 ;
  wire \spi_word[4]_i_1_n_0 ;
  wire \spi_word[5]_i_1_n_0 ;
  wire \spi_word[6]_i_1_n_0 ;
  wire \spi_word[7]_i_1_n_0 ;
  wire \spi_word[8]_i_1_n_0 ;
  wire \spi_word[9]_i_1_n_0 ;
  wire \spi_word_bit_count[0]_i_1_n_0 ;
  wire \spi_word_bit_count[3]_i_2_n_0 ;
  wire \spi_word_bit_count[3]_i_3_n_0 ;
  wire \spi_word_bit_count[4]_i_2_n_0 ;
  wire \spi_word_bit_count[4]_i_3_n_0 ;
  wire \spi_word_bit_count[5]_i_2_n_0 ;
  wire [5:0]spi_word_bit_count_reg__0;
  wire \spi_word_reg[35]_i_11_n_4 ;
  wire \spi_word_reg[35]_i_11_n_5 ;
  wire \spi_word_reg[35]_i_11_n_6 ;
  wire \spi_word_reg[35]_i_11_n_7 ;
  wire \spi_word_reg[35]_i_12_n_0 ;
  wire \spi_word_reg[35]_i_12_n_4 ;
  wire \spi_word_reg[35]_i_12_n_5 ;
  wire \spi_word_reg[35]_i_12_n_6 ;
  wire \spi_word_reg[35]_i_12_n_7 ;
  wire \spi_word_reg[35]_i_14_n_3 ;
  wire \spi_word_reg[35]_i_15_n_3 ;
  wire \spi_word_reg[35]_i_39_n_0 ;
  wire \spi_word_reg[35]_i_41_n_0 ;
  wire \spi_word_reg[35]_i_50_n_0 ;
  wire \spi_word_reg[35]_i_58_n_0 ;
  wire \spi_word_reg[35]_i_82_n_0 ;
  wire \spi_word_reg[35]_i_86_n_0 ;
  wire \spi_word_reg[35]_i_91_n_0 ;
  wire \spi_word_reg[39]_i_102_n_0 ;
  wire \spi_word_reg[39]_i_124_n_0 ;
  wire \spi_word_reg[39]_i_20_n_3 ;
  wire \spi_word_reg[39]_i_22_n_0 ;
  wire \spi_word_reg[39]_i_22_n_4 ;
  wire \spi_word_reg[39]_i_22_n_5 ;
  wire \spi_word_reg[39]_i_22_n_6 ;
  wire \spi_word_reg[39]_i_22_n_7 ;
  wire \spi_word_reg[39]_i_24_n_0 ;
  wire \spi_word_reg[39]_i_25_n_3 ;
  wire \spi_word_reg[39]_i_27_n_1 ;
  wire \spi_word_reg[39]_i_27_n_6 ;
  wire \spi_word_reg[39]_i_27_n_7 ;
  wire \spi_word_reg[39]_i_32_n_0 ;
  wire \spi_word_reg[39]_i_42_n_0 ;
  wire \spi_word_reg[39]_i_51_n_4 ;
  wire \spi_word_reg[39]_i_51_n_5 ;
  wire \spi_word_reg[39]_i_51_n_6 ;
  wire \spi_word_reg[39]_i_51_n_7 ;
  wire \spi_word_reg[39]_i_52_n_0 ;
  wire \spi_word_reg[39]_i_61_n_0 ;
  wire \spi_word_reg[39]_i_63_n_0 ;
  wire \spi_word_reg[39]_i_69_n_0 ;
  wire \spi_word_reg[39]_i_77_n_0 ;
  wire \spi_word_reg[39]_i_90_n_0 ;
  wire \spi_word_reg[39]_i_90_n_4 ;
  wire \spi_word_reg[39]_i_90_n_5 ;
  wire \spi_word_reg[39]_i_90_n_6 ;
  wire \spi_word_reg[39]_i_90_n_7 ;
  wire \spi_word_reg_n_0_[0] ;
  wire \spi_word_reg_n_0_[10] ;
  wire \spi_word_reg_n_0_[11] ;
  wire \spi_word_reg_n_0_[12] ;
  wire \spi_word_reg_n_0_[13] ;
  wire \spi_word_reg_n_0_[14] ;
  wire \spi_word_reg_n_0_[15] ;
  wire \spi_word_reg_n_0_[16] ;
  wire \spi_word_reg_n_0_[17] ;
  wire \spi_word_reg_n_0_[18] ;
  wire \spi_word_reg_n_0_[19] ;
  wire \spi_word_reg_n_0_[1] ;
  wire \spi_word_reg_n_0_[20] ;
  wire \spi_word_reg_n_0_[21] ;
  wire \spi_word_reg_n_0_[22] ;
  wire \spi_word_reg_n_0_[23] ;
  wire \spi_word_reg_n_0_[24] ;
  wire \spi_word_reg_n_0_[25] ;
  wire \spi_word_reg_n_0_[26] ;
  wire \spi_word_reg_n_0_[27] ;
  wire \spi_word_reg_n_0_[28] ;
  wire \spi_word_reg_n_0_[29] ;
  wire \spi_word_reg_n_0_[2] ;
  wire \spi_word_reg_n_0_[30] ;
  wire \spi_word_reg_n_0_[31] ;
  wire \spi_word_reg_n_0_[32] ;
  wire \spi_word_reg_n_0_[33] ;
  wire \spi_word_reg_n_0_[34] ;
  wire \spi_word_reg_n_0_[35] ;
  wire \spi_word_reg_n_0_[36] ;
  wire \spi_word_reg_n_0_[37] ;
  wire \spi_word_reg_n_0_[38] ;
  wire \spi_word_reg_n_0_[39] ;
  wire \spi_word_reg_n_0_[3] ;
  wire \spi_word_reg_n_0_[4] ;
  wire \spi_word_reg_n_0_[5] ;
  wire \spi_word_reg_n_0_[6] ;
  wire \spi_word_reg_n_0_[7] ;
  wire \spi_word_reg_n_0_[8] ;
  wire \spi_word_reg_n_0_[9] ;
  wire [2:0]\NLW_delay_reg[0]_i_2_CO_UNCONNECTED ;
  wire [2:0]\NLW_delay_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_delay_reg[16]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_delay_reg[4]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_delay_reg[8]_i_1_CO_UNCONNECTED ;
  wire [2:0]NLW_frame_counter1_carry_CO_UNCONNECTED;
  wire [2:0]NLW_frame_counter1_carry__0_CO_UNCONNECTED;
  wire [2:0]NLW_frame_counter1_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_frame_counter1_carry__2_CO_UNCONNECTED;
  wire [3:0]\NLW_spi_word_reg[35]_i_11_CO_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_12_CO_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_13_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_13_O_UNCONNECTED ;
  wire [3:1]\NLW_spi_word_reg[35]_i_14_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_14_O_UNCONNECTED ;
  wire [3:1]\NLW_spi_word_reg[35]_i_15_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_15_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_39_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_39_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_41_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_41_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_50_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_50_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_58_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_58_O_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_67_CO_UNCONNECTED ;
  wire [3:3]\NLW_spi_word_reg[35]_i_67_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_82_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_82_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_86_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_86_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[35]_i_91_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_91_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_102_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_102_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_124_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_124_O_UNCONNECTED ;
  wire [3:1]\NLW_spi_word_reg[39]_i_20_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_20_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_21_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_21_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_22_CO_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_24_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_24_O_UNCONNECTED ;
  wire [3:1]\NLW_spi_word_reg[39]_i_25_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_25_O_UNCONNECTED ;
  wire [3:1]\NLW_spi_word_reg[39]_i_26_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_26_O_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_27_CO_UNCONNECTED ;
  wire [3:2]\NLW_spi_word_reg[39]_i_27_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_32_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_32_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_42_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_42_O_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_51_CO_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_52_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_52_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_61_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_61_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_63_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_63_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_69_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_69_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_77_CO_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[39]_i_77_O_UNCONNECTED ;
  wire [2:0]\NLW_spi_word_reg[39]_i_90_CO_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hFF8F8888)) 
    \FSM_onehot_state[13]_i_1 
       (.I0(oled_frame_begin),
        .I1(p_4_in),
        .I2(\FSM_onehot_state[13]_i_2_n_0 ),
        .I3(\FSM_onehot_state[13]_i_3_n_0 ),
        .I4(JB_OBUF[3]),
        .O(\FSM_onehot_state[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_onehot_state[13]_i_2 
       (.I0(p_0_in_0[0]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[12]),
        .I4(p_0_in_0[4]),
        .O(\FSM_onehot_state[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFF)) 
    \FSM_onehot_state[13]_i_3 
       (.I0(p_0_in_0[7]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[5]),
        .I3(p_0_in_0[1]),
        .I4(p_0_in_0[3]),
        .I5(\FSM_onehot_state[13]_i_4_n_0 ),
        .O(\FSM_onehot_state[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFFFFFFFFFF)) 
    \FSM_onehot_state[13]_i_4 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[9]),
        .I2(p_0_in_0[10]),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[8]),
        .I5(p_0_in_0[6]),
        .O(\FSM_onehot_state[13]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_state[15]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[19] ),
        .I1(\FSM_onehot_state[15]_i_2_n_0 ),
        .O(\FSM_onehot_state[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \FSM_onehot_state[15]_i_2 
       (.I0(p_0_in_0[12]),
        .I1(p_0_in_0[8]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[7]),
        .I4(p_0_in_0[5]),
        .I5(\FSM_onehot_state[15]_i_3_n_0 ),
        .O(\FSM_onehot_state[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFF)) 
    \FSM_onehot_state[15]_i_3 
       (.I0(\FSM_onehot_state[15]_i_4_n_0 ),
        .I1(p_0_in_0[1]),
        .I2(oled_pixel_index[3]),
        .I3(p_0_in_0[4]),
        .I4(oled_pixel_index[6]),
        .I5(\FSM_onehot_state[15]_i_7_n_0 ),
        .O(\FSM_onehot_state[15]_i_3_n_0 ));
  (* HLUTNM = "lutpair0" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_onehot_state[15]_i_4 
       (.I0(p_0_in_0[2]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[0]),
        .O(\FSM_onehot_state[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_state[15]_i_5 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[3]),
        .O(oled_pixel_index[3]));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_state[15]_i_6 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[6]),
        .O(oled_pixel_index[6]));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \FSM_onehot_state[15]_i_7 
       (.I0(p_0_in_0[10]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[9]),
        .I3(p_0_in_0[11]),
        .O(\FSM_onehot_state[15]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_onehot_state[31]_i_1 
       (.I0(\delay[0]_i_4_n_0 ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\FSM_onehot_state[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_state[31]_i_2 
       (.I0(\FSM_onehot_state[31]_i_3_n_0 ),
        .I1(delay_reg[17]),
        .I2(delay_reg[8]),
        .I3(delay_reg[14]),
        .I4(delay_reg[11]),
        .I5(\FSM_onehot_state[31]_i_4_n_0 ),
        .O(\delay[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_state[31]_i_3 
       (.I0(delay_reg[19]),
        .I1(delay_reg[4]),
        .I2(delay_reg[12]),
        .I3(delay_reg[0]),
        .O(\FSM_onehot_state[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_state[31]_i_4 
       (.I0(delay_reg[5]),
        .I1(delay_reg[6]),
        .I2(delay_reg[15]),
        .I3(delay_reg[16]),
        .I4(\FSM_onehot_state[31]_i_5_n_0 ),
        .I5(\FSM_onehot_state[31]_i_6_n_0 ),
        .O(\FSM_onehot_state[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_state[31]_i_5 
       (.I0(delay_reg[9]),
        .I1(delay_reg[1]),
        .I2(delay_reg[10]),
        .I3(delay_reg[13]),
        .O(\FSM_onehot_state[31]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_state[31]_i_6 
       (.I0(delay_reg[7]),
        .I1(delay_reg[2]),
        .I2(delay_reg[18]),
        .I3(delay_reg[3]),
        .O(\FSM_onehot_state[31]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hBA)) 
    \FSM_onehot_state[9]_i_1 
       (.I0(p_3_in),
        .I1(oled_frame_begin),
        .I2(p_4_in),
        .O(\FSM_onehot_state[9]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[29] ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[10] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[15] ),
        .Q(p_2_in),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[11] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[20] ),
        .Q(\FSM_onehot_state_reg_n_0_[11] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[12] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[11] ),
        .Q(\FSM_onehot_state_reg_n_0_[12] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[13] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[13]_i_1_n_0 ),
        .Q(JB_OBUF[3]),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[14] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[12] ),
        .Q(\FSM_onehot_state_reg_n_0_[14] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[15] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[15]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[15] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[16] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[24] ),
        .Q(\FSM_onehot_state_reg_n_0_[16] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[17] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[16] ),
        .Q(\FSM_onehot_state_reg_n_0_[17] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[18] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[17] ),
        .Q(\FSM_onehot_state_reg_n_0_[18] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[19] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[28] ),
        .Q(\FSM_onehot_state_reg_n_0_[19] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[1] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[0] ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[20] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[23] ),
        .Q(\FSM_onehot_state_reg_n_0_[20] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[21] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_state_reg_n_0_[21] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[22] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[21] ),
        .Q(\FSM_onehot_state_reg_n_0_[22] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDSE_1" *) 
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[23] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(1'b0),
        .Q(\FSM_onehot_state_reg_n_0_[23] ),
        .S(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[24] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[25] ),
        .Q(\FSM_onehot_state_reg_n_0_[24] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[25] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[30] ),
        .Q(\FSM_onehot_state_reg_n_0_[25] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[26] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[14] ),
        .Q(\FSM_onehot_state_reg_n_0_[26] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[27] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[26] ),
        .Q(\FSM_onehot_state_reg_n_0_[27] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[28] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_state_reg_n_0_[28] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[29] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[18] ),
        .Q(\FSM_onehot_state_reg_n_0_[29] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[2] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[30] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[22] ),
        .Q(\FSM_onehot_state_reg_n_0_[30] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[31] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[27] ),
        .Q(\FSM_onehot_state_reg_n_0_[31] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[3] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[2] ),
        .Q(\FSM_onehot_state_reg_n_0_[3] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[4] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[5] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_state_reg_n_0_[5] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[6] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_state_reg_n_0_[6] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[7] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[31] ),
        .Q(\FSM_onehot_state_reg_n_0_[7] ),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[8] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(p_2_in),
        .Q(p_3_in),
        .R(btnU_IBUF));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDRE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[9] 
       (.C(CLK),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[9]_i_1_n_0 ),
        .Q(p_4_in),
        .R(btnU_IBUF));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \JB_OBUF[0]_inst_i_1 
       (.I0(spi_word_bit_count_reg__0[3]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[5]),
        .I3(spi_word_bit_count_reg__0[2]),
        .I4(spi_word_bit_count_reg__0[0]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(JB_OBUF[0]));
  LUT5 #(
    .INIT(32'hAAAAAAA2)) 
    \JB_OBUF[1]_inst_i_1 
       (.I0(\spi_word_reg_n_0_[39] ),
        .I1(\JB_OBUF[3]_inst_i_2_n_0 ),
        .I2(spi_word_bit_count_reg__0[5]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[3]),
        .O(JB_OBUF[1]));
  LUT5 #(
    .INIT(32'hAAAAAAAE)) 
    \JB_OBUF[3]_inst_i_1 
       (.I0(clk_6p25MHz),
        .I1(\JB_OBUF[3]_inst_i_2_n_0 ),
        .I2(spi_word_bit_count_reg__0[5]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[3]),
        .O(JB_OBUF[2]));
  LUT3 #(
    .INIT(8'h01)) 
    \JB_OBUF[3]_inst_i_2 
       (.I0(spi_word_bit_count_reg__0[1]),
        .I1(spi_word_bit_count_reg__0[0]),
        .I2(spi_word_bit_count_reg__0[2]),
        .O(\JB_OBUF[3]_inst_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \JB_OBUF[5]_inst_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[20] ),
        .O(JB_OBUF[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFFFF)) 
    \JB_OBUF[6]_inst_i_1 
       (.I0(p_3_in),
        .I1(p_2_in),
        .I2(p_4_in),
        .I3(JB_OBUF[3]),
        .I4(\JB_OBUF[6]_inst_i_2_n_0 ),
        .I5(\FSM_onehot_state_reg_n_0_[19] ),
        .O(JB_OBUF[5]));
  LUT2 #(
    .INIT(4'h1)) 
    \JB_OBUF[6]_inst_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[28] ),
        .I1(\FSM_onehot_state_reg_n_0_[15] ),
        .O(\JB_OBUF[6]_inst_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \delay[0]_i_1 
       (.I0(spi_word_bit_count_reg__0[1]),
        .I1(spi_word_bit_count_reg__0[5]),
        .I2(spi_word_bit_count_reg__0[4]),
        .I3(spi_word_bit_count_reg__0[3]),
        .I4(spi_word_bit_count_reg__0[2]),
        .O(\delay[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFFFFFF8000)) 
    \delay[0]_i_10 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\delay[0]_i_4_n_0 ),
        .I5(delay_reg[1]),
        .O(\delay[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0F0F0F0F00FFDDFF)) 
    \delay[0]_i_11 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(delay_reg[0]),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\delay[0]_i_13_n_0 ),
        .I5(\delay[0]_i_4_n_0 ),
        .O(\delay[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0400000404000000)) 
    \delay[0]_i_12 
       (.I0(\delay[0]_i_4_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\spi_word[25]_i_2_n_0 ),
        .I5(\spi_word[22]_i_3_n_0 ),
        .O(\delay[0]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'h82)) 
    \delay[0]_i_13 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .O(\delay[0]_i_13_n_0 ));
  LUT3 #(
    .INIT(8'h1E)) 
    \delay[0]_i_8 
       (.I0(\delay[0]_i_12_n_0 ),
        .I1(delay_reg[3]),
        .I2(\delay[0]_i_4_n_0 ),
        .O(\delay[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFFFFFF8000)) 
    \delay[0]_i_9 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\delay[0]_i_4_n_0 ),
        .I5(delay_reg[2]),
        .O(\delay[0]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h42)) 
    \delay[12]_i_10 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .O(\delay[12]_i_10_n_0 ));
  LUT3 #(
    .INIT(8'h1E)) 
    \delay[12]_i_5 
       (.I0(\delay[4]_i_9_n_0 ),
        .I1(delay_reg[15]),
        .I2(\delay[0]_i_4_n_0 ),
        .O(\delay[12]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0FF2)) 
    \delay[12]_i_6 
       (.I0(\spi_word[14]_i_3_n_0 ),
        .I1(\delay[12]_i_9_n_0 ),
        .I2(delay_reg[14]),
        .I3(\delay[0]_i_4_n_0 ),
        .O(\delay[12]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h00FFFF80)) 
    \delay[12]_i_7 
       (.I0(\delay[12]_i_10_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .I3(delay_reg[13]),
        .I4(\delay[0]_i_4_n_0 ),
        .O(\delay[12]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[12]_i_8 
       (.I0(delay_reg[12]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[12]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hF0FFFF77)) 
    \delay[12]_i_9 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\spi_word[25]_i_2_n_0 ),
        .O(\delay[12]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h5500550055C05500)) 
    \delay[16]_i_3 
       (.I0(delay_reg[19]),
        .I1(\delay[16]_i_7_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\delay[0]_i_4_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .I5(\spi_word[14]_i_4_n_0 ),
        .O(\delay[16]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[16]_i_4 
       (.I0(delay_reg[18]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[16]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[16]_i_5 
       (.I0(delay_reg[17]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[16]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h1E)) 
    \delay[16]_i_6 
       (.I0(\delay[4]_i_9_n_0 ),
        .I1(delay_reg[16]),
        .I2(\delay[0]_i_4_n_0 ),
        .O(\delay[16]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \delay[16]_i_7 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .O(\delay[16]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[4]_i_5 
       (.I0(delay_reg[7]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[4]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h1E)) 
    \delay[4]_i_6 
       (.I0(\delay[4]_i_9_n_0 ),
        .I1(delay_reg[6]),
        .I2(\delay[0]_i_4_n_0 ),
        .O(\delay[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h55555555AEEEAAAA)) 
    \delay[4]_i_7 
       (.I0(\delay[0]_i_4_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .I3(\spi_word[39]_i_9_n_0 ),
        .I4(\delay[0]_i_13_n_0 ),
        .I5(delay_reg[5]),
        .O(\delay[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFFFFFF8000)) 
    \delay[4]_i_8 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\delay[0]_i_4_n_0 ),
        .I5(delay_reg[4]),
        .O(\delay[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000404000000)) 
    \delay[4]_i_9 
       (.I0(\delay[0]_i_4_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .I4(\spi_word[33]_i_3_n_0 ),
        .I5(\spi_word[22]_i_3_n_0 ),
        .O(\delay[4]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'h1E)) 
    \delay[8]_i_4 
       (.I0(\delay[0]_i_12_n_0 ),
        .I1(delay_reg[11]),
        .I2(\delay[0]_i_4_n_0 ),
        .O(\delay[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[8]_i_5 
       (.I0(delay_reg[10]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[8]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \delay[8]_i_6 
       (.I0(delay_reg[9]),
        .I1(\delay[0]_i_4_n_0 ),
        .O(\delay[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h55555555AEEEAAAA)) 
    \delay[8]_i_7 
       (.I0(\delay[0]_i_4_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .I3(\spi_word[39]_i_9_n_0 ),
        .I4(\delay[0]_i_13_n_0 ),
        .I5(delay_reg[8]),
        .O(\delay[8]_i_7_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[0] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_7 ),
        .Q(delay_reg[0]),
        .R(btnU_IBUF));
  CARRY4 \delay_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\delay_reg[0]_i_2_n_0 ,\NLW_delay_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 }),
        .O({\delay_reg[0]_i_2_n_4 ,\delay_reg[0]_i_2_n_5 ,\delay_reg[0]_i_2_n_6 ,\delay_reg[0]_i_2_n_7 }),
        .S({\delay[0]_i_8_n_0 ,\delay[0]_i_9_n_0 ,\delay[0]_i_10_n_0 ,\delay[0]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[10] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_5 ),
        .Q(delay_reg[10]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[11] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_4 ),
        .Q(delay_reg[11]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[12] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_7 ),
        .Q(delay_reg[12]),
        .R(btnU_IBUF));
  CARRY4 \delay_reg[12]_i_1 
       (.CI(\delay_reg[8]_i_1_n_0 ),
        .CO({\delay_reg[12]_i_1_n_0 ,\NLW_delay_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 ,delay_reg[12]}),
        .O({\delay_reg[12]_i_1_n_4 ,\delay_reg[12]_i_1_n_5 ,\delay_reg[12]_i_1_n_6 ,\delay_reg[12]_i_1_n_7 }),
        .S({\delay[12]_i_5_n_0 ,\delay[12]_i_6_n_0 ,\delay[12]_i_7_n_0 ,\delay[12]_i_8_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[13] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_6 ),
        .Q(delay_reg[13]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[14] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_5 ),
        .Q(delay_reg[14]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[15] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_4 ),
        .Q(delay_reg[15]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[16] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_7 ),
        .Q(delay_reg[16]),
        .R(btnU_IBUF));
  CARRY4 \delay_reg[16]_i_1 
       (.CI(\delay_reg[12]_i_1_n_0 ),
        .CO(\NLW_delay_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,delay_reg[18:17],\delay[0]_i_4_n_0 }),
        .O({\delay_reg[16]_i_1_n_4 ,\delay_reg[16]_i_1_n_5 ,\delay_reg[16]_i_1_n_6 ,\delay_reg[16]_i_1_n_7 }),
        .S({\delay[16]_i_3_n_0 ,\delay[16]_i_4_n_0 ,\delay[16]_i_5_n_0 ,\delay[16]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[17] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_6 ),
        .Q(delay_reg[17]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[18] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_5 ),
        .Q(delay_reg[18]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[19] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_4 ),
        .Q(delay_reg[19]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[1] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_6 ),
        .Q(delay_reg[1]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[2] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_5 ),
        .Q(delay_reg[2]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[3] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_4 ),
        .Q(delay_reg[3]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[4] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_7 ),
        .Q(delay_reg[4]),
        .R(btnU_IBUF));
  CARRY4 \delay_reg[4]_i_1 
       (.CI(\delay_reg[0]_i_2_n_0 ),
        .CO({\delay_reg[4]_i_1_n_0 ,\NLW_delay_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({delay_reg[7],\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 ,\delay[0]_i_4_n_0 }),
        .O({\delay_reg[4]_i_1_n_4 ,\delay_reg[4]_i_1_n_5 ,\delay_reg[4]_i_1_n_6 ,\delay_reg[4]_i_1_n_7 }),
        .S({\delay[4]_i_5_n_0 ,\delay[4]_i_6_n_0 ,\delay[4]_i_7_n_0 ,\delay[4]_i_8_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[5] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_6 ),
        .Q(delay_reg[5]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[6] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_5 ),
        .Q(delay_reg[6]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[7] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_4 ),
        .Q(delay_reg[7]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[8] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_7 ),
        .Q(delay_reg[8]),
        .R(btnU_IBUF));
  CARRY4 \delay_reg[8]_i_1 
       (.CI(\delay_reg[4]_i_1_n_0 ),
        .CO({\delay_reg[8]_i_1_n_0 ,\NLW_delay_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[0]_i_4_n_0 ,delay_reg[10:9],\delay[0]_i_4_n_0 }),
        .O({\delay_reg[8]_i_1_n_4 ,\delay_reg[8]_i_1_n_5 ,\delay_reg[8]_i_1_n_6 ,\delay_reg[8]_i_1_n_7 }),
        .S({\delay[8]_i_4_n_0 ,\delay[8]_i_5_n_0 ,\delay[8]_i_6_n_0 ,\delay[8]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[9] 
       (.C(clk_6p25MHz_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_6 ),
        .Q(delay_reg[9]),
        .R(btnU_IBUF));
  CARRY4 frame_counter1_carry
       (.CI(1'b0),
        .CO({frame_counter1_carry_n_0,NLW_frame_counter1_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(\frame_counter_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({p_0_in_0[0],\frame_counter_reg_n_0_[3] ,\frame_counter_reg_n_0_[2] ,\frame_counter_reg_n_0_[1] }));
  CARRY4 frame_counter1_carry__0
       (.CI(frame_counter1_carry_n_0),
        .CO({frame_counter1_carry__0_n_0,NLW_frame_counter1_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(p_0_in_0[4:1]));
  CARRY4 frame_counter1_carry__1
       (.CI(frame_counter1_carry__0_n_0),
        .CO({frame_counter1_carry__1_n_0,NLW_frame_counter1_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(p_0_in_0[8:5]));
  CARRY4 frame_counter1_carry__2
       (.CI(frame_counter1_carry__1_n_0),
        .CO(NLW_frame_counter1_carry__2_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(p_0_in_0[12:9]));
  LUT1 #(
    .INIT(2'h1)) 
    \frame_counter[0]_i_1 
       (.I0(\frame_counter_reg_n_0_[0] ),
        .O(\frame_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[10]_i_1 
       (.I0(data0[10]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[11]_i_1 
       (.I0(data0[11]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[12]_i_1 
       (.I0(data0[12]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[13]_i_1 
       (.I0(data0[13]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[14]_i_1 
       (.I0(data0[14]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[15]_i_1 
       (.I0(data0[15]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[16]_i_1 
       (.I0(data0[16]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \frame_counter[16]_i_2 
       (.I0(\frame_counter[16]_i_3_n_0 ),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[3]),
        .I3(p_0_in_0[5]),
        .I4(\frame_counter[16]_i_4_n_0 ),
        .I5(oled_frame_begin_BUFG_inst_i_4_n_0),
        .O(\frame_counter[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \frame_counter[16]_i_3 
       (.I0(\frame_counter_reg_n_0_[1] ),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[12]),
        .I3(\frame_counter_reg_n_0_[2] ),
        .I4(p_0_in_0[7]),
        .I5(p_0_in_0[1]),
        .O(\frame_counter[16]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \frame_counter[16]_i_4 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[8]),
        .I3(\frame_counter_reg_n_0_[0] ),
        .O(\frame_counter[16]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[1]_i_1 
       (.I0(data0[1]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[2]_i_1 
       (.I0(data0[2]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[3]_i_1 
       (.I0(data0[3]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[4]_i_1 
       (.I0(data0[4]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[5]_i_1 
       (.I0(data0[5]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[6]_i_1 
       (.I0(data0[6]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[7]_i_1 
       (.I0(data0[7]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[8]_i_1 
       (.I0(data0[8]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \frame_counter[9]_i_1 
       (.I0(data0[9]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .O(\frame_counter[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[0]_i_1_n_0 ),
        .Q(\frame_counter_reg_n_0_[0] ),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[10]_i_1_n_0 ),
        .Q(p_0_in_0[6]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[11]_i_1_n_0 ),
        .Q(p_0_in_0[7]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[12]_i_1_n_0 ),
        .Q(p_0_in_0[8]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[13]_i_1_n_0 ),
        .Q(p_0_in_0[9]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[14]_i_1_n_0 ),
        .Q(p_0_in_0[10]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[15] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[15]_i_1_n_0 ),
        .Q(p_0_in_0[11]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[16] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[16]_i_1_n_0 ),
        .Q(p_0_in_0[12]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[1]_i_1_n_0 ),
        .Q(\frame_counter_reg_n_0_[1] ),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[2]_i_1_n_0 ),
        .Q(\frame_counter_reg_n_0_[2] ),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[3]_i_1_n_0 ),
        .Q(\frame_counter_reg_n_0_[3] ),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[4]_i_1_n_0 ),
        .Q(p_0_in_0[0]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[5]_i_1_n_0 ),
        .Q(p_0_in_0[1]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[6]_i_1_n_0 ),
        .Q(p_0_in_0[2]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[7]_i_1_n_0 ),
        .Q(p_0_in_0[3]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[8]_i_1_n_0 ),
        .Q(p_0_in_0[4]),
        .R(btnU_IBUF));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(\frame_counter[9]_i_1_n_0 ),
        .Q(p_0_in_0[5]),
        .R(btnU_IBUF));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    oled_frame_begin_BUFG_inst_i_1
       (.I0(oled_frame_begin_BUFG_inst_i_2_n_0),
        .I1(p_0_in_0[1]),
        .I2(p_0_in_0[12]),
        .I3(p_0_in_0[11]),
        .I4(oled_frame_begin_BUFG_inst_i_3_n_0),
        .I5(oled_frame_begin_BUFG_inst_i_4_n_0),
        .O(oled_frame_begin));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    oled_frame_begin_BUFG_inst_i_2
       (.I0(\frame_counter_reg_n_0_[1] ),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[3]),
        .I3(p_0_in_0[5]),
        .I4(p_0_in_0[6]),
        .I5(p_0_in_0[8]),
        .O(oled_frame_begin_BUFG_inst_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    oled_frame_begin_BUFG_inst_i_3
       (.I0(\frame_counter_reg_n_0_[2] ),
        .I1(\frame_counter_reg_n_0_[0] ),
        .I2(p_0_in_0[7]),
        .I3(p_0_in_0[2]),
        .O(oled_frame_begin_BUFG_inst_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    oled_frame_begin_BUFG_inst_i_4
       (.I0(p_0_in_0[10]),
        .I1(p_0_in_0[9]),
        .I2(\frame_counter_reg_n_0_[3] ),
        .I3(p_0_in_0[0]),
        .O(oled_frame_begin_BUFG_inst_i_4_n_0));
  LUT3 #(
    .INIT(8'h08)) 
    \spi_word[0]_i_1 
       (.I0(\spi_word_bit_count[5]_i_2_n_0 ),
        .I1(\FSM_onehot_state[31]_i_1_n_0 ),
        .I2(btnU_IBUF),
        .O(\spi_word[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[10]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[9] ),
        .O(\spi_word[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[11]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[10] ),
        .O(\spi_word[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[12]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[11] ),
        .O(\spi_word[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[13]_i_1 
       (.I0(\spi_word_reg_n_0_[12] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[14]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[13] ),
        .O(\spi_word[14]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spi_word[14]_i_2 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \spi_word[14]_i_3 
       (.I0(\spi_word[14]_i_5_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .I5(\spi_word[14]_i_6_n_0 ),
        .O(\spi_word[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \spi_word[14]_i_4 
       (.I0(\spi_word[14]_i_7_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[14] ),
        .I2(\FSM_onehot_state_reg_n_0_[12] ),
        .I3(\JB_OBUF[6]_inst_i_2_n_0 ),
        .I4(\spi_word[14]_i_8_n_0 ),
        .I5(\FSM_onehot_state[15]_i_2_n_0 ),
        .O(\spi_word[14]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[14]_i_5 
       (.I0(\FSM_onehot_state_reg_n_0_[16] ),
        .I1(\FSM_onehot_state_reg_n_0_[17] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_state_reg_n_0_[7] ),
        .O(\spi_word[14]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[14]_i_6 
       (.I0(\FSM_onehot_state_reg_n_0_[24] ),
        .I1(\FSM_onehot_state_reg_n_0_[22] ),
        .I2(\FSM_onehot_state_reg_n_0_[18] ),
        .I3(\FSM_onehot_state_reg_n_0_[21] ),
        .I4(\spi_word[14]_i_9_n_0 ),
        .O(\spi_word[14]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[14]_i_7 
       (.I0(\spi_word[33]_i_8_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[24] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(p_2_in),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .O(\spi_word[14]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[14]_i_8 
       (.I0(\FSM_onehot_state_reg_n_0_[3] ),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_state_reg_n_0_[11] ),
        .I3(\FSM_onehot_state_reg_n_0_[20] ),
        .O(\spi_word[14]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[14]_i_9 
       (.I0(\FSM_onehot_state_reg_n_0_[25] ),
        .I1(\FSM_onehot_state_reg_n_0_[29] ),
        .I2(\FSM_onehot_state_reg_n_0_[30] ),
        .I3(\FSM_onehot_state_reg_n_0_[31] ),
        .O(\spi_word[14]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[15]_i_1 
       (.I0(\spi_word_reg_n_0_[14] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \spi_word[16]_i_1 
       (.I0(\spi_word[21]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[15] ),
        .O(\spi_word[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \spi_word[17]_i_1 
       (.I0(\spi_word[21]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[16] ),
        .O(\spi_word[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \spi_word[18]_i_1 
       (.I0(\spi_word[21]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[17] ),
        .O(\spi_word[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \spi_word[19]_i_1 
       (.I0(\spi_word[21]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[18] ),
        .O(\spi_word[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[1]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[0] ),
        .O(\spi_word[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \spi_word[20]_i_1 
       (.I0(\spi_word[21]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[19] ),
        .O(\spi_word[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hF444)) 
    \spi_word[21]_i_1 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word_reg_n_0_[20] ),
        .I2(\spi_word[21]_i_2_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00002000)) 
    \spi_word[21]_i_2 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\delay[0]_i_1_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[21]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h44444F44)) 
    \spi_word[22]_i_1 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word_reg_n_0_[21] ),
        .I2(\spi_word[22]_i_2_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFBF)) 
    \spi_word[22]_i_2 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .O(\spi_word[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_3 
       (.I0(\spi_word[22]_i_4_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[26] ),
        .I2(\FSM_onehot_state_reg_n_0_[28] ),
        .I3(\FSM_onehot_state_reg_n_0_[7] ),
        .I4(\spi_word[22]_i_5_n_0 ),
        .I5(\spi_word[22]_i_6_n_0 ),
        .O(\spi_word[22]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \spi_word[22]_i_4 
       (.I0(p_4_in),
        .I1(oled_frame_begin),
        .O(\spi_word[22]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_5 
       (.I0(\FSM_onehot_state_reg_n_0_[14] ),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_state_reg_n_0_[20] ),
        .I3(\FSM_onehot_state_reg_n_0_[29] ),
        .I4(\FSM_onehot_state_reg_n_0_[23] ),
        .I5(\spi_word[22]_i_7_n_0 ),
        .O(\spi_word[22]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_6 
       (.I0(\FSM_onehot_state_reg_n_0_[25] ),
        .I1(\FSM_onehot_state_reg_n_0_[24] ),
        .I2(\FSM_onehot_state_reg_n_0_[18] ),
        .I3(\FSM_onehot_state_reg_n_0_[21] ),
        .I4(p_3_in),
        .I5(p_2_in),
        .O(\spi_word[22]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[22]_i_7 
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .O(\spi_word[22]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[23]_i_1 
       (.I0(\spi_word_reg_n_0_[22] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBAAAAAAABABABABA)) 
    \spi_word[24]_i_1 
       (.I0(\spi_word[24]_i_2_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[24]_i_3_n_0 ),
        .I4(\spi_word[24]_i_4_n_0 ),
        .I5(\spi_word[33]_i_5_n_0 ),
        .O(\spi_word[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hDD00F0F00000F0F0)) 
    \spi_word[24]_i_2 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word_reg_n_0_[23] ),
        .I3(\spi_word[37]_i_5_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word[24]_i_3_n_0 ),
        .O(\spi_word[24]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[24]_i_3 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[24]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spi_word[24]_i_4 
       (.I0(\spi_word[14]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFF60FF60FF600000)) 
    \spi_word[25]_i_1 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[25]_i_3_n_0 ),
        .I3(\spi_word[25]_i_4_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word_reg_n_0_[24] ),
        .O(\spi_word[25]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spi_word[25]_i_2 
       (.I0(\FSM_onehot_state[15]_i_2_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .O(\spi_word[25]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h45)) 
    \spi_word[25]_i_3 
       (.I0(\spi_word[14]_i_3_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[25]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h14000000FFFFFFFF)) 
    \spi_word[25]_i_4 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[33]_i_3_n_0 ),
        .I5(\delay[0]_i_1_n_0 ),
        .O(\spi_word[25]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAAA3033AAAA)) 
    \spi_word[26]_i_1 
       (.I0(\spi_word_reg_n_0_[25] ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[26]_i_2_n_0 ),
        .I3(\spi_word[33]_i_5_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word[26]_i_3_n_0 ),
        .O(\spi_word[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h1540)) 
    \spi_word[26]_i_2 
       (.I0(\spi_word[14]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[22]_i_3_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[26]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h80A0)) 
    \spi_word[26]_i_3 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[37]_i_5_n_0 ),
        .I3(\spi_word[39]_i_5_n_0 ),
        .O(\spi_word[26]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAAA3033AAAA)) 
    \spi_word[27]_i_1 
       (.I0(\spi_word_reg_n_0_[26] ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[27]_i_2_n_0 ),
        .I3(\spi_word[33]_i_5_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word[27]_i_3_n_0 ),
        .O(\spi_word[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00A8)) 
    \spi_word[27]_i_2 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0F002700)) 
    \spi_word[27]_i_3 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[37]_i_5_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[27]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888A888A8A8A8A)) 
    \spi_word[28]_i_1 
       (.I0(\spi_word[28]_i_2_n_0 ),
        .I1(\spi_word[28]_i_3_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[39]_i_6_n_0 ),
        .I4(\spi_word[28]_i_4_n_0 ),
        .I5(\spi_word[33]_i_5_n_0 ),
        .O(\spi_word[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAAB)) 
    \spi_word[28]_i_2 
       (.I0(\spi_word_reg_n_0_[27] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h555D5D555DD5DD55)) 
    \spi_word[28]_i_3 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .I5(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[28]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \spi_word[28]_i_4 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[28]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hE0E0E0EE)) 
    \spi_word[29]_i_1 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word_reg_n_0_[28] ),
        .I2(\spi_word[29]_i_2_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\spi_word[39]_i_8_n_0 ),
        .O(\spi_word[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5F5F5F555FD55D55)) 
    \spi_word[29]_i_2 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .I5(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[2]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[1] ),
        .O(\spi_word[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEEE0EEE0EEE0EEEE)) 
    \spi_word[30]_i_1 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word_reg_n_0_[29] ),
        .I2(\spi_word[30]_i_2_n_0 ),
        .I3(\spi_word[30]_i_3_n_0 ),
        .I4(\spi_word[35]_i_7_n_0 ),
        .I5(\spi_word[30]_i_4_n_0 ),
        .O(\spi_word[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h40FF)) 
    \spi_word[30]_i_2 
       (.I0(\spi_word[38]_i_4_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[37]_i_5_n_0 ),
        .I3(\delay[0]_i_1_n_0 ),
        .O(\spi_word[30]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[30]_i_3 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[39]_i_7_n_0 ),
        .O(\spi_word[30]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFDF0FD)) 
    \spi_word[30]_i_4 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .I4(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[30]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[31]_i_1 
       (.I0(\spi_word[31]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word_reg_n_0_[30] ),
        .O(\spi_word[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00005001)) 
    \spi_word[31]_i_2 
       (.I0(\spi_word[14]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[33]_i_3_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF2F220000)) 
    \spi_word[32]_i_1 
       (.I0(\spi_word[37]_i_4_n_0 ),
        .I1(\spi_word[32]_i_2_n_0 ),
        .I2(\spi_word[32]_i_3_n_0 ),
        .I3(\spi_word[37]_i_2_n_0 ),
        .I4(\spi_word[38]_i_7_n_0 ),
        .I5(\spi_word[32]_i_4_n_0 ),
        .O(\spi_word[32]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h07)) 
    \spi_word[32]_i_2 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[32]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \spi_word[32]_i_3 
       (.I0(\spi_word_bit_count[3]_i_2_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[24]_i_3_n_0 ),
        .O(\spi_word[32]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7700F0F02200F0F0)) 
    \spi_word[32]_i_4 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word_reg_n_0_[31] ),
        .I3(\spi_word[37]_i_5_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word[39]_i_5_n_0 ),
        .O(\spi_word[32]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hE0EEE0E0E0EEE0EE)) 
    \spi_word[33]_i_1 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word_reg_n_0_[32] ),
        .I2(\spi_word[33]_i_2_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\spi_word[33]_i_4_n_0 ),
        .I5(\spi_word[33]_i_5_n_0 ),
        .O(\spi_word[33]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h333373333F337333)) 
    \spi_word[33]_i_2 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\spi_word[25]_i_2_n_0 ),
        .I5(\spi_word[38]_i_4_n_0 ),
        .O(\spi_word[33]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \spi_word[33]_i_3 
       (.I0(\spi_word[33]_i_6_n_0 ),
        .I1(\spi_word[33]_i_7_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[24] ),
        .I3(\FSM_onehot_state_reg_n_0_[25] ),
        .I4(\FSM_onehot_state_reg_n_0_[30] ),
        .I5(\spi_word[33]_i_8_n_0 ),
        .O(\spi_word[33]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0C4E)) 
    \spi_word[33]_i_4 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[33]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBFFFFFFFFF)) 
    \spi_word[33]_i_5 
       (.I0(\spi_word[39]_i_9_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[39]_i_10_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .I5(\spi_word[35]_i_8_n_0 ),
        .O(\spi_word[33]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \spi_word[33]_i_6 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_state_reg_n_0_[29] ),
        .I4(\FSM_onehot_state_reg_n_0_[28] ),
        .I5(\FSM_onehot_state_reg_n_0_[15] ),
        .O(\spi_word[33]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[33]_i_7 
       (.I0(JB_OBUF[3]),
        .I1(p_4_in),
        .I2(p_2_in),
        .I3(p_3_in),
        .O(\spi_word[33]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[33]_i_8 
       (.I0(\FSM_onehot_state_reg_n_0_[16] ),
        .I1(\FSM_onehot_state_reg_n_0_[17] ),
        .I2(\FSM_onehot_state_reg_n_0_[19] ),
        .I3(\FSM_onehot_state_reg_n_0_[18] ),
        .O(\spi_word[33]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBBABBBABABABA)) 
    \spi_word[34]_i_1 
       (.I0(\spi_word[34]_i_2_n_0 ),
        .I1(\spi_word[34]_i_3_n_0 ),
        .I2(\spi_word[35]_i_4_n_0 ),
        .I3(\spi_word[39]_i_6_n_0 ),
        .I4(\spi_word[34]_i_4_n_0 ),
        .I5(\spi_word[37]_i_2_n_0 ),
        .O(\spi_word[34]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[34]_i_2 
       (.I0(\spi_word_reg_n_0_[33] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[34]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hE0FF)) 
    \spi_word[34]_i_3 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[24]_i_3_n_0 ),
        .I2(\spi_word[37]_i_5_n_0 ),
        .I3(\delay[0]_i_1_n_0 ),
        .O(\spi_word[34]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h70)) 
    \spi_word[34]_i_4 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[34]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hBABBBABABABBBABB)) 
    \spi_word[35]_i_1 
       (.I0(\spi_word[35]_i_2_n_0 ),
        .I1(\spi_word[35]_i_3_n_0 ),
        .I2(\spi_word[35]_i_4_n_0 ),
        .I3(\spi_word[35]_i_5_n_0 ),
        .I4(\spi_word[35]_i_6_n_0 ),
        .I5(\spi_word[35]_i_7_n_0 ),
        .O(\spi_word[35]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8AAA)) 
    \spi_word[35]_i_10 
       (.I0(\spi_word_reg[35]_i_14_n_3 ),
        .I1(\spi_word_reg[35]_i_15_n_3 ),
        .I2(\spi_word_reg[35]_i_11_n_7 ),
        .I3(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[35]_i_10_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \spi_word[35]_i_100 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[35]_i_100_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \spi_word[35]_i_101 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[0]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[35]_i_101_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_102 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[1]),
        .O(\spi_word[35]_i_102_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_16 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[6]),
        .O(\spi_word[35]_i_16_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_17 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[5]),
        .O(oled_pixel_index[5]));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_18 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[4]),
        .O(\spi_word[35]_i_18_n_0 ));
  LUT3 #(
    .INIT(8'h95)) 
    \spi_word[35]_i_19 
       (.I0(\frame_counter_reg[12]_0 [2]),
        .I1(p_0_in_0[7]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[35]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[35]_i_2 
       (.I0(\spi_word_reg_n_0_[34] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[35]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h87)) 
    \spi_word[35]_i_20 
       (.I0(p_0_in_0[6]),
        .I1(JB_OBUF[3]),
        .I2(\frame_counter_reg[12]_0 [1]),
        .O(\spi_word[35]_i_20_n_0 ));
  LUT3 #(
    .INIT(8'h87)) 
    \spi_word[35]_i_21 
       (.I0(p_0_in_0[5]),
        .I1(JB_OBUF[3]),
        .I2(\frame_counter_reg[12]_0 [0]),
        .O(\spi_word[35]_i_21_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \spi_word[35]_i_22 
       (.I0(p_0_in_0[4]),
        .I1(JB_OBUF[3]),
        .O(\spi_word[35]_i_22_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_23 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[3]),
        .O(\spi_word[35]_i_23_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_24 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[2]),
        .O(\spi_word[35]_i_24_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_25 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[1]),
        .O(\spi_word[35]_i_25_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_26 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[0]),
        .O(oled_pixel_index[0]));
  LUT2 #(
    .INIT(4'h7)) 
    \spi_word[35]_i_27 
       (.I0(p_0_in_0[3]),
        .I1(JB_OBUF[3]),
        .O(\spi_word[35]_i_27_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \spi_word[35]_i_28 
       (.I0(p_0_in_0[2]),
        .I1(JB_OBUF[3]),
        .O(\spi_word[35]_i_28_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \spi_word[35]_i_29 
       (.I0(p_0_in_0[1]),
        .I1(JB_OBUF[3]),
        .O(\spi_word[35]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hDD0D0000FFFFFFFF)) 
    \spi_word[35]_i_3 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[22]_i_3_n_0 ),
        .I3(\spi_word[39]_i_5_n_0 ),
        .I4(\spi_word[37]_i_5_n_0 ),
        .I5(\delay[0]_i_1_n_0 ),
        .O(\spi_word[35]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \spi_word[35]_i_30 
       (.I0(p_0_in_0[0]),
        .I1(JB_OBUF[3]),
        .O(\spi_word[35]_i_30_n_0 ));
  LUT5 #(
    .INIT(32'h00001444)) 
    \spi_word[35]_i_31 
       (.I0(Q[7]),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word[35]_i_44_n_0 ),
        .I4(Q[6]),
        .O(\spi_word[35]_i_31_n_0 ));
  LUT5 #(
    .INIT(32'h15403D54)) 
    \spi_word[35]_i_32 
       (.I0(Q[5]),
        .I1(\spi_word[35]_i_45_n_0 ),
        .I2(\spi_word_reg[39]_i_27_n_7 ),
        .I3(\spi_word_reg[39]_i_27_n_6 ),
        .I4(Q[4]),
        .O(\spi_word[35]_i_32_n_0 ));
  LUT4 #(
    .INIT(16'h1171)) 
    \spi_word[35]_i_33 
       (.I0(\spi_word[35]_i_46_n_0 ),
        .I1(Q[3]),
        .I2(\spi_word[35]_i_47_n_0 ),
        .I3(Q[2]),
        .O(\spi_word[35]_i_33_n_0 ));
  LUT4 #(
    .INIT(16'h4F04)) 
    \spi_word[35]_i_34 
       (.I0(Q[0]),
        .I1(\spi_word[35]_i_48_n_0 ),
        .I2(Q[1]),
        .I3(\spi_word[35]_i_49_n_0 ),
        .O(\spi_word[35]_i_34_n_0 ));
  LUT5 #(
    .INIT(32'h00006A95)) 
    \spi_word[35]_i_35 
       (.I0(Q[6]),
        .I1(\spi_word[35]_i_44_n_0 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word_reg[39]_i_27_n_1 ),
        .I4(Q[7]),
        .O(\spi_word[35]_i_35_n_0 ));
  LUT5 #(
    .INIT(32'h09906009)) 
    \spi_word[35]_i_36 
       (.I0(\spi_word_reg[39]_i_27_n_6 ),
        .I1(Q[5]),
        .I2(\spi_word_reg[39]_i_27_n_7 ),
        .I3(\spi_word[35]_i_45_n_0 ),
        .I4(Q[4]),
        .O(\spi_word[35]_i_36_n_0 ));
  LUT4 #(
    .INIT(16'h0990)) 
    \spi_word[35]_i_37 
       (.I0(\spi_word[35]_i_47_n_0 ),
        .I1(Q[2]),
        .I2(\spi_word[35]_i_46_n_0 ),
        .I3(Q[3]),
        .O(\spi_word[35]_i_37_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \spi_word[35]_i_38 
       (.I0(\spi_word[35]_i_49_n_0 ),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(\spi_word[35]_i_48_n_0 ),
        .O(\spi_word[35]_i_38_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \spi_word[35]_i_4 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[38]_i_4_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[35]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \spi_word[35]_i_44 
       (.I0(\spi_word_reg[39]_i_22_n_4 ),
        .I1(\spi_word_reg[39]_i_22_n_6 ),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(\spi_word_reg[39]_i_22_n_5 ),
        .I4(\spi_word[39]_i_29_n_0 ),
        .I5(\spi_word_reg[39]_i_27_n_7 ),
        .O(\spi_word[35]_i_44_n_0 ));
  LUT5 #(
    .INIT(32'h40000000)) 
    \spi_word[35]_i_45 
       (.I0(\spi_word[39]_i_29_n_0 ),
        .I1(\spi_word_reg[39]_i_22_n_5 ),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(\spi_word_reg[39]_i_22_n_6 ),
        .I4(\spi_word_reg[39]_i_22_n_4 ),
        .O(\spi_word[35]_i_45_n_0 ));
  LUT5 #(
    .INIT(32'h63333333)) 
    \spi_word[35]_i_46 
       (.I0(\spi_word[39]_i_29_n_0 ),
        .I1(\spi_word_reg[39]_i_22_n_4 ),
        .I2(\spi_word_reg[39]_i_22_n_6 ),
        .I3(\spi_word_reg[39]_i_22_n_7 ),
        .I4(\spi_word_reg[39]_i_22_n_5 ),
        .O(\spi_word[35]_i_46_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA66A6AAAA)) 
    \spi_word[35]_i_47 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_22_n_6 ),
        .I2(\spi_word_reg[39]_i_51_n_4 ),
        .I3(oled_pixel_index[12]),
        .I4(\spi_word_reg[39]_i_22_n_7 ),
        .I5(\spi_word_reg[39]_i_24_n_0 ),
        .O(\spi_word[35]_i_47_n_0 ));
  LUT5 #(
    .INIT(32'hFF70008F)) 
    \spi_word[35]_i_48 
       (.I0(p_0_in_0[12]),
        .I1(JB_OBUF[3]),
        .I2(\spi_word_reg[39]_i_51_n_4 ),
        .I3(\spi_word_reg[39]_i_24_n_0 ),
        .I4(\spi_word_reg[39]_i_22_n_7 ),
        .O(\spi_word[35]_i_48_n_0 ));
  LUT6 #(
    .INIT(64'h9AAAAAAA9A9A9A9A)) 
    \spi_word[35]_i_49 
       (.I0(\spi_word_reg[39]_i_22_n_6 ),
        .I1(\spi_word_reg[39]_i_24_n_0 ),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(p_0_in_0[12]),
        .I4(JB_OBUF[3]),
        .I5(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[35]_i_49_n_0 ));
  LUT4 #(
    .INIT(16'hBABB)) 
    \spi_word[35]_i_5 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[35]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h956A)) 
    \spi_word[35]_i_51 
       (.I0(Q[6]),
        .I1(\spi_word[35]_i_44_n_0 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word_reg[39]_i_27_n_1 ),
        .O(\spi_word[35]_i_51_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \spi_word[35]_i_52 
       (.I0(Q[5]),
        .I1(\spi_word[35]_i_44_n_0 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .O(\spi_word[35]_i_52_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[35]_i_53 
       (.I0(Q[4]),
        .I1(\spi_word[35]_i_76_n_0 ),
        .O(\spi_word[35]_i_53_n_0 ));
  LUT5 #(
    .INIT(32'h82227DDD)) 
    \spi_word[35]_i_54 
       (.I0(Q[6]),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word[35]_i_44_n_0 ),
        .I4(Q[7]),
        .O(\spi_word[35]_i_54_n_0 ));
  LUT5 #(
    .INIT(32'h9CC66339)) 
    \spi_word[35]_i_55 
       (.I0(Q[5]),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word[35]_i_44_n_0 ),
        .I4(Q[6]),
        .O(\spi_word[35]_i_55_n_0 ));
  LUT5 #(
    .INIT(32'h9CC66339)) 
    \spi_word[35]_i_56 
       (.I0(Q[4]),
        .I1(\spi_word_reg[39]_i_27_n_6 ),
        .I2(\spi_word_reg[39]_i_27_n_7 ),
        .I3(\spi_word[35]_i_45_n_0 ),
        .I4(Q[5]),
        .O(\spi_word[35]_i_56_n_0 ));
  LUT4 #(
    .INIT(16'h6999)) 
    \spi_word[35]_i_57 
       (.I0(Q[4]),
        .I1(\spi_word[35]_i_76_n_0 ),
        .I2(Q[3]),
        .I3(\spi_word[35]_i_46_n_0 ),
        .O(\spi_word[35]_i_57_n_0 ));
  LUT4 #(
    .INIT(16'h956A)) 
    \spi_word[35]_i_59 
       (.I0(Q[6]),
        .I1(\spi_word[35]_i_44_n_0 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word_reg[39]_i_27_n_1 ),
        .O(\spi_word[35]_i_59_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \spi_word[35]_i_6 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[35]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[35]_i_60 
       (.I0(Q[4]),
        .I1(\spi_word[35]_i_76_n_0 ),
        .O(\spi_word[35]_i_60_n_0 ));
  LUT5 #(
    .INIT(32'h82227DDD)) 
    \spi_word[35]_i_61 
       (.I0(Q[6]),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word[35]_i_44_n_0 ),
        .I4(Q[7]),
        .O(\spi_word[35]_i_61_n_0 ));
  LUT5 #(
    .INIT(32'h9CC66339)) 
    \spi_word[35]_i_62 
       (.I0(Q[5]),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .I2(\spi_word_reg[39]_i_27_n_6 ),
        .I3(\spi_word[35]_i_44_n_0 ),
        .I4(Q[6]),
        .O(\spi_word[35]_i_62_n_0 ));
  LUT5 #(
    .INIT(32'h9CC66339)) 
    \spi_word[35]_i_63 
       (.I0(Q[4]),
        .I1(\spi_word_reg[39]_i_27_n_6 ),
        .I2(\spi_word_reg[39]_i_27_n_7 ),
        .I3(\spi_word[35]_i_45_n_0 ),
        .I4(Q[5]),
        .O(\spi_word[35]_i_63_n_0 ));
  LUT4 #(
    .INIT(16'h6669)) 
    \spi_word[35]_i_64 
       (.I0(Q[4]),
        .I1(\spi_word[35]_i_76_n_0 ),
        .I2(\spi_word[35]_i_46_n_0 ),
        .I3(Q[3]),
        .O(\spi_word[35]_i_64_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[35]_i_68 
       (.I0(Q[3]),
        .I1(\spi_word[35]_i_46_n_0 ),
        .O(\spi_word[35]_i_68_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF2F00D0)) 
    \spi_word[35]_i_69 
       (.I0(\spi_word_reg[39]_i_51_n_4 ),
        .I1(oled_pixel_index[12]),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(\spi_word_reg[39]_i_24_n_0 ),
        .I4(\spi_word_reg[39]_i_22_n_6 ),
        .I5(Q[1]),
        .O(\spi_word[35]_i_69_n_0 ));
  LUT6 #(
    .INIT(64'hF0D0F0D0F0D0F0F0)) 
    \spi_word[35]_i_7 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .I4(\spi_word[39]_i_10_n_0 ),
        .I5(\spi_word[35]_i_8_n_0 ),
        .O(\spi_word[35]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h99A9A9A9FFFFFFFF)) 
    \spi_word[35]_i_70 
       (.I0(\spi_word_reg[39]_i_22_n_7 ),
        .I1(\spi_word_reg[39]_i_24_n_0 ),
        .I2(\spi_word_reg[39]_i_51_n_4 ),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[12]),
        .I5(Q[0]),
        .O(\spi_word[35]_i_70_n_0 ));
  LUT6 #(
    .INIT(64'h6656565699A9A9A9)) 
    \spi_word[35]_i_71 
       (.I0(\spi_word_reg[39]_i_22_n_7 ),
        .I1(\spi_word_reg[39]_i_24_n_0 ),
        .I2(\spi_word_reg[39]_i_51_n_4 ),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[12]),
        .I5(Q[0]),
        .O(\spi_word[35]_i_71_n_0 ));
  LUT4 #(
    .INIT(16'h2DD2)) 
    \spi_word[35]_i_72 
       (.I0(Q[2]),
        .I1(\spi_word[35]_i_47_n_0 ),
        .I2(\spi_word[35]_i_46_n_0 ),
        .I3(Q[3]),
        .O(\spi_word[35]_i_72_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \spi_word[35]_i_73 
       (.I0(\spi_word[35]_i_47_n_0 ),
        .I1(Q[2]),
        .I2(\spi_word[35]_i_69_n_0 ),
        .O(\spi_word[35]_i_73_n_0 ));
  LUT4 #(
    .INIT(16'h2DD2)) 
    \spi_word[35]_i_74 
       (.I0(Q[0]),
        .I1(\spi_word[35]_i_48_n_0 ),
        .I2(Q[1]),
        .I3(\spi_word[35]_i_49_n_0 ),
        .O(\spi_word[35]_i_74_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA6A55555595AA)) 
    \spi_word[35]_i_75 
       (.I0(Q[0]),
        .I1(p_0_in_0[12]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word_reg[39]_i_51_n_4 ),
        .I4(\spi_word_reg[39]_i_24_n_0 ),
        .I5(\spi_word_reg[39]_i_22_n_7 ),
        .O(\spi_word[35]_i_75_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA6AAAAAAA)) 
    \spi_word[35]_i_76 
       (.I0(\spi_word_reg[39]_i_27_n_7 ),
        .I1(\spi_word_reg[39]_i_22_n_4 ),
        .I2(\spi_word_reg[39]_i_22_n_6 ),
        .I3(\spi_word_reg[39]_i_22_n_7 ),
        .I4(\spi_word_reg[39]_i_22_n_5 ),
        .I5(\spi_word[39]_i_29_n_0 ),
        .O(\spi_word[35]_i_76_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \spi_word[35]_i_78 
       (.I0(Q[2]),
        .I1(\spi_word[35]_i_46_n_0 ),
        .I2(Q[3]),
        .O(\spi_word[35]_i_78_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[35]_i_79 
       (.I0(Q[2]),
        .I1(\spi_word[35]_i_47_n_0 ),
        .O(\spi_word[35]_i_79_n_0 ));
  LUT5 #(
    .INIT(32'h00020020)) 
    \spi_word[35]_i_8 
       (.I0(\spi_word[35]_i_9_n_0 ),
        .I1(\spi_word[35]_i_10_n_0 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_5 ),
        .I4(\spi_word_reg[35]_i_11_n_4 ),
        .O(\spi_word[35]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFF2F00D000D0FF2F)) 
    \spi_word[35]_i_80 
       (.I0(\spi_word_reg[39]_i_51_n_4 ),
        .I1(oled_pixel_index[12]),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(\spi_word_reg[39]_i_24_n_0 ),
        .I4(\spi_word_reg[39]_i_22_n_6 ),
        .I5(Q[1]),
        .O(\spi_word[35]_i_80_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA6A55555595AA)) 
    \spi_word[35]_i_81 
       (.I0(Q[0]),
        .I1(p_0_in_0[12]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word_reg[39]_i_51_n_4 ),
        .I4(\spi_word_reg[39]_i_24_n_0 ),
        .I5(\spi_word_reg[39]_i_22_n_7 ),
        .O(\spi_word[35]_i_81_n_0 ));
  LUT6 #(
    .INIT(64'hA7700000588FFFFF)) 
    \spi_word[35]_i_83 
       (.I0(\spi_word[39]_i_88_n_0 ),
        .I1(p_0_in_0[7]),
        .I2(p_0_in_0[9]),
        .I3(p_0_in_0[11]),
        .I4(JB_OBUF[3]),
        .I5(\spi_word[39]_i_89_n_0 ),
        .O(\spi_word[35]_i_83_n_0 ));
  LUT6 #(
    .INIT(64'h9996666696666666)) 
    \spi_word[35]_i_84 
       (.I0(\spi_word[39]_i_45_n_0 ),
        .I1(\spi_word[39]_i_88_n_0 ),
        .I2(p_0_in_0[7]),
        .I3(p_0_in_0[9]),
        .I4(JB_OBUF[3]),
        .I5(p_0_in_0[11]),
        .O(\spi_word[35]_i_84_n_0 ));
  LUT6 #(
    .INIT(64'h6969699969999999)) 
    \spi_word[35]_i_85 
       (.I0(\spi_word[39]_i_46_n_0 ),
        .I1(\spi_word[39]_i_86_n_0 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[10]),
        .I4(p_0_in_0[6]),
        .I5(p_0_in_0[8]),
        .O(\spi_word[35]_i_85_n_0 ));
  LUT5 #(
    .INIT(32'h6A95956A)) 
    \spi_word[35]_i_87 
       (.I0(\spi_word[39]_i_78_n_0 ),
        .I1(p_0_in_0[12]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_135_n_0 ),
        .I4(\spi_word[39]_i_87_n_0 ),
        .O(\spi_word[35]_i_87_n_0 ));
  LUT5 #(
    .INIT(32'h956A6A95)) 
    \spi_word[35]_i_88 
       (.I0(\spi_word[39]_i_79_n_0 ),
        .I1(p_0_in_0[11]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_132_n_0 ),
        .I4(\spi_word[39]_i_136_n_0 ),
        .O(\spi_word[35]_i_88_n_0 ));
  LUT5 #(
    .INIT(32'h69969696)) 
    \spi_word[35]_i_89 
       (.I0(\spi_word[39]_i_80_n_0 ),
        .I1(\spi_word[39]_i_137_n_0 ),
        .I2(\spi_word[39]_i_133_n_0 ),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[10]),
        .O(\spi_word[35]_i_89_n_0 ));
  LUT6 #(
    .INIT(64'h000FE00000000000)) 
    \spi_word[35]_i_9 
       (.I0(\spi_word_reg[35]_i_12_n_6 ),
        .I1(\spi_word_reg[35]_i_12_n_7 ),
        .I2(\spi_word_reg[35]_i_12_n_4 ),
        .I3(\spi_word_reg[35]_i_12_n_5 ),
        .I4(\spi_word_reg[35]_i_11_n_7 ),
        .I5(oled_data42_in),
        .O(\spi_word[35]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h6A95956A)) 
    \spi_word[35]_i_90 
       (.I0(\spi_word[39]_i_81_n_0 ),
        .I1(p_0_in_0[9]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_138_n_0 ),
        .I4(\spi_word[39]_i_134_n_0 ),
        .O(\spi_word[35]_i_90_n_0 ));
  LUT5 #(
    .INIT(32'h956A6A95)) 
    \spi_word[35]_i_92 
       (.I0(\spi_word[39]_i_125_n_0 ),
        .I1(p_0_in_0[8]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_160_n_0 ),
        .I4(\spi_word[39]_i_127_n_0 ),
        .O(\spi_word[35]_i_92_n_0 ));
  LUT6 #(
    .INIT(64'h6996AAAAAAAAAAAA)) 
    \spi_word[35]_i_93 
       (.I0(\spi_word[39]_i_126_n_0 ),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[4]),
        .I4(JB_OBUF[3]),
        .I5(p_0_in_0[6]),
        .O(\spi_word[35]_i_93_n_0 ));
  LUT6 #(
    .INIT(64'hD77D7DD728828228)) 
    \spi_word[35]_i_94 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[0]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(\spi_word[39]_i_127_n_0 ),
        .O(\spi_word[35]_i_94_n_0 ));
  LUT5 #(
    .INIT(32'h6F9F9060)) 
    \spi_word[35]_i_95 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[5]),
        .I4(\FSM_onehot_state[15]_i_4_n_0 ),
        .O(\spi_word[35]_i_95_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_96 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[4]),
        .O(\spi_word[35]_i_96_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_97 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[3]),
        .O(\spi_word[35]_i_97_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[35]_i_98 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[2]),
        .O(\spi_word[35]_i_98_n_0 ));
  LUT4 #(
    .INIT(16'h9600)) 
    \spi_word[35]_i_99 
       (.I0(p_0_in_0[0]),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[4]),
        .I3(JB_OBUF[3]),
        .O(\spi_word[35]_i_99_n_0 ));
  LUT6 #(
    .INIT(64'h20202022AAAAAAAA)) 
    \spi_word[36]_i_1 
       (.I0(\spi_word[36]_i_2_n_0 ),
        .I1(\spi_word[37]_i_5_n_0 ),
        .I2(\spi_word[36]_i_3_n_0 ),
        .I3(\spi_word[38]_i_5_n_0 ),
        .I4(\spi_word[38]_i_6_n_0 ),
        .I5(\spi_word[36]_i_4_n_0 ),
        .O(\spi_word[36]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAAB)) 
    \spi_word[36]_i_2 
       (.I0(\spi_word_reg_n_0_[35] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[36]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h80B08080)) 
    \spi_word[36]_i_3 
       (.I0(\spi_word[38]_i_4_n_0 ),
        .I1(\spi_word[33]_i_3_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[36]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAAA08AA)) 
    \spi_word[36]_i_4 
       (.I0(\delay[0]_i_1_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[39]_i_5_n_0 ),
        .I3(\spi_word[37]_i_5_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[36]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F200)) 
    \spi_word[37]_i_1 
       (.I0(\spi_word[37]_i_2_n_0 ),
        .I1(\spi_word[37]_i_3_n_0 ),
        .I2(\spi_word[37]_i_4_n_0 ),
        .I3(\delay[0]_i_1_n_0 ),
        .I4(\spi_word[37]_i_5_n_0 ),
        .I5(\spi_word[37]_i_6_n_0 ),
        .O(\spi_word[37]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h110154545F5F5F5F)) 
    \spi_word[37]_i_2 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[37]_i_7_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[37]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF000F0FFF077F077)) 
    \spi_word[37]_i_3 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[25]_i_2_n_0 ),
        .I5(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[37]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hD0)) 
    \spi_word[37]_i_4 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[38]_i_4_n_0 ),
        .I2(\spi_word[39]_i_5_n_0 ),
        .O(\spi_word[37]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \spi_word[37]_i_5 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[37]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hDDF000F0)) 
    \spi_word[37]_i_6 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word_reg_n_0_[36] ),
        .I3(\delay[0]_i_1_n_0 ),
        .I4(\spi_word[37]_i_5_n_0 ),
        .O(\spi_word[37]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF01000101)) 
    \spi_word[37]_i_7 
       (.I0(\spi_word[39]_i_19_n_0 ),
        .I1(\spi_word[39]_i_18_n_0 ),
        .I2(\spi_word[39]_i_17_n_0 ),
        .I3(\spi_word[39]_i_16_n_0 ),
        .I4(\spi_word[37]_i_8_n_0 ),
        .I5(\spi_word[35]_i_8_n_0 ),
        .O(\spi_word[37]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hDFFDFDDFDFDFFDFD)) 
    \spi_word[37]_i_8 
       (.I0(oled_data66_in),
        .I1(\spi_word_reg[39]_i_20_n_3 ),
        .I2(\spi_word[37]_i_9_n_0 ),
        .I3(\spi_word[39]_i_29_n_0 ),
        .I4(\spi_word_reg[39]_i_22_n_4 ),
        .I5(\spi_word[39]_i_28_n_0 ),
        .O(\spi_word[37]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h1951115519511951)) 
    \spi_word[37]_i_9 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_22_n_6 ),
        .I2(\spi_word_reg[39]_i_24_n_0 ),
        .I3(\spi_word_reg[39]_i_22_n_7 ),
        .I4(oled_pixel_index[12]),
        .I5(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[37]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hEAEAEAEFAAAAAAAA)) 
    \spi_word[38]_i_1 
       (.I0(\spi_word[38]_i_2_n_0 ),
        .I1(\spi_word[38]_i_3_n_0 ),
        .I2(\spi_word[38]_i_4_n_0 ),
        .I3(\spi_word[38]_i_5_n_0 ),
        .I4(\spi_word[38]_i_6_n_0 ),
        .I5(\spi_word[38]_i_7_n_0 ),
        .O(\spi_word[38]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[38]_i_2 
       (.I0(\spi_word_reg_n_0_[37] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[38]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[38]_i_3 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .O(\spi_word[38]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spi_word[38]_i_4 
       (.I0(\spi_word[22]_i_3_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word[38]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \spi_word[38]_i_5 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[39]_i_10_n_0 ),
        .O(\spi_word[38]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \spi_word[38]_i_6 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[38]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \spi_word[38]_i_7 
       (.I0(spi_word_bit_count_reg__0[2]),
        .I1(spi_word_bit_count_reg__0[3]),
        .I2(spi_word_bit_count_reg__0[4]),
        .I3(spi_word_bit_count_reg__0[5]),
        .I4(spi_word_bit_count_reg__0[1]),
        .I5(\spi_word[37]_i_5_n_0 ),
        .O(\spi_word[38]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hEA)) 
    \spi_word[39]_i_1 
       (.I0(btnU_IBUF),
        .I1(\delay[0]_i_4_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .O(\spi_word[39]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000000F4)) 
    \spi_word[39]_i_10 
       (.I0(\spi_word[39]_i_14_n_0 ),
        .I1(\spi_word[39]_i_15_n_0 ),
        .I2(\spi_word[39]_i_16_n_0 ),
        .I3(\spi_word[39]_i_17_n_0 ),
        .I4(\spi_word[39]_i_18_n_0 ),
        .I5(\spi_word[39]_i_19_n_0 ),
        .O(\spi_word[39]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hD0202FDF)) 
    \spi_word[39]_i_100 
       (.I0(p_0_in_0[5]),
        .I1(\spi_word_reg[39]_i_90_n_7 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[6]),
        .I4(\spi_word_reg[39]_i_90_n_6 ),
        .O(\spi_word[39]_i_100_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \spi_word[39]_i_101 
       (.I0(p_0_in_0[5]),
        .I1(JB_OBUF[3]),
        .I2(\spi_word_reg[39]_i_90_n_7 ),
        .O(\spi_word[39]_i_101_n_0 ));
  LUT4 #(
    .INIT(16'h52FF)) 
    \spi_word[39]_i_103 
       (.I0(\spi_word_reg[35]_i_11_n_6 ),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_4 ),
        .I3(\c_offset_zero_reg[7] [5]),
        .O(\spi_word[39]_i_103_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \spi_word[39]_i_104 
       (.I0(\spi_word_reg[35]_i_12_n_4 ),
        .I1(\c_offset_zero_reg[7] [3]),
        .O(\spi_word[39]_i_104_n_0 ));
  LUT5 #(
    .INIT(32'h82A27D5D)) 
    \spi_word[39]_i_105 
       (.I0(\c_offset_zero_reg[7] [6]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [7]),
        .O(\spi_word[39]_i_105_n_0 ));
  LUT5 #(
    .INIT(32'h9C866379)) 
    \spi_word[39]_i_106 
       (.I0(\c_offset_zero_reg[7] [5]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [6]),
        .O(\spi_word[39]_i_106_n_0 ));
  LUT6 #(
    .INIT(64'h222DD2D2DDD22D2D)) 
    \spi_word[39]_i_107 
       (.I0(\c_offset_zero_reg[7] [4]),
        .I1(\spi_word_reg[35]_i_11_n_7 ),
        .I2(\spi_word_reg[35]_i_11_n_4 ),
        .I3(\spi_word_reg[35]_i_11_n_5 ),
        .I4(\spi_word_reg[35]_i_11_n_6 ),
        .I5(\c_offset_zero_reg[7] [5]),
        .O(\spi_word[39]_i_107_n_0 ));
  LUT4 #(
    .INIT(16'hD22D)) 
    \spi_word[39]_i_108 
       (.I0(\c_offset_zero_reg[7] [3]),
        .I1(\spi_word_reg[35]_i_12_n_4 ),
        .I2(\c_offset_zero_reg[7] [4]),
        .I3(\spi_word_reg[35]_i_11_n_7 ),
        .O(\spi_word[39]_i_108_n_0 ));
  LUT6 #(
    .INIT(64'h6200000000000062)) 
    \spi_word[39]_i_109 
       (.I0(\spi_word_reg[35]_i_11_n_5 ),
        .I1(\spi_word_reg[35]_i_11_n_6 ),
        .I2(\spi_word_reg[35]_i_11_n_4 ),
        .I3(\spi_word[39]_i_117_n_0 ),
        .I4(\c_offset_zero_reg[7] [6]),
        .I5(\c_offset_zero_reg[7] [7]),
        .O(\spi_word[39]_i_109_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[39]_i_11 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_state_reg_n_0_[14] ),
        .I3(\FSM_onehot_state_reg_n_0_[12] ),
        .I4(\FSM_onehot_state_reg_n_0_[18] ),
        .I5(\FSM_onehot_state_reg_n_0_[19] ),
        .O(\spi_word[39]_i_11_n_0 ));
  LUT5 #(
    .INIT(32'hC2AB802A)) 
    \spi_word[39]_i_110 
       (.I0(\spi_word[39]_i_150_n_0 ),
        .I1(\spi_word[39]_i_151_n_0 ),
        .I2(\c_offset_zero_reg[7] [4]),
        .I3(\c_offset_zero_reg[7] [5]),
        .I4(\spi_word_reg[35]_i_11_n_7 ),
        .O(\spi_word[39]_i_110_n_0 ));
  LUT6 #(
    .INIT(64'hBCCC2AAAA8880222)) 
    \spi_word[39]_i_111 
       (.I0(\spi_word_reg[35]_i_12_n_4 ),
        .I1(\c_offset_zero_reg[7] [2]),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\c_offset_zero_reg[7] [0]),
        .I4(\c_offset_zero_reg[7] [3]),
        .I5(\spi_word_reg[35]_i_12_n_5 ),
        .O(\spi_word[39]_i_111_n_0 ));
  LUT4 #(
    .INIT(16'hB980)) 
    \spi_word[39]_i_112 
       (.I0(\c_offset_zero_reg[7] [0]),
        .I1(\c_offset_zero_reg[7] [1]),
        .I2(\spi_word_reg[35]_i_12_n_7 ),
        .I3(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[39]_i_112_n_0 ));
  LUT6 #(
    .INIT(64'h8114148181811481)) 
    \spi_word[39]_i_113 
       (.I0(\c_offset_zero_reg[7] [7]),
        .I1(\c_offset_zero_reg[7] [6]),
        .I2(\spi_word[39]_i_117_n_0 ),
        .I3(\spi_word_reg[35]_i_11_n_5 ),
        .I4(\spi_word_reg[35]_i_11_n_6 ),
        .I5(\spi_word_reg[35]_i_11_n_4 ),
        .O(\spi_word[39]_i_113_n_0 ));
  LUT5 #(
    .INIT(32'h09906009)) 
    \spi_word[39]_i_114 
       (.I0(\c_offset_zero_reg[7] [5]),
        .I1(\spi_word[39]_i_150_n_0 ),
        .I2(\c_offset_zero_reg[7] [4]),
        .I3(\spi_word[39]_i_151_n_0 ),
        .I4(\spi_word_reg[35]_i_11_n_7 ),
        .O(\spi_word[39]_i_114_n_0 ));
  LUT6 #(
    .INIT(64'h6009090906606060)) 
    \spi_word[39]_i_115 
       (.I0(\c_offset_zero_reg[7] [3]),
        .I1(\spi_word_reg[35]_i_12_n_4 ),
        .I2(\c_offset_zero_reg[7] [2]),
        .I3(\c_offset_zero_reg[7] [1]),
        .I4(\c_offset_zero_reg[7] [0]),
        .I5(\spi_word_reg[35]_i_12_n_5 ),
        .O(\spi_word[39]_i_115_n_0 ));
  LUT4 #(
    .INIT(16'h1482)) 
    \spi_word[39]_i_116 
       (.I0(\spi_word_reg[35]_i_12_n_7 ),
        .I1(\spi_word_reg[35]_i_12_n_6 ),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\c_offset_zero_reg[7] [0]),
        .O(\spi_word[39]_i_116_n_0 ));
  LUT6 #(
    .INIT(64'h8888800000000000)) 
    \spi_word[39]_i_117 
       (.I0(\c_offset_zero_reg[7] [4]),
        .I1(\c_offset_zero_reg[7] [3]),
        .I2(\c_offset_zero_reg[7] [0]),
        .I3(\c_offset_zero_reg[7] [1]),
        .I4(\c_offset_zero_reg[7] [2]),
        .I5(\c_offset_zero_reg[7] [5]),
        .O(\spi_word[39]_i_117_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[39]_i_118 
       (.I0(\spi_word_reg[35]_i_12_n_4 ),
        .I1(\c_offset_zero_reg[7] [3]),
        .O(\spi_word[39]_i_118_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[39]_i_119 
       (.I0(\c_offset_zero_reg[7] [1]),
        .O(\spi_word[39]_i_119_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[39]_i_12 
       (.I0(\FSM_onehot_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_reg_n_0_[31] ),
        .I3(\FSM_onehot_state_reg_n_0_[29] ),
        .O(\spi_word[39]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h6966)) 
    \spi_word[39]_i_120 
       (.I0(\c_offset_zero_reg[7] [3]),
        .I1(\spi_word_reg[35]_i_12_n_4 ),
        .I2(\c_offset_zero_reg[7] [2]),
        .I3(\spi_word_reg[35]_i_12_n_5 ),
        .O(\spi_word[39]_i_120_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \spi_word[39]_i_121 
       (.I0(\c_offset_zero_reg[7] [1]),
        .I1(\c_offset_zero_reg[7] [2]),
        .I2(\spi_word_reg[35]_i_12_n_5 ),
        .O(\spi_word[39]_i_121_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[39]_i_122 
       (.I0(\c_offset_zero_reg[7] [1]),
        .I1(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[39]_i_122_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_123 
       (.I0(\c_offset_zero_reg[7] [0]),
        .I1(\spi_word_reg[35]_i_12_n_7 ),
        .O(\spi_word[39]_i_123_n_0 ));
  LUT6 #(
    .INIT(64'hE0E0E080E0808080)) 
    \spi_word[39]_i_125 
       (.I0(\spi_word[39]_i_159_n_0 ),
        .I1(p_0_in_0[7]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[0]),
        .I4(p_0_in_0[2]),
        .I5(p_0_in_0[4]),
        .O(\spi_word[39]_i_125_n_0 ));
  LUT6 #(
    .INIT(64'hE8FF17FF1700E800)) 
    \spi_word[39]_i_126 
       (.I0(p_0_in_0[4]),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[0]),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[7]),
        .I5(\spi_word[39]_i_159_n_0 ),
        .O(\spi_word[39]_i_126_n_0 ));
  LUT4 #(
    .INIT(16'hC880)) 
    \spi_word[39]_i_127 
       (.I0(p_0_in_0[3]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[5]),
        .I3(p_0_in_0[1]),
        .O(\spi_word[39]_i_127_n_0 ));
  LUT5 #(
    .INIT(32'h956A6A95)) 
    \spi_word[39]_i_128 
       (.I0(\spi_word[39]_i_125_n_0 ),
        .I1(p_0_in_0[8]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_160_n_0 ),
        .I4(\spi_word[39]_i_127_n_0 ),
        .O(\spi_word[39]_i_128_n_0 ));
  LUT6 #(
    .INIT(64'h6996AAAAAAAAAAAA)) 
    \spi_word[39]_i_129 
       (.I0(\spi_word[39]_i_126_n_0 ),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[4]),
        .I4(JB_OBUF[3]),
        .I5(p_0_in_0[6]),
        .O(\spi_word[39]_i_129_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \spi_word[39]_i_13 
       (.I0(\FSM_onehot_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_state_reg_n_0_[28] ),
        .I2(\FSM_onehot_state_reg_n_0_[26] ),
        .O(\spi_word[39]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hD77D7DD728828228)) 
    \spi_word[39]_i_130 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[0]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(\spi_word[39]_i_127_n_0 ),
        .O(\spi_word[39]_i_130_n_0 ));
  LUT5 #(
    .INIT(32'h6F9F9060)) 
    \spi_word[39]_i_131 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[5]),
        .I4(\FSM_onehot_state[15]_i_4_n_0 ),
        .O(\spi_word[39]_i_131_n_0 ));
  LUT4 #(
    .INIT(16'h7BB7)) 
    \spi_word[39]_i_132 
       (.I0(p_0_in_0[9]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[5]),
        .I3(p_0_in_0[7]),
        .O(\spi_word[39]_i_132_n_0 ));
  LUT4 #(
    .INIT(16'h7BB7)) 
    \spi_word[39]_i_133 
       (.I0(p_0_in_0[8]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[6]),
        .O(\spi_word[39]_i_133_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \spi_word[39]_i_134 
       (.I0(p_0_in_0[4]),
        .I1(p_0_in_0[6]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[2]),
        .O(\spi_word[39]_i_134_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \spi_word[39]_i_135 
       (.I0(p_0_in_0[10]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[6]),
        .I3(p_0_in_0[8]),
        .O(\spi_word[39]_i_135_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \spi_word[39]_i_136 
       (.I0(p_0_in_0[6]),
        .I1(p_0_in_0[8]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[4]),
        .O(\spi_word[39]_i_136_n_0 ));
  LUT4 #(
    .INIT(16'h577F)) 
    \spi_word[39]_i_137 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[7]),
        .I2(p_0_in_0[3]),
        .I3(p_0_in_0[5]),
        .O(\spi_word[39]_i_137_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \spi_word[39]_i_138 
       (.I0(p_0_in_0[7]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[3]),
        .I3(p_0_in_0[5]),
        .O(\spi_word[39]_i_138_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_139 
       (.I0(\spi_word_reg[39]_i_22_n_6 ),
        .I1(\spi_word_reg[39]_i_22_n_4 ),
        .O(\spi_word[39]_i_139_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \spi_word[39]_i_14 
       (.I0(\spi_word_reg[39]_i_20_n_3 ),
        .I1(oled_data66_in),
        .O(\spi_word[39]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_140 
       (.I0(\spi_word_reg[39]_i_22_n_7 ),
        .I1(\spi_word_reg[39]_i_22_n_5 ),
        .O(\spi_word[39]_i_140_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[39]_i_141 
       (.I0(\spi_word_reg[39]_i_22_n_6 ),
        .O(\spi_word[39]_i_141_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[39]_i_142 
       (.I0(\spi_word_reg[35]_i_12_n_4 ),
        .I1(\c_offset_zero_reg[7] [3]),
        .O(\spi_word[39]_i_142_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \spi_word[39]_i_143 
       (.I0(\spi_word_reg[35]_i_12_n_6 ),
        .I1(\c_offset_zero_reg[7] [1]),
        .O(\spi_word[39]_i_143_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_144 
       (.I0(\spi_word_reg[35]_i_12_n_6 ),
        .I1(\c_offset_zero_reg[7] [1]),
        .O(\spi_word[39]_i_144_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \spi_word[39]_i_145 
       (.I0(\spi_word_reg[35]_i_12_n_7 ),
        .I1(\c_offset_zero_reg[7] [0]),
        .O(\spi_word[39]_i_145_n_0 ));
  LUT4 #(
    .INIT(16'hD22D)) 
    \spi_word[39]_i_146 
       (.I0(\c_offset_zero_reg[7] [2]),
        .I1(\spi_word_reg[35]_i_12_n_5 ),
        .I2(\c_offset_zero_reg[7] [3]),
        .I3(\spi_word_reg[35]_i_12_n_4 ),
        .O(\spi_word[39]_i_146_n_0 ));
  LUT4 #(
    .INIT(16'h6966)) 
    \spi_word[39]_i_147 
       (.I0(\c_offset_zero_reg[7] [2]),
        .I1(\spi_word_reg[35]_i_12_n_5 ),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[39]_i_147_n_0 ));
  LUT4 #(
    .INIT(16'h4BB4)) 
    \spi_word[39]_i_148 
       (.I0(\spi_word_reg[35]_i_12_n_7 ),
        .I1(\c_offset_zero_reg[7] [0]),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[39]_i_148_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_149 
       (.I0(\c_offset_zero_reg[7] [0]),
        .I1(\spi_word_reg[35]_i_12_n_7 ),
        .O(\spi_word[39]_i_149_n_0 ));
  LUT6 #(
    .INIT(64'h555555555A56AAAA)) 
    \spi_word[39]_i_15 
       (.I0(\spi_word_reg[39]_i_22_n_4 ),
        .I1(\spi_word[39]_i_23_n_0 ),
        .I2(\spi_word_reg[39]_i_22_n_7 ),
        .I3(\spi_word_reg[39]_i_24_n_0 ),
        .I4(\spi_word_reg[39]_i_22_n_6 ),
        .I5(\spi_word_reg[39]_i_22_n_5 ),
        .O(\spi_word[39]_i_15_n_0 ));
  LUT3 #(
    .INIT(8'h1A)) 
    \spi_word[39]_i_150 
       (.I0(\spi_word_reg[35]_i_11_n_4 ),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .O(\spi_word[39]_i_150_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \spi_word[39]_i_151 
       (.I0(\c_offset_zero_reg[7] [3]),
        .I1(\c_offset_zero_reg[7] [0]),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\c_offset_zero_reg[7] [2]),
        .O(\spi_word[39]_i_151_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_152 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[4]),
        .O(oled_pixel_index[4]));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_153 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[3]),
        .O(\spi_word[39]_i_153_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_154 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[2]),
        .O(oled_pixel_index[2]));
  (* HLUTNM = "lutpair0" *) 
  LUT4 #(
    .INIT(16'h8448)) 
    \spi_word[39]_i_155 
       (.I0(p_0_in_0[2]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[0]),
        .I3(p_0_in_0[4]),
        .O(\spi_word[39]_i_155_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \spi_word[39]_i_156 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_156_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \spi_word[39]_i_157 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[0]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_157_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_158 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[1]),
        .O(oled_pixel_index[1]));
  LUT4 #(
    .INIT(16'h8448)) 
    \spi_word[39]_i_159 
       (.I0(p_0_in_0[5]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[3]),
        .O(\spi_word[39]_i_159_n_0 ));
  LUT4 #(
    .INIT(16'h4F44)) 
    \spi_word[39]_i_16 
       (.I0(\spi_word_reg[39]_i_25_n_3 ),
        .I1(oled_data66_in),
        .I2(\spi_word_reg[39]_i_20_n_3 ),
        .I3(oled_data410_in),
        .O(\spi_word[39]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'h7BB7)) 
    \spi_word[39]_i_160 
       (.I0(p_0_in_0[2]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[6]),
        .O(\spi_word[39]_i_160_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA6AAAAAAAAAAA)) 
    \spi_word[39]_i_17 
       (.I0(\spi_word_reg[39]_i_27_n_1 ),
        .I1(\spi_word_reg[39]_i_27_n_6 ),
        .I2(\spi_word_reg[39]_i_22_n_4 ),
        .I3(\spi_word[39]_i_28_n_0 ),
        .I4(\spi_word[39]_i_29_n_0 ),
        .I5(\spi_word_reg[39]_i_27_n_7 ),
        .O(\spi_word[39]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h8A20CF30CF30CF30)) 
    \spi_word[39]_i_18 
       (.I0(\spi_word_reg[39]_i_27_n_6 ),
        .I1(\spi_word[39]_i_29_n_0 ),
        .I2(\spi_word[39]_i_28_n_0 ),
        .I3(\spi_word_reg[39]_i_22_n_4 ),
        .I4(\spi_word_reg[39]_i_27_n_7 ),
        .I5(\spi_word[39]_i_30_n_0 ),
        .O(\spi_word[39]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'h4B4B4B404B4B0B4B)) 
    \spi_word[39]_i_19 
       (.I0(\spi_word[39]_i_29_n_0 ),
        .I1(\spi_word[39]_i_28_n_0 ),
        .I2(\spi_word_reg[39]_i_22_n_4 ),
        .I3(\spi_word_reg[39]_i_27_n_7 ),
        .I4(\spi_word[39]_i_31_n_0 ),
        .I5(\spi_word_reg[39]_i_27_n_6 ),
        .O(\spi_word[39]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'h8A8A8A888A8A8A8A)) 
    \spi_word[39]_i_2 
       (.I0(\spi_word[39]_i_3_n_0 ),
        .I1(\spi_word[39]_i_4_n_0 ),
        .I2(\spi_word[39]_i_5_n_0 ),
        .I3(\spi_word[39]_i_6_n_0 ),
        .I4(\spi_word[39]_i_7_n_0 ),
        .I5(\spi_word[39]_i_8_n_0 ),
        .O(\spi_word[39]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \spi_word[39]_i_23 
       (.I0(p_0_in_0[12]),
        .I1(JB_OBUF[3]),
        .I2(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[39]_i_23_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \spi_word[39]_i_28 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_22_n_7 ),
        .I2(\spi_word_reg[39]_i_22_n_6 ),
        .O(\spi_word[39]_i_28_n_0 ));
  LUT4 #(
    .INIT(16'hAEEE)) 
    \spi_word[39]_i_29 
       (.I0(\spi_word_reg[39]_i_24_n_0 ),
        .I1(\spi_word_reg[39]_i_51_n_4 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[12]),
        .O(\spi_word[39]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAAB)) 
    \spi_word[39]_i_3 
       (.I0(\spi_word_reg_n_0_[38] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[39]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hF7EFFFEEF7EFF7EF)) 
    \spi_word[39]_i_30 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_22_n_6 ),
        .I2(\spi_word_reg[39]_i_24_n_0 ),
        .I3(\spi_word_reg[39]_i_22_n_7 ),
        .I4(oled_pixel_index[12]),
        .I5(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[39]_i_30_n_0 ));
  LUT6 #(
    .INIT(64'hA28AAA88A28AA28A)) 
    \spi_word[39]_i_31 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_22_n_6 ),
        .I2(\spi_word_reg[39]_i_24_n_0 ),
        .I3(\spi_word_reg[39]_i_22_n_7 ),
        .I4(oled_pixel_index[12]),
        .I5(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[39]_i_31_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[39]_i_33 
       (.I0(\c_offset_zero_reg[7] [7]),
        .O(\spi_word[39]_i_33_n_0 ));
  LUT5 #(
    .INIT(32'h00001404)) 
    \spi_word[39]_i_34 
       (.I0(\c_offset_zero_reg[7] [7]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [6]),
        .O(\spi_word[39]_i_34_n_0 ));
  LUT6 #(
    .INIT(64'h022F022F02022F02)) 
    \spi_word[39]_i_35 
       (.I0(\spi_word_reg[35]_i_11_n_7 ),
        .I1(\c_offset_zero_reg[7] [4]),
        .I2(\c_offset_zero_reg[7] [5]),
        .I3(\spi_word_reg[35]_i_11_n_6 ),
        .I4(\spi_word_reg[35]_i_11_n_5 ),
        .I5(\spi_word_reg[35]_i_11_n_4 ),
        .O(\spi_word[39]_i_35_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \spi_word[39]_i_36 
       (.I0(\spi_word_reg[35]_i_12_n_5 ),
        .I1(\c_offset_zero_reg[7] [2]),
        .I2(\c_offset_zero_reg[7] [3]),
        .I3(\spi_word_reg[35]_i_12_n_4 ),
        .O(\spi_word[39]_i_36_n_0 ));
  LUT4 #(
    .INIT(16'h4F04)) 
    \spi_word[39]_i_37 
       (.I0(\c_offset_zero_reg[7] [0]),
        .I1(\spi_word_reg[35]_i_12_n_7 ),
        .I2(\c_offset_zero_reg[7] [1]),
        .I3(\spi_word_reg[35]_i_12_n_6 ),
        .O(\spi_word[39]_i_37_n_0 ));
  LUT5 #(
    .INIT(32'h14044151)) 
    \spi_word[39]_i_38 
       (.I0(\c_offset_zero_reg[7] [7]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [6]),
        .O(\spi_word[39]_i_38_n_0 ));
  LUT6 #(
    .INIT(64'h1AE5000000001AE5)) 
    \spi_word[39]_i_39 
       (.I0(\spi_word_reg[35]_i_11_n_4 ),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\c_offset_zero_reg[7] [5]),
        .I4(\c_offset_zero_reg[7] [4]),
        .I5(\spi_word_reg[35]_i_11_n_7 ),
        .O(\spi_word[39]_i_39_n_0 ));
  LUT5 #(
    .INIT(32'hFF8AFFFF)) 
    \spi_word[39]_i_4 
       (.I0(\spi_word[39]_i_5_n_0 ),
        .I1(\spi_word[38]_i_4_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[37]_i_5_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .O(\spi_word[39]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \spi_word[39]_i_40 
       (.I0(\c_offset_zero_reg[7] [2]),
        .I1(\spi_word_reg[35]_i_12_n_5 ),
        .I2(\c_offset_zero_reg[7] [3]),
        .I3(\spi_word_reg[35]_i_12_n_4 ),
        .O(\spi_word[39]_i_40_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \spi_word[39]_i_41 
       (.I0(\spi_word_reg[35]_i_12_n_6 ),
        .I1(\c_offset_zero_reg[7] [1]),
        .I2(\c_offset_zero_reg[7] [0]),
        .I3(\spi_word_reg[35]_i_12_n_7 ),
        .O(\spi_word[39]_i_41_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \spi_word[39]_i_43 
       (.I0(p_0_in_0[12]),
        .I1(p_0_in_0[10]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_43_n_0 ));
  LUT6 #(
    .INIT(64'h00E80000E8000000)) 
    \spi_word[39]_i_44 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[9]),
        .I2(p_0_in_0[7]),
        .I3(\spi_word[39]_i_43_n_0 ),
        .I4(JB_OBUF[3]),
        .I5(p_0_in_0[8]),
        .O(\spi_word[39]_i_44_n_0 ));
  LUT5 #(
    .INIT(32'h0000E800)) 
    \spi_word[39]_i_45 
       (.I0(p_0_in_0[8]),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[10]),
        .I3(JB_OBUF[3]),
        .I4(\spi_word[39]_i_86_n_0 ),
        .O(\spi_word[39]_i_45_n_0 ));
  LUT6 #(
    .INIT(64'hA88A8AA880080880)) 
    \spi_word[39]_i_46 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[12]),
        .I2(p_0_in_0[8]),
        .I3(p_0_in_0[6]),
        .I4(p_0_in_0[10]),
        .I5(\spi_word[39]_i_87_n_0 ),
        .O(\spi_word[39]_i_46_n_0 ));
  LUT6 #(
    .INIT(64'hEE00170017008800)) 
    \spi_word[39]_i_47 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[9]),
        .I2(p_0_in_0[8]),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[10]),
        .I5(p_0_in_0[12]),
        .O(\spi_word[39]_i_47_n_0 ));
  LUT6 #(
    .INIT(64'hA7700000588FFFFF)) 
    \spi_word[39]_i_48 
       (.I0(\spi_word[39]_i_88_n_0 ),
        .I1(p_0_in_0[7]),
        .I2(p_0_in_0[9]),
        .I3(p_0_in_0[11]),
        .I4(JB_OBUF[3]),
        .I5(\spi_word[39]_i_89_n_0 ),
        .O(\spi_word[39]_i_48_n_0 ));
  LUT6 #(
    .INIT(64'h9996666696666666)) 
    \spi_word[39]_i_49 
       (.I0(\spi_word[39]_i_45_n_0 ),
        .I1(\spi_word[39]_i_88_n_0 ),
        .I2(p_0_in_0[7]),
        .I3(p_0_in_0[9]),
        .I4(JB_OBUF[3]),
        .I5(p_0_in_0[11]),
        .O(\spi_word[39]_i_49_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \spi_word[39]_i_5 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[39]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6969699969999999)) 
    \spi_word[39]_i_50 
       (.I0(\spi_word[39]_i_46_n_0 ),
        .I1(\spi_word[39]_i_86_n_0 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[10]),
        .I4(p_0_in_0[6]),
        .I5(p_0_in_0[8]),
        .O(\spi_word[39]_i_50_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \spi_word[39]_i_53 
       (.I0(\spi_word_reg[39]_i_51_n_5 ),
        .I1(p_0_in_0[11]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_53_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \spi_word[39]_i_54 
       (.I0(\spi_word_reg[39]_i_51_n_6 ),
        .I1(p_0_in_0[10]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_54_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \spi_word[39]_i_55 
       (.I0(\spi_word_reg[39]_i_51_n_7 ),
        .I1(p_0_in_0[9]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_55_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \spi_word[39]_i_56 
       (.I0(\spi_word_reg[39]_i_90_n_4 ),
        .I1(p_0_in_0[8]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_56_n_0 ));
  LUT5 #(
    .INIT(32'hBC4C43B3)) 
    \spi_word[39]_i_57 
       (.I0(p_0_in_0[11]),
        .I1(\spi_word_reg[39]_i_51_n_5 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[12]),
        .I4(\spi_word_reg[39]_i_51_n_4 ),
        .O(\spi_word[39]_i_57_n_0 ));
  LUT5 #(
    .INIT(32'hBC4C43B3)) 
    \spi_word[39]_i_58 
       (.I0(p_0_in_0[10]),
        .I1(\spi_word_reg[39]_i_51_n_6 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[11]),
        .I4(\spi_word_reg[39]_i_51_n_5 ),
        .O(\spi_word[39]_i_58_n_0 ));
  LUT5 #(
    .INIT(32'hBC4C43B3)) 
    \spi_word[39]_i_59 
       (.I0(p_0_in_0[9]),
        .I1(\spi_word_reg[39]_i_51_n_7 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[10]),
        .I4(\spi_word_reg[39]_i_51_n_6 ),
        .O(\spi_word[39]_i_59_n_0 ));
  LUT4 #(
    .INIT(16'h0F07)) 
    \spi_word[39]_i_6 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word[39]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hBC4C43B3)) 
    \spi_word[39]_i_60 
       (.I0(p_0_in_0[8]),
        .I1(\spi_word_reg[39]_i_90_n_4 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[9]),
        .I4(\spi_word_reg[39]_i_51_n_7 ),
        .O(\spi_word[39]_i_60_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[39]_i_62 
       (.I0(\c_offset_zero_reg[7] [7]),
        .O(\spi_word[39]_i_62_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \spi_word[39]_i_64 
       (.I0(\c_offset_zero_reg[7] [7]),
        .I1(\c_offset_zero_reg[7] [6]),
        .I2(\spi_word[39]_i_117_n_0 ),
        .O(\spi_word[39]_i_64_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \spi_word[39]_i_65 
       (.I0(p_0_in_0[12]),
        .I1(p_0_in_0[10]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_65_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_66 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[12]),
        .O(\spi_word[39]_i_66_n_0 ));
  LUT4 #(
    .INIT(16'h7800)) 
    \spi_word[39]_i_67 
       (.I0(p_0_in_0[10]),
        .I1(p_0_in_0[12]),
        .I2(p_0_in_0[11]),
        .I3(JB_OBUF[3]),
        .O(\spi_word[39]_i_67_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[39]_i_68 
       (.I0(JB_OBUF[3]),
        .I1(p_0_in_0[12]),
        .O(oled_pixel_index[12]));
  LUT4 #(
    .INIT(16'h0400)) 
    \spi_word[39]_i_7 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .I2(\spi_word[25]_i_2_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word[39]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h52FF)) 
    \spi_word[39]_i_70 
       (.I0(\spi_word_reg[35]_i_11_n_6 ),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_4 ),
        .I3(\c_offset_zero_reg[7] [5]),
        .O(\spi_word[39]_i_70_n_0 ));
  LUT4 #(
    .INIT(16'h99A6)) 
    \spi_word[39]_i_71 
       (.I0(\c_offset_zero_reg[7] [5]),
        .I1(\spi_word_reg[35]_i_11_n_6 ),
        .I2(\spi_word_reg[35]_i_11_n_5 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .O(\spi_word[39]_i_71_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \spi_word[39]_i_72 
       (.I0(\spi_word_reg[35]_i_12_n_4 ),
        .I1(\c_offset_zero_reg[7] [3]),
        .O(\spi_word[39]_i_72_n_0 ));
  LUT5 #(
    .INIT(32'h82A27D5D)) 
    \spi_word[39]_i_73 
       (.I0(\c_offset_zero_reg[7] [6]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [7]),
        .O(\spi_word[39]_i_73_n_0 ));
  LUT5 #(
    .INIT(32'h9C866379)) 
    \spi_word[39]_i_74 
       (.I0(\c_offset_zero_reg[7] [5]),
        .I1(\spi_word_reg[35]_i_11_n_5 ),
        .I2(\spi_word_reg[35]_i_11_n_6 ),
        .I3(\spi_word_reg[35]_i_11_n_4 ),
        .I4(\c_offset_zero_reg[7] [6]),
        .O(\spi_word[39]_i_74_n_0 ));
  LUT6 #(
    .INIT(64'h222DD2D2DDD22D2D)) 
    \spi_word[39]_i_75 
       (.I0(\c_offset_zero_reg[7] [4]),
        .I1(\spi_word_reg[35]_i_11_n_7 ),
        .I2(\spi_word_reg[35]_i_11_n_4 ),
        .I3(\spi_word_reg[35]_i_11_n_5 ),
        .I4(\spi_word_reg[35]_i_11_n_6 ),
        .I5(\c_offset_zero_reg[7] [5]),
        .O(\spi_word[39]_i_75_n_0 ));
  LUT4 #(
    .INIT(16'hD22D)) 
    \spi_word[39]_i_76 
       (.I0(\c_offset_zero_reg[7] [3]),
        .I1(\spi_word_reg[35]_i_12_n_4 ),
        .I2(\c_offset_zero_reg[7] [4]),
        .I3(\spi_word_reg[35]_i_11_n_7 ),
        .O(\spi_word[39]_i_76_n_0 ));
  LUT6 #(
    .INIT(64'hC880CCCC0000C880)) 
    \spi_word[39]_i_78 
       (.I0(p_0_in_0[4]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[8]),
        .I3(p_0_in_0[6]),
        .I4(\spi_word[39]_i_132_n_0 ),
        .I5(p_0_in_0[11]),
        .O(\spi_word[39]_i_78_n_0 ));
  LUT6 #(
    .INIT(64'hE800FF000000E800)) 
    \spi_word[39]_i_79 
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[3]),
        .I2(p_0_in_0[7]),
        .I3(JB_OBUF[3]),
        .I4(\spi_word[39]_i_133_n_0 ),
        .I5(p_0_in_0[10]),
        .O(\spi_word[39]_i_79_n_0 ));
  LUT5 #(
    .INIT(32'hFFBFFFFF)) 
    \spi_word[39]_i_8 
       (.I0(\spi_word[39]_i_9_n_0 ),
        .I1(\spi_word[14]_i_4_n_0 ),
        .I2(\spi_word[14]_i_3_n_0 ),
        .I3(\spi_word[22]_i_3_n_0 ),
        .I4(\spi_word[39]_i_10_n_0 ),
        .O(\spi_word[39]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hF0F0906090600000)) 
    \spi_word[39]_i_80 
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[3]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[7]),
        .I4(\spi_word[39]_i_134_n_0 ),
        .I5(p_0_in_0[9]),
        .O(\spi_word[39]_i_80_n_0 ));
  LUT6 #(
    .INIT(64'hEB00BE0082002800)) 
    \spi_word[39]_i_81 
       (.I0(\spi_word[39]_i_127_n_0 ),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[4]),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[2]),
        .I5(p_0_in_0[8]),
        .O(\spi_word[39]_i_81_n_0 ));
  LUT5 #(
    .INIT(32'h6A95956A)) 
    \spi_word[39]_i_82 
       (.I0(\spi_word[39]_i_78_n_0 ),
        .I1(p_0_in_0[12]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_135_n_0 ),
        .I4(\spi_word[39]_i_87_n_0 ),
        .O(\spi_word[39]_i_82_n_0 ));
  LUT5 #(
    .INIT(32'h956A6A95)) 
    \spi_word[39]_i_83 
       (.I0(\spi_word[39]_i_79_n_0 ),
        .I1(p_0_in_0[11]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_132_n_0 ),
        .I4(\spi_word[39]_i_136_n_0 ),
        .O(\spi_word[39]_i_83_n_0 ));
  LUT5 #(
    .INIT(32'h69969696)) 
    \spi_word[39]_i_84 
       (.I0(\spi_word[39]_i_80_n_0 ),
        .I1(\spi_word[39]_i_137_n_0 ),
        .I2(\spi_word[39]_i_133_n_0 ),
        .I3(JB_OBUF[3]),
        .I4(p_0_in_0[10]),
        .O(\spi_word[39]_i_84_n_0 ));
  LUT5 #(
    .INIT(32'h6A95956A)) 
    \spi_word[39]_i_85 
       (.I0(\spi_word[39]_i_81_n_0 ),
        .I1(p_0_in_0[9]),
        .I2(JB_OBUF[3]),
        .I3(\spi_word[39]_i_138_n_0 ),
        .I4(\spi_word[39]_i_134_n_0 ),
        .O(\spi_word[39]_i_85_n_0 ));
  LUT4 #(
    .INIT(16'h7BB7)) 
    \spi_word[39]_i_86 
       (.I0(p_0_in_0[11]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[9]),
        .I3(p_0_in_0[7]),
        .O(\spi_word[39]_i_86_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \spi_word[39]_i_87 
       (.I0(p_0_in_0[7]),
        .I1(p_0_in_0[9]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[5]),
        .O(\spi_word[39]_i_87_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \spi_word[39]_i_88 
       (.I0(p_0_in_0[8]),
        .I1(JB_OBUF[3]),
        .I2(p_0_in_0[10]),
        .I3(p_0_in_0[12]),
        .O(\spi_word[39]_i_88_n_0 ));
  LUT4 #(
    .INIT(16'h1F7F)) 
    \spi_word[39]_i_89 
       (.I0(p_0_in_0[10]),
        .I1(p_0_in_0[12]),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[8]),
        .O(\spi_word[39]_i_89_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[39]_i_9 
       (.I0(\spi_word[39]_i_11_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[17] ),
        .I2(\FSM_onehot_state_reg_n_0_[27] ),
        .I3(\FSM_onehot_state_reg_n_0_[6] ),
        .I4(\spi_word[39]_i_12_n_0 ),
        .I5(\spi_word[39]_i_13_n_0 ),
        .O(\spi_word[39]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[39]_i_91 
       (.I0(\spi_word_reg[39]_i_27_n_6 ),
        .O(\spi_word[39]_i_91_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_92 
       (.I0(\spi_word_reg[39]_i_27_n_7 ),
        .I1(\spi_word_reg[39]_i_27_n_1 ),
        .O(\spi_word[39]_i_92_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_93 
       (.I0(\spi_word_reg[39]_i_22_n_4 ),
        .I1(\spi_word_reg[39]_i_27_n_6 ),
        .O(\spi_word[39]_i_93_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[39]_i_94 
       (.I0(\spi_word_reg[39]_i_22_n_5 ),
        .I1(\spi_word_reg[39]_i_27_n_7 ),
        .O(\spi_word[39]_i_94_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \spi_word[39]_i_95 
       (.I0(\spi_word_reg[39]_i_90_n_5 ),
        .I1(p_0_in_0[7]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_95_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \spi_word[39]_i_96 
       (.I0(\spi_word_reg[39]_i_90_n_6 ),
        .I1(p_0_in_0[6]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_96_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \spi_word[39]_i_97 
       (.I0(\spi_word_reg[39]_i_90_n_7 ),
        .I1(p_0_in_0[5]),
        .I2(JB_OBUF[3]),
        .O(\spi_word[39]_i_97_n_0 ));
  LUT5 #(
    .INIT(32'hBC4C43B3)) 
    \spi_word[39]_i_98 
       (.I0(p_0_in_0[7]),
        .I1(\spi_word_reg[39]_i_90_n_5 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[8]),
        .I4(\spi_word_reg[39]_i_90_n_4 ),
        .O(\spi_word[39]_i_98_n_0 ));
  LUT5 #(
    .INIT(32'h2FDFD020)) 
    \spi_word[39]_i_99 
       (.I0(p_0_in_0[6]),
        .I1(\spi_word_reg[39]_i_90_n_6 ),
        .I2(JB_OBUF[3]),
        .I3(p_0_in_0[7]),
        .I4(\spi_word_reg[39]_i_90_n_5 ),
        .O(\spi_word[39]_i_99_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[3]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[2] ),
        .O(\spi_word[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[4]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[3] ),
        .O(\spi_word[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[5]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[4] ),
        .O(\spi_word[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[6]_i_1 
       (.I0(\spi_word_reg_n_0_[5] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \spi_word[7]_i_1 
       (.I0(\spi_word_reg_n_0_[6] ),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[8]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[7] ),
        .O(\spi_word[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2F0F0F0F20000000)) 
    \spi_word[9]_i_1 
       (.I0(\spi_word[14]_i_2_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\delay[0]_i_1_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .I5(\spi_word_reg_n_0_[8] ),
        .O(\spi_word[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555554)) 
    \spi_word_bit_count[0]_i_1 
       (.I0(spi_word_bit_count_reg__0[0]),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word_bit_count[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA55555554)) 
    \spi_word_bit_count[1]_i_1 
       (.I0(spi_word_bit_count_reg__0[0]),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(p_0_in__0[1]));
  LUT6 #(
    .INIT(64'hCCCCCCCC99999998)) 
    \spi_word_bit_count[2]_i_1 
       (.I0(spi_word_bit_count_reg__0[0]),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(p_0_in__0[2]));
  LUT6 #(
    .INIT(64'h28A4FFFF28A40000)) 
    \spi_word_bit_count[3]_i_1 
       (.I0(\spi_word_bit_count[3]_i_2_n_0 ),
        .I1(\spi_word[14]_i_3_n_0 ),
        .I2(\spi_word[14]_i_4_n_0 ),
        .I3(\spi_word[33]_i_3_n_0 ),
        .I4(\delay[0]_i_1_n_0 ),
        .I5(\spi_word_bit_count[3]_i_3_n_0 ),
        .O(p_0_in__0[3]));
  LUT2 #(
    .INIT(4'h1)) 
    \spi_word_bit_count[3]_i_2 
       (.I0(\spi_word[25]_i_2_n_0 ),
        .I1(\spi_word[22]_i_3_n_0 ),
        .O(\spi_word_bit_count[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \spi_word_bit_count[3]_i_3 
       (.I0(spi_word_bit_count_reg__0[3]),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[0]),
        .I3(spi_word_bit_count_reg__0[1]),
        .O(\spi_word_bit_count[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \spi_word_bit_count[4]_i_2 
       (.I0(spi_word_bit_count_reg__0[4]),
        .I1(spi_word_bit_count_reg__0[3]),
        .I2(spi_word_bit_count_reg__0[1]),
        .I3(spi_word_bit_count_reg__0[0]),
        .I4(spi_word_bit_count_reg__0[2]),
        .O(\spi_word_bit_count[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h26FC6CFF)) 
    \spi_word_bit_count[4]_i_3 
       (.I0(\spi_word[33]_i_3_n_0 ),
        .I1(\spi_word[25]_i_2_n_0 ),
        .I2(\spi_word[22]_i_3_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .I4(\spi_word[14]_i_4_n_0 ),
        .O(\spi_word_bit_count[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B88BB8B8B8B8)) 
    \spi_word_bit_count[5]_i_1 
       (.I0(\spi_word_bit_count[5]_i_2_n_0 ),
        .I1(\delay[0]_i_1_n_0 ),
        .I2(spi_word_bit_count_reg__0[5]),
        .I3(spi_word_bit_count_reg__0[3]),
        .I4(spi_word_bit_count_reg__0[4]),
        .I5(\JB_OBUF[3]_inst_i_2_n_0 ),
        .O(p_0_in__0[5]));
  LUT4 #(
    .INIT(16'h8000)) 
    \spi_word_bit_count[5]_i_2 
       (.I0(\spi_word[14]_i_4_n_0 ),
        .I1(\spi_word[39]_i_9_n_0 ),
        .I2(\spi_word[14]_i_2_n_0 ),
        .I3(\spi_word[14]_i_3_n_0 ),
        .O(\spi_word_bit_count[5]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word_bit_count[0]_i_1_n_0 ),
        .Q(spi_word_bit_count_reg__0[0]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in__0[1]),
        .Q(spi_word_bit_count_reg__0[1]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in__0[2]),
        .Q(spi_word_bit_count_reg__0[2]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in__0[3]),
        .Q(spi_word_bit_count_reg__0[3]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in__0[4]),
        .Q(spi_word_bit_count_reg__0[4]),
        .R(\spi_word[39]_i_1_n_0 ));
  MUXF7 \spi_word_bit_count_reg[4]_i_1 
       (.I0(\spi_word_bit_count[4]_i_2_n_0 ),
        .I1(\spi_word_bit_count[4]_i_3_n_0 ),
        .O(p_0_in__0[4]),
        .S(\delay[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in__0[5]),
        .Q(spi_word_bit_count_reg__0[5]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[0]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[10]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[10] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[11]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[11] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[12]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[12] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[13]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[13] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[14]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[14] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[15] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[15]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[15] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[16] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[16]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[16] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[17] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[17]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[17] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[18] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[18]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[18] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[19] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[19]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[19] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[1]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[1] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[20] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[20]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[20] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[21] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[21]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[21] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[22] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[22]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[22] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[23] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[23]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[23] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[24] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[24]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[24] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[25] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[25]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[25] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[26] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[26]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[26] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[27] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[27]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[27] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[28] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[28]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[28] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[29] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[29]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[29] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[2]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[2] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[30] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[30]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[30] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[31] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[31]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[31] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[32] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[32]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[32] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[33] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[33]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[33] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[34] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[34]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[34] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[35] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[35]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[35] ),
        .R(\spi_word[39]_i_1_n_0 ));
  CARRY4 \spi_word_reg[35]_i_11 
       (.CI(\spi_word_reg[35]_i_12_n_0 ),
        .CO(\NLW_spi_word_reg[35]_i_11_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,\spi_word[35]_i_16_n_0 ,oled_pixel_index[5],\spi_word[35]_i_18_n_0 }),
        .O({\spi_word_reg[35]_i_11_n_4 ,\spi_word_reg[35]_i_11_n_5 ,\spi_word_reg[35]_i_11_n_6 ,\spi_word_reg[35]_i_11_n_7 }),
        .S({\spi_word[35]_i_19_n_0 ,\spi_word[35]_i_20_n_0 ,\spi_word[35]_i_21_n_0 ,\spi_word[35]_i_22_n_0 }));
  CARRY4 \spi_word_reg[35]_i_12 
       (.CI(1'b0),
        .CO({\spi_word_reg[35]_i_12_n_0 ,\NLW_spi_word_reg[35]_i_12_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[35]_i_23_n_0 ,\spi_word[35]_i_24_n_0 ,\spi_word[35]_i_25_n_0 ,oled_pixel_index[0]}),
        .O({\spi_word_reg[35]_i_12_n_4 ,\spi_word_reg[35]_i_12_n_5 ,\spi_word_reg[35]_i_12_n_6 ,\spi_word_reg[35]_i_12_n_7 }),
        .S({\spi_word[35]_i_27_n_0 ,\spi_word[35]_i_28_n_0 ,\spi_word[35]_i_29_n_0 ,\spi_word[35]_i_30_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_13 
       (.CI(1'b0),
        .CO({oled_data42_in,\NLW_spi_word_reg[35]_i_13_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[35]_i_31_n_0 ,\spi_word[35]_i_32_n_0 ,\spi_word[35]_i_33_n_0 ,\spi_word[35]_i_34_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_13_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_35_n_0 ,\spi_word[35]_i_36_n_0 ,\spi_word[35]_i_37_n_0 ,\spi_word[35]_i_38_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_14 
       (.CI(\spi_word_reg[35]_i_39_n_0 ),
        .CO({\NLW_spi_word_reg[35]_i_14_CO_UNCONNECTED [3:1],\spi_word_reg[35]_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_spi_word_reg[35]_i_14_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,p_0_in[1]}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_15 
       (.CI(\spi_word_reg[35]_i_41_n_0 ),
        .CO({\NLW_spi_word_reg[35]_i_15_CO_UNCONNECTED [3:1],\spi_word_reg[35]_i_15_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_spi_word_reg[35]_i_15_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,S}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_39 
       (.CI(\spi_word_reg[35]_i_50_n_0 ),
        .CO({\spi_word_reg[35]_i_39_n_0 ,\NLW_spi_word_reg[35]_i_39_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({Q[7],\spi_word[35]_i_51_n_0 ,\spi_word[35]_i_52_n_0 ,\spi_word[35]_i_53_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_39_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_54_n_0 ,\spi_word[35]_i_55_n_0 ,\spi_word[35]_i_56_n_0 ,\spi_word[35]_i_57_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_41 
       (.CI(\spi_word_reg[35]_i_58_n_0 ),
        .CO({\spi_word_reg[35]_i_41_n_0 ,\NLW_spi_word_reg[35]_i_41_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({Q[7],\spi_word[35]_i_59_n_0 ,\spi_word[35]_i_52_n_0 ,\spi_word[35]_i_60_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_41_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_61_n_0 ,\spi_word[35]_i_62_n_0 ,\spi_word[35]_i_63_n_0 ,\spi_word[35]_i_64_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_50 
       (.CI(1'b0),
        .CO({\spi_word_reg[35]_i_50_n_0 ,\NLW_spi_word_reg[35]_i_50_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[35]_i_68_n_0 ,\spi_word[35]_i_69_n_0 ,\spi_word[35]_i_70_n_0 ,\spi_word[35]_i_71_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_50_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_72_n_0 ,\spi_word[35]_i_73_n_0 ,\spi_word[35]_i_74_n_0 ,\spi_word[35]_i_75_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[35]_i_58 
       (.CI(1'b0),
        .CO({\spi_word_reg[35]_i_58_n_0 ,\NLW_spi_word_reg[35]_i_58_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({p_0_in[0],Q[2],\spi_word[35]_i_49_n_0 ,\spi_word[35]_i_48_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_58_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_78_n_0 ,\spi_word[35]_i_79_n_0 ,\spi_word[35]_i_80_n_0 ,\spi_word[35]_i_81_n_0 }));
  CARRY4 \spi_word_reg[35]_i_67 
       (.CI(\spi_word_reg[35]_i_82_n_0 ),
        .CO(\NLW_spi_word_reg[35]_i_67_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\spi_word[39]_i_45_n_0 ,\spi_word[39]_i_46_n_0 }),
        .O({\NLW_spi_word_reg[35]_i_67_O_UNCONNECTED [3],O}),
        .S({1'b0,\spi_word[35]_i_83_n_0 ,\spi_word[35]_i_84_n_0 ,\spi_word[35]_i_85_n_0 }));
  CARRY4 \spi_word_reg[35]_i_82 
       (.CI(\spi_word_reg[35]_i_86_n_0 ),
        .CO({\spi_word_reg[35]_i_82_n_0 ,\NLW_spi_word_reg[35]_i_82_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_78_n_0 ,\spi_word[39]_i_79_n_0 ,\spi_word[39]_i_80_n_0 ,\spi_word[39]_i_81_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_82_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_87_n_0 ,\spi_word[35]_i_88_n_0 ,\spi_word[35]_i_89_n_0 ,\spi_word[35]_i_90_n_0 }));
  CARRY4 \spi_word_reg[35]_i_86 
       (.CI(\spi_word_reg[35]_i_91_n_0 ),
        .CO({\spi_word_reg[35]_i_86_n_0 ,\NLW_spi_word_reg[35]_i_86_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_125_n_0 ,\spi_word[39]_i_126_n_0 ,\spi_word[39]_i_127_n_0 ,\FSM_onehot_state[15]_i_4_n_0 }),
        .O(\NLW_spi_word_reg[35]_i_86_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_92_n_0 ,\spi_word[35]_i_93_n_0 ,\spi_word[35]_i_94_n_0 ,\spi_word[35]_i_95_n_0 }));
  CARRY4 \spi_word_reg[35]_i_91 
       (.CI(1'b0),
        .CO({\spi_word_reg[35]_i_91_n_0 ,\NLW_spi_word_reg[35]_i_91_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[35]_i_96_n_0 ,\spi_word[35]_i_97_n_0 ,\spi_word[35]_i_98_n_0 ,1'b0}),
        .O(\NLW_spi_word_reg[35]_i_91_O_UNCONNECTED [3:0]),
        .S({\spi_word[35]_i_99_n_0 ,\spi_word[35]_i_100_n_0 ,\spi_word[35]_i_101_n_0 ,\spi_word[35]_i_102_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[36] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[36]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[36] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[37] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[37]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[37] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[38] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[38]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[38] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[39] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[39]_i_2_n_0 ),
        .Q(\spi_word_reg_n_0_[39] ),
        .R(\spi_word[39]_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_102 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_102_n_0 ,\NLW_spi_word_reg[39]_i_102_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[39]_i_142_n_0 ,\spi_word[39]_i_143_n_0 ,\spi_word[39]_i_144_n_0 ,\spi_word[39]_i_145_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_102_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_146_n_0 ,\spi_word[39]_i_147_n_0 ,\spi_word[39]_i_148_n_0 ,\spi_word[39]_i_149_n_0 }));
  CARRY4 \spi_word_reg[39]_i_124 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_124_n_0 ,\NLW_spi_word_reg[39]_i_124_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({oled_pixel_index[4],\spi_word[39]_i_153_n_0 ,oled_pixel_index[2],1'b0}),
        .O(\NLW_spi_word_reg[39]_i_124_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_155_n_0 ,\spi_word[39]_i_156_n_0 ,\spi_word[39]_i_157_n_0 ,oled_pixel_index[1]}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_20 
       (.CI(\spi_word_reg[39]_i_32_n_0 ),
        .CO({\NLW_spi_word_reg[39]_i_20_CO_UNCONNECTED [3:1],\spi_word_reg[39]_i_20_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_spi_word_reg[39]_i_20_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\spi_word[39]_i_33_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_21 
       (.CI(1'b0),
        .CO({oled_data66_in,\NLW_spi_word_reg[39]_i_21_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[39]_i_34_n_0 ,\spi_word[39]_i_35_n_0 ,\spi_word[39]_i_36_n_0 ,\spi_word[39]_i_37_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_21_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_38_n_0 ,\spi_word[39]_i_39_n_0 ,\spi_word[39]_i_40_n_0 ,\spi_word[39]_i_41_n_0 }));
  CARRY4 \spi_word_reg[39]_i_22 
       (.CI(\spi_word_reg[39]_i_42_n_0 ),
        .CO({\spi_word_reg[39]_i_22_n_0 ,\NLW_spi_word_reg[39]_i_22_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_43_n_0 ,\spi_word[39]_i_44_n_0 ,\spi_word[39]_i_45_n_0 ,\spi_word[39]_i_46_n_0 }),
        .O({\spi_word_reg[39]_i_22_n_4 ,\spi_word_reg[39]_i_22_n_5 ,\spi_word_reg[39]_i_22_n_6 ,\spi_word_reg[39]_i_22_n_7 }),
        .S({\spi_word[39]_i_47_n_0 ,\spi_word[39]_i_48_n_0 ,\spi_word[39]_i_49_n_0 ,\spi_word[39]_i_50_n_0 }));
  CARRY4 \spi_word_reg[39]_i_24 
       (.CI(\spi_word_reg[39]_i_52_n_0 ),
        .CO({\spi_word_reg[39]_i_24_n_0 ,\NLW_spi_word_reg[39]_i_24_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_53_n_0 ,\spi_word[39]_i_54_n_0 ,\spi_word[39]_i_55_n_0 ,\spi_word[39]_i_56_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_24_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_57_n_0 ,\spi_word[39]_i_58_n_0 ,\spi_word[39]_i_59_n_0 ,\spi_word[39]_i_60_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_25 
       (.CI(\spi_word_reg[39]_i_61_n_0 ),
        .CO({\NLW_spi_word_reg[39]_i_25_CO_UNCONNECTED [3:1],\spi_word_reg[39]_i_25_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_spi_word_reg[39]_i_25_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\spi_word[39]_i_62_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_26 
       (.CI(\spi_word_reg[39]_i_63_n_0 ),
        .CO({\NLW_spi_word_reg[39]_i_26_CO_UNCONNECTED [3:1],oled_data410_in}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_spi_word_reg[39]_i_26_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\spi_word[39]_i_64_n_0 }));
  CARRY4 \spi_word_reg[39]_i_27 
       (.CI(\spi_word_reg[39]_i_22_n_0 ),
        .CO({\NLW_spi_word_reg[39]_i_27_CO_UNCONNECTED [3],\spi_word_reg[39]_i_27_n_1 ,\NLW_spi_word_reg[39]_i_27_CO_UNCONNECTED [1:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\spi_word[39]_i_65_n_0 }),
        .O({\NLW_spi_word_reg[39]_i_27_O_UNCONNECTED [3:2],\spi_word_reg[39]_i_27_n_6 ,\spi_word_reg[39]_i_27_n_7 }),
        .S({1'b0,1'b1,\spi_word[39]_i_66_n_0 ,\spi_word[39]_i_67_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_32 
       (.CI(\spi_word_reg[39]_i_69_n_0 ),
        .CO({\spi_word_reg[39]_i_32_n_0 ,\NLW_spi_word_reg[39]_i_32_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\c_offset_zero_reg[7] [7],\spi_word[39]_i_70_n_0 ,\spi_word[39]_i_71_n_0 ,\spi_word[39]_i_72_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_32_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_73_n_0 ,\spi_word[39]_i_74_n_0 ,\spi_word[39]_i_75_n_0 ,\spi_word[39]_i_76_n_0 }));
  CARRY4 \spi_word_reg[39]_i_42 
       (.CI(\spi_word_reg[39]_i_77_n_0 ),
        .CO({\spi_word_reg[39]_i_42_n_0 ,\NLW_spi_word_reg[39]_i_42_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_78_n_0 ,\spi_word[39]_i_79_n_0 ,\spi_word[39]_i_80_n_0 ,\spi_word[39]_i_81_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_42_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_82_n_0 ,\spi_word[39]_i_83_n_0 ,\spi_word[39]_i_84_n_0 ,\spi_word[39]_i_85_n_0 }));
  CARRY4 \spi_word_reg[39]_i_51 
       (.CI(\spi_word_reg[39]_i_90_n_0 ),
        .CO(\NLW_spi_word_reg[39]_i_51_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,\spi_word_reg[39]_i_27_n_7 ,\spi_word_reg[39]_i_22_n_4 ,\spi_word_reg[39]_i_22_n_5 }),
        .O({\spi_word_reg[39]_i_51_n_4 ,\spi_word_reg[39]_i_51_n_5 ,\spi_word_reg[39]_i_51_n_6 ,\spi_word_reg[39]_i_51_n_7 }),
        .S({\spi_word[39]_i_91_n_0 ,\spi_word[39]_i_92_n_0 ,\spi_word[39]_i_93_n_0 ,\spi_word[39]_i_94_n_0 }));
  CARRY4 \spi_word_reg[39]_i_52 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_52_n_0 ,\NLW_spi_word_reg[39]_i_52_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_95_n_0 ,\spi_word[39]_i_96_n_0 ,\spi_word[39]_i_97_n_0 ,1'b0}),
        .O(\NLW_spi_word_reg[39]_i_52_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_98_n_0 ,\spi_word[39]_i_99_n_0 ,\spi_word[39]_i_100_n_0 ,\spi_word[39]_i_101_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_61 
       (.CI(\spi_word_reg[39]_i_102_n_0 ),
        .CO({\spi_word_reg[39]_i_61_n_0 ,\NLW_spi_word_reg[39]_i_61_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\c_offset_zero_reg[7] [7],\spi_word[39]_i_103_n_0 ,\spi_word[39]_i_71_n_0 ,\spi_word[39]_i_104_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_61_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_105_n_0 ,\spi_word[39]_i_106_n_0 ,\spi_word[39]_i_107_n_0 ,\spi_word[39]_i_108_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_63 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_63_n_0 ,\NLW_spi_word_reg[39]_i_63_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI({\spi_word[39]_i_109_n_0 ,\spi_word[39]_i_110_n_0 ,\spi_word[39]_i_111_n_0 ,\spi_word[39]_i_112_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_63_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_113_n_0 ,\spi_word[39]_i_114_n_0 ,\spi_word[39]_i_115_n_0 ,\spi_word[39]_i_116_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \spi_word_reg[39]_i_69 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_69_n_0 ,\NLW_spi_word_reg[39]_i_69_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_118_n_0 ,\spi_word[39]_i_119_n_0 ,\c_offset_zero_reg[7] [1],\spi_word_reg[35]_i_12_n_7 }),
        .O(\NLW_spi_word_reg[39]_i_69_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_120_n_0 ,\spi_word[39]_i_121_n_0 ,\spi_word[39]_i_122_n_0 ,\spi_word[39]_i_123_n_0 }));
  CARRY4 \spi_word_reg[39]_i_77 
       (.CI(\spi_word_reg[39]_i_124_n_0 ),
        .CO({\spi_word_reg[39]_i_77_n_0 ,\NLW_spi_word_reg[39]_i_77_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word[39]_i_125_n_0 ,\spi_word[39]_i_126_n_0 ,\spi_word[39]_i_127_n_0 ,\FSM_onehot_state[15]_i_4_n_0 }),
        .O(\NLW_spi_word_reg[39]_i_77_O_UNCONNECTED [3:0]),
        .S({\spi_word[39]_i_128_n_0 ,\spi_word[39]_i_129_n_0 ,\spi_word[39]_i_130_n_0 ,\spi_word[39]_i_131_n_0 }));
  CARRY4 \spi_word_reg[39]_i_90 
       (.CI(1'b0),
        .CO({\spi_word_reg[39]_i_90_n_0 ,\NLW_spi_word_reg[39]_i_90_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\spi_word_reg[39]_i_22_n_6 ,\spi_word_reg[39]_i_22_n_7 ,1'b0,1'b1}),
        .O({\spi_word_reg[39]_i_90_n_4 ,\spi_word_reg[39]_i_90_n_5 ,\spi_word_reg[39]_i_90_n_6 ,\spi_word_reg[39]_i_90_n_7 }),
        .S({\spi_word[39]_i_139_n_0 ,\spi_word[39]_i_140_n_0 ,\spi_word[39]_i_141_n_0 ,\spi_word_reg[39]_i_22_n_7 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[3]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[3] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[4]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[4] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[5]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[5] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[6]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[6] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[7]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[7] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[8]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[8] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(\spi_word[9]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[9] ),
        .R(\spi_word[39]_i_1_n_0 ));
endmodule

(* CHAR_HEIGHT = "12" *) (* CHAR_THICKNESS = "2" *) (* CHAR_WIDTH = "7" *) 
(* ECO_CHECKSUM = "27c966a1" *) 
(* NotValidForBitStream *)
module Top_Student
   (clk,
    btnU,
    JB,
    led0);
  input clk;
  input btnU;
  output [7:0]JB;
  output led0;

  wire [7:0]JB;
  wire [7:0]JB_OBUF;
  wire btnU;
  wire btnU_IBUF;
  wire c_offset_zero;
  wire \c_offset_zero[0]_i_1_n_0 ;
  wire \c_offset_zero[4]_i_2_n_0 ;
  wire \c_offset_zero[4]_i_3_n_0 ;
  wire \c_offset_zero[4]_i_4_n_0 ;
  wire \c_offset_zero[4]_i_5_n_0 ;
  wire \c_offset_zero[4]_i_6_n_0 ;
  wire \c_offset_zero[4]_i_7_n_0 ;
  wire \c_offset_zero[7]_i_2_n_0 ;
  wire \c_offset_zero[7]_i_3_n_0 ;
  wire \c_offset_zero[7]_i_4_n_0 ;
  wire \c_offset_zero_reg[4]_i_1_n_0 ;
  wire \c_offset_zero_reg[4]_i_1_n_4 ;
  wire \c_offset_zero_reg[4]_i_1_n_5 ;
  wire \c_offset_zero_reg[4]_i_1_n_6 ;
  wire \c_offset_zero_reg[4]_i_1_n_7 ;
  wire \c_offset_zero_reg[7]_i_1_n_5 ;
  wire \c_offset_zero_reg[7]_i_1_n_6 ;
  wire \c_offset_zero_reg[7]_i_1_n_7 ;
  wire [7:0]c_offset_zero_reg__0;
  wire clear;
  wire clk;
  wire clk_6p25MHz;
  wire clk_6p25MHz_BUFG;
  wire clk_6p25MHz_i_1_n_0;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire \counter_6p25mhz[0]_i_1_n_0 ;
  wire \counter_6p25mhz[1]_i_1_n_0 ;
  wire \counter_6p25mhz[2]_i_1_n_0 ;
  wire \counter_6p25mhz[3]_i_1_n_0 ;
  wire \counter_6p25mhz[4]_i_2_n_0 ;
  wire [4:0]counter_6p25mhz_reg__0;
  wire [2:0]counter_frames_seven;
  wire \counter_frames_seven[0]_i_1_n_0 ;
  wire \counter_frames_seven[1]_i_1_n_0 ;
  wire \counter_frames_seven[2]_i_1_n_0 ;
  wire [1:1]counter_frames_zero;
  wire \counter_frames_zero[0]_i_1_n_0 ;
  wire \counter_frames_zero[1]_i_1_n_0 ;
  wire [0:0]counter_frames_zero__0;
  wire disp_n_7;
  wire disp_n_8;
  wire disp_n_9;
  wire led0;
  wire \offset_seven[6]_i_2_n_0 ;
  wire \offset_seven[7]_i_3_n_0 ;
  wire \offset_seven[7]_i_4_n_0 ;
  wire [7:0]offset_seven_reg__0;
  wire \offset_zero[1]_i_1_n_0 ;
  wire \offset_zero[4]_i_1_n_0 ;
  wire \offset_zero[5]_i_1_n_0 ;
  wire \offset_zero[6]_i_3_n_0 ;
  wire \offset_zero[6]_i_4_n_0 ;
  wire \offset_zero[7]_i_1_n_0 ;
  wire \offset_zero[7]_i_2_n_0 ;
  wire [7:0]offset_zero_reg__0;
  wire oled_frame_begin;
  wire oled_frame_begin_BUFG;
  wire [7:0]p_0_in;
  wire [7:0]p_0_in__1;
  wire [6:0]p_0_in__2;
  wire r_offset_seven;
  wire \r_offset_seven[4]_i_3_n_0 ;
  wire \r_offset_seven[4]_i_4_n_0 ;
  wire \r_offset_seven[4]_i_5_n_0 ;
  wire \r_offset_seven[4]_i_6_n_0 ;
  wire \r_offset_seven[4]_i_7_n_0 ;
  wire \r_offset_seven[7]_i_2_n_0 ;
  wire \r_offset_seven[7]_i_3_n_0 ;
  wire \r_offset_seven[7]_i_4_n_0 ;
  wire \r_offset_seven_reg[4]_i_1_n_0 ;
  wire \r_offset_seven_reg[4]_i_1_n_4 ;
  wire \r_offset_seven_reg[4]_i_1_n_5 ;
  wire \r_offset_seven_reg[4]_i_1_n_6 ;
  wire \r_offset_seven_reg[4]_i_1_n_7 ;
  wire \r_offset_seven_reg[7]_i_1_n_5 ;
  wire \r_offset_seven_reg[7]_i_1_n_6 ;
  wire \r_offset_seven_reg[7]_i_1_n_7 ;
  wire [7:0]r_offset_seven_reg__0;
  wire \spi_word[35]_i_42_n_0 ;
  wire \spi_word[35]_i_65_n_0 ;
  wire \spi_word[35]_i_66_n_0 ;
  wire \spi_word_reg[35]_i_43_n_5 ;
  wire \spi_word_reg[35]_i_43_n_6 ;
  wire \spi_word_reg[35]_i_43_n_7 ;
  wire [2:0]\NLW_c_offset_zero_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_c_offset_zero_reg[7]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_c_offset_zero_reg[7]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_r_offset_seven_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_r_offset_seven_reg[7]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_r_offset_seven_reg[7]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_spi_word_reg[35]_i_43_CO_UNCONNECTED ;
  wire [3:3]\NLW_spi_word_reg[35]_i_43_O_UNCONNECTED ;

  OBUF \JB_OBUF[0]_inst 
       (.I(JB_OBUF[0]),
        .O(JB[0]));
  OBUF \JB_OBUF[1]_inst 
       (.I(JB_OBUF[1]),
        .O(JB[1]));
  OBUFT \JB_OBUF[2]_inst 
       (.I(1'b0),
        .O(JB[2]),
        .T(1'b1));
  OBUF \JB_OBUF[3]_inst 
       (.I(JB_OBUF[3]),
        .O(JB[3]));
  OBUF \JB_OBUF[4]_inst 
       (.I(JB_OBUF[4]),
        .O(JB[4]));
  OBUF \JB_OBUF[5]_inst 
       (.I(JB_OBUF[5]),
        .O(JB[5]));
  OBUF \JB_OBUF[6]_inst 
       (.I(JB_OBUF[6]),
        .O(JB[6]));
  OBUF \JB_OBUF[7]_inst 
       (.I(JB_OBUF[7]),
        .O(JB[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \JB_OBUF[7]_inst_i_1 
       (.I0(btnU_IBUF),
        .O(JB_OBUF[7]));
  IBUF btnU_IBUF_inst
       (.I(btnU),
        .O(btnU_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \c_offset_zero[0]_i_1 
       (.I0(c_offset_zero_reg__0[0]),
        .O(\c_offset_zero[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \c_offset_zero[4]_i_2 
       (.I0(c_offset_zero_reg__0[1]),
        .O(\c_offset_zero[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[4]_i_3 
       (.I0(c_offset_zero_reg__0[3]),
        .I1(c_offset_zero_reg__0[4]),
        .O(\c_offset_zero[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[4]_i_4 
       (.I0(c_offset_zero_reg__0[2]),
        .I1(c_offset_zero_reg__0[3]),
        .O(\c_offset_zero[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[4]_i_5 
       (.I0(c_offset_zero_reg__0[1]),
        .I1(c_offset_zero_reg__0[2]),
        .O(\c_offset_zero[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h55A6)) 
    \c_offset_zero[4]_i_6 
       (.I0(c_offset_zero_reg__0[1]),
        .I1(offset_zero_reg__0[6]),
        .I2(\c_offset_zero[4]_i_7_n_0 ),
        .I3(offset_zero_reg__0[7]),
        .O(\c_offset_zero[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h1515151515151555)) 
    \c_offset_zero[4]_i_7 
       (.I0(offset_zero_reg__0[5]),
        .I1(offset_zero_reg__0[3]),
        .I2(offset_zero_reg__0[4]),
        .I3(offset_zero_reg__0[0]),
        .I4(offset_zero_reg__0[2]),
        .I5(offset_zero_reg__0[1]),
        .O(\c_offset_zero[4]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[7]_i_2 
       (.I0(c_offset_zero_reg__0[6]),
        .I1(c_offset_zero_reg__0[7]),
        .O(\c_offset_zero[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[7]_i_3 
       (.I0(c_offset_zero_reg__0[5]),
        .I1(c_offset_zero_reg__0[6]),
        .O(\c_offset_zero[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \c_offset_zero[7]_i_4 
       (.I0(c_offset_zero_reg__0[4]),
        .I1(c_offset_zero_reg__0[5]),
        .O(\c_offset_zero[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero[0]_i_1_n_0 ),
        .Q(c_offset_zero_reg__0[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[4]_i_1_n_7 ),
        .Q(c_offset_zero_reg__0[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[2] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[4]_i_1_n_6 ),
        .Q(c_offset_zero_reg__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[3] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[4]_i_1_n_5 ),
        .Q(c_offset_zero_reg__0[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[4] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[4]_i_1_n_4 ),
        .Q(c_offset_zero_reg__0[4]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \c_offset_zero_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\c_offset_zero_reg[4]_i_1_n_0 ,\NLW_c_offset_zero_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(c_offset_zero_reg__0[0]),
        .DI({c_offset_zero_reg__0[3:1],\c_offset_zero[4]_i_2_n_0 }),
        .O({\c_offset_zero_reg[4]_i_1_n_4 ,\c_offset_zero_reg[4]_i_1_n_5 ,\c_offset_zero_reg[4]_i_1_n_6 ,\c_offset_zero_reg[4]_i_1_n_7 }),
        .S({\c_offset_zero[4]_i_3_n_0 ,\c_offset_zero[4]_i_4_n_0 ,\c_offset_zero[4]_i_5_n_0 ,\c_offset_zero[4]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[5] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[7]_i_1_n_7 ),
        .Q(c_offset_zero_reg__0[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[6] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[7]_i_1_n_6 ),
        .Q(c_offset_zero_reg__0[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \c_offset_zero_reg[7] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\c_offset_zero_reg[7]_i_1_n_5 ),
        .Q(c_offset_zero_reg__0[7]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \c_offset_zero_reg[7]_i_1 
       (.CI(\c_offset_zero_reg[4]_i_1_n_0 ),
        .CO(\NLW_c_offset_zero_reg[7]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,c_offset_zero_reg__0[5:4]}),
        .O({\NLW_c_offset_zero_reg[7]_i_1_O_UNCONNECTED [3],\c_offset_zero_reg[7]_i_1_n_5 ,\c_offset_zero_reg[7]_i_1_n_6 ,\c_offset_zero_reg[7]_i_1_n_7 }),
        .S({1'b0,\c_offset_zero[7]_i_2_n_0 ,\c_offset_zero[7]_i_3_n_0 ,\c_offset_zero[7]_i_4_n_0 }));
  BUFG clk_6p25MHz_BUFG_inst
       (.I(clk_6p25MHz),
        .O(clk_6p25MHz_BUFG));
  LUT6 #(
    .INIT(64'hFFFF7FFF00008000)) 
    clk_6p25MHz_i_1
       (.I0(counter_6p25mhz_reg__0[0]),
        .I1(counter_6p25mhz_reg__0[2]),
        .I2(counter_6p25mhz_reg__0[1]),
        .I3(counter_6p25mhz_reg__0[3]),
        .I4(counter_6p25mhz_reg__0[4]),
        .I5(clk_6p25MHz),
        .O(clk_6p25MHz_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    clk_6p25MHz_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(clk_6p25MHz_i_1_n_0),
        .Q(clk_6p25MHz),
        .R(1'b0));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \counter_6p25mhz[0]_i_1 
       (.I0(counter_6p25mhz_reg__0[0]),
        .O(\counter_6p25mhz[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_6p25mhz[1]_i_1 
       (.I0(counter_6p25mhz_reg__0[0]),
        .I1(counter_6p25mhz_reg__0[1]),
        .O(\counter_6p25mhz[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \counter_6p25mhz[2]_i_1 
       (.I0(counter_6p25mhz_reg__0[0]),
        .I1(counter_6p25mhz_reg__0[1]),
        .I2(counter_6p25mhz_reg__0[2]),
        .O(\counter_6p25mhz[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \counter_6p25mhz[3]_i_1 
       (.I0(counter_6p25mhz_reg__0[1]),
        .I1(counter_6p25mhz_reg__0[0]),
        .I2(counter_6p25mhz_reg__0[2]),
        .I3(counter_6p25mhz_reg__0[3]),
        .O(\counter_6p25mhz[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h40000000)) 
    \counter_6p25mhz[4]_i_1 
       (.I0(counter_6p25mhz_reg__0[4]),
        .I1(counter_6p25mhz_reg__0[3]),
        .I2(counter_6p25mhz_reg__0[1]),
        .I3(counter_6p25mhz_reg__0[2]),
        .I4(counter_6p25mhz_reg__0[0]),
        .O(clear));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \counter_6p25mhz[4]_i_2 
       (.I0(counter_6p25mhz_reg__0[2]),
        .I1(counter_6p25mhz_reg__0[0]),
        .I2(counter_6p25mhz_reg__0[1]),
        .I3(counter_6p25mhz_reg__0[3]),
        .I4(counter_6p25mhz_reg__0[4]),
        .O(\counter_6p25mhz[4]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_6p25mhz_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_6p25mhz[0]_i_1_n_0 ),
        .Q(counter_6p25mhz_reg__0[0]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \counter_6p25mhz_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_6p25mhz[1]_i_1_n_0 ),
        .Q(counter_6p25mhz_reg__0[1]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \counter_6p25mhz_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_6p25mhz[2]_i_1_n_0 ),
        .Q(counter_6p25mhz_reg__0[2]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \counter_6p25mhz_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_6p25mhz[3]_i_1_n_0 ),
        .Q(counter_6p25mhz_reg__0[3]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \counter_6p25mhz_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_6p25mhz[4]_i_2_n_0 ),
        .Q(counter_6p25mhz_reg__0[4]),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h15)) 
    \counter_frames_seven[0]_i_1 
       (.I0(counter_frames_seven[0]),
        .I1(counter_frames_seven[1]),
        .I2(counter_frames_seven[2]),
        .O(\counter_frames_seven[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \counter_frames_seven[1]_i_1 
       (.I0(counter_frames_seven[0]),
        .I1(counter_frames_seven[1]),
        .I2(counter_frames_seven[2]),
        .O(\counter_frames_seven[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h18)) 
    \counter_frames_seven[2]_i_1 
       (.I0(counter_frames_seven[0]),
        .I1(counter_frames_seven[1]),
        .I2(counter_frames_seven[2]),
        .O(\counter_frames_seven[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_frames_seven_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(1'b1),
        .D(\counter_frames_seven[0]_i_1_n_0 ),
        .Q(counter_frames_seven[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \counter_frames_seven_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(1'b1),
        .D(\counter_frames_seven[1]_i_1_n_0 ),
        .Q(counter_frames_seven[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \counter_frames_seven_reg[2] 
       (.C(oled_frame_begin_BUFG),
        .CE(1'b1),
        .D(\counter_frames_seven[2]_i_1_n_0 ),
        .Q(counter_frames_seven[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \counter_frames_zero[0]_i_1 
       (.I0(counter_frames_zero__0),
        .I1(counter_frames_zero),
        .O(\counter_frames_zero[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \counter_frames_zero[1]_i_1 
       (.I0(counter_frames_zero__0),
        .I1(counter_frames_zero),
        .O(\counter_frames_zero[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_frames_zero_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(1'b1),
        .D(\counter_frames_zero[0]_i_1_n_0 ),
        .Q(counter_frames_zero__0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \counter_frames_zero_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(1'b1),
        .D(\counter_frames_zero[1]_i_1_n_0 ),
        .Q(counter_frames_zero),
        .R(1'b0));
  Oled_Display disp
       (.CLK(clk_6p25MHz_BUFG),
        .JB_OBUF({JB_OBUF[6:3],JB_OBUF[1:0]}),
        .O({disp_n_7,disp_n_8,disp_n_9}),
        .Q(r_offset_seven_reg__0),
        .S(\spi_word[35]_i_42_n_0 ),
        .btnU_IBUF(btnU_IBUF),
        .\c_offset_zero_reg[7] (c_offset_zero_reg__0),
        .clk_6p25MHz(clk_6p25MHz),
        .clk_6p25MHz_reg(clk_6p25MHz_BUFG),
        .\frame_counter_reg[12]_0 ({\spi_word_reg[35]_i_43_n_5 ,\spi_word_reg[35]_i_43_n_6 ,\spi_word_reg[35]_i_43_n_7 }),
        .oled_frame_begin(oled_frame_begin),
        .p_0_in({p_0_in[7],p_0_in[2]}));
  OBUFT led0_OBUF_inst
       (.I(1'b0),
        .O(led0),
        .T(1'b1));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \offset_seven[0]_i_1 
       (.I0(offset_seven_reg__0[0]),
        .O(p_0_in__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \offset_seven[1]_i_1 
       (.I0(offset_seven_reg__0[0]),
        .I1(offset_seven_reg__0[1]),
        .O(p_0_in__1[1]));
  LUT3 #(
    .INIT(8'h6A)) 
    \offset_seven[2]_i_1 
       (.I0(offset_seven_reg__0[2]),
        .I1(offset_seven_reg__0[1]),
        .I2(offset_seven_reg__0[0]),
        .O(p_0_in__1[2]));
  LUT5 #(
    .INIT(32'h4555AAAA)) 
    \offset_seven[3]_i_1 
       (.I0(offset_seven_reg__0[3]),
        .I1(offset_seven_reg__0[4]),
        .I2(offset_seven_reg__0[6]),
        .I3(offset_seven_reg__0[5]),
        .I4(\offset_seven[6]_i_2_n_0 ),
        .O(p_0_in__1[3]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \offset_seven[4]_i_1 
       (.I0(offset_seven_reg__0[4]),
        .I1(offset_seven_reg__0[2]),
        .I2(offset_seven_reg__0[1]),
        .I3(offset_seven_reg__0[0]),
        .I4(offset_seven_reg__0[3]),
        .O(p_0_in__1[4]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'h6788FF00)) 
    \offset_seven[5]_i_1 
       (.I0(offset_seven_reg__0[3]),
        .I1(offset_seven_reg__0[4]),
        .I2(offset_seven_reg__0[6]),
        .I3(offset_seven_reg__0[5]),
        .I4(\offset_seven[6]_i_2_n_0 ),
        .O(p_0_in__1[5]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'h68F0F0F0)) 
    \offset_seven[6]_i_1 
       (.I0(offset_seven_reg__0[3]),
        .I1(offset_seven_reg__0[4]),
        .I2(offset_seven_reg__0[6]),
        .I3(offset_seven_reg__0[5]),
        .I4(\offset_seven[6]_i_2_n_0 ),
        .O(p_0_in__1[6]));
  LUT3 #(
    .INIT(8'h80)) 
    \offset_seven[6]_i_2 
       (.I0(offset_seven_reg__0[2]),
        .I1(offset_seven_reg__0[1]),
        .I2(offset_seven_reg__0[0]),
        .O(\offset_seven[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000777F0000)) 
    \offset_seven[7]_i_1 
       (.I0(offset_seven_reg__0[5]),
        .I1(offset_seven_reg__0[6]),
        .I2(offset_seven_reg__0[3]),
        .I3(offset_seven_reg__0[4]),
        .I4(\offset_seven[7]_i_3_n_0 ),
        .I5(offset_seven_reg__0[7]),
        .O(r_offset_seven));
  LUT4 #(
    .INIT(16'h8000)) 
    \offset_seven[7]_i_2 
       (.I0(offset_seven_reg__0[5]),
        .I1(offset_seven_reg__0[6]),
        .I2(offset_seven_reg__0[4]),
        .I3(\offset_seven[7]_i_4_n_0 ),
        .O(p_0_in__1[7]));
  LUT3 #(
    .INIT(8'hA8)) 
    \offset_seven[7]_i_3 
       (.I0(counter_frames_seven[2]),
        .I1(counter_frames_seven[1]),
        .I2(counter_frames_seven[0]),
        .O(\offset_seven[7]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \offset_seven[7]_i_4 
       (.I0(offset_seven_reg__0[3]),
        .I1(offset_seven_reg__0[0]),
        .I2(offset_seven_reg__0[1]),
        .I3(offset_seven_reg__0[2]),
        .O(\offset_seven[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[0]),
        .Q(offset_seven_reg__0[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[1]),
        .Q(offset_seven_reg__0[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[2] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[2]),
        .Q(offset_seven_reg__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[3] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[3]),
        .Q(offset_seven_reg__0[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[4] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[4]),
        .Q(offset_seven_reg__0[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[5] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[5]),
        .Q(offset_seven_reg__0[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[6] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[6]),
        .Q(offset_seven_reg__0[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_seven_reg[7] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in__1[7]),
        .Q(offset_seven_reg__0[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \offset_zero[0]_i_1 
       (.I0(offset_zero_reg__0[0]),
        .O(p_0_in__2[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \offset_zero[1]_i_1 
       (.I0(offset_zero_reg__0[0]),
        .I1(offset_zero_reg__0[1]),
        .O(\offset_zero[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \offset_zero[2]_i_1 
       (.I0(offset_zero_reg__0[2]),
        .I1(offset_zero_reg__0[1]),
        .I2(offset_zero_reg__0[0]),
        .O(p_0_in__2[2]));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \offset_zero[3]_i_1 
       (.I0(offset_zero_reg__0[3]),
        .I1(offset_zero_reg__0[0]),
        .I2(offset_zero_reg__0[1]),
        .I3(offset_zero_reg__0[2]),
        .O(p_0_in__2[3]));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \offset_zero[4]_i_1 
       (.I0(offset_zero_reg__0[4]),
        .I1(offset_zero_reg__0[2]),
        .I2(offset_zero_reg__0[1]),
        .I3(offset_zero_reg__0[0]),
        .I4(offset_zero_reg__0[3]),
        .O(\offset_zero[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \offset_zero[5]_i_1 
       (.I0(offset_zero_reg__0[5]),
        .I1(offset_zero_reg__0[4]),
        .I2(offset_zero_reg__0[3]),
        .I3(offset_zero_reg__0[0]),
        .I4(offset_zero_reg__0[1]),
        .I5(offset_zero_reg__0[2]),
        .O(\offset_zero[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h002AAAAAAAAAAAAA)) 
    \offset_zero[6]_i_1 
       (.I0(counter_frames_zero),
        .I1(offset_zero_reg__0[4]),
        .I2(offset_zero_reg__0[5]),
        .I3(offset_zero_reg__0[6]),
        .I4(offset_zero_reg__0[7]),
        .I5(\offset_zero[6]_i_3_n_0 ),
        .O(c_offset_zero));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \offset_zero[6]_i_2 
       (.I0(offset_zero_reg__0[6]),
        .I1(\offset_zero[6]_i_4_n_0 ),
        .I2(offset_zero_reg__0[4]),
        .I3(offset_zero_reg__0[5]),
        .O(p_0_in__2[6]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \offset_zero[6]_i_3 
       (.I0(offset_zero_reg__0[2]),
        .I1(offset_zero_reg__0[1]),
        .I2(offset_zero_reg__0[6]),
        .I3(offset_zero_reg__0[3]),
        .O(\offset_zero[6]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \offset_zero[6]_i_4 
       (.I0(offset_zero_reg__0[3]),
        .I1(offset_zero_reg__0[0]),
        .I2(offset_zero_reg__0[1]),
        .I3(offset_zero_reg__0[2]),
        .O(\offset_zero[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \offset_zero[7]_i_1 
       (.I0(c_offset_zero),
        .I1(offset_zero_reg__0[5]),
        .I2(offset_zero_reg__0[4]),
        .I3(offset_zero_reg__0[7]),
        .I4(offset_zero_reg__0[0]),
        .I5(\offset_zero[6]_i_3_n_0 ),
        .O(\offset_zero[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \offset_zero[7]_i_2 
       (.I0(offset_zero_reg__0[7]),
        .I1(offset_zero_reg__0[5]),
        .I2(offset_zero_reg__0[4]),
        .I3(\offset_zero[6]_i_4_n_0 ),
        .I4(offset_zero_reg__0[6]),
        .O(\offset_zero[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(p_0_in__2[0]),
        .Q(offset_zero_reg__0[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\offset_zero[1]_i_1_n_0 ),
        .Q(offset_zero_reg__0[1]),
        .R(\offset_zero[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[2] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(p_0_in__2[2]),
        .Q(offset_zero_reg__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[3] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(p_0_in__2[3]),
        .Q(offset_zero_reg__0[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[4] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\offset_zero[4]_i_1_n_0 ),
        .Q(offset_zero_reg__0[4]),
        .R(\offset_zero[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[5] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\offset_zero[5]_i_1_n_0 ),
        .Q(offset_zero_reg__0[5]),
        .R(\offset_zero[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[6] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(p_0_in__2[6]),
        .Q(offset_zero_reg__0[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \offset_zero_reg[7] 
       (.C(oled_frame_begin_BUFG),
        .CE(c_offset_zero),
        .D(\offset_zero[7]_i_2_n_0 ),
        .Q(offset_zero_reg__0[7]),
        .R(\offset_zero[7]_i_1_n_0 ));
  BUFG oled_frame_begin_BUFG_inst
       (.I(oled_frame_begin),
        .O(oled_frame_begin_BUFG));
  LUT1 #(
    .INIT(2'h1)) 
    \r_offset_seven[0]_i_1 
       (.I0(r_offset_seven_reg__0[0]),
        .O(p_0_in[0]));
  LUT1 #(
    .INIT(2'h1)) 
    \r_offset_seven[4]_i_2 
       (.I0(r_offset_seven_reg__0[1]),
        .O(p_0_in[1]));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[4]_i_3 
       (.I0(r_offset_seven_reg__0[3]),
        .I1(r_offset_seven_reg__0[4]),
        .O(\r_offset_seven[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[4]_i_4 
       (.I0(r_offset_seven_reg__0[2]),
        .I1(r_offset_seven_reg__0[3]),
        .O(\r_offset_seven[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[4]_i_5 
       (.I0(r_offset_seven_reg__0[1]),
        .I1(r_offset_seven_reg__0[2]),
        .O(\r_offset_seven[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h5656565655555556)) 
    \r_offset_seven[4]_i_6 
       (.I0(r_offset_seven_reg__0[1]),
        .I1(offset_seven_reg__0[6]),
        .I2(offset_seven_reg__0[7]),
        .I3(offset_seven_reg__0[3]),
        .I4(offset_seven_reg__0[2]),
        .I5(\r_offset_seven[4]_i_7_n_0 ),
        .O(\r_offset_seven[4]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \r_offset_seven[4]_i_7 
       (.I0(offset_seven_reg__0[4]),
        .I1(offset_seven_reg__0[5]),
        .O(\r_offset_seven[4]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[7]_i_2 
       (.I0(r_offset_seven_reg__0[6]),
        .I1(r_offset_seven_reg__0[7]),
        .O(\r_offset_seven[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[7]_i_3 
       (.I0(r_offset_seven_reg__0[5]),
        .I1(r_offset_seven_reg__0[6]),
        .O(\r_offset_seven[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r_offset_seven[7]_i_4 
       (.I0(r_offset_seven_reg__0[4]),
        .I1(r_offset_seven_reg__0[5]),
        .O(\r_offset_seven[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[0] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(p_0_in[0]),
        .Q(r_offset_seven_reg__0[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[1] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[4]_i_1_n_7 ),
        .Q(r_offset_seven_reg__0[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[2] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[4]_i_1_n_6 ),
        .Q(r_offset_seven_reg__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[3] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[4]_i_1_n_5 ),
        .Q(r_offset_seven_reg__0[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[4] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[4]_i_1_n_4 ),
        .Q(r_offset_seven_reg__0[4]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \r_offset_seven_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\r_offset_seven_reg[4]_i_1_n_0 ,\NLW_r_offset_seven_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(r_offset_seven_reg__0[0]),
        .DI({r_offset_seven_reg__0[3:1],p_0_in[1]}),
        .O({\r_offset_seven_reg[4]_i_1_n_4 ,\r_offset_seven_reg[4]_i_1_n_5 ,\r_offset_seven_reg[4]_i_1_n_6 ,\r_offset_seven_reg[4]_i_1_n_7 }),
        .S({\r_offset_seven[4]_i_3_n_0 ,\r_offset_seven[4]_i_4_n_0 ,\r_offset_seven[4]_i_5_n_0 ,\r_offset_seven[4]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[5] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[7]_i_1_n_7 ),
        .Q(r_offset_seven_reg__0[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[6] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[7]_i_1_n_6 ),
        .Q(r_offset_seven_reg__0[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_offset_seven_reg[7] 
       (.C(oled_frame_begin_BUFG),
        .CE(r_offset_seven),
        .D(\r_offset_seven_reg[7]_i_1_n_5 ),
        .Q(r_offset_seven_reg__0[7]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \r_offset_seven_reg[7]_i_1 
       (.CI(\r_offset_seven_reg[4]_i_1_n_0 ),
        .CO(\NLW_r_offset_seven_reg[7]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,r_offset_seven_reg__0[5:4]}),
        .O({\NLW_r_offset_seven_reg[7]_i_1_O_UNCONNECTED [3],\r_offset_seven_reg[7]_i_1_n_5 ,\r_offset_seven_reg[7]_i_1_n_6 ,\r_offset_seven_reg[7]_i_1_n_7 }),
        .S({1'b0,\r_offset_seven[7]_i_2_n_0 ,\r_offset_seven[7]_i_3_n_0 ,\r_offset_seven[7]_i_4_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[35]_i_40 
       (.I0(r_offset_seven_reg__0[7]),
        .O(p_0_in[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[35]_i_42 
       (.I0(r_offset_seven_reg__0[7]),
        .O(\spi_word[35]_i_42_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \spi_word[35]_i_65 
       (.I0(disp_n_9),
        .I1(disp_n_7),
        .O(\spi_word[35]_i_65_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[35]_i_66 
       (.I0(disp_n_8),
        .O(\spi_word[35]_i_66_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \spi_word[35]_i_77 
       (.I0(r_offset_seven_reg__0[2]),
        .O(p_0_in[2]));
  CARRY4 \spi_word_reg[35]_i_43 
       (.CI(1'b0),
        .CO(\NLW_spi_word_reg[35]_i_43_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\NLW_spi_word_reg[35]_i_43_O_UNCONNECTED [3],\spi_word_reg[35]_i_43_n_5 ,\spi_word_reg[35]_i_43_n_6 ,\spi_word_reg[35]_i_43_n_7 }),
        .S({1'b0,\spi_word[35]_i_65_n_0 ,\spi_word[35]_i_66_n_0 ,disp_n_9}));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
