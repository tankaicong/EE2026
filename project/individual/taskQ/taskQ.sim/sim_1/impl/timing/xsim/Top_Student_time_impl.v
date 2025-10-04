// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Fri Oct  3 17:06:18 2025
// Host        : DESKTOP-2GF0LO4 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/joelk/Documents/ee_files/proj_lab/FDP.sim/sim_1/impl/timing/xsim/Top_Student_time_impl.v
// Design      : Top_Student
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module Oled_Display
   (JC_OBUF,
    spi_busy__4,
    D,
    O,
    CO,
    \pixel_data_reg[4] ,
    CLK,
    scr_clk_BUFG,
    screen_reg,
    \FSM_onehot_state_reg[13]_0 ,
    \FSM_onehot_state_reg[13]_1 ,
    Q,
    \frame_buff_reg[28][86][15] ,
    \frame_buff_reg[28][57][15] ,
    \frame_buff_reg[28][28][15] ,
    \frame_counter_reg[13]_0 );
  output [4:0]JC_OBUF;
  output spi_busy__4;
  output [2:0]D;
  output [1:0]O;
  output [0:0]CO;
  output [3:0]\pixel_data_reg[4] ;
  output CLK;
  input scr_clk_BUFG;
  input screen_reg;
  input \FSM_onehot_state_reg[13]_0 ;
  input [3:0]\FSM_onehot_state_reg[13]_1 ;
  input [2:0]Q;
  input [2:0]\frame_buff_reg[28][86][15] ;
  input [2:0]\frame_buff_reg[28][57][15] ;
  input [2:0]\frame_buff_reg[28][28][15] ;
  input [3:0]\frame_counter_reg[13]_0 ;

  wire CLK;
  wire [0:0]CO;
  wire [2:0]D;
  wire \FSM_onehot_state[13]_i_1_n_0 ;
  wire \FSM_onehot_state[13]_i_2_n_0 ;
  wire \FSM_onehot_state[13]_i_3_n_0 ;
  wire \FSM_onehot_state[13]_i_4_n_0 ;
  wire \FSM_onehot_state[15]_i_1_n_0 ;
  wire \FSM_onehot_state[15]_i_2_n_0 ;
  wire \FSM_onehot_state[15]_i_3_n_0 ;
  wire \FSM_onehot_state[15]_i_4_n_0 ;
  wire \FSM_onehot_state[15]_i_5_n_0 ;
  wire \FSM_onehot_state[31]_i_1_n_0 ;
  wire \FSM_onehot_state[31]_i_3_n_0 ;
  wire \FSM_onehot_state[31]_i_4_n_0 ;
  wire \FSM_onehot_state[31]_i_5_n_0 ;
  wire \FSM_onehot_state[31]_i_6_n_0 ;
  wire \FSM_onehot_state[9]_i_1_n_0 ;
  wire \FSM_onehot_state_reg[13]_0 ;
  wire [3:0]\FSM_onehot_state_reg[13]_1 ;
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
  wire [4:0]JC_OBUF;
  wire \JC_OBUF[6]_inst_i_2_n_0 ;
  wire [1:0]O;
  wire [2:0]Q;
  wire [16:1]data0;
  wire [0:0]data0__0;
  wire [14:6]delay;
  wire \delay[0]_i_10_n_0 ;
  wire \delay[0]_i_11_n_0 ;
  wire \delay[0]_i_13_n_0 ;
  wire \delay[0]_i_14_n_0 ;
  wire \delay[0]_i_1_n_0 ;
  wire \delay[0]_i_4_n_0 ;
  wire \delay[0]_i_5_n_0 ;
  wire \delay[0]_i_6_n_0 ;
  wire \delay[0]_i_7_n_0 ;
  wire \delay[0]_i_8_n_0 ;
  wire \delay[0]_i_9_n_0 ;
  wire \delay[12]_i_2_n_0 ;
  wire \delay[12]_i_3_n_0 ;
  wire \delay[12]_i_4_n_0 ;
  wire \delay[12]_i_5_n_0 ;
  wire \delay[12]_i_6_n_0 ;
  wire \delay[12]_i_7_n_0 ;
  wire \delay[12]_i_8_n_0 ;
  wire \delay[12]_i_9_n_0 ;
  wire \delay[16]_i_2_n_0 ;
  wire \delay[16]_i_3_n_0 ;
  wire \delay[16]_i_4_n_0 ;
  wire \delay[16]_i_5_n_0 ;
  wire \delay[16]_i_6_n_0 ;
  wire \delay[16]_i_7_n_0 ;
  wire \delay[16]_i_8_n_0 ;
  wire \delay[16]_i_9_n_0 ;
  wire \delay[4]_i_2_n_0 ;
  wire \delay[4]_i_3_n_0 ;
  wire \delay[4]_i_4_n_0 ;
  wire \delay[4]_i_5_n_0 ;
  wire \delay[4]_i_6_n_0 ;
  wire \delay[4]_i_7_n_0 ;
  wire \delay[4]_i_8_n_0 ;
  wire \delay[4]_i_9_n_0 ;
  wire \delay[8]_i_2_n_0 ;
  wire \delay[8]_i_3_n_0 ;
  wire \delay[8]_i_4_n_0 ;
  wire \delay[8]_i_5_n_0 ;
  wire \delay[8]_i_6_n_0 ;
  wire \delay[8]_i_7_n_0 ;
  wire \delay[8]_i_8_n_0 ;
  wire \delay[8]_i_9_n_0 ;
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
  wire [15:4]frame_buff;
  wire [2:0]\frame_buff_reg[28][28][15] ;
  wire [2:0]\frame_buff_reg[28][57][15] ;
  wire [2:0]\frame_buff_reg[28][86][15] ;
  wire frame_counter1_carry__0_n_0;
  wire frame_counter1_carry__1_n_0;
  wire frame_counter1_carry_n_0;
  wire \frame_counter[16]_i_1_n_0 ;
  wire \frame_counter[16]_i_2_n_0 ;
  wire \frame_counter[16]_i_3_n_0 ;
  wire \frame_counter[16]_i_4_n_0 ;
  wire \frame_counter[16]_i_5_n_0 ;
  wire [3:0]\frame_counter_reg[13]_0 ;
  wire \frame_counter_reg_n_0_[0] ;
  wire \frame_counter_reg_n_0_[1] ;
  wire \frame_counter_reg_n_0_[2] ;
  wire \frame_counter_reg_n_0_[3] ;
  wire [4:0]fsm_next_state__72;
  wire [5:3]p_0_in;
  wire [12:0]p_0_in_0;
  wire p_0_in__0;
  wire p_1_in;
  (* RTL_KEEP = "yes" *) wire p_2_in;
  (* RTL_KEEP = "yes" *) wire p_3_in;
  (* RTL_KEEP = "yes" *) wire p_4_in;
  wire \pixel_data[10]_i_2_n_0 ;
  wire \pixel_data[10]_i_3_n_0 ;
  wire \pixel_data[10]_i_5_n_0 ;
  wire \pixel_data[15]_i_100_n_0 ;
  wire \pixel_data[15]_i_101_n_0 ;
  wire \pixel_data[15]_i_102_n_0 ;
  wire \pixel_data[15]_i_103_n_0 ;
  wire \pixel_data[15]_i_104_n_0 ;
  wire \pixel_data[15]_i_105_n_0 ;
  wire \pixel_data[15]_i_106_n_0 ;
  wire \pixel_data[15]_i_10_n_0 ;
  wire \pixel_data[15]_i_11_n_0 ;
  wire \pixel_data[15]_i_12_n_0 ;
  wire \pixel_data[15]_i_15_n_0 ;
  wire \pixel_data[15]_i_16_n_0 ;
  wire \pixel_data[15]_i_23_n_0 ;
  wire \pixel_data[15]_i_26_n_0 ;
  wire \pixel_data[15]_i_27_n_0 ;
  wire \pixel_data[15]_i_29_n_0 ;
  wire \pixel_data[15]_i_30_n_0 ;
  wire \pixel_data[15]_i_31_n_0 ;
  wire \pixel_data[15]_i_33_n_0 ;
  wire \pixel_data[15]_i_34_n_0 ;
  wire \pixel_data[15]_i_35_n_0 ;
  wire \pixel_data[15]_i_36_n_0 ;
  wire \pixel_data[15]_i_37_n_0 ;
  wire \pixel_data[15]_i_38_n_0 ;
  wire \pixel_data[15]_i_39_n_0 ;
  wire \pixel_data[15]_i_3_n_0 ;
  wire \pixel_data[15]_i_40_n_0 ;
  wire \pixel_data[15]_i_47_n_0 ;
  wire \pixel_data[15]_i_48_n_0 ;
  wire \pixel_data[15]_i_49_n_0 ;
  wire \pixel_data[15]_i_4_n_0 ;
  wire \pixel_data[15]_i_50_n_0 ;
  wire \pixel_data[15]_i_51_n_0 ;
  wire \pixel_data[15]_i_52_n_0 ;
  wire \pixel_data[15]_i_53_n_0 ;
  wire \pixel_data[15]_i_54_n_0 ;
  wire \pixel_data[15]_i_55_n_0 ;
  wire \pixel_data[15]_i_56_n_0 ;
  wire \pixel_data[15]_i_57_n_0 ;
  wire \pixel_data[15]_i_58_n_0 ;
  wire \pixel_data[15]_i_59_n_0 ;
  wire \pixel_data[15]_i_60_n_0 ;
  wire \pixel_data[15]_i_61_n_0 ;
  wire \pixel_data[15]_i_66_n_0 ;
  wire \pixel_data[15]_i_67_n_0 ;
  wire \pixel_data[15]_i_68_n_0 ;
  wire \pixel_data[15]_i_69_n_0 ;
  wire \pixel_data[15]_i_6_n_0 ;
  wire \pixel_data[15]_i_70_n_0 ;
  wire \pixel_data[15]_i_71_n_0 ;
  wire \pixel_data[15]_i_72_n_0 ;
  wire \pixel_data[15]_i_73_n_0 ;
  wire \pixel_data[15]_i_80_n_0 ;
  wire \pixel_data[15]_i_81_n_0 ;
  wire \pixel_data[15]_i_82_n_0 ;
  wire \pixel_data[15]_i_83_n_0 ;
  wire \pixel_data[15]_i_85_n_0 ;
  wire \pixel_data[15]_i_86_n_0 ;
  wire \pixel_data[15]_i_87_n_0 ;
  wire \pixel_data[15]_i_88_n_0 ;
  wire \pixel_data[15]_i_89_n_0 ;
  wire \pixel_data[15]_i_8_n_0 ;
  wire \pixel_data[15]_i_90_n_0 ;
  wire \pixel_data[15]_i_91_n_0 ;
  wire \pixel_data[15]_i_92_n_0 ;
  wire \pixel_data[15]_i_93_n_0 ;
  wire \pixel_data[15]_i_94_n_0 ;
  wire \pixel_data[15]_i_95_n_0 ;
  wire \pixel_data[15]_i_96_n_0 ;
  wire \pixel_data[15]_i_98_n_0 ;
  wire \pixel_data[15]_i_9_n_0 ;
  wire \pixel_data[4]_i_2_n_0 ;
  wire \pixel_data[4]_i_3_n_0 ;
  wire \pixel_data[4]_i_5_n_0 ;
  wire \pixel_data_reg[15]_i_17_n_0 ;
  wire \pixel_data_reg[15]_i_28_n_0 ;
  wire \pixel_data_reg[15]_i_32_n_0 ;
  wire \pixel_data_reg[15]_i_46_n_0 ;
  wire \pixel_data_reg[15]_i_65_n_0 ;
  wire \pixel_data_reg[15]_i_84_n_0 ;
  wire [3:0]\pixel_data_reg[4] ;
  wire [12:1]pixel_index;
  wire [10:7]pixel_index__0;
  wire scr_clk_BUFG;
  wire screen_reg;
  wire [6:1]sel0;
  wire spi_busy__4;
  wire \spi_word[0]_i_1_n_0 ;
  wire \spi_word[10]_i_1_n_0 ;
  wire \spi_word[11]_i_1_n_0 ;
  wire \spi_word[12]_i_1_n_0 ;
  wire \spi_word[13]_i_1_n_0 ;
  wire \spi_word[14]_i_1_n_0 ;
  wire \spi_word[15]_i_1_n_0 ;
  wire \spi_word[16]_i_1_n_0 ;
  wire \spi_word[17]_i_1_n_0 ;
  wire \spi_word[18]_i_1_n_0 ;
  wire \spi_word[19]_i_1_n_0 ;
  wire \spi_word[1]_i_1_n_0 ;
  wire \spi_word[20]_i_1_n_0 ;
  wire \spi_word[20]_i_2_n_0 ;
  wire \spi_word[20]_i_3_n_0 ;
  wire \spi_word[21]_i_1_n_0 ;
  wire \spi_word[21]_i_2_n_0 ;
  wire \spi_word[22]_i_10_n_0 ;
  wire \spi_word[22]_i_11_n_0 ;
  wire \spi_word[22]_i_12_n_0 ;
  wire \spi_word[22]_i_13_n_0 ;
  wire \spi_word[22]_i_14_n_0 ;
  wire \spi_word[22]_i_15_n_0 ;
  wire \spi_word[22]_i_16_n_0 ;
  wire \spi_word[22]_i_1_n_0 ;
  wire \spi_word[22]_i_3_n_0 ;
  wire \spi_word[22]_i_6_n_0 ;
  wire \spi_word[22]_i_7_n_0 ;
  wire \spi_word[22]_i_8_n_0 ;
  wire \spi_word[22]_i_9_n_0 ;
  wire \spi_word[23]_i_1_n_0 ;
  wire \spi_word[24]_i_1_n_0 ;
  wire \spi_word[25]_i_1_n_0 ;
  wire \spi_word[26]_i_1_n_0 ;
  wire \spi_word[27]_i_1_n_0 ;
  wire \spi_word[28]_i_1_n_0 ;
  wire \spi_word[29]_i_1_n_0 ;
  wire \spi_word[2]_i_1_n_0 ;
  wire \spi_word[30]_i_1_n_0 ;
  wire \spi_word[31]_i_1_n_0 ;
  wire \spi_word[32]_i_1_n_0 ;
  wire \spi_word[33]_i_1_n_0 ;
  wire \spi_word[34]_i_1_n_0 ;
  wire \spi_word[35]_i_1_n_0 ;
  wire \spi_word[36]_i_1_n_0 ;
  wire \spi_word[37]_i_1_n_0 ;
  wire \spi_word[38]_i_1_n_0 ;
  wire \spi_word[39]_i_10_n_0 ;
  wire \spi_word[39]_i_11_n_0 ;
  wire \spi_word[39]_i_12_n_0 ;
  wire \spi_word[39]_i_13_n_0 ;
  wire \spi_word[39]_i_14_n_0 ;
  wire \spi_word[39]_i_15_n_0 ;
  wire \spi_word[39]_i_16_n_0 ;
  wire \spi_word[39]_i_17_n_0 ;
  wire \spi_word[39]_i_1_n_0 ;
  wire \spi_word[39]_i_2_n_0 ;
  wire \spi_word[39]_i_4_n_0 ;
  wire \spi_word[39]_i_7_n_0 ;
  wire \spi_word[39]_i_8_n_0 ;
  wire \spi_word[39]_i_9_n_0 ;
  wire \spi_word[3]_i_1_n_0 ;
  wire \spi_word[4]_i_1_n_0 ;
  wire \spi_word[5]_i_1_n_0 ;
  wire \spi_word[6]_i_1_n_0 ;
  wire \spi_word[7]_i_1_n_0 ;
  wire \spi_word[8]_i_1_n_0 ;
  wire \spi_word[9]_i_1_n_0 ;
  wire [38:14]spi_word__35;
  wire \spi_word_bit_count[0]_i_1_n_0 ;
  wire \spi_word_bit_count[1]_i_1_n_0 ;
  wire \spi_word_bit_count[2]_i_1_n_0 ;
  wire \spi_word_bit_count[3]_i_2_n_0 ;
  wire \spi_word_bit_count[4]_i_2_n_0 ;
  wire \spi_word_bit_count[4]_i_3_n_0 ;
  wire \spi_word_bit_count[5]_i_2_n_0 ;
  wire \spi_word_bit_count[5]_i_3_n_0 ;
  wire [5:0]spi_word_bit_count_reg__0;
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
  wire [3:0]\NLW_pixel_data_reg[15]_i_14_CO_UNCONNECTED ;
  wire [3:2]\NLW_pixel_data_reg[15]_i_14_O_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_17_CO_UNCONNECTED ;
  wire [3:0]\NLW_pixel_data_reg[15]_i_17_O_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_28_CO_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_32_CO_UNCONNECTED ;
  wire [3:0]\NLW_pixel_data_reg[15]_i_32_O_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_46_CO_UNCONNECTED ;
  wire [3:0]\NLW_pixel_data_reg[15]_i_46_O_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_65_CO_UNCONNECTED ;
  wire [3:0]\NLW_pixel_data_reg[15]_i_65_O_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_84_CO_UNCONNECTED ;
  wire [3:0]\NLW_pixel_data_reg[15]_i_84_O_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hFFF88888)) 
    \FSM_onehot_state[13]_i_1 
       (.I0(CLK),
        .I1(p_4_in),
        .I2(\FSM_onehot_state[13]_i_2_n_0 ),
        .I3(\FSM_onehot_state[13]_i_3_n_0 ),
        .I4(JC_OBUF[2]),
        .O(\FSM_onehot_state[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFFFFFFFFFF)) 
    \FSM_onehot_state[13]_i_2 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[10]),
        .I2(p_0_in_0[9]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[0]),
        .I5(p_0_in_0[12]),
        .O(\FSM_onehot_state[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFF)) 
    \FSM_onehot_state[13]_i_3 
       (.I0(p_0_in_0[6]),
        .I1(p_0_in_0[5]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[8]),
        .I4(p_0_in_0[7]),
        .I5(\FSM_onehot_state[13]_i_4_n_0 ),
        .O(\FSM_onehot_state[13]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \FSM_onehot_state[13]_i_4 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[4]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[1]),
        .I4(p_0_in_0[2]),
        .O(\FSM_onehot_state[13]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_state[15]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[19] ),
        .I1(\FSM_onehot_state[15]_i_2_n_0 ),
        .O(\FSM_onehot_state[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \FSM_onehot_state[15]_i_2 
       (.I0(\FSM_onehot_state[15]_i_3_n_0 ),
        .I1(p_0_in_0[11]),
        .I2(p_0_in_0[9]),
        .I3(p_0_in_0[8]),
        .I4(JC_OBUF[2]),
        .I5(\FSM_onehot_state[15]_i_4_n_0 ),
        .O(\FSM_onehot_state[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFF)) 
    \FSM_onehot_state[15]_i_3 
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[4]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[7]),
        .I4(p_0_in_0[6]),
        .I5(\FSM_onehot_state[15]_i_5_n_0 ),
        .O(\FSM_onehot_state[15]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \FSM_onehot_state[15]_i_4 
       (.I0(p_0_in_0[12]),
        .I1(p_0_in_0[10]),
        .I2(JC_OBUF[2]),
        .O(\FSM_onehot_state[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \FSM_onehot_state[15]_i_5 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[3]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[0]),
        .I4(p_0_in_0[1]),
        .O(\FSM_onehot_state[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_onehot_state[31]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(p_1_in),
        .O(\FSM_onehot_state[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFBFF)) 
    \FSM_onehot_state[31]_i_2 
       (.I0(\FSM_onehot_state[31]_i_3_n_0 ),
        .I1(\FSM_onehot_state[31]_i_4_n_0 ),
        .I2(\FSM_onehot_state[31]_i_5_n_0 ),
        .I3(\FSM_onehot_state[31]_i_6_n_0 ),
        .O(p_1_in));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_onehot_state[31]_i_3 
       (.I0(delay_reg[2]),
        .I1(delay_reg[0]),
        .I2(delay_reg[1]),
        .I3(delay_reg[4]),
        .I4(delay_reg[3]),
        .O(\FSM_onehot_state[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \FSM_onehot_state[31]_i_4 
       (.I0(delay_reg[9]),
        .I1(delay_reg[8]),
        .I2(delay_reg[5]),
        .I3(delay_reg[6]),
        .I4(delay_reg[7]),
        .O(\FSM_onehot_state[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_onehot_state[31]_i_5 
       (.I0(delay_reg[12]),
        .I1(delay_reg[10]),
        .I2(delay_reg[11]),
        .I3(delay_reg[14]),
        .I4(delay_reg[13]),
        .O(\FSM_onehot_state[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \FSM_onehot_state[31]_i_6 
       (.I0(delay_reg[18]),
        .I1(delay_reg[19]),
        .I2(delay_reg[15]),
        .I3(delay_reg[16]),
        .I4(delay_reg[17]),
        .O(\FSM_onehot_state[31]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hBA)) 
    \FSM_onehot_state[9]_i_1 
       (.I0(p_3_in),
        .I1(CLK),
        .I2(p_4_in),
        .O(\FSM_onehot_state[9]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[29] ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[10] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[15] ),
        .Q(p_2_in),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[11] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[20] ),
        .Q(\FSM_onehot_state_reg_n_0_[11] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[12] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[11] ),
        .Q(\FSM_onehot_state_reg_n_0_[12] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[13] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[13]_i_1_n_0 ),
        .Q(JC_OBUF[2]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[14] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[12] ),
        .Q(\FSM_onehot_state_reg_n_0_[14] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[15] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[15]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[15] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[16] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[24] ),
        .Q(\FSM_onehot_state_reg_n_0_[16] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[17] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[16] ),
        .Q(\FSM_onehot_state_reg_n_0_[17] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[18] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[17] ),
        .Q(\FSM_onehot_state_reg_n_0_[18] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[19] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[28] ),
        .Q(\FSM_onehot_state_reg_n_0_[19] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[1] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[0] ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[20] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[23] ),
        .Q(\FSM_onehot_state_reg_n_0_[20] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[21] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_state_reg_n_0_[21] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[22] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[21] ),
        .Q(\FSM_onehot_state_reg_n_0_[22] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[23] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(1'b0),
        .Q(\FSM_onehot_state_reg_n_0_[23] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[24] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[25] ),
        .Q(\FSM_onehot_state_reg_n_0_[24] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[25] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[30] ),
        .Q(\FSM_onehot_state_reg_n_0_[25] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[26] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[14] ),
        .Q(\FSM_onehot_state_reg_n_0_[26] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[27] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[26] ),
        .Q(\FSM_onehot_state_reg_n_0_[27] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[28] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_state_reg_n_0_[28] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[29] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[18] ),
        .Q(\FSM_onehot_state_reg_n_0_[29] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[2] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[30] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[22] ),
        .Q(\FSM_onehot_state_reg_n_0_[30] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[31] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[27] ),
        .Q(\FSM_onehot_state_reg_n_0_[31] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[3] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[2] ),
        .Q(\FSM_onehot_state_reg_n_0_[3] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[4] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[5] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_state_reg_n_0_[5] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[6] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_state_reg_n_0_[6] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[7] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state_reg_n_0_[31] ),
        .Q(\FSM_onehot_state_reg_n_0_[7] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[8] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(p_2_in),
        .Q(p_3_in),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "DisablePowerSave:00000000000000000000000000000100,SetContrastC:00000000000000000000000000000001,DisableScrolling:00000000000000000000000000000010,SetMultiplexRatio:00000000000000000000000000100000,SetNormalDisplay:00000000000000000000000010000000,SetRowAddress:00000000000000000000000100000000,SetColAddress:00000000000000000000010000000000,ReleaseReset:00000000000000000000100000000000,WaitNextFrame:00000000000000000000001000000000,EnableDriver:00000000000000000001000000000000,SetVCOMH:00000000000000010000000000000000,SendPixel:00000000000000000010000000000000,SetMasterCurrent:00000000000000100000000000000000,Reset:00000000000100000000000000000000,DisplayOn:00000000000010000000000000000000,SetDisplayClock:00000000001000000000000000000000,PrepareNextFrame:00000000000000001000000000000000,PowerUp:00000000100000000000000000000000,SetPrechargeLevel:00000001000000000000000000000000,SetPhaseAdjust:00000000000000000000000000001000,SetSecondPrechargeC:00000010000000000000000000000000,SetRemapDisplayFormat:00000100000000000000000000000000,VccEn:00010000000000000000000000000000,DisplayOff:00000000000000000100000000000000,SetContrastB:00100000000000000000000000000000,SetSecondPrechargeA:00000000010000000000000000000000,ClearScreen:00000000000000000000000000010000,SetContrastA:00000000000001000000000000000000,SetSecondPrechargeB:01000000000000000000000000000000,SetStartLine:00001000000000000000000000000000,SetMasterConfiguration:00000000000000000000000001000000,SetOffset:10000000000000000000000000000000" *) 
  (* KEEP = "yes" *) 
  (* XILINX_LEGACY_PRIM = "FDE_1" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_state_reg[9] 
       (.C(scr_clk_BUFG),
        .CE(\FSM_onehot_state[31]_i_1_n_0 ),
        .D(\FSM_onehot_state[9]_i_1_n_0 ),
        .Q(p_4_in),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \JC_OBUF[0]_inst_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[3]),
        .I2(spi_word_bit_count_reg__0[4]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[0]),
        .I5(spi_word_bit_count_reg__0[2]),
        .O(JC_OBUF[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \JC_OBUF[1]_inst_i_1 
       (.I0(\spi_word_reg_n_0_[39] ),
        .I1(spi_busy__4),
        .O(JC_OBUF[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \JC_OBUF[3]_inst_i_2 
       (.I0(spi_word_bit_count_reg__0[2]),
        .I1(spi_word_bit_count_reg__0[0]),
        .I2(spi_word_bit_count_reg__0[1]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(spi_word_bit_count_reg__0[5]),
        .O(spi_busy__4));
  LUT1 #(
    .INIT(2'h1)) 
    \JC_OBUF[5]_inst_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[20] ),
        .O(JC_OBUF[3]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \JC_OBUF[6]_inst_i_1 
       (.I0(JC_OBUF[2]),
        .I1(p_4_in),
        .I2(\FSM_onehot_state_reg_n_0_[28] ),
        .I3(\JC_OBUF[6]_inst_i_2_n_0 ),
        .O(JC_OBUF[4]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \JC_OBUF[6]_inst_i_2 
       (.I0(p_2_in),
        .I1(p_3_in),
        .I2(\FSM_onehot_state_reg_n_0_[19] ),
        .I3(\FSM_onehot_state_reg_n_0_[15] ),
        .O(\JC_OBUF[6]_inst_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \delay[0]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .O(\delay[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00100010)) 
    \delay[0]_i_10 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[1]),
        .I5(p_1_in),
        .O(\delay[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF2CEE2CEE)) 
    \delay[0]_i_11 
       (.I0(\delay[0]_i_14_n_0 ),
        .I1(fsm_next_state__72[2]),
        .I2(fsm_next_state__72[4]),
        .I3(\delay[0]_i_13_n_0 ),
        .I4(delay_reg[0]),
        .I5(p_1_in),
        .O(\delay[0]_i_11_n_0 ));
  LUT5 #(
    .INIT(32'h0000C00D)) 
    \delay[0]_i_12 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[2]),
        .I3(fsm_next_state__72[4]),
        .I4(fsm_next_state__72[3]),
        .O(delay[11]));
  LUT2 #(
    .INIT(4'h2)) 
    \delay[0]_i_13 
       (.I0(fsm_next_state__72[0]),
        .I1(fsm_next_state__72[3]),
        .O(\delay[0]_i_13_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \delay[0]_i_14 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[3]),
        .O(\delay[0]_i_14_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[0]_i_4 
       (.I0(delay_reg[3]),
        .I1(p_1_in),
        .I2(delay[11]),
        .O(\delay[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF000000100010)) 
    \delay[0]_i_5 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[2]),
        .I5(p_1_in),
        .O(\delay[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF000000100010)) 
    \delay[0]_i_6 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[1]),
        .I5(p_1_in),
        .O(\delay[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8BBBBB8B8BBB8888)) 
    \delay[0]_i_7 
       (.I0(delay_reg[0]),
        .I1(p_1_in),
        .I2(\delay[0]_i_13_n_0 ),
        .I3(fsm_next_state__72[4]),
        .I4(fsm_next_state__72[2]),
        .I5(\delay[0]_i_14_n_0 ),
        .O(\delay[0]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[0]_i_8 
       (.I0(delay[11]),
        .I1(delay_reg[3]),
        .I2(p_1_in),
        .O(\delay[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00100010)) 
    \delay[0]_i_9 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[2]),
        .I5(p_1_in),
        .O(\delay[0]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h00000845)) 
    \delay[12]_i_10 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[1]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[3]),
        .O(delay[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[12]_i_2 
       (.I0(delay_reg[15]),
        .I1(p_1_in),
        .I2(delay[6]),
        .O(\delay[12]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[12]_i_3 
       (.I0(delay_reg[14]),
        .I1(p_1_in),
        .I2(delay[14]),
        .O(\delay[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8B8888888888888B)) 
    \delay[12]_i_4 
       (.I0(delay_reg[13]),
        .I1(p_1_in),
        .I2(\delay[0]_i_14_n_0 ),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[4]),
        .I5(fsm_next_state__72[0]),
        .O(\delay[12]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[12]_i_5 
       (.I0(p_1_in),
        .I1(delay_reg[12]),
        .O(\delay[12]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[12]_i_6 
       (.I0(delay[6]),
        .I1(delay_reg[15]),
        .I2(p_1_in),
        .O(\delay[12]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[12]_i_7 
       (.I0(delay[14]),
        .I1(delay_reg[14]),
        .I2(p_1_in),
        .O(\delay[12]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00810081)) 
    \delay[12]_i_8 
       (.I0(fsm_next_state__72[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[2]),
        .I3(\delay[0]_i_14_n_0 ),
        .I4(delay_reg[13]),
        .I5(p_1_in),
        .O(\delay[12]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[12]_i_9 
       (.I0(delay_reg[12]),
        .I1(p_1_in),
        .O(\delay[12]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[16]_i_2 
       (.I0(p_1_in),
        .I1(delay_reg[18]),
        .O(\delay[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[16]_i_3 
       (.I0(p_1_in),
        .I1(delay_reg[17]),
        .O(\delay[16]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[16]_i_4 
       (.I0(delay_reg[16]),
        .I1(p_1_in),
        .I2(delay[6]),
        .O(\delay[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00800080)) 
    \delay[16]_i_5 
       (.I0(\delay[16]_i_9_n_0 ),
        .I1(fsm_next_state__72[2]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[3]),
        .I4(delay_reg[19]),
        .I5(p_1_in),
        .O(\delay[16]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[16]_i_6 
       (.I0(delay_reg[18]),
        .I1(p_1_in),
        .O(\delay[16]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[16]_i_7 
       (.I0(delay_reg[17]),
        .I1(p_1_in),
        .O(\delay[16]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[16]_i_8 
       (.I0(delay[6]),
        .I1(delay_reg[16]),
        .I2(p_1_in),
        .O(\delay[16]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[16]_i_9 
       (.I0(fsm_next_state__72[0]),
        .I1(fsm_next_state__72[1]),
        .O(\delay[16]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h50000001)) 
    \delay[4]_i_10 
       (.I0(fsm_next_state__72[3]),
        .I1(fsm_next_state__72[1]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[0]),
        .O(delay[6]));
  LUT5 #(
    .INIT(32'h40040004)) 
    \delay[4]_i_11 
       (.I0(fsm_next_state__72[3]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[1]),
        .O(delay[8]));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[4]_i_2 
       (.I0(p_1_in),
        .I1(delay_reg[7]),
        .O(\delay[4]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[4]_i_3 
       (.I0(delay_reg[6]),
        .I1(p_1_in),
        .I2(delay[6]),
        .O(\delay[4]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[4]_i_4 
       (.I0(delay_reg[5]),
        .I1(p_1_in),
        .I2(delay[8]),
        .O(\delay[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF000000100010)) 
    \delay[4]_i_5 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[4]),
        .I5(p_1_in),
        .O(\delay[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[4]_i_6 
       (.I0(delay_reg[7]),
        .I1(p_1_in),
        .O(\delay[4]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[4]_i_7 
       (.I0(delay[6]),
        .I1(delay_reg[6]),
        .I2(p_1_in),
        .O(\delay[4]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[4]_i_8 
       (.I0(delay[8]),
        .I1(delay_reg[5]),
        .I2(p_1_in),
        .O(\delay[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00100010)) 
    \delay[4]_i_9 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[0]),
        .I3(fsm_next_state__72[2]),
        .I4(delay_reg[4]),
        .I5(p_1_in),
        .O(\delay[4]_i_9_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[8]_i_2 
       (.I0(delay_reg[11]),
        .I1(p_1_in),
        .I2(delay[11]),
        .O(\delay[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[8]_i_3 
       (.I0(p_1_in),
        .I1(delay_reg[10]),
        .O(\delay[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \delay[8]_i_4 
       (.I0(p_1_in),
        .I1(delay_reg[9]),
        .O(\delay[8]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \delay[8]_i_5 
       (.I0(delay_reg[8]),
        .I1(p_1_in),
        .I2(delay[8]),
        .O(\delay[8]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[8]_i_6 
       (.I0(delay[11]),
        .I1(delay_reg[11]),
        .I2(p_1_in),
        .O(\delay[8]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[8]_i_7 
       (.I0(delay_reg[10]),
        .I1(p_1_in),
        .O(\delay[8]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \delay[8]_i_8 
       (.I0(delay_reg[9]),
        .I1(p_1_in),
        .O(\delay[8]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h3A)) 
    \delay[8]_i_9 
       (.I0(delay[8]),
        .I1(delay_reg[8]),
        .I2(p_1_in),
        .O(\delay[8]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[0] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_7 ),
        .Q(delay_reg[0]),
        .R(1'b0));
  CARRY4 \delay_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\delay_reg[0]_i_2_n_0 ,\NLW_delay_reg[0]_i_2_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[0]_i_4_n_0 ,\delay[0]_i_5_n_0 ,\delay[0]_i_6_n_0 ,\delay[0]_i_7_n_0 }),
        .O({\delay_reg[0]_i_2_n_4 ,\delay_reg[0]_i_2_n_5 ,\delay_reg[0]_i_2_n_6 ,\delay_reg[0]_i_2_n_7 }),
        .S({\delay[0]_i_8_n_0 ,\delay[0]_i_9_n_0 ,\delay[0]_i_10_n_0 ,\delay[0]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[10] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_5 ),
        .Q(delay_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[11] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_4 ),
        .Q(delay_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[12] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_7 ),
        .Q(delay_reg[12]),
        .R(1'b0));
  CARRY4 \delay_reg[12]_i_1 
       (.CI(\delay_reg[8]_i_1_n_0 ),
        .CO({\delay_reg[12]_i_1_n_0 ,\NLW_delay_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[12]_i_2_n_0 ,\delay[12]_i_3_n_0 ,\delay[12]_i_4_n_0 ,\delay[12]_i_5_n_0 }),
        .O({\delay_reg[12]_i_1_n_4 ,\delay_reg[12]_i_1_n_5 ,\delay_reg[12]_i_1_n_6 ,\delay_reg[12]_i_1_n_7 }),
        .S({\delay[12]_i_6_n_0 ,\delay[12]_i_7_n_0 ,\delay[12]_i_8_n_0 ,\delay[12]_i_9_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[13] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_6 ),
        .Q(delay_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[14] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_5 ),
        .Q(delay_reg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[15] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[12]_i_1_n_4 ),
        .Q(delay_reg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[16] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_7 ),
        .Q(delay_reg[16]),
        .R(1'b0));
  CARRY4 \delay_reg[16]_i_1 
       (.CI(\delay_reg[12]_i_1_n_0 ),
        .CO(\NLW_delay_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,\delay[16]_i_2_n_0 ,\delay[16]_i_3_n_0 ,\delay[16]_i_4_n_0 }),
        .O({\delay_reg[16]_i_1_n_4 ,\delay_reg[16]_i_1_n_5 ,\delay_reg[16]_i_1_n_6 ,\delay_reg[16]_i_1_n_7 }),
        .S({\delay[16]_i_5_n_0 ,\delay[16]_i_6_n_0 ,\delay[16]_i_7_n_0 ,\delay[16]_i_8_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[17] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_6 ),
        .Q(delay_reg[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[18] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_5 ),
        .Q(delay_reg[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[19] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[16]_i_1_n_4 ),
        .Q(delay_reg[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[1] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_6 ),
        .Q(delay_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[2] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_5 ),
        .Q(delay_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[3] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[0]_i_2_n_4 ),
        .Q(delay_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[4] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_7 ),
        .Q(delay_reg[4]),
        .R(1'b0));
  CARRY4 \delay_reg[4]_i_1 
       (.CI(\delay_reg[0]_i_2_n_0 ),
        .CO({\delay_reg[4]_i_1_n_0 ,\NLW_delay_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[4]_i_2_n_0 ,\delay[4]_i_3_n_0 ,\delay[4]_i_4_n_0 ,\delay[4]_i_5_n_0 }),
        .O({\delay_reg[4]_i_1_n_4 ,\delay_reg[4]_i_1_n_5 ,\delay_reg[4]_i_1_n_6 ,\delay_reg[4]_i_1_n_7 }),
        .S({\delay[4]_i_6_n_0 ,\delay[4]_i_7_n_0 ,\delay[4]_i_8_n_0 ,\delay[4]_i_9_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[5] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_6 ),
        .Q(delay_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[6] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_5 ),
        .Q(delay_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[7] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[4]_i_1_n_4 ),
        .Q(delay_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[8] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_7 ),
        .Q(delay_reg[8]),
        .R(1'b0));
  CARRY4 \delay_reg[8]_i_1 
       (.CI(\delay_reg[4]_i_1_n_0 ),
        .CO({\delay_reg[8]_i_1_n_0 ,\NLW_delay_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\delay[8]_i_2_n_0 ,\delay[8]_i_3_n_0 ,\delay[8]_i_4_n_0 ,\delay[8]_i_5_n_0 }),
        .O({\delay_reg[8]_i_1_n_4 ,\delay_reg[8]_i_1_n_5 ,\delay_reg[8]_i_1_n_6 ,\delay_reg[8]_i_1_n_7 }),
        .S({\delay[8]_i_6_n_0 ,\delay[8]_i_7_n_0 ,\delay[8]_i_8_n_0 ,\delay[8]_i_9_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \delay_reg[9] 
       (.C(screen_reg),
        .CE(\delay[0]_i_1_n_0 ),
        .D(\delay_reg[8]_i_1_n_6 ),
        .Q(delay_reg[9]),
        .R(1'b0));
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
        .O(data0__0));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \frame_counter[16]_i_1 
       (.I0(p_0_in_0[9]),
        .I1(\frame_counter[16]_i_2_n_0 ),
        .I2(p_0_in_0[7]),
        .I3(\frame_counter_reg_n_0_[1] ),
        .I4(\frame_counter[16]_i_3_n_0 ),
        .I5(\frame_counter[16]_i_4_n_0 ),
        .O(\frame_counter[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \frame_counter[16]_i_2 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[10]),
        .O(\frame_counter[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \frame_counter[16]_i_3 
       (.I0(\frame_counter_reg_n_0_[3] ),
        .I1(p_0_in_0[0]),
        .O(\frame_counter[16]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF7FFF)) 
    \frame_counter[16]_i_4 
       (.I0(p_0_in_0[2]),
        .I1(\frame_counter_reg_n_0_[0] ),
        .I2(p_0_in_0[11]),
        .I3(p_0_in_0[12]),
        .I4(\frame_counter[16]_i_5_n_0 ),
        .O(\frame_counter[16]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \frame_counter[16]_i_5 
       (.I0(\frame_counter_reg_n_0_[2] ),
        .I1(p_0_in_0[8]),
        .I2(p_0_in_0[5]),
        .I3(p_0_in_0[6]),
        .O(\frame_counter[16]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[0] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0__0),
        .Q(\frame_counter_reg_n_0_[0] ),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[10] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[10]),
        .Q(p_0_in_0[6]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[11] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[11]),
        .Q(p_0_in_0[7]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[12] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[12]),
        .Q(p_0_in_0[8]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[13] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[13]),
        .Q(p_0_in_0[9]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[14] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[14]),
        .Q(p_0_in_0[10]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[15] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[15]),
        .Q(p_0_in_0[11]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[16] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[16]),
        .Q(p_0_in_0[12]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[1] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[1]),
        .Q(\frame_counter_reg_n_0_[1] ),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[2] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[2]),
        .Q(\frame_counter_reg_n_0_[2] ),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[3] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[3]),
        .Q(\frame_counter_reg_n_0_[3] ),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[4] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[4]),
        .Q(p_0_in_0[0]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[5] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[5]),
        .Q(p_0_in_0[1]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[6] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[6]),
        .Q(p_0_in_0[2]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[7] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[7]),
        .Q(p_0_in_0[3]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[8] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[8]),
        .Q(p_0_in_0[4]),
        .R(\frame_counter[16]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \frame_counter_reg[9] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(data0[9]),
        .Q(p_0_in_0[5]),
        .R(\frame_counter[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8F8FF8808080088)) 
    \pixel_data[10]_i_1 
       (.I0(\pixel_data[15]_i_3_n_0 ),
        .I1(\pixel_data[10]_i_2_n_0 ),
        .I2(sel0[6]),
        .I3(\pixel_data[15]_i_6_n_0 ),
        .I4(sel0[5]),
        .I5(\pixel_data[10]_i_3_n_0 ),
        .O(D[1]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[10]_i_2 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][57][15] [1]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAEFFFEF0A200020)) 
    \pixel_data[10]_i_3 
       (.I0(frame_buff[10]),
        .I1(\pixel_data[15]_i_11_n_0 ),
        .I2(sel0[5]),
        .I3(sel0[6]),
        .I4(\pixel_data[15]_i_15_n_0 ),
        .I5(\pixel_data[10]_i_5_n_0 ),
        .O(\pixel_data[10]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[10]_i_4 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][86][15] [1]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(frame_buff[10]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[10]_i_5 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][28][15] [1]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[10]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF8F8FF8808080088)) 
    \pixel_data[15]_i_1 
       (.I0(\pixel_data[15]_i_3_n_0 ),
        .I1(\pixel_data[15]_i_4_n_0 ),
        .I2(sel0[6]),
        .I3(\pixel_data[15]_i_6_n_0 ),
        .I4(sel0[5]),
        .I5(\pixel_data[15]_i_8_n_0 ),
        .O(D[2]));
  LUT5 #(
    .INIT(32'hFFFFFFFD)) 
    \pixel_data[15]_i_10 
       (.I0(\pixel_data[15]_i_27_n_0 ),
        .I1(p_0_in_0[1]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[3]),
        .I4(p_0_in_0[4]),
        .O(\pixel_data[15]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \pixel_data[15]_i_100 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[4]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[6]),
        .O(\pixel_data[15]_i_100_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \pixel_data[15]_i_101 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[0]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_101_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_102 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[3]),
        .O(\pixel_data[15]_i_102_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_103 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[2]),
        .O(\pixel_data[15]_i_103_n_0 ));
  LUT4 #(
    .INIT(16'h9600)) 
    \pixel_data[15]_i_104 
       (.I0(p_0_in_0[0]),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[4]),
        .I3(JC_OBUF[2]),
        .O(\pixel_data[15]_i_104_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \pixel_data[15]_i_105 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_105_n_0 ));
  LUT3 #(
    .INIT(8'h60)) 
    \pixel_data[15]_i_106 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[0]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_106_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_107 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[1]),
        .O(pixel_index[1]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_108 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[4]),
        .O(pixel_index[4]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_109 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[2]),
        .O(pixel_index[2]));
  LUT6 #(
    .INIT(64'hFFDC0000000023FF)) 
    \pixel_data[15]_i_11 
       (.I0(\pixel_data[15]_i_12_n_0 ),
        .I1(\pixel_data_reg[4] [1]),
        .I2(\pixel_data_reg[4] [0]),
        .I3(\pixel_data_reg[4] [2]),
        .I4(\pixel_data_reg[4] [3]),
        .I5(O[0]),
        .O(\pixel_data[15]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hBFAA)) 
    \pixel_data[15]_i_12 
       (.I0(\pixel_data_reg[15]_i_17_n_0 ),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[12]),
        .I3(\FSM_onehot_state_reg[13]_1 [3]),
        .O(\pixel_data[15]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h00002FFFFFFFFFD0)) 
    \pixel_data[15]_i_15 
       (.I0(\pixel_data[15]_i_12_n_0 ),
        .I1(\pixel_data_reg[4] [0]),
        .I2(\pixel_data_reg[4] [1]),
        .I3(\pixel_data_reg[4] [2]),
        .I4(\pixel_data_reg[4] [3]),
        .I5(O[0]),
        .O(\pixel_data[15]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h02AAAAA8AAAA0000)) 
    \pixel_data[15]_i_16 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[2]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[3]),
        .O(\pixel_data[15]_i_16_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_18 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[12]),
        .O(pixel_index[12]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \pixel_data[15]_i_2 
       (.I0(\pixel_data[15]_i_9_n_0 ),
        .I1(p_0_in_0[11]),
        .I2(p_0_in_0[12]),
        .I3(p_0_in_0[10]),
        .I4(p_0_in_0[9]),
        .I5(\pixel_data[15]_i_10_n_0 ),
        .O(CLK));
  LUT6 #(
    .INIT(64'hBAFFFFFF45000000)) 
    \pixel_data[15]_i_20 
       (.I0(\pixel_data_reg[15]_i_17_n_0 ),
        .I1(pixel_index[12]),
        .I2(\FSM_onehot_state_reg[13]_1 [3]),
        .I3(\pixel_data_reg[4] [0]),
        .I4(\pixel_data_reg[4] [1]),
        .I5(\pixel_data_reg[4] [2]),
        .O(sel0[2]));
  LUT6 #(
    .INIT(64'hBFAAFFFF40550000)) 
    \pixel_data[15]_i_21 
       (.I0(\pixel_data_reg[15]_i_17_n_0 ),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[12]),
        .I3(\FSM_onehot_state_reg[13]_1 [3]),
        .I4(\pixel_data_reg[4] [0]),
        .I5(\pixel_data_reg[4] [1]),
        .O(sel0[1]));
  LUT5 #(
    .INIT(32'hBFFF4000)) 
    \pixel_data[15]_i_22 
       (.I0(\pixel_data[15]_i_12_n_0 ),
        .I1(\pixel_data_reg[4] [1]),
        .I2(\pixel_data_reg[4] [0]),
        .I3(\pixel_data_reg[4] [2]),
        .I4(\pixel_data_reg[4] [3]),
        .O(sel0[3]));
  LUT5 #(
    .INIT(32'hFF2A00D5)) 
    \pixel_data[15]_i_23 
       (.I0(\FSM_onehot_state_reg[13]_1 [3]),
        .I1(p_0_in_0[12]),
        .I2(JC_OBUF[2]),
        .I3(\pixel_data_reg[15]_i_17_n_0 ),
        .I4(\pixel_data_reg[4] [0]),
        .O(\pixel_data[15]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFF40000000)) 
    \pixel_data[15]_i_24 
       (.I0(\pixel_data[15]_i_12_n_0 ),
        .I1(\pixel_data_reg[4] [2]),
        .I2(\pixel_data_reg[4] [0]),
        .I3(\pixel_data_reg[4] [1]),
        .I4(\pixel_data_reg[4] [3]),
        .I5(O[0]),
        .O(sel0[4]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[15]_i_25 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][86][15] [2]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(frame_buff[15]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[15]_i_26 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][28][15] [2]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[15]_i_26_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \pixel_data[15]_i_27 
       (.I0(p_0_in_0[0]),
        .I1(\frame_counter_reg_n_0_[3] ),
        .I2(\frame_counter_reg_n_0_[0] ),
        .I3(\frame_counter_reg_n_0_[1] ),
        .I4(\frame_counter_reg_n_0_[2] ),
        .O(\pixel_data[15]_i_27_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \pixel_data[15]_i_29 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[10]),
        .I2(p_0_in_0[12]),
        .O(\pixel_data[15]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'h00CF751000004510)) 
    \pixel_data[15]_i_3 
       (.I0(\pixel_data[15]_i_11_n_0 ),
        .I1(\pixel_data[15]_i_12_n_0 ),
        .I2(\FSM_onehot_state_reg[13]_0 ),
        .I3(O[1]),
        .I4(CO),
        .I5(\pixel_data[15]_i_15_n_0 ),
        .O(\pixel_data[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_30 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[12]),
        .O(\pixel_data[15]_i_30_n_0 ));
  LUT4 #(
    .INIT(16'h7800)) 
    \pixel_data[15]_i_31 
       (.I0(p_0_in_0[10]),
        .I1(p_0_in_0[12]),
        .I2(p_0_in_0[11]),
        .I3(JC_OBUF[2]),
        .O(\pixel_data[15]_i_31_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \pixel_data[15]_i_33 
       (.I0(\FSM_onehot_state_reg[13]_1 [2]),
        .I1(p_0_in_0[11]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_33_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \pixel_data[15]_i_34 
       (.I0(\FSM_onehot_state_reg[13]_1 [1]),
        .I1(p_0_in_0[10]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_34_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \pixel_data[15]_i_35 
       (.I0(\FSM_onehot_state_reg[13]_1 [0]),
        .I1(p_0_in_0[9]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_35_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \pixel_data[15]_i_36 
       (.I0(\frame_counter_reg[13]_0 [3]),
        .I1(p_0_in_0[8]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_36_n_0 ));
  LUT5 #(
    .INIT(32'hB4C34BC3)) 
    \pixel_data[15]_i_37 
       (.I0(p_0_in_0[11]),
        .I1(\FSM_onehot_state_reg[13]_1 [2]),
        .I2(\FSM_onehot_state_reg[13]_1 [3]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[12]),
        .O(\pixel_data[15]_i_37_n_0 ));
  LUT5 #(
    .INIT(32'hB4C34BC3)) 
    \pixel_data[15]_i_38 
       (.I0(p_0_in_0[10]),
        .I1(\FSM_onehot_state_reg[13]_1 [1]),
        .I2(\FSM_onehot_state_reg[13]_1 [2]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[11]),
        .O(\pixel_data[15]_i_38_n_0 ));
  LUT5 #(
    .INIT(32'hB4C34BC3)) 
    \pixel_data[15]_i_39 
       (.I0(p_0_in_0[9]),
        .I1(\FSM_onehot_state_reg[13]_1 [0]),
        .I2(\FSM_onehot_state_reg[13]_1 [1]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[10]),
        .O(\pixel_data[15]_i_39_n_0 ));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[15]_i_4 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][57][15] [2]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB4C34BC3)) 
    \pixel_data[15]_i_40 
       (.I0(p_0_in_0[8]),
        .I1(\frame_counter_reg[13]_0 [3]),
        .I2(\FSM_onehot_state_reg[13]_1 [0]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[9]),
        .O(\pixel_data[15]_i_40_n_0 ));
  LUT6 #(
    .INIT(64'hE0E0E080E0808080)) 
    \pixel_data[15]_i_47 
       (.I0(p_0_in_0[9]),
        .I1(p_0_in_0[11]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[12]),
        .I4(p_0_in_0[10]),
        .I5(p_0_in_0[8]),
        .O(\pixel_data[15]_i_47_n_0 ));
  LUT6 #(
    .INIT(64'h9696960096000000)) 
    \pixel_data[15]_i_48 
       (.I0(pixel_index__0[10]),
        .I1(pixel_index__0[8]),
        .I2(pixel_index[12]),
        .I3(pixel_index[11]),
        .I4(pixel_index__0[9]),
        .I5(pixel_index__0[7]),
        .O(\pixel_data[15]_i_48_n_0 ));
  LUT6 #(
    .INIT(64'h9696960096000000)) 
    \pixel_data[15]_i_49 
       (.I0(pixel_index__0[9]),
        .I1(pixel_index__0[7]),
        .I2(pixel_index[11]),
        .I3(pixel_index__0[10]),
        .I4(pixel_index__0[8]),
        .I5(pixel_index[6]),
        .O(\pixel_data[15]_i_49_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFFFFF45000000)) 
    \pixel_data[15]_i_5 
       (.I0(\pixel_data_reg[15]_i_17_n_0 ),
        .I1(pixel_index[12]),
        .I2(\FSM_onehot_state_reg[13]_1 [3]),
        .I3(\FSM_onehot_state_reg[13]_0 ),
        .I4(O[1]),
        .I5(CO),
        .O(sel0[6]));
  LUT6 #(
    .INIT(64'hC8C8C880C8808080)) 
    \pixel_data[15]_i_50 
       (.I0(p_0_in_0[12]),
        .I1(JC_OBUF[2]),
        .I2(\pixel_data[15]_i_80_n_0 ),
        .I3(p_0_in_0[9]),
        .I4(p_0_in_0[7]),
        .I5(p_0_in_0[5]),
        .O(\pixel_data[15]_i_50_n_0 ));
  LUT6 #(
    .INIT(64'hFC0017001700C000)) 
    \pixel_data[15]_i_51 
       (.I0(p_0_in_0[8]),
        .I1(p_0_in_0[11]),
        .I2(p_0_in_0[9]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[10]),
        .I5(p_0_in_0[12]),
        .O(\pixel_data[15]_i_51_n_0 ));
  LUT5 #(
    .INIT(32'h695596AA)) 
    \pixel_data[15]_i_52 
       (.I0(\pixel_data[15]_i_48_n_0 ),
        .I1(p_0_in_0[11]),
        .I2(p_0_in_0[9]),
        .I3(JC_OBUF[2]),
        .I4(\pixel_data[15]_i_81_n_0 ),
        .O(\pixel_data[15]_i_52_n_0 ));
  LUT6 #(
    .INIT(64'h9996666696666666)) 
    \pixel_data[15]_i_53 
       (.I0(\pixel_data[15]_i_49_n_0 ),
        .I1(\pixel_data[15]_i_82_n_0 ),
        .I2(p_0_in_0[7]),
        .I3(p_0_in_0[9]),
        .I4(JC_OBUF[2]),
        .I5(p_0_in_0[11]),
        .O(\pixel_data[15]_i_53_n_0 ));
  LUT6 #(
    .INIT(64'h9996666696666666)) 
    \pixel_data[15]_i_54 
       (.I0(\pixel_data[15]_i_50_n_0 ),
        .I1(\pixel_data[15]_i_83_n_0 ),
        .I2(p_0_in_0[6]),
        .I3(p_0_in_0[8]),
        .I4(JC_OBUF[2]),
        .I5(p_0_in_0[10]),
        .O(\pixel_data[15]_i_54_n_0 ));
  LUT3 #(
    .INIT(8'h2A)) 
    \pixel_data[15]_i_55 
       (.I0(\frame_counter_reg[13]_0 [2]),
        .I1(p_0_in_0[7]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_55_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \pixel_data[15]_i_56 
       (.I0(\frame_counter_reg[13]_0 [1]),
        .I1(p_0_in_0[6]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_56_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \pixel_data[15]_i_57 
       (.I0(\frame_counter_reg[13]_0 [0]),
        .I1(p_0_in_0[5]),
        .I2(JC_OBUF[2]),
        .O(\pixel_data[15]_i_57_n_0 ));
  LUT5 #(
    .INIT(32'hB4C34BC3)) 
    \pixel_data[15]_i_58 
       (.I0(p_0_in_0[7]),
        .I1(\frame_counter_reg[13]_0 [2]),
        .I2(\frame_counter_reg[13]_0 [3]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[8]),
        .O(\pixel_data[15]_i_58_n_0 ));
  LUT5 #(
    .INIT(32'h2DF0D2F0)) 
    \pixel_data[15]_i_59 
       (.I0(p_0_in_0[6]),
        .I1(\frame_counter_reg[13]_0 [1]),
        .I2(\frame_counter_reg[13]_0 [2]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[7]),
        .O(\pixel_data[15]_i_59_n_0 ));
  LUT6 #(
    .INIT(64'h057F07FFFFE0FEA0)) 
    \pixel_data[15]_i_6 
       (.I0(sel0[2]),
        .I1(sel0[1]),
        .I2(sel0[6]),
        .I3(sel0[3]),
        .I4(\pixel_data[15]_i_23_n_0 ),
        .I5(sel0[4]),
        .O(\pixel_data[15]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hD20F2D0F)) 
    \pixel_data[15]_i_60 
       (.I0(p_0_in_0[5]),
        .I1(\frame_counter_reg[13]_0 [0]),
        .I2(\frame_counter_reg[13]_0 [1]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[6]),
        .O(\pixel_data[15]_i_60_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \pixel_data[15]_i_61 
       (.I0(p_0_in_0[5]),
        .I1(JC_OBUF[2]),
        .I2(\frame_counter_reg[13]_0 [0]),
        .O(\pixel_data[15]_i_61_n_0 ));
  LUT6 #(
    .INIT(64'hC8C8C880C8808080)) 
    \pixel_data[15]_i_66 
       (.I0(p_0_in_0[11]),
        .I1(JC_OBUF[2]),
        .I2(\pixel_data[15]_i_93_n_0 ),
        .I3(p_0_in_0[8]),
        .I4(p_0_in_0[6]),
        .I5(p_0_in_0[4]),
        .O(\pixel_data[15]_i_66_n_0 ));
  LUT6 #(
    .INIT(64'hC8C8C880C8808080)) 
    \pixel_data[15]_i_67 
       (.I0(p_0_in_0[10]),
        .I1(JC_OBUF[2]),
        .I2(\pixel_data[15]_i_94_n_0 ),
        .I3(p_0_in_0[7]),
        .I4(p_0_in_0[5]),
        .I5(p_0_in_0[3]),
        .O(\pixel_data[15]_i_67_n_0 ));
  LUT6 #(
    .INIT(64'hC8C8C880C8808080)) 
    \pixel_data[15]_i_68 
       (.I0(p_0_in_0[9]),
        .I1(JC_OBUF[2]),
        .I2(\pixel_data[15]_i_95_n_0 ),
        .I3(p_0_in_0[6]),
        .I4(p_0_in_0[4]),
        .I5(p_0_in_0[2]),
        .O(\pixel_data[15]_i_68_n_0 ));
  LUT6 #(
    .INIT(64'hEB00BE0082002800)) 
    \pixel_data[15]_i_69 
       (.I0(p_0_in_0[8]),
        .I1(p_0_in_0[4]),
        .I2(p_0_in_0[2]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[6]),
        .I5(\pixel_data[15]_i_96_n_0 ),
        .O(\pixel_data[15]_i_69_n_0 ));
  LUT6 #(
    .INIT(64'hBFAAFFFF40550000)) 
    \pixel_data[15]_i_7 
       (.I0(\pixel_data_reg[15]_i_17_n_0 ),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[12]),
        .I3(\FSM_onehot_state_reg[13]_1 [3]),
        .I4(\FSM_onehot_state_reg[13]_0 ),
        .I5(O[1]),
        .O(sel0[5]));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \pixel_data[15]_i_70 
       (.I0(\pixel_data[15]_i_66_n_0 ),
        .I1(\pixel_data[15]_i_80_n_0 ),
        .I2(pixel_index[12]),
        .I3(pixel_index[5]),
        .I4(pixel_index__0[7]),
        .I5(pixel_index__0[9]),
        .O(\pixel_data[15]_i_70_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \pixel_data[15]_i_71 
       (.I0(\pixel_data[15]_i_67_n_0 ),
        .I1(pixel_index__0[7]),
        .I2(pixel_index[5]),
        .I3(pixel_index__0[9]),
        .I4(pixel_index[11]),
        .I5(\pixel_data[15]_i_98_n_0 ),
        .O(\pixel_data[15]_i_71_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \pixel_data[15]_i_72 
       (.I0(\pixel_data[15]_i_68_n_0 ),
        .I1(\pixel_data[15]_i_94_n_0 ),
        .I2(pixel_index__0[10]),
        .I3(pixel_index[3]),
        .I4(pixel_index[5]),
        .I5(pixel_index__0[7]),
        .O(\pixel_data[15]_i_72_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \pixel_data[15]_i_73 
       (.I0(\pixel_data[15]_i_69_n_0 ),
        .I1(pixel_index[5]),
        .I2(pixel_index[3]),
        .I3(pixel_index__0[7]),
        .I4(pixel_index__0[9]),
        .I5(\pixel_data[15]_i_100_n_0 ),
        .O(\pixel_data[15]_i_73_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_74 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[10]),
        .O(pixel_index__0[10]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_75 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[8]),
        .O(pixel_index__0[8]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_76 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[11]),
        .O(pixel_index[11]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_77 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[9]),
        .O(pixel_index__0[9]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_78 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[7]),
        .O(pixel_index__0[7]));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_79 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[6]),
        .O(pixel_index[6]));
  LUT6 #(
    .INIT(64'hFAEFFFEF0A200020)) 
    \pixel_data[15]_i_8 
       (.I0(frame_buff[15]),
        .I1(\pixel_data[15]_i_11_n_0 ),
        .I2(sel0[5]),
        .I3(sel0[6]),
        .I4(\pixel_data[15]_i_15_n_0 ),
        .I5(\pixel_data[15]_i_26_n_0 ),
        .O(\pixel_data[15]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_80 
       (.I0(p_0_in_0[10]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[6]),
        .I3(p_0_in_0[8]),
        .O(\pixel_data[15]_i_80_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \pixel_data[15]_i_81 
       (.I0(p_0_in_0[8]),
        .I1(p_0_in_0[10]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[12]),
        .O(\pixel_data[15]_i_81_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_82 
       (.I0(p_0_in_0[12]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[8]),
        .I3(p_0_in_0[10]),
        .O(\pixel_data[15]_i_82_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_83 
       (.I0(p_0_in_0[11]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[7]),
        .I3(p_0_in_0[9]),
        .O(\pixel_data[15]_i_83_n_0 ));
  LUT6 #(
    .INIT(64'hC8C8C880C8808080)) 
    \pixel_data[15]_i_85 
       (.I0(p_0_in_0[7]),
        .I1(JC_OBUF[2]),
        .I2(\pixel_data[15]_i_88_n_0 ),
        .I3(p_0_in_0[4]),
        .I4(p_0_in_0[2]),
        .I5(p_0_in_0[0]),
        .O(\pixel_data[15]_i_85_n_0 ));
  LUT6 #(
    .INIT(64'hE8FF17FF1700E800)) 
    \pixel_data[15]_i_86 
       (.I0(p_0_in_0[4]),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[0]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[7]),
        .I5(\pixel_data[15]_i_88_n_0 ),
        .O(\pixel_data[15]_i_86_n_0 ));
  LUT5 #(
    .INIT(32'h69960000)) 
    \pixel_data[15]_i_87 
       (.I0(p_0_in_0[2]),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[6]),
        .I4(JC_OBUF[2]),
        .O(\pixel_data[15]_i_87_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_88 
       (.I0(p_0_in_0[5]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[3]),
        .O(\pixel_data[15]_i_88_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \pixel_data[15]_i_89 
       (.I0(\pixel_data[15]_i_85_n_0 ),
        .I1(pixel_index[4]),
        .I2(pixel_index[2]),
        .I3(pixel_index[6]),
        .I4(pixel_index__0[8]),
        .I5(\pixel_data[15]_i_96_n_0 ),
        .O(\pixel_data[15]_i_89_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \pixel_data[15]_i_9 
       (.I0(p_0_in_0[6]),
        .I1(p_0_in_0[5]),
        .I2(p_0_in_0[8]),
        .I3(p_0_in_0[7]),
        .O(\pixel_data[15]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h6A9A9A6AAAAAAAAA)) 
    \pixel_data[15]_i_90 
       (.I0(\pixel_data[15]_i_86_n_0 ),
        .I1(p_0_in_0[4]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[0]),
        .I4(p_0_in_0[2]),
        .I5(p_0_in_0[6]),
        .O(\pixel_data[15]_i_90_n_0 ));
  LUT6 #(
    .INIT(64'hD77D7DD728828228)) 
    \pixel_data[15]_i_91 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[6]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[0]),
        .I4(p_0_in_0[2]),
        .I5(\pixel_data[15]_i_96_n_0 ),
        .O(\pixel_data[15]_i_91_n_0 ));
  LUT6 #(
    .INIT(64'h6900960096009600)) 
    \pixel_data[15]_i_92 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[1]),
        .I2(p_0_in_0[5]),
        .I3(JC_OBUF[2]),
        .I4(p_0_in_0[2]),
        .I5(p_0_in_0[0]),
        .O(\pixel_data[15]_i_92_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_93 
       (.I0(p_0_in_0[9]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[5]),
        .I3(p_0_in_0[7]),
        .O(\pixel_data[15]_i_93_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_94 
       (.I0(p_0_in_0[8]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[4]),
        .I3(p_0_in_0[6]),
        .O(\pixel_data[15]_i_94_n_0 ));
  LUT4 #(
    .INIT(16'h8448)) 
    \pixel_data[15]_i_95 
       (.I0(p_0_in_0[7]),
        .I1(JC_OBUF[2]),
        .I2(p_0_in_0[3]),
        .I3(p_0_in_0[5]),
        .O(\pixel_data[15]_i_95_n_0 ));
  LUT4 #(
    .INIT(16'hE080)) 
    \pixel_data[15]_i_96 
       (.I0(p_0_in_0[1]),
        .I1(p_0_in_0[3]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[5]),
        .O(\pixel_data[15]_i_96_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_97 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .O(pixel_index[5]));
  LUT4 #(
    .INIT(16'hE080)) 
    \pixel_data[15]_i_98 
       (.I0(p_0_in_0[4]),
        .I1(p_0_in_0[6]),
        .I2(JC_OBUF[2]),
        .I3(p_0_in_0[8]),
        .O(\pixel_data[15]_i_98_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pixel_data[15]_i_99 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[3]),
        .O(pixel_index[3]));
  LUT6 #(
    .INIT(64'hF8F8FF8808080088)) 
    \pixel_data[4]_i_1 
       (.I0(\pixel_data[15]_i_3_n_0 ),
        .I1(\pixel_data[4]_i_2_n_0 ),
        .I2(sel0[6]),
        .I3(\pixel_data[15]_i_6_n_0 ),
        .I4(sel0[5]),
        .I5(\pixel_data[4]_i_3_n_0 ),
        .O(D[0]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[4]_i_2 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][57][15] [0]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAEFFFEF0A200020)) 
    \pixel_data[4]_i_3 
       (.I0(frame_buff[4]),
        .I1(\pixel_data[15]_i_11_n_0 ),
        .I2(sel0[5]),
        .I3(sel0[6]),
        .I4(\pixel_data[15]_i_15_n_0 ),
        .I5(\pixel_data[4]_i_5_n_0 ),
        .O(\pixel_data[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[4]_i_4 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][86][15] [0]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(frame_buff[4]));
  LUT4 #(
    .INIT(16'h7000)) 
    \pixel_data[4]_i_5 
       (.I0(JC_OBUF[2]),
        .I1(p_0_in_0[5]),
        .I2(\frame_buff_reg[28][28][15] [0]),
        .I3(\pixel_data[15]_i_16_n_0 ),
        .O(\pixel_data[4]_i_5_n_0 ));
  CARRY4 \pixel_data_reg[15]_i_14 
       (.CI(\pixel_data_reg[15]_i_28_n_0 ),
        .CO({\NLW_pixel_data_reg[15]_i_14_CO_UNCONNECTED [3],CO,\NLW_pixel_data_reg[15]_i_14_CO_UNCONNECTED [1:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\pixel_data[15]_i_29_n_0 }),
        .O({\NLW_pixel_data_reg[15]_i_14_O_UNCONNECTED [3:2],O}),
        .S({1'b0,1'b1,\pixel_data[15]_i_30_n_0 ,\pixel_data[15]_i_31_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_17 
       (.CI(\pixel_data_reg[15]_i_32_n_0 ),
        .CO({\pixel_data_reg[15]_i_17_n_0 ,\NLW_pixel_data_reg[15]_i_17_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_33_n_0 ,\pixel_data[15]_i_34_n_0 ,\pixel_data[15]_i_35_n_0 ,\pixel_data[15]_i_36_n_0 }),
        .O(\NLW_pixel_data_reg[15]_i_17_O_UNCONNECTED [3:0]),
        .S({\pixel_data[15]_i_37_n_0 ,\pixel_data[15]_i_38_n_0 ,\pixel_data[15]_i_39_n_0 ,\pixel_data[15]_i_40_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_28 
       (.CI(\pixel_data_reg[15]_i_46_n_0 ),
        .CO({\pixel_data_reg[15]_i_28_n_0 ,\NLW_pixel_data_reg[15]_i_28_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_47_n_0 ,\pixel_data[15]_i_48_n_0 ,\pixel_data[15]_i_49_n_0 ,\pixel_data[15]_i_50_n_0 }),
        .O(\pixel_data_reg[4] ),
        .S({\pixel_data[15]_i_51_n_0 ,\pixel_data[15]_i_52_n_0 ,\pixel_data[15]_i_53_n_0 ,\pixel_data[15]_i_54_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_32 
       (.CI(1'b0),
        .CO({\pixel_data_reg[15]_i_32_n_0 ,\NLW_pixel_data_reg[15]_i_32_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_55_n_0 ,\pixel_data[15]_i_56_n_0 ,\pixel_data[15]_i_57_n_0 ,1'b0}),
        .O(\NLW_pixel_data_reg[15]_i_32_O_UNCONNECTED [3:0]),
        .S({\pixel_data[15]_i_58_n_0 ,\pixel_data[15]_i_59_n_0 ,\pixel_data[15]_i_60_n_0 ,\pixel_data[15]_i_61_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_46 
       (.CI(\pixel_data_reg[15]_i_65_n_0 ),
        .CO({\pixel_data_reg[15]_i_46_n_0 ,\NLW_pixel_data_reg[15]_i_46_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_66_n_0 ,\pixel_data[15]_i_67_n_0 ,\pixel_data[15]_i_68_n_0 ,\pixel_data[15]_i_69_n_0 }),
        .O(\NLW_pixel_data_reg[15]_i_46_O_UNCONNECTED [3:0]),
        .S({\pixel_data[15]_i_70_n_0 ,\pixel_data[15]_i_71_n_0 ,\pixel_data[15]_i_72_n_0 ,\pixel_data[15]_i_73_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_65 
       (.CI(\pixel_data_reg[15]_i_84_n_0 ),
        .CO({\pixel_data_reg[15]_i_65_n_0 ,\NLW_pixel_data_reg[15]_i_65_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_85_n_0 ,\pixel_data[15]_i_86_n_0 ,\pixel_data[15]_i_87_n_0 ,\pixel_data[15]_i_88_n_0 }),
        .O(\NLW_pixel_data_reg[15]_i_65_O_UNCONNECTED [3:0]),
        .S({\pixel_data[15]_i_89_n_0 ,\pixel_data[15]_i_90_n_0 ,\pixel_data[15]_i_91_n_0 ,\pixel_data[15]_i_92_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_84 
       (.CI(1'b0),
        .CO({\pixel_data_reg[15]_i_84_n_0 ,\NLW_pixel_data_reg[15]_i_84_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({\pixel_data[15]_i_101_n_0 ,\pixel_data[15]_i_102_n_0 ,\pixel_data[15]_i_103_n_0 ,1'b0}),
        .O(\NLW_pixel_data_reg[15]_i_84_O_UNCONNECTED [3:0]),
        .S({\pixel_data[15]_i_104_n_0 ,\pixel_data[15]_i_105_n_0 ,\pixel_data[15]_i_106_n_0 ,pixel_index[1]}));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[0]_i_1 
       (.I0(spi_word__35[14]),
        .I1(\FSM_onehot_state[31]_i_1_n_0 ),
        .O(\spi_word[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[10]_i_1 
       (.I0(\spi_word_reg_n_0_[9] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[11]_i_1 
       (.I0(\spi_word_reg_n_0_[10] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[12]_i_1 
       (.I0(\spi_word_reg_n_0_[11] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \spi_word[13]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(\spi_word_reg_n_0_[12] ),
        .O(\spi_word[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[14]_i_1 
       (.I0(\spi_word_reg_n_0_[13] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00100000)) 
    \spi_word[14]_i_2 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[2]),
        .I3(fsm_next_state__72[3]),
        .I4(fsm_next_state__72[4]),
        .O(spi_word__35[14]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \spi_word[15]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(\spi_word_reg_n_0_[14] ),
        .O(\spi_word[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hC0C5C0C0)) 
    \spi_word[16]_i_1 
       (.I0(fsm_next_state__72[3]),
        .I1(\spi_word_reg_n_0_[15] ),
        .I2(p_0_in__0),
        .I3(\spi_word[20]_i_2_n_0 ),
        .I4(\spi_word[20]_i_3_n_0 ),
        .O(\spi_word[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hC0C5C0C0)) 
    \spi_word[17]_i_1 
       (.I0(fsm_next_state__72[3]),
        .I1(\spi_word_reg_n_0_[16] ),
        .I2(p_0_in__0),
        .I3(\spi_word[20]_i_2_n_0 ),
        .I4(\spi_word[20]_i_3_n_0 ),
        .O(\spi_word[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hC0C5C0C0)) 
    \spi_word[18]_i_1 
       (.I0(fsm_next_state__72[3]),
        .I1(\spi_word_reg_n_0_[17] ),
        .I2(p_0_in__0),
        .I3(\spi_word[20]_i_2_n_0 ),
        .I4(\spi_word[20]_i_3_n_0 ),
        .O(\spi_word[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hC0C5C0C0)) 
    \spi_word[19]_i_1 
       (.I0(fsm_next_state__72[3]),
        .I1(\spi_word_reg_n_0_[18] ),
        .I2(p_0_in__0),
        .I3(\spi_word[20]_i_2_n_0 ),
        .I4(\spi_word[20]_i_3_n_0 ),
        .O(\spi_word[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[1]_i_1 
       (.I0(\spi_word_reg_n_0_[0] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hC0C5C0C0)) 
    \spi_word[20]_i_1 
       (.I0(fsm_next_state__72[3]),
        .I1(\spi_word_reg_n_0_[19] ),
        .I2(p_0_in__0),
        .I3(\spi_word[20]_i_2_n_0 ),
        .I4(\spi_word[20]_i_3_n_0 ),
        .O(\spi_word[20]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \spi_word[20]_i_2 
       (.I0(fsm_next_state__72[2]),
        .I1(fsm_next_state__72[1]),
        .O(\spi_word[20]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hEA)) 
    \spi_word[20]_i_3 
       (.I0(fsm_next_state__72[4]),
        .I1(fsm_next_state__72[3]),
        .I2(fsm_next_state__72[2]),
        .O(\spi_word[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888B8888888888)) 
    \spi_word[21]_i_1 
       (.I0(\spi_word_reg_n_0_[20] ),
        .I1(p_0_in__0),
        .I2(fsm_next_state__72[2]),
        .I3(\spi_word[21]_i_2_n_0 ),
        .I4(fsm_next_state__72[3]),
        .I5(fsm_next_state__72[4]),
        .O(\spi_word[21]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \spi_word[21]_i_2 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[0]),
        .O(\spi_word[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8888888B88888888)) 
    \spi_word[22]_i_1 
       (.I0(\spi_word_reg_n_0_[21] ),
        .I1(p_0_in__0),
        .I2(fsm_next_state__72[2]),
        .I3(\spi_word[22]_i_3_n_0 ),
        .I4(fsm_next_state__72[3]),
        .I5(fsm_next_state__72[4]),
        .O(\spi_word[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_10 
       (.I0(\spi_word[22]_i_15_n_0 ),
        .I1(\spi_word[22]_i_13_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_state_reg_n_0_[5] ),
        .I5(\FSM_onehot_state_reg_n_0_[3] ),
        .O(\spi_word[22]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[22]_i_11 
       (.I0(p_2_in),
        .I1(p_4_in),
        .I2(\FSM_onehot_state_reg_n_0_[15] ),
        .I3(JC_OBUF[2]),
        .I4(\spi_word[22]_i_16_n_0 ),
        .O(\spi_word[22]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[22]_i_12 
       (.I0(\FSM_onehot_state_reg_n_0_[28] ),
        .I1(\FSM_onehot_state_reg_n_0_[30] ),
        .I2(\FSM_onehot_state_reg_n_0_[24] ),
        .I3(\FSM_onehot_state_reg_n_0_[25] ),
        .O(\spi_word[22]_i_12_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[22]_i_13 
       (.I0(\FSM_onehot_state_reg_n_0_[17] ),
        .I1(\FSM_onehot_state_reg_n_0_[16] ),
        .O(\spi_word[22]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[22]_i_14 
       (.I0(\FSM_onehot_state_reg_n_0_[18] ),
        .I1(\FSM_onehot_state_reg_n_0_[19] ),
        .I2(\FSM_onehot_state_reg_n_0_[14] ),
        .I3(\FSM_onehot_state_reg_n_0_[17] ),
        .O(\spi_word[22]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[22]_i_15 
       (.I0(\FSM_onehot_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_state_reg_n_0_[6] ),
        .O(\spi_word[22]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[22]_i_16 
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(p_3_in),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\spi_word[22]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\spi_word[22]_i_6_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_state[15]_i_2_n_0 ),
        .I4(\spi_word[22]_i_7_n_0 ),
        .I5(\spi_word[22]_i_8_n_0 ),
        .O(fsm_next_state__72[2]));
  LUT2 #(
    .INIT(4'hB)) 
    \spi_word[22]_i_3 
       (.I0(fsm_next_state__72[0]),
        .I1(fsm_next_state__72[1]),
        .O(\spi_word[22]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_4 
       (.I0(\spi_word[22]_i_9_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[31] ),
        .I2(\FSM_onehot_state_reg_n_0_[30] ),
        .I3(\FSM_onehot_state_reg_n_0_[25] ),
        .I4(\FSM_onehot_state_reg_n_0_[29] ),
        .I5(\spi_word[22]_i_10_n_0 ),
        .O(fsm_next_state__72[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[22]_i_5 
       (.I0(\FSM_onehot_state_reg_n_0_[29] ),
        .I1(\spi_word[22]_i_11_n_0 ),
        .I2(\spi_word[22]_i_12_n_0 ),
        .I3(\spi_word[22]_i_13_n_0 ),
        .I4(\FSM_onehot_state_reg_n_0_[19] ),
        .I5(\FSM_onehot_state_reg_n_0_[18] ),
        .O(fsm_next_state__72[4]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[22]_i_6 
       (.I0(\FSM_onehot_state_reg_n_0_[12] ),
        .I1(\FSM_onehot_state_reg_n_0_[31] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_state_reg_n_0_[7] ),
        .O(\spi_word[22]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[22]_i_7 
       (.I0(\FSM_onehot_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .O(\spi_word[22]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[22]_i_8 
       (.I0(\FSM_onehot_state_reg_n_0_[27] ),
        .I1(\FSM_onehot_state_reg_n_0_[26] ),
        .I2(\FSM_onehot_state_reg_n_0_[29] ),
        .I3(\FSM_onehot_state_reg_n_0_[28] ),
        .I4(\spi_word[22]_i_14_n_0 ),
        .O(\spi_word[22]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[22]_i_9 
       (.I0(\FSM_onehot_state_reg_n_0_[22] ),
        .I1(\FSM_onehot_state_reg_n_0_[24] ),
        .I2(\FSM_onehot_state_reg_n_0_[18] ),
        .I3(\FSM_onehot_state_reg_n_0_[21] ),
        .O(\spi_word[22]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \spi_word[23]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(\spi_word_reg_n_0_[22] ),
        .O(\spi_word[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[24]_i_1 
       (.I0(\spi_word_reg_n_0_[23] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[24]),
        .O(\spi_word[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000F000F0300008)) 
    \spi_word[24]_i_2 
       (.I0(Q[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[1]),
        .I5(fsm_next_state__72[0]),
        .O(spi_word__35[24]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[25]_i_1 
       (.I0(\spi_word_reg_n_0_[24] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[25]),
        .O(\spi_word[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h33C030C330C00008)) 
    \spi_word[25]_i_2 
       (.I0(Q[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[25]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[26]_i_1 
       (.I0(\spi_word_reg_n_0_[25] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[26]),
        .O(\spi_word[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h30C000C0F03000C8)) 
    \spi_word[26]_i_2 
       (.I0(Q[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[26]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[27]_i_1 
       (.I0(\spi_word_reg_n_0_[26] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[27]),
        .O(\spi_word[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h30C0F0C030000038)) 
    \spi_word[27]_i_2 
       (.I0(Q[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[1]),
        .I5(fsm_next_state__72[0]),
        .O(spi_word__35[27]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[28]_i_1 
       (.I0(\spi_word_reg_n_0_[27] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[28]),
        .O(\spi_word[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC3F0C033F0C00038)) 
    \spi_word[28]_i_2 
       (.I0(Q[0]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[28]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[29]_i_1 
       (.I0(\spi_word_reg_n_0_[28] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[29]),
        .O(\spi_word[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h03F00000F0F030F8)) 
    \spi_word[29]_i_2 
       (.I0(Q[1]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[1]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[2]),
        .O(spi_word__35[29]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[2]_i_1 
       (.I0(\spi_word_reg_n_0_[1] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[30]_i_1 
       (.I0(\spi_word_reg_n_0_[29] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[30]),
        .O(\spi_word[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC3C00000303000F8)) 
    \spi_word[30]_i_2 
       (.I0(Q[1]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[1]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[2]),
        .O(spi_word__35[30]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[31]_i_1 
       (.I0(\spi_word_reg_n_0_[30] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[31]),
        .O(\spi_word[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0000040)) 
    \spi_word[31]_i_2 
       (.I0(fsm_next_state__72[2]),
        .I1(Q[1]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[3]),
        .I4(fsm_next_state__72[1]),
        .I5(fsm_next_state__72[0]),
        .O(spi_word__35[31]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[32]_i_1 
       (.I0(\spi_word_reg_n_0_[31] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[32]),
        .O(\spi_word[32]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3C3CC3C0C0FFCC38)) 
    \spi_word[32]_i_2 
       (.I0(Q[1]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[1]),
        .I5(fsm_next_state__72[0]),
        .O(spi_word__35[32]));
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[33]_i_1 
       (.I0(\spi_word_reg_n_0_[32] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[33]),
        .O(\spi_word[33]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCC00303F0F0C038)) 
    \spi_word[33]_i_2 
       (.I0(Q[1]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[1]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[2]),
        .O(spi_word__35[33]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[34]_i_1 
       (.I0(\spi_word_reg_n_0_[33] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[34]),
        .O(\spi_word[34]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3CCC03CF0000FCC8)) 
    \spi_word[34]_i_2 
       (.I0(Q[1]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[2]),
        .I4(fsm_next_state__72[0]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[34]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[35]_i_1 
       (.I0(\spi_word_reg_n_0_[34] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[35]),
        .O(\spi_word[35]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3C03C0033000F0F8)) 
    \spi_word[35]_i_2 
       (.I0(Q[2]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[0]),
        .I4(fsm_next_state__72[2]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[35]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[36]_i_1 
       (.I0(\spi_word_reg_n_0_[35] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[36]),
        .O(\spi_word[36]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0030FC3F0000C008)) 
    \spi_word[36]_i_2 
       (.I0(Q[2]),
        .I1(fsm_next_state__72[4]),
        .I2(fsm_next_state__72[3]),
        .I3(fsm_next_state__72[0]),
        .I4(fsm_next_state__72[2]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[36]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[37]_i_1 
       (.I0(\spi_word_reg_n_0_[36] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[37]),
        .O(\spi_word[37]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0FCFCFC33F3FC020)) 
    \spi_word[37]_i_2 
       (.I0(Q[2]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[3]),
        .I4(fsm_next_state__72[2]),
        .I5(fsm_next_state__72[1]),
        .O(spi_word__35[37]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[38]_i_1 
       (.I0(\spi_word_reg_n_0_[37] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[38]),
        .O(\spi_word[38]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0009000200080002)) 
    \spi_word[38]_i_2 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[2]),
        .I3(fsm_next_state__72[3]),
        .I4(fsm_next_state__72[4]),
        .I5(Q[2]),
        .O(spi_word__35[38]));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \spi_word[39]_i_1 
       (.I0(p_1_in),
        .I1(spi_word_bit_count_reg__0[5]),
        .I2(spi_word_bit_count_reg__0[4]),
        .I3(spi_word_bit_count_reg__0[2]),
        .I4(spi_word_bit_count_reg__0[1]),
        .I5(spi_word_bit_count_reg__0[3]),
        .O(\spi_word[39]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[39]_i_10 
       (.I0(p_2_in),
        .I1(\FSM_onehot_state_reg_n_0_[14] ),
        .I2(p_3_in),
        .I3(\FSM_onehot_state_reg_n_0_[29] ),
        .O(\spi_word[39]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hAAAA2AAA)) 
    \spi_word[39]_i_11 
       (.I0(p_4_in),
        .I1(\pixel_data[15]_i_27_n_0 ),
        .I2(\spi_word[39]_i_15_n_0 ),
        .I3(\spi_word[39]_i_16_n_0 ),
        .I4(\pixel_data[15]_i_9_n_0 ),
        .O(\spi_word[39]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[39]_i_12 
       (.I0(\FSM_onehot_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .O(\spi_word[39]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[39]_i_13 
       (.I0(\FSM_onehot_state_reg_n_0_[25] ),
        .I1(\FSM_onehot_state_reg_n_0_[24] ),
        .I2(\FSM_onehot_state_reg_n_0_[28] ),
        .I3(\FSM_onehot_state_reg_n_0_[26] ),
        .I4(\spi_word[39]_i_17_n_0 ),
        .O(\spi_word[39]_i_13_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[39]_i_14 
       (.I0(\FSM_onehot_state_reg_n_0_[19] ),
        .I1(\FSM_onehot_state_reg_n_0_[18] ),
        .O(\spi_word[39]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \spi_word[39]_i_15 
       (.I0(p_0_in_0[4]),
        .I1(p_0_in_0[3]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[1]),
        .O(\spi_word[39]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \spi_word[39]_i_16 
       (.I0(p_0_in_0[11]),
        .I1(p_0_in_0[12]),
        .I2(p_0_in_0[10]),
        .I3(p_0_in_0[9]),
        .O(\spi_word[39]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[39]_i_17 
       (.I0(\FSM_onehot_state_reg_n_0_[21] ),
        .I1(\FSM_onehot_state_reg_n_0_[23] ),
        .I2(\FSM_onehot_state_reg_n_0_[18] ),
        .I3(\FSM_onehot_state_reg_n_0_[20] ),
        .O(\spi_word[39]_i_17_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[39]_i_2 
       (.I0(\spi_word_reg_n_0_[38] ),
        .I1(p_0_in__0),
        .I2(\spi_word[39]_i_4_n_0 ),
        .O(\spi_word[39]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \spi_word[39]_i_3 
       (.I0(spi_word_bit_count_reg__0[3]),
        .I1(spi_word_bit_count_reg__0[1]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[4]),
        .I4(spi_word_bit_count_reg__0[5]),
        .O(p_0_in__0));
  LUT6 #(
    .INIT(64'hEFEF8180FFFFF2F2)) 
    \spi_word[39]_i_4 
       (.I0(fsm_next_state__72[1]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[2]),
        .I3(Q[2]),
        .I4(fsm_next_state__72[3]),
        .I5(fsm_next_state__72[4]),
        .O(\spi_word[39]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[39]_i_5 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(\spi_word[39]_i_7_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[3] ),
        .I3(\FSM_onehot_state[15]_i_2_n_0 ),
        .I4(\spi_word[39]_i_8_n_0 ),
        .I5(\spi_word[39]_i_9_n_0 ),
        .O(fsm_next_state__72[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[39]_i_6 
       (.I0(\FSM_onehot_state_reg_n_0_[3] ),
        .I1(\spi_word[39]_i_10_n_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(\spi_word[39]_i_11_n_0 ),
        .I4(\spi_word[39]_i_12_n_0 ),
        .I5(\spi_word[39]_i_13_n_0 ),
        .O(fsm_next_state__72[0]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \spi_word[39]_i_7 
       (.I0(\FSM_onehot_state_reg_n_0_[12] ),
        .I1(\FSM_onehot_state_reg_n_0_[28] ),
        .I2(p_2_in),
        .I3(\FSM_onehot_state_reg_n_0_[11] ),
        .O(\spi_word[39]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \spi_word[39]_i_8 
       (.I0(\FSM_onehot_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .O(\spi_word[39]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \spi_word[39]_i_9 
       (.I0(\spi_word[39]_i_14_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[24] ),
        .I2(\FSM_onehot_state_reg_n_0_[20] ),
        .I3(\FSM_onehot_state_reg_n_0_[15] ),
        .I4(\FSM_onehot_state_reg_n_0_[14] ),
        .I5(\spi_word[22]_i_13_n_0 ),
        .O(\spi_word[39]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[3]_i_1 
       (.I0(\spi_word_reg_n_0_[2] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[4]_i_1 
       (.I0(\spi_word_reg_n_0_[3] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[5]_i_1 
       (.I0(\spi_word_reg_n_0_[4] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \spi_word[6]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(\spi_word_reg_n_0_[5] ),
        .O(\spi_word[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \spi_word[7]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(\spi_word_reg_n_0_[6] ),
        .O(\spi_word[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[8]_i_1 
       (.I0(\spi_word_reg_n_0_[7] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \spi_word[9]_i_1 
       (.I0(\spi_word_reg_n_0_[8] ),
        .I1(p_0_in__0),
        .I2(spi_word__35[14]),
        .O(\spi_word[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFFFFFFE)) 
    \spi_word_bit_count[0]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(spi_word_bit_count_reg__0[0]),
        .O(\spi_word_bit_count[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF00000000FFFE)) 
    \spi_word_bit_count[1]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[3]),
        .I4(spi_word_bit_count_reg__0[1]),
        .I5(spi_word_bit_count_reg__0[0]),
        .O(\spi_word_bit_count[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF00FF00FF0000FE)) 
    \spi_word_bit_count[2]_i_1 
       (.I0(spi_word_bit_count_reg__0[5]),
        .I1(spi_word_bit_count_reg__0[4]),
        .I2(spi_word_bit_count_reg__0[3]),
        .I3(spi_word_bit_count_reg__0[2]),
        .I4(spi_word_bit_count_reg__0[0]),
        .I5(spi_word_bit_count_reg__0[1]),
        .O(\spi_word_bit_count[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE01FFFFFE010000)) 
    \spi_word_bit_count[3]_i_1 
       (.I0(spi_word_bit_count_reg__0[1]),
        .I1(spi_word_bit_count_reg__0[0]),
        .I2(spi_word_bit_count_reg__0[2]),
        .I3(spi_word_bit_count_reg__0[3]),
        .I4(p_0_in__0),
        .I5(\spi_word_bit_count[3]_i_2_n_0 ),
        .O(p_0_in[3]));
  LUT5 #(
    .INIT(32'h0404B440)) 
    \spi_word_bit_count[3]_i_2 
       (.I0(fsm_next_state__72[0]),
        .I1(fsm_next_state__72[2]),
        .I2(fsm_next_state__72[1]),
        .I3(fsm_next_state__72[4]),
        .I4(fsm_next_state__72[3]),
        .O(\spi_word_bit_count[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFDD591A)) 
    \spi_word_bit_count[4]_i_2 
       (.I0(fsm_next_state__72[2]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[1]),
        .I4(fsm_next_state__72[3]),
        .O(\spi_word_bit_count[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    \spi_word_bit_count[4]_i_3 
       (.I0(spi_word_bit_count_reg__0[3]),
        .I1(spi_word_bit_count_reg__0[2]),
        .I2(spi_word_bit_count_reg__0[0]),
        .I3(spi_word_bit_count_reg__0[1]),
        .I4(spi_word_bit_count_reg__0[4]),
        .O(\spi_word_bit_count[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000020)) 
    \spi_word_bit_count[5]_i_2 
       (.I0(fsm_next_state__72[2]),
        .I1(fsm_next_state__72[0]),
        .I2(fsm_next_state__72[4]),
        .I3(fsm_next_state__72[3]),
        .I4(fsm_next_state__72[1]),
        .O(\spi_word_bit_count[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    \spi_word_bit_count[5]_i_3 
       (.I0(spi_word_bit_count_reg__0[4]),
        .I1(spi_word_bit_count_reg__0[1]),
        .I2(spi_word_bit_count_reg__0[0]),
        .I3(spi_word_bit_count_reg__0[2]),
        .I4(spi_word_bit_count_reg__0[3]),
        .I5(spi_word_bit_count_reg__0[5]),
        .O(\spi_word_bit_count[5]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[0] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word_bit_count[0]_i_1_n_0 ),
        .Q(spi_word_bit_count_reg__0[0]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[1] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word_bit_count[1]_i_1_n_0 ),
        .Q(spi_word_bit_count_reg__0[1]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[2] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word_bit_count[2]_i_1_n_0 ),
        .Q(spi_word_bit_count_reg__0[2]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[3] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(spi_word_bit_count_reg__0[3]),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[4] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(spi_word_bit_count_reg__0[4]),
        .R(\spi_word[39]_i_1_n_0 ));
  MUXF7 \spi_word_bit_count_reg[4]_i_1 
       (.I0(\spi_word_bit_count[4]_i_2_n_0 ),
        .I1(\spi_word_bit_count[4]_i_3_n_0 ),
        .O(p_0_in[4]),
        .S(p_0_in__0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_bit_count_reg[5] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(p_0_in[5]),
        .Q(spi_word_bit_count_reg__0[5]),
        .R(\spi_word[39]_i_1_n_0 ));
  MUXF7 \spi_word_bit_count_reg[5]_i_1 
       (.I0(\spi_word_bit_count[5]_i_2_n_0 ),
        .I1(\spi_word_bit_count[5]_i_3_n_0 ),
        .O(p_0_in[5]),
        .S(p_0_in__0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[0] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[0]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[10] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[10]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[10] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[11] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[11]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[11] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[12] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[12]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[12] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[13] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[13]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[13] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[14] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[14]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[14] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[15] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[15]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[15] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[16] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[16]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[16] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[17] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[17]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[17] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[18] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[18]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[18] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[19] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[19]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[19] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[1] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[1]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[1] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[20] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[20]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[20] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[21] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[21]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[21] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[22] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[22]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[22] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[23] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[23]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[23] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[24] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[24]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[24] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[25] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[25]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[25] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[26] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[26]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[26] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[27] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[27]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[27] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[28] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[28]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[28] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[29] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[29]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[29] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[2] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[2]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[2] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[30] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[30]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[30] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[31] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[31]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[31] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[32] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[32]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[32] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[33] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[33]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[33] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[34] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[34]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[34] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[35] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[35]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[35] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[36] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[36]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[36] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[37] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[37]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[37] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[38] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[38]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[38] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[39] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[39]_i_2_n_0 ),
        .Q(\spi_word_reg_n_0_[39] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[3] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[3]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[3] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[4] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[4]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[4] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[5] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[5]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[5] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[6] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[6]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[6] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[7] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[7]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[7] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[8] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[8]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[8] ),
        .R(\spi_word[39]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \spi_word_reg[9] 
       (.C(scr_clk_BUFG),
        .CE(1'b1),
        .D(\spi_word[9]_i_1_n_0 ),
        .Q(\spi_word_reg_n_0_[9] ),
        .R(\spi_word[39]_i_1_n_0 ));
endmodule

(* ECO_CHECKSUM = "82abdcb0" *) 
(* NotValidForBitStream *)
module Top_Student
   (CLOCK,
    btn,
    JC);
  input CLOCK;
  input [2:0]btn;
  output [7:0]JC;

  wire CLOCK;
  wire CLOCK_IBUF;
  wire CLOCK_IBUF_BUFG;
  wire [7:0]JC;
  wire [6:0]JC_OBUF;
  wire [2:0]btn;
  wire [2:0]btn_IBUF;
  wire [15:4]center_color;
  wire [2:0]ctr_state;
  wire \ctr_state[0]_i_1_n_0 ;
  wire \ctr_state[1]_i_1_n_0 ;
  wire \ctr_state[2]_i_1_n_0 ;
  wire frame_begin;
  wire [15:4]\frame_buff_reg[28][28]__0 ;
  wire [15:4]\frame_buff_reg[28][57]__0 ;
  wire [15:4]\frame_buff_reg[28][86]__0 ;
  wire [15:4]left_color;
  wire [2:0]left_state;
  wire \left_state[0]_i_1_n_0 ;
  wire \left_state[1]_i_1_n_0 ;
  wire \left_state[2]_i_1_n_0 ;
  wire oled_n_10;
  wire oled_n_11;
  wire oled_n_12;
  wire oled_n_13;
  wire oled_n_14;
  wire oled_n_15;
  wire oled_n_6;
  wire oled_n_7;
  wire oled_n_8;
  wire oled_n_9;
  wire [15:4]pixel_data;
  wire \pixel_data[15]_i_13_n_0 ;
  wire \pixel_data[15]_i_42_n_0 ;
  wire \pixel_data[15]_i_43_n_0 ;
  wire \pixel_data[15]_i_44_n_0 ;
  wire \pixel_data[15]_i_45_n_0 ;
  wire \pixel_data[15]_i_62_n_0 ;
  wire \pixel_data[15]_i_63_n_0 ;
  wire \pixel_data[15]_i_64_n_0 ;
  wire \pixel_data_reg[15]_i_19_n_4 ;
  wire \pixel_data_reg[15]_i_19_n_5 ;
  wire \pixel_data_reg[15]_i_19_n_6 ;
  wire \pixel_data_reg[15]_i_19_n_7 ;
  wire \pixel_data_reg[15]_i_41_n_0 ;
  wire \pixel_data_reg[15]_i_41_n_4 ;
  wire \pixel_data_reg[15]_i_41_n_5 ;
  wire \pixel_data_reg[15]_i_41_n_6 ;
  wire \pixel_data_reg[15]_i_41_n_7 ;
  wire [15:4]right_color;
  wire [2:0]right_state;
  wire \right_state[0]_i_1_n_0 ;
  wire \right_state[1]_i_1_n_0 ;
  wire \right_state[2]_i_1_n_0 ;
  wire scr_clk;
  wire scr_clk_BUFG;
  wire spi_busy__4;
  wire [3:0]\NLW_pixel_data_reg[15]_i_19_CO_UNCONNECTED ;
  wire [2:0]\NLW_pixel_data_reg[15]_i_41_CO_UNCONNECTED ;

initial begin
 $sdf_annotate("Top_Student_time_impl.sdf",,,,"tool_control");
end
  BUFG CLOCK_IBUF_BUFG_inst
       (.I(CLOCK_IBUF),
        .O(CLOCK_IBUF_BUFG));
  IBUF CLOCK_IBUF_inst
       (.I(CLOCK),
        .O(CLOCK_IBUF));
  OBUF \JC_OBUF[0]_inst 
       (.I(JC_OBUF[0]),
        .O(JC[0]));
  OBUF \JC_OBUF[1]_inst 
       (.I(JC_OBUF[1]),
        .O(JC[1]));
  OBUFT \JC_OBUF[2]_inst 
       (.I(1'b0),
        .O(JC[2]),
        .T(1'b1));
  OBUF \JC_OBUF[3]_inst 
       (.I(JC_OBUF[3]),
        .O(JC[3]));
  OBUF \JC_OBUF[4]_inst 
       (.I(JC_OBUF[4]),
        .O(JC[4]));
  OBUF \JC_OBUF[5]_inst 
       (.I(JC_OBUF[5]),
        .O(JC[5]));
  OBUF \JC_OBUF[6]_inst 
       (.I(JC_OBUF[6]),
        .O(JC[6]));
  OBUF \JC_OBUF[7]_inst 
       (.I(1'b1),
        .O(JC[7]));
  IBUF \btn_IBUF[0]_inst 
       (.I(btn[0]),
        .O(btn_IBUF[0]));
  IBUF \btn_IBUF[1]_inst 
       (.I(btn[1]),
        .O(btn_IBUF[1]));
  IBUF \btn_IBUF[2]_inst 
       (.I(btn[2]),
        .O(btn_IBUF[2]));
  next_color centernc
       (.Q({center_color[15],center_color[10],center_color[4]}),
        .ctr_state(ctr_state));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h112A)) 
    \ctr_state[0]_i_1 
       (.I0(btn_IBUF[0]),
        .I1(ctr_state[2]),
        .I2(ctr_state[1]),
        .I3(ctr_state[0]),
        .O(\ctr_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h1230)) 
    \ctr_state[1]_i_1 
       (.I0(btn_IBUF[0]),
        .I1(ctr_state[2]),
        .I2(ctr_state[1]),
        .I3(ctr_state[0]),
        .O(\ctr_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h200C)) 
    \ctr_state[2]_i_1 
       (.I0(btn_IBUF[0]),
        .I1(ctr_state[2]),
        .I2(ctr_state[1]),
        .I3(ctr_state[0]),
        .O(\ctr_state[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b1)) 
    \ctr_state_reg[0] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ctr_state[0]_i_1_n_0 ),
        .Q(ctr_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \ctr_state_reg[1] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ctr_state[1]_i_1_n_0 ),
        .Q(ctr_state[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ctr_state_reg[2] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ctr_state[2]_i_1_n_0 ),
        .Q(ctr_state[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][28][10] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(left_color[10]),
        .Q(\frame_buff_reg[28][28]__0 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][28][15] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(left_color[15]),
        .Q(\frame_buff_reg[28][28]__0 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][28][4] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(left_color[4]),
        .Q(\frame_buff_reg[28][28]__0 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][57][10] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(center_color[10]),
        .Q(\frame_buff_reg[28][57]__0 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][57][15] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(center_color[15]),
        .Q(\frame_buff_reg[28][57]__0 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][57][4] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(center_color[4]),
        .Q(\frame_buff_reg[28][57]__0 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][86][10] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(right_color[10]),
        .Q(\frame_buff_reg[28][86]__0 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][86][15] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(right_color[15]),
        .Q(\frame_buff_reg[28][86]__0 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \frame_buff_reg[28][86][4] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(right_color[4]),
        .Q(\frame_buff_reg[28][86]__0 [4]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h112A)) 
    \left_state[0]_i_1 
       (.I0(btn_IBUF[1]),
        .I1(left_state[2]),
        .I2(left_state[1]),
        .I3(left_state[0]),
        .O(\left_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h1230)) 
    \left_state[1]_i_1 
       (.I0(btn_IBUF[1]),
        .I1(left_state[2]),
        .I2(left_state[1]),
        .I3(left_state[0]),
        .O(\left_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h200C)) 
    \left_state[2]_i_1 
       (.I0(btn_IBUF[1]),
        .I1(left_state[2]),
        .I2(left_state[1]),
        .I3(left_state[0]),
        .O(\left_state[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \left_state_reg[0] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\left_state[0]_i_1_n_0 ),
        .Q(left_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \left_state_reg[1] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\left_state[1]_i_1_n_0 ),
        .Q(left_state[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \left_state_reg[2] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\left_state[2]_i_1_n_0 ),
        .Q(left_state[2]),
        .R(1'b0));
  next_color_0 leftnc
       (.Q({left_color[15],left_color[10],left_color[4]}),
        .left_state(left_state));
  Oled_Display oled
       (.CLK(frame_begin),
        .CO(oled_n_11),
        .D({oled_n_6,oled_n_7,oled_n_8}),
        .\FSM_onehot_state_reg[13]_0 (\pixel_data[15]_i_13_n_0 ),
        .\FSM_onehot_state_reg[13]_1 ({\pixel_data_reg[15]_i_19_n_4 ,\pixel_data_reg[15]_i_19_n_5 ,\pixel_data_reg[15]_i_19_n_6 ,\pixel_data_reg[15]_i_19_n_7 }),
        .JC_OBUF({JC_OBUF[6:4],JC_OBUF[1:0]}),
        .O({oled_n_9,oled_n_10}),
        .Q({pixel_data[15],pixel_data[10],pixel_data[4]}),
        .\frame_buff_reg[28][28][15] ({\frame_buff_reg[28][28]__0 [15],\frame_buff_reg[28][28]__0 [10],\frame_buff_reg[28][28]__0 [4]}),
        .\frame_buff_reg[28][57][15] ({\frame_buff_reg[28][57]__0 [15],\frame_buff_reg[28][57]__0 [10],\frame_buff_reg[28][57]__0 [4]}),
        .\frame_buff_reg[28][86][15] ({\frame_buff_reg[28][86]__0 [15],\frame_buff_reg[28][86]__0 [10],\frame_buff_reg[28][86]__0 [4]}),
        .\frame_counter_reg[13]_0 ({\pixel_data_reg[15]_i_41_n_4 ,\pixel_data_reg[15]_i_41_n_5 ,\pixel_data_reg[15]_i_41_n_6 ,\pixel_data_reg[15]_i_41_n_7 }),
        .\pixel_data_reg[4] ({oled_n_12,oled_n_13,oled_n_14,oled_n_15}),
        .scr_clk_BUFG(scr_clk_BUFG),
        .screen_reg(scr_clk_BUFG),
        .spi_busy__4(spi_busy__4));
  LUT5 #(
    .INIT(32'h80000000)) 
    \pixel_data[15]_i_13 
       (.I0(oled_n_10),
        .I1(oled_n_13),
        .I2(oled_n_15),
        .I3(oled_n_14),
        .I4(oled_n_12),
        .O(\pixel_data[15]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \pixel_data[15]_i_42 
       (.I0(oled_n_9),
        .O(\pixel_data[15]_i_42_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pixel_data[15]_i_43 
       (.I0(oled_n_10),
        .I1(oled_n_11),
        .O(\pixel_data[15]_i_43_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pixel_data[15]_i_44 
       (.I0(oled_n_12),
        .I1(oled_n_9),
        .O(\pixel_data[15]_i_44_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pixel_data[15]_i_45 
       (.I0(oled_n_13),
        .I1(oled_n_10),
        .O(\pixel_data[15]_i_45_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pixel_data[15]_i_62 
       (.I0(oled_n_14),
        .I1(oled_n_12),
        .O(\pixel_data[15]_i_62_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \pixel_data[15]_i_63 
       (.I0(oled_n_15),
        .I1(oled_n_13),
        .O(\pixel_data[15]_i_63_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \pixel_data[15]_i_64 
       (.I0(oled_n_14),
        .O(\pixel_data[15]_i_64_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \pixel_data_reg[10] 
       (.C(frame_begin),
        .CE(1'b1),
        .D(oled_n_7),
        .Q(pixel_data[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \pixel_data_reg[15] 
       (.C(frame_begin),
        .CE(1'b1),
        .D(oled_n_6),
        .Q(pixel_data[15]),
        .R(1'b0));
  CARRY4 \pixel_data_reg[15]_i_19 
       (.CI(\pixel_data_reg[15]_i_41_n_0 ),
        .CO(\NLW_pixel_data_reg[15]_i_19_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,oled_n_10,oled_n_12,oled_n_13}),
        .O({\pixel_data_reg[15]_i_19_n_4 ,\pixel_data_reg[15]_i_19_n_5 ,\pixel_data_reg[15]_i_19_n_6 ,\pixel_data_reg[15]_i_19_n_7 }),
        .S({\pixel_data[15]_i_42_n_0 ,\pixel_data[15]_i_43_n_0 ,\pixel_data[15]_i_44_n_0 ,\pixel_data[15]_i_45_n_0 }));
  CARRY4 \pixel_data_reg[15]_i_41 
       (.CI(1'b0),
        .CO({\pixel_data_reg[15]_i_41_n_0 ,\NLW_pixel_data_reg[15]_i_41_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({oled_n_14,oled_n_15,1'b0,1'b1}),
        .O({\pixel_data_reg[15]_i_41_n_4 ,\pixel_data_reg[15]_i_41_n_5 ,\pixel_data_reg[15]_i_41_n_6 ,\pixel_data_reg[15]_i_41_n_7 }),
        .S({\pixel_data[15]_i_62_n_0 ,\pixel_data[15]_i_63_n_0 ,\pixel_data[15]_i_64_n_0 ,oled_n_15}));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \pixel_data_reg[4] 
       (.C(frame_begin),
        .CE(1'b1),
        .D(oled_n_8),
        .Q(pixel_data[4]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h112A)) 
    \right_state[0]_i_1 
       (.I0(btn_IBUF[2]),
        .I1(right_state[2]),
        .I2(right_state[1]),
        .I3(right_state[0]),
        .O(\right_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h1230)) 
    \right_state[1]_i_1 
       (.I0(btn_IBUF[2]),
        .I1(right_state[2]),
        .I2(right_state[1]),
        .I3(right_state[0]),
        .O(\right_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h200C)) 
    \right_state[2]_i_1 
       (.I0(btn_IBUF[2]),
        .I1(right_state[2]),
        .I2(right_state[1]),
        .I3(right_state[0]),
        .O(\right_state[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b1)) 
    \right_state_reg[0] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\right_state[0]_i_1_n_0 ),
        .Q(right_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \right_state_reg[1] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\right_state[1]_i_1_n_0 ),
        .Q(right_state[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \right_state_reg[2] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\right_state[2]_i_1_n_0 ),
        .Q(right_state[2]),
        .R(1'b0));
  next_color_1 rightnc
       (.Q({right_color[15],right_color[10],right_color[4]}),
        .right_state(right_state));
  screen_625mhz scr
       (.CLOCK_IBUF_BUFG(CLOCK_IBUF_BUFG),
        .JC_OBUF(JC_OBUF[3]),
        .scr_clk(scr_clk),
        .spi_busy__4(spi_busy__4));
  BUFG scr_clk_BUFG_inst
       (.I(scr_clk),
        .O(scr_clk_BUFG));
endmodule

module next_color
   (Q,
    ctr_state);
  output [2:0]Q;
  input [2:0]ctr_state;

  wire [2:0]Q;
  wire \color_out_inferred__0/i__n_0 ;
  wire \color_out_reg[10]_i_1_n_0 ;
  wire \color_out_reg[15]_i_1_n_0 ;
  wire \color_out_reg[4]_i_1_n_0 ;
  wire [2:0]ctr_state;

  LUT3 #(
    .INIT(8'h57)) 
    \color_out_inferred__0/i_ 
       (.I0(ctr_state[2]),
        .I1(ctr_state[1]),
        .I2(ctr_state[0]),
        .O(\color_out_inferred__0/i__n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[10] 
       (.CLR(1'b0),
        .D(\color_out_reg[10]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[1]));
  LUT2 #(
    .INIT(4'hE)) 
    \color_out_reg[10]_i_1 
       (.I0(ctr_state[2]),
        .I1(ctr_state[1]),
        .O(\color_out_reg[10]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[15] 
       (.CLR(1'b0),
        .D(\color_out_reg[15]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \color_out_reg[15]_i_1 
       (.I0(ctr_state[0]),
        .O(\color_out_reg[15]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[4] 
       (.CLR(1'b0),
        .D(\color_out_reg[4]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[0]));
  LUT3 #(
    .INIT(8'h0E)) 
    \color_out_reg[4]_i_1 
       (.I0(ctr_state[0]),
        .I1(ctr_state[2]),
        .I2(ctr_state[1]),
        .O(\color_out_reg[4]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "next_color" *) 
module next_color_0
   (Q,
    left_state);
  output [2:0]Q;
  input [2:0]left_state;

  wire [2:0]Q;
  wire \color_out_inferred__0/i__n_0 ;
  wire \color_out_reg[10]_i_1_n_0 ;
  wire \color_out_reg[15]_i_1_n_0 ;
  wire \color_out_reg[4]_i_1_n_0 ;
  wire [2:0]left_state;

  LUT3 #(
    .INIT(8'h57)) 
    \color_out_inferred__0/i_ 
       (.I0(left_state[2]),
        .I1(left_state[1]),
        .I2(left_state[0]),
        .O(\color_out_inferred__0/i__n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[10] 
       (.CLR(1'b0),
        .D(\color_out_reg[10]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[1]));
  LUT2 #(
    .INIT(4'hE)) 
    \color_out_reg[10]_i_1 
       (.I0(left_state[2]),
        .I1(left_state[1]),
        .O(\color_out_reg[10]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[15] 
       (.CLR(1'b0),
        .D(\color_out_reg[15]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \color_out_reg[15]_i_1 
       (.I0(left_state[0]),
        .O(\color_out_reg[15]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[4] 
       (.CLR(1'b0),
        .D(\color_out_reg[4]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[0]));
  LUT3 #(
    .INIT(8'h0E)) 
    \color_out_reg[4]_i_1 
       (.I0(left_state[0]),
        .I1(left_state[2]),
        .I2(left_state[1]),
        .O(\color_out_reg[4]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "next_color" *) 
module next_color_1
   (Q,
    right_state);
  output [2:0]Q;
  input [2:0]right_state;

  wire [2:0]Q;
  wire \color_out_inferred__0/i__n_0 ;
  wire \color_out_reg[10]_i_1_n_0 ;
  wire \color_out_reg[15]_i_1_n_0 ;
  wire \color_out_reg[4]_i_1_n_0 ;
  wire [2:0]right_state;

  LUT3 #(
    .INIT(8'h57)) 
    \color_out_inferred__0/i_ 
       (.I0(right_state[2]),
        .I1(right_state[1]),
        .I2(right_state[0]),
        .O(\color_out_inferred__0/i__n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[10] 
       (.CLR(1'b0),
        .D(\color_out_reg[10]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[1]));
  LUT2 #(
    .INIT(4'hE)) 
    \color_out_reg[10]_i_1 
       (.I0(right_state[2]),
        .I1(right_state[1]),
        .O(\color_out_reg[10]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[15] 
       (.CLR(1'b0),
        .D(\color_out_reg[15]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \color_out_reg[15]_i_1 
       (.I0(right_state[0]),
        .O(\color_out_reg[15]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    \color_out_reg[4] 
       (.CLR(1'b0),
        .D(\color_out_reg[4]_i_1_n_0 ),
        .G(\color_out_inferred__0/i__n_0 ),
        .GE(1'b1),
        .Q(Q[0]));
  LUT3 #(
    .INIT(8'h0E)) 
    \color_out_reg[4]_i_1 
       (.I0(right_state[0]),
        .I1(right_state[2]),
        .I2(right_state[1]),
        .O(\color_out_reg[4]_i_1_n_0 ));
endmodule

module screen_625mhz
   (scr_clk,
    JC_OBUF,
    CLOCK_IBUF_BUFG,
    spi_busy__4);
  output scr_clk;
  output [0:0]JC_OBUF;
  input CLOCK_IBUF_BUFG;
  input spi_busy__4;

  wire CLOCK_IBUF_BUFG;
  wire [3:0]COUNT;
  wire \COUNT[0]_i_1_n_0 ;
  wire \COUNT[1]_i_1_n_0 ;
  wire \COUNT[2]_i_1_n_0 ;
  wire \COUNT[3]_i_1_n_0 ;
  wire \COUNT[3]_i_2_n_0 ;
  wire [0:0]JC_OBUF;
  wire scr_clk;
  wire screen_i_1_n_0;
  wire spi_busy__4;

  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \COUNT[0]_i_1 
       (.I0(COUNT[0]),
        .O(\COUNT[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \COUNT[1]_i_1 
       (.I0(COUNT[0]),
        .I1(COUNT[1]),
        .O(\COUNT[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \COUNT[2]_i_1 
       (.I0(COUNT[0]),
        .I1(COUNT[1]),
        .I2(COUNT[2]),
        .O(\COUNT[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \COUNT[3]_i_1 
       (.I0(COUNT[3]),
        .I1(COUNT[2]),
        .I2(COUNT[0]),
        .I3(COUNT[1]),
        .O(\COUNT[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \COUNT[3]_i_2 
       (.I0(COUNT[1]),
        .I1(COUNT[0]),
        .I2(COUNT[2]),
        .I3(COUNT[3]),
        .O(\COUNT[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \COUNT_reg[0] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\COUNT[0]_i_1_n_0 ),
        .Q(COUNT[0]),
        .R(\COUNT[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \COUNT_reg[1] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\COUNT[1]_i_1_n_0 ),
        .Q(COUNT[1]),
        .R(\COUNT[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \COUNT_reg[2] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\COUNT[2]_i_1_n_0 ),
        .Q(COUNT[2]),
        .R(\COUNT[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \COUNT_reg[3] 
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(\COUNT[3]_i_2_n_0 ),
        .Q(COUNT[3]),
        .R(\COUNT[3]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \JC_OBUF[3]_inst_i_1 
       (.I0(scr_clk),
        .I1(spi_busy__4),
        .O(JC_OBUF));
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    screen_i_1
       (.I0(COUNT[1]),
        .I1(COUNT[0]),
        .I2(COUNT[2]),
        .I3(COUNT[3]),
        .I4(scr_clk),
        .O(screen_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    screen_reg
       (.C(CLOCK_IBUF_BUFG),
        .CE(1'b1),
        .D(screen_i_1_n_0),
        .Q(scr_clk),
        .R(1'b0));
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
