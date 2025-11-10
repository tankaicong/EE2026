// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon Nov 10 03:28:35 2025
// Host        : kc-ThinkPad-T14-Gen-5 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /media/kc/Data/EE2026/project/FDP/FDP.runs/overlay_mem_synth_1/overlay_mem_sim_netlist.v
// Design      : overlay_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "overlay_mem,blk_mem_gen_v8_4_1,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module overlay_mem
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [17:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [3:0]douta;

  wire [17:0]addra;
  wire clka;
  wire [3:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [3:0]NLW_U0_doutb_UNCONNECTED;
  wire [17:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [17:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "18" *) 
  (* C_ADDRB_WIDTH = "18" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "17" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "2" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.370774 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "overlay_mem.mem" *) 
  (* C_INIT_FILE_NAME = "overlay_mem.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "136000" *) 
  (* C_READ_DEPTH_B = "136000" *) 
  (* C_READ_WIDTH_A = "4" *) 
  (* C_READ_WIDTH_B = "4" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "136000" *) 
  (* C_WRITE_DEPTH_B = "136000" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "4" *) 
  (* C_WRITE_WIDTH_B = "4" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  overlay_mem_blk_mem_gen_v8_4_1 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[3:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[17:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[17:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[3:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "bindec" *) 
module overlay_mem_bindec
   (ena_array,
    addra);
  output [0:0]ena_array;
  input [4:0]addra;

  wire [4:0]addra;
  wire [0:0]ena_array;

  LUT5 #(
    .INIT(32'h00000010)) 
    ENOUT
       (.I0(addra[3]),
        .I1(addra[2]),
        .I2(addra[4]),
        .I3(addra[0]),
        .I4(addra[1]),
        .O(ena_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module overlay_mem_blk_mem_gen_generic_cstr
   (douta,
    clka,
    addra);
  output [3:0]douta;
  input clka;
  input [17:0]addra;

  wire [17:0]addra;
  wire clka;
  wire [3:0]douta;
  wire [16:16]ena_array;
  wire ram_douta;
  wire \ram_ena_inferred__0/i__n_0 ;
  wire ram_ena_n_0;
  wire \ramloop[1].ram.r_n_0 ;
  wire \ramloop[2].ram.r_n_0 ;
  wire \ramloop[2].ram.r_n_1 ;
  wire \ramloop[2].ram.r_n_2 ;
  wire \ramloop[2].ram.r_n_3 ;
  wire \ramloop[3].ram.r_n_0 ;
  wire \ramloop[4].ram.r_n_0 ;
  wire \ramloop[5].ram.r_n_0 ;
  wire \ramloop[6].ram.r_n_0 ;
  wire \ramloop[7].ram.r_n_0 ;
  wire \ramloop[8].ram.r_n_0 ;

  overlay_mem_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[17:13]),
        .ena_array(ena_array));
  overlay_mem_blk_mem_gen_mux \has_mux_a.A 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T (\ramloop[1].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 (\ramloop[3].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 (\ramloop[4].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_2 (\ramloop[5].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_3 (\ramloop[6].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_4 (\ramloop[7].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_5 (\ramloop[8].ram.r_n_0 ),
        .DOADO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 }),
        .DOUTA(ram_douta),
        .addra(addra[17:13]),
        .clka(clka),
        .douta(douta));
  LUT2 #(
    .INIT(4'h1)) 
    ram_ena
       (.I0(addra[17]),
        .I1(addra[16]),
        .O(ram_ena_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \ram_ena_inferred__0/i_ 
       (.I0(addra[16]),
        .I1(addra[17]),
        .O(\ram_ena_inferred__0/i__n_0 ));
  overlay_mem_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.DOUTA(ram_douta),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.DOUTA(\ramloop[1].ram.r_n_0 ),
        .ENA(\ram_ena_inferred__0/i__n_0 ),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.DOADO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 }),
        .addra(addra[12:0]),
        .clka(clka),
        .ena_array(ena_array));
  overlay_mem_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.DOUTA(\ramloop[3].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.DOUTA(\ramloop[4].ram.r_n_0 ),
        .ENA(\ram_ena_inferred__0/i__n_0 ),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.DOUTA(\ramloop[5].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.DOUTA(\ramloop[6].ram.r_n_0 ),
        .ENA(\ram_ena_inferred__0/i__n_0 ),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.DOUTA(\ramloop[7].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized7 \ramloop[8].ram.r 
       (.DOUTA(\ramloop[8].ram.r_n_0 ),
        .ENA(\ram_ena_inferred__0/i__n_0 ),
        .addra(addra[15:0]),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module overlay_mem_blk_mem_gen_mux
   (douta,
    addra,
    clka,
    DOUTA,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ,
    DOADO,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_3 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_4 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_5 );
  output [3:0]douta;
  input [4:0]addra;
  input clka;
  input [0:0]DOUTA;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ;
  input [3:0]DOADO;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_2 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_3 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_4 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_5 ;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_2 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_3 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_4 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_5 ;
  wire [3:0]DOADO;
  wire [0:0]DOUTA;
  wire [4:0]addra;
  wire clka;
  wire [3:0]douta;
  wire \douta[3]_INST_0_i_1_n_0 ;
  wire [4:0]sel_pipe;
  wire [4:0]sel_pipe_d1;

  LUT6 #(
    .INIT(64'hFFFF541054105410)) 
    \douta[0]_INST_0 
       (.I0(sel_pipe_d1[4]),
        .I1(sel_pipe_d1[3]),
        .I2(DOUTA),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ),
        .I4(DOADO[0]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[0]));
  LUT6 #(
    .INIT(64'hFFFF541054105410)) 
    \douta[1]_INST_0 
       (.I0(sel_pipe_d1[4]),
        .I1(sel_pipe_d1[3]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ),
        .I4(DOADO[1]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[1]));
  LUT6 #(
    .INIT(64'hFFFF541054105410)) 
    \douta[2]_INST_0 
       (.I0(sel_pipe_d1[4]),
        .I1(sel_pipe_d1[3]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_2 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_3 ),
        .I4(DOADO[2]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[2]));
  LUT6 #(
    .INIT(64'hFFFF541054105410)) 
    \douta[3]_INST_0 
       (.I0(sel_pipe_d1[4]),
        .I1(sel_pipe_d1[3]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_4 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_5 ),
        .I4(DOADO[3]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[3]));
  LUT5 #(
    .INIT(32'h00010000)) 
    \douta[3]_INST_0_i_1 
       (.I0(sel_pipe_d1[0]),
        .I1(sel_pipe_d1[1]),
        .I2(sel_pipe_d1[2]),
        .I3(sel_pipe_d1[3]),
        .I4(sel_pipe_d1[4]),
        .O(\douta[3]_INST_0_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe[0]),
        .Q(sel_pipe_d1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe[1]),
        .Q(sel_pipe_d1[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe[2]),
        .Q(sel_pipe_d1[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe[3]),
        .Q(sel_pipe_d1[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe[4]),
        .Q(sel_pipe_d1[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[0]),
        .Q(sel_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[1]),
        .Q(sel_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[2]),
        .Q(sel_pipe[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[3]),
        .Q(sel_pipe[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[4]),
        .Q(sel_pipe[4]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized0
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized1
   (DOADO,
    clka,
    ena_array,
    addra);
  output [3:0]DOADO;
  input clka;
  input [0:0]ena_array;
  input [12:0]addra;

  wire [3:0]DOADO;
  wire [12:0]addra;
  wire clka;
  wire [0:0]ena_array;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.DOADO(DOADO),
        .addra(addra),
        .clka(clka),
        .ena_array(ena_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized2
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized2 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized3
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized4
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized4 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized5
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized5 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized6
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized6 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized7
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized7 \prim_init.ram 
       (.DOUTA(DOUTA),
        .ENA(ENA),
        .addra(addra),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFF0006067063063861FE3FE7067063FE1FE000),
    .INIT_01(256'hFC0FF81FF0FFF1FFFFFF0003FE7FE7063061FE3FE7067063FE1FE000FFFFFFFF),
    .INIT_02(256'hFFFD9FF83F0FFFF0FFFFFFFE0001FFFFFFDFFE5FFB7FEEFFBBFEEFFBBFCEFF8B),
    .INIT_03(256'hC9C9B4EDEDEC1B6078340E0E03060606FDBFFFDBFFFFFFFB3FF37EDFFFEDFFFF),
    .INIT_04(256'hC31E1F81986F6F6D99B6738198C9CE77B7B98C661FCCC7C7E3FBDBDB969E6763),
    .INIT_05(256'h8FC6D8F0F9ECDB7B7B9CCE736CCCC6F66DBDBDB666D9B660037B36DEDEDB336C),
    .INIT_06(256'hE5C6F87840DC6FFFFFFCFEFFFFFFE7EFFFFFFF00F0084021840C07C030F0F3F1),
    .INIT_07(256'h80430F9863F196FBFF319D6FB33318C6FB333F2E6FB333067EFB03334FEFB7B1),
    .INIT_08(256'hFFFFDFC1FFFFFC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00),
    .INIT_09(256'hB0180DECDB1F8FC0CDB3198CFCE61F0F8FCDCCE6720CC1E0F040CDFFFFFDFCDF),
    .INIT_0A(256'h6CF9F39CC33C3C7E3FCE674F27E03C181C0300C0603E07E1F0F9ECE73198DECD),
    .INIT_0B(256'h806100B7ECDB1F8D0B36CFF35ACDB30CD6B30C1B318CFF7ECCF33FDFB37ECE70),
    .INIT_0C(256'hFFF9FDFFFFEDFFFFFFFFFFFFFFFFFFFCFDFFFFE1FFFFFFFFFFFFFFFFFFFE001F),
    .INIT_0D(256'hCF26D369C9B38C00E00103038381E070180C1C038DFFFFEDFFFFFFFFFFFFFFFF),
    .INIT_0E(256'h0C0CC61B36C9CC663274FCE71FCCCCCC7C66198FC7E3E3F1FCBE4ECC7879393C),
    .INIT_0F(256'hECDB36CCC0C0061B36DECC6037B7ECDB30CC78787EFB36C0CC63F0360CDB39CC),
    .INIT_10(256'h18680F87E0FE36CC78787C3E1F9ED3E3E7B7ECE736CCCCCCC66739DEC7E637B7),
    .INIT_11(256'hFFFFFFFFFF6FFFFFFEDFFFFFFFFFFFFFFFFFFF6FFFFFFEC0860103030180C03E),
    .INIT_12(256'h7FFFFFFFFFFFFFFFFF6FFFFFFEDD7FFFFFFFFFFFFFFFFF6FFFFFFEDC7FFFFFFF),
    .INIT_13(256'hFFE3FF80FFFFFFFFFFFFFFFFFFFFFFFFFF3E7FFFFFFFFFFFFFFFFF0FFFFFFE63),
    .INIT_14(256'h00000000000000000001FFF1FFFFE3FFFFE7FFC000000000000FFCFFFFFF1FFF),
    .INIT_15(256'hFFE0000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FC71F8A3F147E38FF07FFFFFFFFF),
    .INIT_17(256'hFEDFFFFFFFD9FFBFFFFC03F0FFFF0FFFFFFFE0001FFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_18(256'h00E000C1B6078340E0E0306060FFFFF66FDBFFFDBFFFFFFFB3FF7FFFFB37EDFF),
    .INIT_19(256'h198C9CE77B7B9C7F3398C661FCCC7C7E3FBDBD7C9D99B969E6763C9C9B4EDEDE),
    .INIT_1A(256'hD99B666D9B660037B36DEDEDB30CCDB336CC31E1F81986F6F6D9CE66D99B6738),
    .INIT_1B(256'h7C030F0F7F1B663F18FC6D8F0F9ECDB7B7B9CDB339CCE736CCCC6F66DBDBDB66),
    .INIT_1C(256'hFFFFFFFFFFFFFFFFFFFDBFFFFFFFFFFFFFFFFFFFFFFFFEC086010084021840C0),
    .INIT_1D(256'hFFFFE637FFFFFFFFFFFFFFFFFFFFFFF6EBFFFFFFFFFFFFFFFFFFFFFFFB71FFFF),
    .INIT_1E(256'h6018183C00000180603FFFFFFFFFFFFFFFFFFFFFFFE7CFFFFFFFFFFFFFFFFFFF),
    .INIT_1F(256'h38CE737EDDBF6EE338CE73E7C18060E31FC7E3C3CFF3FC7F4FD3CB99CFF3FD3F),
    .INIT_20(256'h7ECDB35ADDB860E360CC335ADDBF6F634FCFF318DDBF6F3F1FCFF33CDDBF6E7F),
    .INIT_21(256'h0FFFF0FFFFFFE0F07E01807E1C3801807ECDB37EDDBBFD3F7ECDB342DDBBFCFF),
    .INIT_22(256'h080C0C000FFFFFFFC3FFFC3FFFFFF8001FFFFFFF87FFF87FFFFFF0303FFFFFFF),
    .INIT_23(256'h001800000000000000000000003000201080600800040200006000E06181E018),
    .INIT_24(256'h3000C03000780601080601806001800000000C02100C0300C003000000001800),
    .INIT_25(256'h180F08043F0000000000000C201E00007E00000000000018003C0000840300C0),
    .INIT_26(256'hFFFE1C071FFFFFFFFFC3FFFFFFFC3F0FFFFFFFFFFF87FFFFFFF80200C0210086),
    .INIT_27(256'h03FFFFFFFFF87FFFFFFF800007FFFFFFFFF0FFFFFFFF0E038FFFFFFFFFE1FFFF),
    .INIT_28(256'hFF6FFFFFB7F63F3FFFFFF87FFFFC3F8403FFF80E03FFFFFFFFFFFFFFFFFFE008),
    .INIT_29(256'hDBFFFFFEFC799CBD3B36DFFFFFF1881E0C0C1986FFFFFFEDFFFFF6FECFF7FFFF),
    .INIT_2A(256'h336DB30DFFFFFFDBFB1F9B6D9B6FFFFFF8C0D98CC36CDB7FFFFFDF9987C78CE6),
    .INIT_2B(256'hFC380C05B80601FFFFFFED9F0F8D9F87E7FFFFFF6D9CC66DCE7FBFFFFFFB6360),
    .INIT_2C(256'hFFFFFFFFFFFFFEDAFFFFFFFFFFFFFFFFF6C7FFFFFFFFFFFFFFFFB7FFFFFFFFFF),
    .INIT_2D(256'hFFFF6FFF3F7FFFF861FFC0F87FFC03FFFFFFFFFCF3FFFFFFFFFFFFFFFFCCDFFF),
    .INIT_2E(256'h3CB3F1E672FD3965B00C0C062078318C1B8DFFFFEDB7FFFFEDFFCFEFFFFF6DBF),
    .INIT_2F(256'h6719866D9B6FEC7EDB3F32CE736CC3036630C319B63F8CC67E661F1F8F8DB4ED),
    .INIT_30(256'h301C380E00DB1F8DB67C3E6D9F27E6D9CE6DB6731B6D8C7F36CDB36D8D80DB60),
    .INIT_31(256'hDB5F9B60332D066D98CE3019B67F1FCFE6D8F93F3F9B680E00000C03080430E0),
    .INIT_32(256'hFF00203807C1013E4FDF63F1FC7F7D9FE6338DF673980CB419867E36D7E6D8FC),
    .INIT_33(256'hFFFCFDFFFFFFFFFFF7FBFFE1FFFFC300FFFFFF87FFFFFFFFFFFFE01FFFFFFFFF),
    .INIT_34(256'hFFFFB7FFFFFFFFFFFF9FDFFFFFFFFFFF7FBFFEDFFFFDA7EFFFFFFB7FFFFFFFFF),
    .INIT_35(256'hE062D03C0D9C6F80380040C0E0E0781C038DFC1803038000C3FFEDFFFFD8FEFF),
    .INIT_36(256'hFDF3E39CCD7FEEDCF2AC799E59C6FAF93B31E1E4E4F33C9B38DF9CAF87930CED),
    .INIT_37(256'h303033186CDB274FDF6336CC1666EDD9ACCCC3318FEFB9C7F333331F198663F1),
    .INIT_38(256'hDF66D9AC6FB6CC331E1E1FBECDB0360DF3F36CFC666EDC1AFC366D9A7EFB6CE7),
    .INIT_39(256'h339CC66067F982CC366D99C6FB6CDB330300186CDB7B7EDF0336CC66660C0F37),
    .INIT_3A(256'hE1F0F87E7B7EDF3E3F8FC6F67F999ACCE7399FEFB9CDB333333199CE77B7EDF6),
    .INIT_3B(256'h04300FB0218040C0C060300F87E1F80B02010F0000F1AC7C3F1A7EFBF8DB31E1),
    .INIT_3C(256'hFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFE0421018),
    .INIT_3D(256'hFFFFFFFFFFFFB75FFFFFFFFFFFFFFFFFFFFFB71FFFFFFFFFFFFFFFFFFFFFFB71),
    .INIT_3E(256'hFF98DFFFFFFFFFFFFFFFFFFFFFF98DFFFFFFFFFFFFFFFFFFFFFB75FFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFCF9FFFFFFFFFFFFFFFFFFFFFFCF9FFFFFFFFFFFFFFFFFFF),
    .INIT_40(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE03FFFFFFFFFFFFFFFFFFFFFFE03FFFF),
    .INIT_41(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_42(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_43(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF80007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'h0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000FFF),
    .INIT_4D(256'hFFFFFFFFFFFFFFFFE4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80001FFFFFFFFF),
    .INIT_4E(256'hFFFFFFFFFF88FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003FFFFFFFFFFFFFFF),
    .INIT_4F(256'hFFFF39FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE00007FFFFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF80001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCD9),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF00003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B1FFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE00007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE633FFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFC0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9933FFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hC0003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3263FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCE67FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFFFFF33E67FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC000FF),
    .INIT_58(256'hFFFFFFFFFFFFFFFFC67CC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFFFFFF),
    .INIT_59(256'hFFFFFFFFFF99FCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFFFFFFFFFFFFFF),
    .INIT_5A(256'hFFFE67FCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5E(256'h30DB7FFFFDBFB3FDB7FFFFDBFB1F987FFFFC3F8403FFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5F(256'h0DB7F63F36DB36C30366330DB36CFCCC3E3C6736CFC799CBD3B36C3103C18183),
    .INIT_60(256'hFFFFFFFB7FFFFF870180B700C03B67C3E367E1F9B6CE6336E73FDB6360336DB3),
    .INIT_61(256'hFFFFFFE07FFFFFFFFFFCF3FFFFFFFFFF99BFFFFFFFFFFB6BFFFFFFFFFFB63FFF),
    .INIT_62(256'hFFFFFFFB6DFFFFFB7FF9F83FFFC003FFFFF0FFC30FFFFFFFFC30FFFFFC3FFE01),
    .INIT_63(256'h66FFFF6FEFFFFFDBFF6DBFFFFFFFF6DBFFFFF6FFE7F37FFFB7F7FFFFEDFFB6DF),
    .INIT_64(256'hFFFE769E59F8F3397E9CB2CC1E0000DE01818600DB7FFF8060603103C18C60DC),
    .INIT_65(256'hDB3987F33F67F198C7F36D8019FC6633F330F8FC7C6D9B99D981B9DA7969D9B6),
    .INIT_66(256'h36FF6C336CDB7F63F6D9F9966D9CE67EDCE6D99CE6DB7FB739B66181B318618C),
    .INIT_67(256'h63F9B66D9BDB6D9B666D9CEC00DB66D9B6C6C06DB0338CDB30CC0DB0CDB330CC),
    .INIT_68(256'h3F3FFF6D8FC6DB3E1F36CF93F39CDB37B6DB39CCDB3FDFFFB6CE736DB398DB6C),
    .INIT_69(256'hF8601008601E186100806100FFFE184021870180E1C07003F1B66F6DB63F19B6),
    .INIT_6A(256'hF2F1E332C31800606040838DB7FFB7FF6FFB1FDB7FFB7FF6FFB4FD87FF87FF0F),
    .INIT_6B(256'hDB336CDB0338DB6C3336CD9E332C30E7336CC03336CFC7F3198F33336CFD3B34),
    .INIT_6C(256'hFFFFFFFFFEDFFFFFF86180402DC08601B6DB31F8D9E34FDB6DB339CDB331FDB6),
    .INIT_6D(256'h1FFFFFFFFFFFFF3CFFFFFFFFFFFFE66FFFFFFFFFFFFEDAFFFFFFFFFFFFED8FFF),
    .INIT_6E(256'h98DB67E600C319F8FC7C3F3F4E40C3183636DFFDFDB7FF3E61FFE03FFFFFFFF8),
    .INIT_6F(256'h0800000103810030FFFFE0061FFFFE00C3FFFFE01870180ED9F0F9B6C67F6D81),
    .INIT_70(256'h870300FC30C0000F86180001F0C3000C3E186001840000003000000000000000),
    .INIT_71(256'h018000000000000000000C06020001E0F04001FFFFFC001FFFFFC001FFFFFC01),
    .INIT_72(256'h0F0FE9F830C03030060100C0603E00000001E00000001E01800001E018000000),
    .INIT_73(256'hDB67F97D3F666DB30CBE3FA79659864338C7E38CE7019C6738FE3F1FC7F36D3F),
    .INIT_74(256'h1C3E001800030EDE7E6D9FCCB76E7F36CFE75BB7719B60318DDBB2CC321AE6ED),
    .INIT_75(256'hE1FF87FC20FFFC3FFFFFFF007FFFFFFFFFE1F87FE1FF0C3FFF0FFFFFFFE02000),
    .INIT_76(256'h0FE0C30100303007FFFFFFFFFE1F87FE1FF083FFF0FFFFFFFC01FFFFFFFFFF87),
    .INIT_77(256'h000100000006100C0100000101003F01080000004010300186078060000860C0),
    .INIT_78(256'h00601806000060000003E00000000004000000180000000000000000F8000000),
    .INIT_79(256'h18060000003E00000000000000000000601800018000000F8000000000000000),
    .INIT_7A(256'hC3E000800000000001E0000000006000000010F8000000000000007800018060),
    .INIT_7B(256'hFFFFFFF03E001C030086000840430FC043001E00180807800200000180000000),
    .INIT_7C(256'hFFFFFFFFFFFE1C7FFFFFFFFFFE1FFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFF87),
    .INIT_7D(256'hFFE007FFFFFFFFFFE1FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFFF87FFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC01FFFFFFFFFFF87FFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'h007FE1FFFFFC01F0FFFF000FFC3FFFFFC03E1FFFE001FFFFFFFFFFFFFF80FFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000080601003E00C00001020181E06007C03C00003FF0FFFFFC00F87FFF8),
    .INIT_01(256'h0601E0018618061007C300000000000300C200F86000000000000000001F0000),
    .INIT_02(256'h010C03C0030C0000010F80018078006180000021F000300F000C30C030003E18),
    .INIT_03(256'h7C3E1F0F87C3E1F0F87C1FC0F80F0000000000000C07F81FE0F038700C02187E),
    .INIT_04(256'h800402FE7E3FBFC06E77DB0DF6DB7DB6DF6DB7DB6DF6DB7DB6DF018000000000),
    .INIT_05(256'h086000430002180010C00086100430C02184027E3FCE730CDB36CDB36CDB36C1),
    .INIT_06(256'h0000000000000000000000000000000000000618041080008400002004010020),
    .INIT_07(256'hA3FFE7FFCFFFFFFCFFF8FFE3FFE7FFCFFFFFFCFFF80003FFE7FFCFFF80000000),
    .INIT_08(256'hFFE7FFCFFFFFFCFFF8DAA3FFE7FFCFFFFFFCFFF8DAA3FFE7FFCFFFFFFCFFF8C2),
    .INIT_09(256'hE7FFCFFFFFFCFFF8DAA3FFE7FFCFFFFFFCFFF8EAA3FFE7FFCFFFFFFCFFF8C2A3),
    .INIT_0A(256'hFFCFFFFFFCFFF8FFE3FFE7FFCFFFFFFCFFF8DA23FFE7FFCFFFFFFCFFF8DAA3FF),
    .INIT_0B(256'h0FFF800000000000000000000000000000000000000000007FFCFFF80003FFE7),
    .INIT_0C(256'hFFFFFCFFF9FFF00003F38FFFFFFCFFF9FFF00003FF8FFFFFFCFFF9FFF0000000),
    .INIT_0D(256'hFFFCFFF9FFF00003F38FFFFFFCFFF9FFF00003F38FFFFFFCFFF9FFF00003F38F),
    .INIT_0E(256'hFCFFF9FFF00003838FFFFFFCFFF9FFF00003F38FFFFFFCFFF9FFF00003F38FFF),
    .INIT_0F(256'hFFF9FFF00000000FFFFFFCFFF9FFF00003FF8FFFFFFCFFF9FFF00003838FFFFF),
    .INIT_10(256'hF9FFF3FFE7FFCFFF800000000000000000000000000000000000000000007FFC),
    .INIT_11(256'hFFF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFF),
    .INIT_12(256'hF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9),
    .INIT_13(256'hFFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9FF),
    .INIT_14(256'h000000007FFCFFF9FFF3FFE7FFCFFFFFFCFFF9FFF3FFE7FFCFFFFFFCFFF9FFF3),
    .INIT_15(256'hF87FE187FFFF87FE180000000000000000000000000000000000000000000000),
    .INIT_16(256'h00000000180000180000000001840100840018601818600187FFFF87FE187FFF),
    .INIT_17(256'hFFFFFFFFFFFF0086100806100860000060000600000600006018006000000180),
    .INIT_18(256'h0E06007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFF),
    .INIT_19(256'h00000000000000000001F8000040101802018000040218408060183C0303C040),
    .INIT_1A(256'hC03000000060000061800000003000000060180000000000003000000061F800),
    .INIT_1B(256'h8403008061860000C00080000000000061860000C00000000000000061860000),
    .INIT_1C(256'hFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFC0E1861010C201C007),
    .INIT_1D(256'hFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFF),
    .INIT_1E(256'hFDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F800000000000007FFFFFFFFF),
    .INIT_1F(256'hFBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3),
    .INIT_20(256'h0005FEFF7FBFE0000BFDFEFF7FC00017FBFDFEFF80002000000001FFFFDFEFF7),
    .INIT_21(256'hF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC00017FBFDFEFF80002FF7FBFDFF0),
    .INIT_22(256'hEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC000100000000080002F),
    .INIT_23(256'h3FF7FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC00017FBFDF),
    .INIT_24(256'hDFF0000003FE7FBFE0000007FCFF7FC000000FF9FEFF8000001FF00001FFFFC0),
    .INIT_25(256'hFFFFF003FDFF0000003FE7FBFE0000007FCFF7FC000000FF9FEFF8000001FF3F),
    .INIT_26(256'h7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F80000FF),
    .INIT_27(256'h000000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF),
    .INIT_28(256'h0180061830081807800C3FF87FF0FFFE187FF0FFE1FFFC30FFE1FFC3FFF86000),
    .INIT_29(256'h000061800300000000C300060000000000010C00018000000200000308080004),
    .INIT_2A(256'hFFFFFFFC3FFFFFFFFFFFF87FF01C300C038080401860000200000030C0000000),
    .INIT_2B(256'hFC3FFE1803FF0FFF8701FFFFFFFFFF87FFFFFFFFFFFF0FFFFFFFFFFFFE1FFFFF),
    .INIT_2C(256'h00C30061800000002000000000080000000002000081008180003FF0FFF8600F),
    .INIT_2D(256'hFBFDFEFF0000000000000081C300E1C04030C01860000C30061800030C018600),
    .INIT_2E(256'hF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7),
    .INIT_2F(256'hF7FBFDFEFF7F800000000000003FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEF),
    .INIT_30(256'hEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCF),
    .INIT_31(256'hDFE7FBFDFEFF7FBFC00000000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDF),
    .INIT_32(256'hDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBF),
    .INIT_33(256'hBFDFEFF3FDFEFF7FBFDFE00000000000000FF7FBFDFEFF7F9FEFF7FBFDFEFF3F),
    .INIT_34(256'h7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7F),
    .INIT_35(256'h7FBFDFEFF7F9FEFF7FBFDFEFF000000000000007FBFDFEFF7FBFCFF7FBFDFEFF),
    .INIT_36(256'hFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF),
    .INIT_37(256'h87C0F03804000000000084E1F87E1C00000000000003FDFEFF7FBFDFE7FBFDFE),
    .INIT_38(256'h081860C1B9DFFFFFFFFFFFDBF3F3FFFFFFFFFFFB7F3CFFFFFFFFFFFF0FF03E1F),
    .INIT_39(256'h30CDB30CC61B39CC16D9B67F8F8CC3F99ADB398C34E4F33B1E5B66E586C1C0F0),
    .INIT_3A(256'h008607C3E36CFC9E4FC6D98CCE6D98C7E39CDB0186CDB319CE6D9B63F7D9867E),
    .INIT_3B(256'hFFFEFEFFFDBFFFFFFFFFFFFFFFEFEFFFC3FFFFFFFFFFFFFFFE0080C043000E07),
    .INIT_3C(256'hE001DB99DA73CE4C30F26D06FFFD83C0307E0E006070006FFFDBFFFFFFFFFFFF),
    .INIT_3D(256'hB6618FD9F9999F80D06001DB67398DB19999829D7E7FDDCC3F8F99F1FF99AFD7),
    .INIT_3E(256'hF99F1819F9EDF67FDDCE6D98DB199998DEDF6001DB66D80D8199998DEDF6FFFD),
    .INIT_3F(256'h00804FC7F9866D9B66D9B6619FE3F201FFFE010C203C043C003E1F0001CFC6D8),
    .INIT_40(256'h8C6001C61A7E7FDDF98FE001DF99C6FFFC601C6FFFF6D8FEFFFF6DA7EFFFF0C3),
    .INIT_41(256'h00000201C0F03E1F870000FFFF0C300001F6DA7E7FDF6D9FE001F6D9C6FFFF6D),
    .INIT_42(256'h6FFFFEDB33FBFFFFB6CCFEFFFFE1800000000000024924924387E1F872100000),
    .INIT_43(256'hF6F6036DB37D818FDB6CD064E630C335F9F8F8FCCD7E369CBF3341A030630C00),
    .INIT_44(256'h33B1E583C0206DFFFFFF6FFFFFF87FFFFFFC2038601F0F63E6DB37DBD98DB6CD),
    .INIT_45(256'hFFFE00FFFC02010C0027E36CFC739B66336CDB319B6619F8DB39CC1730FE66B7),
    .INIT_46(256'h8F87F33F1F0FE9CCECC313971B078006DE0DC6FFFFEC37FF3FBFFFFB39FFE7EF),
    .INIT_47(256'h303E36CDB67C6598CDB36DB19D60336CDB606318FCC336D9FAE66339CC30C69F),
    .INIT_48(256'hFFF66FFFFFFFFF3FBFFFFD9BFFFFFFFFE7EFFFFF00FFFFFFFFFC020218061C04),
    .INIT_49(256'hD9B69F9CE3F99CC3F9B6330FE5F27666E6766DA7971801C00183C0030C0DC6FF),
    .INIT_4A(256'hD99CE6D9FC739FE6D9B666D9B6739B6719B66199B6619866D8C66D9CE66D9CE6),
    .INIT_4B(256'hFFFFF6FFFFFFFFFFFFFFFFFD810C02010C003807007F1B663F1B66E4FC9F9CE6),
    .INIT_4C(256'hFFFFFFFFFFFFFCC6FFFFFFFFFFFFFFFF6EBFFFFFFFFFFFFFFFDB8FFFFFFFFFFF),
    .INIT_4D(256'h0FE6DA7971878C0DC6FFFFF3FBFFFFE7EFFFFFC0301FFFFFFFFFFFFFFFF9F3FF),
    .INIT_4E(256'h70924924924924078807006D8FC9FACD739FEDEDB671BB76D8C6DEDB69FACD33),
    .INIT_4F(256'h0BFD800000FFE0037FB7FB7FB7FB7FB7FB7FB7FB7FB7FD7FEBF16FAD8377F7C0),
    .INIT_50(256'hD7F55FE97FDDFFB7FF1FF8007F9802FF5FEBFD7FAFF606FED81AFF5FEBFD7FB0),
    .INIT_51(256'hFFF7BFFF77FFF0FFFF8FFF5FFEBFFD7FFAFFF5FF0800FFF820175F5EBD7D75FA),
    .INIT_52(256'h01FFFF9FFFF8600376FF6F6FEDF6FDBF6FB7F6F6FF6EDFF6DBFF6B7FF66FFF6D),
    .INIT_53(256'hBFEDDBFEDDB80DDB7FDDB7FDDB803C30FFFF6FFFF6FFFF6FFFF6FFFF6FFFC600),
    .INIT_54(256'hFFDD9C1DD9BEDD9BEDD9BEDD9BEDD9C1DD9FFDD9FFDDA00DDBFEDDBFEDDBFEDD),
    .INIT_55(256'hF7FECC0FFD9BFFFB37FFF66FFFECDFF819806FF3FEDFEBFDC03802003C1FFDD9),
    .INIT_56(256'h801FFAFF3FF3FE70E600DECDFDBD9BFB7B37F6F66FEE1CDFDFF981BFF3FB8067),
    .INIT_57(256'hBFF5AD806B37FED6EFFDADBFFB5F7FF6BDFFED73F81AEFEFF5BFDFE8FFC03003),
    .INIT_58(256'hFFFF87F0036FDFFADFBFF5BF70EB7EDED6FDBDAC0B7B3FE6F67FCE1D635FFAD6),
    .INIT_59(256'hFFFC03FFFC03FFFC03FF00030F00030F000303000303C00003C00003FFFFFFFF),
    .INIT_5A(256'hFC03FFFC03FFFC03FFFC03FFFC03FFFC03FFFC03FFFC03FFFC03FFFC03FFFC03),
    .INIT_5B(256'h003FFFFFFFFFFFFFFC0FFFFC0FFFFC03FFFC03FFFC03FFFC03FFFC03FFFC03FF),
    .INIT_5C(256'h03003F00C00FC03003F00C00FC03C03000F00C003FC0000FF00003FC0000FF00),
    .INIT_5D(256'h3F00000FC00003FF0000FFC0003003FC0C00FF03003F00C00FC03003F00C00FC),
    .INIT_5E(256'hFFFFFFFFFFFFFC0FF03F03FC0FC03F00F00FC03C03F00F00FC03C03F00F00C00),
    .INIT_5F(256'h003F003003F003003F003C030003C030003FC0003FFC0003FFC0003FFC0003FF),
    .INIT_60(256'h30000003000000300000030000003003FC03003FC03003F003003F003003F003),
    .INIT_61(256'h0F00FF00F003F003003F003003F003003F003003F003003F0030030003003000),
    .INIT_62(256'h003C030003C030003FC0003FFC0003FFC0003FFC0003FFFFFFFFFFFFFFF00FF0),
    .INIT_63(256'hF003FFFF003FFFF003FFFF003FFFF003FFFF00300FF00300FF003003F003003F),
    .INIT_64(256'h0003F000003F000003F003FC03003FC03C03F003C03F003FFFF003FFFF003FFF),
    .INIT_65(256'h03003F00C00FC03C03FC0F00FF03FFFFFFFFFFFFFF0000FFF0000FFF00003FF0),
    .INIT_66(256'h3FF0000FFC0003FF0000FFC0003F00000FC00003F003C0FC00F03000300C000C),
    .INIT_67(256'hFC0F00FF03C03FC0300FF00C03FFC000FFF0003FFC000FFF0003FFFC00FFFF00),
    .INIT_68(256'h00007FF0000E000001F80001F807FC0700000000FF03C03FC0F003F00C00FC03),
    .INIT_69(256'hFF7EFFFF7EFDFDFDDFFFFF9FFFFFBFF7FFF77FFFFEFDFFFEFDFBFDFBBFFFFF00),
    .INIT_6A(256'h77FFFFE7FFFFEFF7FFFDDFFFFFB87FFF877EFDFEEFFFFFCFFFFFDFF7FFFBBFFF),
    .INIT_6B(256'hFBDF77FFFFEEFDFEFDDFBDFFB803F003FFFFF7F7F83EEFFFFFDDF801FBBF7DFF),
    .INIT_6C(256'hBF77EDFFEFFEFDFFFEFDFFF7FBEFB80003F77EFF7EEFDDFFDFFDFBFC01F803F7),
    .INIT_6D(256'hFFBF7FF7FBFBEFFFFEFDFFFFDFBBF5FFF7FF7EFFFF7EFFF7FBF7DFFFFDFB807F),
    .INIT_6E(256'h003F7EFFFF0EFFFFFDFFDFBFFFDFBFFBFEFDF7FFFF7EFC000FDDF9FFFBFFBF7F),
    .INIT_6F(256'hFF7FF7EFFFF7EFFFBFEF7DFEFFFFBF7FFFBF7FFFFEFFEFDFFFEFDFFEFFBEFBFC),
    .INIT_70(256'hFBFFFF7FBFFFEEFC000FDFFFFFBFFBF7FFFBF7FFEFF83EFF7FFFDC3FFFDFBFFF),
    .INIT_71(256'h7FFFF7FFFFEFFEFDFFFEFDFFFEFFFFBFDFFFF77EFFFFEFFFFFDFFDFBFFFDFBFF),
    .INIT_72(256'h7FFFBF7FFFEFFFEFFFFEFDDFBFFFFBFFF9F7FF7EFFFF7EFFFFBFFFDFE001FBBF),
    .INIT_73(256'hFFFFBF77EFF00EFFFB7DFFDFBFFFDFBFFFF781F7FFFF7EEFDFFFFDFFFAFBFFBF),
    .INIT_74(256'hFBDF7007E00FF7EFFFF7DF7DFFFFFFBBF7FBF77FFBBEFFEFDFFFEFDFFFF7DEFB),
    .INIT_75(256'hFFF7DFDF7FFFFFEEFC00FDDFFBEFBBFFFFF7FBF7FFF7DFBEFFFFFFDDFBFDFBBF),
    .INIT_76(256'hF7FFFBF7FBFBEEFFFFFDFEFDFFF7DFEFBFFFFFF70FFFF0EFFBF7DDFFFFFBFDFB),
    .INIT_77(256'h00007FBF7FF7DFFBEFFFFFFDFBFFFDFBFBFDF77FFFFEFF7EFFF7DFF7DFFFFFFB),
    .INIT_78(256'hFDC03FE038000007E00007FC0001FFC03FF81FFC07000000FC0000FC03FE0380),
    .INIT_79(256'hF70FFFF0E1FFFC1FBFBFBBFFFFF7EFFFF7FDFFFDDFBFDFBBFFFFF7EFFFF7FDFF),
    .INIT_7A(256'h9FBDFFB803F0077FFFFEEFFFFF9FBEFFBBFFFFF77FFFFEEFFFFF9FBF7FBBFFFF),
    .INIT_7B(256'h7F7EFEEFDFDF9FB7FFBFFBF7FF7F00FEEFC01F9FBBFFBFFBF7FF7FFFFEEFFFFF),
    .INIT_7C(256'hFFFFBFFBF7FF7F7EFEE01FDF9F9FFFBFFBF7FF7F7EFEEFDFDF9FAFFFBFFBF7FF),
    .INIT_7D(256'h7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9F),
    .INIT_7E(256'hFFBFFBF7FF7F7EFEE01FDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F),
    .INIT_7F(256'hFEEFC01F9FFFAFBFFBF7FF7F7EFEEFDFDF9FFFCFBFFBF7FF7F7EFEEFDFDF9FFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized0
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hB803F0077FFFFEEFFFFF9FFEEFBFFBF7FF7FFFFEEFFFFF9FFF6FBFFBF7FF7F00),
    .INIT_01(256'hFDFFFDDFF7EFBBFFFFF70FFFF0E1FFFC1FFBEFBBFFFFF77FFFFEEFFFFF9FFDEF),
    .INIT_02(256'h000007E00007FC0001DFDFEFBBFFFFF7EFFFF7FDFFFDDFEFEFBBFFFFF7EFFFF7),
    .INIT_03(256'hF9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFC0000000000000003FE038),
    .INIT_04(256'hFBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7),
    .INIT_05(256'hF70344FF7FBFDFEFC6A9FEFF7FBFDFA813FDFEFF7FBFDFE00000000000000FF7),
    .INIT_06(256'h07FBFDFEFF73BFCFF7FBFDFEE56A9FEFF7FBFDC8D53FDFEFF7FB81B27FBFDFEF),
    .INIT_07(256'hEFF7FB9DFE7FBFDFEFF73BFCFF7FBFDFEE77F9FEFF7FBFDCEFF0000000000000),
    .INIT_08(256'h000003FDFEFF7FB9DFE7FBFDFEFF73BFCFF7FBFDFEE77F9FEFF7FBFDCEFF3FDF),
    .INIT_09(256'h9FEFF001D9CEFF3FDFE003B39DFE7FBFC007E73BFCFF7F80000E77F800000000),
    .INIT_0A(256'h0000000001FEFF00001FEFF3FDFE003F3FDFE7FBFC006643BFCFF7F800EC877F),
    .INIT_0B(256'h7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFC0000),
    .INIT_0C(256'h00000000000000FF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF),
    .INIT_0D(256'hFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF00000000000000),
    .INIT_0E(256'h00003FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFE),
    .INIT_0F(256'hFEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F8000000000),
    .INIT_10(256'h000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9),
    .INIT_11(256'hFBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFC00000),
    .INIT_12(256'h0000000000000FF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7),
    .INIT_13(256'h07FBFDFE7FBFC00FF7FBFCFF7F801FEFF7F9FEFF003FDFEFF3FDFE007FBFDFE0),
    .INIT_14(256'hEFF000000000000007FBFC00FF7FBFCFF7F801FEFF7F9FEFF003FDFEFF3FDFE0),
    .INIT_15(256'hEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDF),
    .INIT_16(256'h0000000000000000000003FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9F),
    .INIT_17(256'hBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFC000000),
    .INIT_18(256'h0000000FFFFEFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7F),
    .INIT_19(256'h7FC00017FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC000100),
    .INIT_1A(256'h00800000000400017FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF),
    .INIT_1B(256'hFF7FBFE0000BFDFEFF7FC00017FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE00),
    .INIT_1C(256'h0000FF80000AABFE01FFBFDFEFF7FC00017FBFDFEFF80002FF7FBFDFF00005FE),
    .INIT_1D(256'hFCFF7F8000000FF9FEFF8000001FF3FDFE0000003FE7FBFE0000007FCFF7F800),
    .INIT_1E(256'hFDFEFF7FBFC00002A9FFFF801FEFF8000001FF3FDFE0000003FE7FBFE0000007),
    .INIT_1F(256'hFBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FB),
    .INIT_20(256'hF0015500000000000000000000000FF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7),
    .INIT_21(256'hF7FBFDFEFF3FDFFFF7FBFDFE7FFFDFEFF7FBFCFF7FFFDFEFF7F9FFFF7FBFDFEF),
    .INIT_22(256'hF00004010000003FFFFBFDFFFF7FBFDFE7FFFDFEFF7FBFCFF7FFFDFEFF7F9FFF),
    .INIT_23(256'h2FF7FFFDFF00005FFFF7FBFE0000BFDFFFF7FC00017FFFDFEFF80002FF7FFFDF),
    .INIT_24(256'hDFFFF8000200005540100005FFFF7FBFE0000BFDFFFF7FC00017FFFDFEFF8000),
    .INIT_25(256'hC00017FFFDFFFF80002FF7FBFDFF00005FFFF7FFFE0000BFDFEFF7FC00017FFF),
    .INIT_26(256'h3FDFF0000003FE0055401FF807FEFF7FBFDFF00005FFFF7FFFE0000BFDFEFF7F),
    .INIT_27(256'h8000001FF3FDFF0000003FE7FBFE0000007FCFF7FC000000FF9FEFF8000001FF),
    .INIT_28(256'hFF7F9FEFF7FBFDFEFF00001FFFFFFE007FBFE0000007FCFF7FC000000FF9FEFF),
    .INIT_29(256'hFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFE),
    .INIT_2A(256'hFEFF7FBFC00FFC00000000000000000000003FDFEFF7FBFDFE7FBFDFEFF7FBFC),
    .INIT_2B(256'hFDFE7FC03FEFF7FBFCFF807FDFEFF7F9FF00FFBFDFEFF3FE01FF7FBFDFE7FC03),
    .INIT_2C(256'hFE01FF7FC0001004020000FFFFEFF807FDFEFF7F9FF00FFBFDFEFF3FE01FF7FB),
    .INIT_2D(256'hFBFE0000BFE01FF7FC00017FC03FEFF80002FF807FDFF00005FF00FFBFE0000B),
    .INIT_2E(256'h0005FF00007FE000080201FF80400017FC03FEFF80002FF807FDFF00005FF00F),
    .INIT_2F(256'hF80003FF00005FF00007FE0000BFE0000FFC00017FC0001FF80002FF80003FF0),
    .INIT_30(256'h000007FCFF7FC000000FF801FF807FE01FFBFE0000FFC00017FC0001FF80002F),
    .INIT_31(256'h3FE7FBFE0000007FCFF7FC000000FF9FEFF8000001FF3FDFF0000003FE7FBFE0),
    .INIT_32(256'hDFEFF7FBFDFE7FBFDFEFF7FBFC00007FFFFFF801FEFF8000001FF3FDFF000000),
    .INIT_33(256'hBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3F),
    .INIT_34(256'hB9DDDDDDDDDDDDDC0000000000000000000000000000FF7FBFDFEFF7F9FEFF7F),
    .INIT_35(256'hBC0007BB9DDDDDDE0003DDC0000001FFFF000777777777777773BBBBBBBBBBBB),
    .INIT_36(256'h73BBBBBBBBBC7BB9DDDDDDDDDE3DDC0000001FFF100077777778000F773BBBBB),
    .INIT_37(256'h777777773BBBC7BBBBBBBB9DDDE3DDDDDDDDC0001F00001F00077777777778F7),
    .INIT_38(256'h077778F780F77773BBBC7BC07BBBB9DDDE3DE03DDDDC0001101FF0000077778F),
    .INIT_39(256'hF1F00000777780F80F77773BBBC07C07BBBB9DDDE03E03DDDDC00011F1010000),
    .INIT_3A(256'hC00001FFF00000077777800F777073BBBBC007BBB839DDDDE003DDDC1C0001F1),
    .INIT_3B(256'hDDDDDC1C00001F00000000777777777777073BBBBBBBBBBB839DDDDDDDDDDDC1),
    .INIT_3C(256'h9DDDDFDDDFDDDDC000011FFF0000077777FF77777073BBBBFFBBBBB839DDDDFF),
    .INIT_3D(256'hBBBBBBB9DDDDDDDDDDDDDC00001FFFF0000077777F777F77773BBBBFBBBFBBBB),
    .INIT_3E(256'h3BBBBBBBBBBBBB80000000000000000000000000000777777777777773BBBBBB),
    .INIT_3F(256'h00007773BBBBBB80003BB800000000000000EEEEEEEEEEEEEE77777777777777),
    .INIT_40(256'h777777777707773BBBBBBBBB83BB800000000000000EEEEEEE0000EEE7777777),
    .INIT_41(256'hEEEEEEE777707777777773BBB83BBBBBBBB800000000000000EEEEEEEEEE0EEE),
    .INIT_42(256'hEEEE0EE00EEEEE777707700777773BBB83B803BBBB800000000000000EEEE0EE),
    .INIT_43(256'h0000000EEEE00E00EEEEE777700700777773BBB803803BBBB800000000000000),
    .INIT_44(256'h00000000000000EEEEE000EEEEEE777770007777773BBBB8003BBBBB80000000),
    .INIT_45(256'hBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB8),
    .INIT_46(256'hBBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBB),
    .INIT_47(256'h7777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773),
    .INIT_48(256'h777777777777700000000000000000000000000000EEEEEEEEEEEEEE77777777),
    .INIT_49(256'h001EEE77777778000F7700000007FFFC001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7),
    .INIT_4A(256'hEEEEEEEEF1EEE77777777778F7700000007FFC4001DDDDDDE0003DDCEEEEEEF0),
    .INIT_4B(256'hDDDDDCEEEF1EEEEEEEEE77778F7777777700007C00007C001DDDDDDDDDE3DDCE),
    .INIT_4C(256'hDDE3DE03DDDDCEEEF1EF01EEEEE77778F780F777700004407FC00001DDDE3DDD),
    .INIT_4D(256'hC07FC1DDDE03E03DDDDCEEEF01F01EEEEE777780F80F7777000047C40400001D),
    .INIT_4E(256'h0007FFC004041DDDDE003DDE03CEEEEF001EEF01E77777800F7780F00007C7C7),
    .INIT_4F(256'h77777000007C00007FC1DDDDDDDDDDE03CEEEEEEEEEEF01E7777777777780F00),
    .INIT_50(256'h777F777F77770000047FFC00001DDDDFFDDDDDDDCEEEEFFEEEEEEEE77777FF77),
    .INIT_51(256'hEEEEE77777777777777000007FFFC00001DDDDFDDDFDDDDCEEEEFEEEFEEEEE77),
    .INIT_52(256'hEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_53(256'h03DDCEEEEEEF0001EEE0000000FFFF8003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEE),
    .INIT_54(256'hDDDDFDDC3DDCEEEEEEFEEE1EEE000000080008003BBBBBBC0007BB9DDDDDDE00),
    .INIT_55(256'hBBBB9DDDE1DDDFDDDDCEEEF0EEEFEEEEE0000FFFFFFF8003BBBBBBFBB87BB9DD),
    .INIT_56(256'hBC3B807BBBB9DDDE1DC03DDDDCEEEF0EE01EEEEE000080000800003BBBC3BBBF),
    .INIT_57(256'h0FF83BBBC03807BBBB9DDDE01C03DDDDCEEEF00E01EEEEE000080000800003BB),
    .INIT_58(256'h0FFFFF808083BBBF8003FBC079DDDFC001FDE03CEEEFE000FEF01E0000800008),
    .INIT_59(256'hEEEE00000FFFF80FF83BBBBBBBBBBC079DDDDDDDDDDE03CEEEEEEEEEEF01E000),
    .INIT_5A(256'hEFEEEFEEEEE000008000800003BBBBFBBBFBBBB9DDDDFDDDFDDDDCEEEEFEEEFE),
    .INIT_5B(256'hDDDCEEEEEEEEEEEEEE00000FFFF800003BBBBFBBBFBBBB9DDDDFDDDFDDDDCEEE),
    .INIT_5C(256'hCDB1E4F90C204000801840E03000000000000003BBBBBBBBBBBBB9DDDDDDDDDD),
    .INIT_5D(256'h19E667B0D68306DB6180663B9C63366DB73B8E6B9F9FBF7EDB3F1FC698F1F9E3),
    .INIT_5E(256'h71B6C63366E76DB0E79B0D6B060C361B067DBFD6BE7CDB7FBE66FB0D69F3EDB6),
    .INIT_5F(256'hFFFFFFFFFFFFF0C06000081808C0016DB6DF9E3C7E6D9FC65B6DFBF7EFF6DBFE),
    .INIT_60(256'h6F67F7FFFFFFFCFDB6F63F7FFFFFFFE0030F0807FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'hF7FFFFFFF9FDB6F67F7FFFFFFFB8DB6F6E37FFFFFFFB8DB6F6E37FFFFFFF9FDB),
    .INIT_62(256'hFFFFFBADFEFEFF7FFFFFFF98DCE06E37FFFFFFFDCD86F6637FFFFFFFCFDB6F63),
    .INIT_63(256'hE1E698F1F8FDFDCCE0C2040200001E0FFFF8610000807FFFFFFFB2CFCFE3F7FF),
    .INIT_64(256'hFD6B6D7D8C66FB0D6B6D7D9E667B0D6B2D0DBF663B9C638C0DF3E6B9F9F9FDFD),
    .INIT_65(256'h003F06DB6DF8FDFDBF665B6DF9FDFDA1671B6C638C0DAD679B0D6B2D0DAD67DB),
    .INIT_66(256'hCFDFDFEB7EFEFFE00000080000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C0600200),
    .INIT_67(256'h7B5B7EFF9FD7DB7B5B7EFFB8D0DB7B5B06FFB8C0C30B1806FF9FDFDFEB7EFEFF),
    .INIT_68(256'hFFB2DFDB7F7EF6FFBADFDB7F7EF6FF98C0DB0318F6FFDCD0DB7B5B06FFCFD7DB),
    .INIT_69(256'hA41000000027FFFFFFFFE7FFFFFFFFE7FFFFFFFFE0000000000F8600180000F0),
    .INIT_6A(256'h7927A5D0924920A5D09248A0A5D39249E3A5D0924920A5D0924920A5D78E79E7),
    .INIT_6B(256'hC000000005DFFFFFFFE5DFFFFFFFE5DFFFFFFFE5DFFFFFFFE5D000000025D78E),
    .INIT_6C(256'hA881C08890A481C7BE60A381C000000001C000000001C000000001C000000001),
    .INIT_6D(256'h000000000000000001C78897A381C08890A481C08890A881C388F0A881C08890),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h48A081C39249E381C092492081C092492081C78E79E780000000000000000000),
    .INIT_70(256'hC000000001C000000001C000000001C000000001C78E792781C092492081C092),
    .INIT_71(256'hA3A5D000000025DFFFFFFFE5DFFFFFFFE5DFFFFFFFE5DFFFFFFFE1C000000001),
    .INIT_72(256'h8897A3A5D08890A4A5D08890A8A5D388F0A8A5D08890A8A5D08890A4A5D7BE60),
    .INIT_73(256'h0000000000000000000007FFFFFFFFE7FFFFFFFFE7FFFFFFFFE41000000025D7),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized1
   (DOADO,
    clka,
    ena_array,
    addra);
  output [3:0]DOADO;
  input clka;
  input [0:0]ena_array;
  input [12:0]addra;

  wire [3:0]DOADO;
  wire [12:0]addra;
  wire clka;
  wire [0:0]ena_array;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_01(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_02(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_03(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_04(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_05(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_06(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_07(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_08(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_09(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0A(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0B(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0C(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0D(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0E(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_0F(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_10(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_11(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_12(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_13(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_14(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_15(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_16(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_17(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_18(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_19(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1A(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1B(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1C(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1D(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1E(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_1F(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_20(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_21(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_22(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_23(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_24(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_25(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_26(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_27(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_28(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_29(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2A(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2B(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2C(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2D(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2E(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_2F(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_30(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_31(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_32(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_33(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_34(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_35(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_36(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_37(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_38(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_39(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3A(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3B(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3C(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3D(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3E(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_3F(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_40(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_41(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_42(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_43(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_44(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_45(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_46(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_47(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_48(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_49(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_4A(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_4B(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_4C(256'h2222222222222222222222222222222222222222222222222222222222222222),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(4),
    .READ_WIDTH_B(4),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(4),
    .WRITE_WIDTH_B(4)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:4],DOADO}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized2
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h19F19F9819C19FF98F1C03E07FFFFFF9F98F9CF9C79E01C018F98F9C01E01FFF),
    .INIT_01(256'hFC0FF81FF0FFF1FFFFFF000000000000000000000000000000000000FFFC0380),
    .INIT_02(256'hFFFC00003F0FFFF0FFFFFFFE0001FFFFFFDFFE5FFB7FEEFFBBFEEFFBBFCEFF8B),
    .INIT_03(256'h08080401E1E0186078040E0E03000000FC3FFFC3FFFFFFF800007E1FFFE1FFFF),
    .INIT_04(256'h00000000000F0F0C003000000000000787800000000000000003C3C010806000),
    .INIT_05(256'h0000C00001E0187878000000600000F00C3C3C3000C030000078061E1E180060),
    .INIT_06(256'h0400F87840C00FFFFFFC00FFFFFFE00FFFFFFF00F0084021840C07C030F0F000),
    .INIT_07(256'h80430F80000010F80000010F80000000F80000200F80000600F80000400F8780),
    .INIT_08(256'hFFFFC001FFFFFC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00),
    .INIT_09(256'h800001E018000000018000000000000000000C06020001E0F04001FFFFFC001F),
    .INIT_0A(256'h60000000000000000000604020003C181C0300C0603E00000001E00000001E01),
    .INIT_0B(256'h80610087E01800010806000042018000108000180000007E0000001F80000000),
    .INIT_0C(256'hFFF801FFFFE1FFFFFFFFFFFFFFFFFFFC01FFFFE1FFFFFFFFFFFFFFFFFFFE001F),
    .INIT_0D(256'hC020100808000000E00103038381E070180C1C0001FFFFE1FFFFFFFFFFFFFFFF),
    .INIT_0E(256'h0000001806000000000400000000000000000000000000000000400000010100),
    .INIT_0F(256'hE018060000000018061E00000787E0180000000000F806000000000600180000),
    .INIT_10(256'h18080F87E000060000000000001E10000787E000060000000000001E00000787),
    .INIT_11(256'hFFFFFFFFFF0FFFFFFE1FFFFFFFFFFFFFFFFFFF0FFFFFFE00860103030180C03E),
    .INIT_12(256'h7FFFFFFFFFFFFFFFFF0FFFFFFE1C7FFFFFFFFFFFFFFFFF0FFFFFFE1C7FFFFFFF),
    .INIT_13(256'hFFFFFF80FFFFFFFFFFFFFFFFFFFFFFFFFF007FFFFFFFFFFFFFFFFF0FFFFFFE00),
    .INIT_14(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_15(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_16(256'hFFBBFFBFFFFFFFFFFFFFFFFFFFFFFFC1FE00F800E000C001C007C01FE0FFFFFF),
    .INIT_17(256'hFE1FFFFFFFC0003FFFFC03F0FFFF0FFFFFFFE0001FFFFFFFF7F7F7DF70771F1E),
    .INIT_18(256'h00E0000186078040E0E0300000FFFFF00FC3FFFC3FFFFFFF80007FFFF807E1FF),
    .INIT_19(256'h00000000787800000000000000000000003C3C00800001080600008080401E1E),
    .INIT_1A(256'hC003000C030000078061E1E18000018006000000000000F0F0C00000C0030000),
    .INIT_1B(256'h7C030F0F0003000000000C00001E0187878001800000000600000F00C3C3C300),
    .INIT_1C(256'hFFFFFFFFFFFFFFFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFE0086010084021840C0),
    .INIT_1D(256'hFFFFE007FFFFFFFFFFFFFFFFFFFFFFF0E3FFFFFFFFFFFFFFFFFFFFFFF871FFFF),
    .INIT_1E(256'h6018183C00000180603FFFFFFFFFFFFFFFFFFFFFFFE00FFFFFFFFFFFFFFFFFFF),
    .INIT_1F(256'h000000001C3F0E00000000000000000000000000000000004010081800000100),
    .INIT_20(256'h7E0180421C380000600000421C3F0F00400000001C3F0F00000000001C3F0E00),
    .INIT_21(256'h0FFFF0FFFFFFE0F07E01807E1C3801807E01807E1C3801007E0180421C380000),
    .INIT_22(256'h080C0DF3EFFFFFFFDBFFFDBFFFFFFBC3DFFFFFFFB7FFFB7FFFFFF733BFFFFFFF),
    .INIT_23(256'h8CDB39C6631987F1F9F8CC6799B65F27969E6769B1B4F2DFB06000E06D81E0D8),
    .INIT_24(256'hB666D9B6637B36CD6B36CDB36CCDB30CC6066D9AD66D9B66D99B67398C9CDB31),
    .INIT_25(256'h186F08043F07F1FC3F18FC6DA7DEC7E37ECE739CE7339CDB1FBD9CE6859B66D9),
    .INIT_26(256'hFFFEDC371FFFFFFFFFDBFFFFFFFDBF6FFFFFFFFFFFB7FFFFFFFB02C0C0210086),
    .INIT_27(256'hF3FFFFFFFFF87FFFFFFF98C637FFFFFFFFF6FFFFFFFF6E9BAFFFFFFFFFEDFFFF),
    .INIT_28(256'hFF6FFFFFB7F63F3FFFFFF87FFFFC3F8403FFF80E03FFFFFFFFFFFFFFFFFFE7C9),
    .INIT_29(256'hDBFFFFFEFC799CBD3B36DFFFFFF1881E0C0C1986FFFFFFEDFFFFF6FECFF7FFFF),
    .INIT_2A(256'h336DB30DFFFFFFDBFB1F9B6D9B6FFFFFF8C0D98CC36CDB7FFFFFDF9987C78CE6),
    .INIT_2B(256'hFC380C05B80601FFFFFFED9F0F8D9F87E7FFFFFF6D9CC66DCE7FBFFFFFFB6360),
    .INIT_2C(256'hFFFFFFFFFFFFFEDAFFFFFFFFFFFFFFFFF6C7FFFFFFFFFFFFFFFFB7FFFFFFFFFF),
    .INIT_2D(256'hFFFF6FFF3F7FFFF861FFC0F87FFC03FFFFFFFFFCF3FFFFFFFFFFFFFFFFCCDFFF),
    .INIT_2E(256'h3CB3F1E672FD3965B00C0C062078318C1B8DFFFFEDB7FFFFEDFFCFEFFFFF6DBF),
    .INIT_2F(256'h6719866D9B6FEC7EDB3F32CE736CC3036630C319B63F8CC67E661F1F8F8DB4ED),
    .INIT_30(256'h301C380E00DB1F8DB67C3E6D9F27E6D9CE6DB6731B6D8C7F36CDB36D8D80DB60),
    .INIT_31(256'hDB5F9B60332D066D98CE3019B67F1FCFE6D8F93F3F9B680E00000C03080430E0),
    .INIT_32(256'hFF00203807C1013E4FDF63F1FC7F7D9FE6338DF673980CB419867E36D7E6D8FC),
    .INIT_33(256'hFFFC01FFFFFFFFFFF003FFE1FFFFC300FFFFFF87FFFFFFFFFFFFE01FFFFFFFFF),
    .INIT_34(256'hFFFF87FFFFFFFFFFFF801FFFFFFFFFFF003FFE1FFFFC200FFFFFF87FFFFFFFFF),
    .INIT_35(256'hE062103C0C000F80380040C0E0E0781C0001FC180303800003FFE1FFFFC000FF),
    .INIT_36(256'h01F0000001000E1C022001804000F8010000000404030080001F8080001000E1),
    .INIT_37(256'h00000000601800401F0006001000E1C020000000000F80000000000000000000),
    .INIT_38(256'h1F00C0200F8600000000003E01800601F0006000000E1C0200300C0200F86000),
    .INIT_39(256'h0000000000000200300C0000F86018000000006018787E1F0006000000000030),
    .INIT_3A(256'h00000000787E1F00000000F0000002000000000F80018000000000000787E1F0),
    .INIT_3B(256'h04300F80218040C0C060300F87E1F80802010F0000002000000200F800180000),
    .INIT_3C(256'hFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFE0421018),
    .INIT_3D(256'hFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFFF871),
    .INIT_3E(256'hFF801FFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFF),
    .INIT_40(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE03FFFFFFFFFFFFFFFFFFFFFFE03FFFF),
    .INIT_41(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_42(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_43(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8FC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE3FC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF8E1C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hDBE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CFFF),
    .INIT_4D(256'hFFFFFFFFFFFFFFFFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0F9FFFFFFFFF),
    .INIT_4E(256'hFFFFFFFFFF80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDF3FFFFFFFFFFFFFFF),
    .INIT_4F(256'hFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7DBE7FFFFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF9F6F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC21),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF3EDF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF041FFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE7DBE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1C3FFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFCFB7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87C3FFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hCF0F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0F83FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3F87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFFFFF0F787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7F8FF),
    .INIT_58(256'hFFFFFFFFFFFFFFFFC1EF07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFFFFFF),
    .INIT_59(256'hFFFFFFFFFF878F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFFFFFFFFFFFFFF),
    .INIT_5A(256'hFFFE1E0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5E(256'h30DB7FFFFDBFB3FDB7FFFFDBFB1F987FFFFC3F8403FFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5F(256'h0DB7F63F36DB36C30366330DB36CFCCC3E3C6736CFC799CBD3B36C3103C18183),
    .INIT_60(256'hFFFFFFFB7FFFFF870180B700C03B67C3E367E1F9B6CE6336E73FDB6360336DB3),
    .INIT_61(256'hFFFFFFE07FFFFFFFFFFCF3FFFFFFFFFF99BFFFFFFFFFFB6BFFFFFFFFFFB63FFF),
    .INIT_62(256'hFFFFFFFB6DFFFFFB7FF9F83FFFC003FFFFF0FFC30FFFFFFFFC30FFFFFC3FFE01),
    .INIT_63(256'h66FFFF6FEFFFFFDBFF6DBFFFFFFFF6DBFFFFF6FFE7F37FFFB7F7FFFFEDFFB6DF),
    .INIT_64(256'hFFFE769E59F8F3397E9CB2CC1E0000DE01818600DB7FFF8060603103C18C60DC),
    .INIT_65(256'hDB3987F33F67F198C7F36D8019FC6633F330F8FC7C6D9B99D981B9DA7969D9B6),
    .INIT_66(256'h36FF6C336CDB7F63F6D9F9966D9CE67EDCE6D99CE6DB7FB739B66181B318618C),
    .INIT_67(256'h63F9B66D9BDB6D9B666D9CEC00DB66D9B6C6C06DB0338CDB30CC0DB0CDB330CC),
    .INIT_68(256'h3F3FFF6D8FC6DB3E1F36CF93F39CDB37B6DB39CCDB3FDFFFB6CE736DB398DB6C),
    .INIT_69(256'hF8601008601E186100806100FFFE184021870180E1C07003F1B66F6DB63F19B6),
    .INIT_6A(256'hF2F1E332C31800606040838DB7FFB7FF6FFB1FDB7FFB7FF6FFB4FD87FF87FF0F),
    .INIT_6B(256'hDB336CDB0338DB6C3336CD9E332C30E7336CC03336CFC7F3198F33336CFD3B34),
    .INIT_6C(256'hFFFFFFFFFEDFFFFFF86180402DC08601B6DB31F8D9E34FDB6DB339CDB331FDB6),
    .INIT_6D(256'h1FFFFFFFFFFFFF3CFFFFFFFFFFFFE66FFFFFFFFFFFFEDAFFFFFFFFFFFFED8FFF),
    .INIT_6E(256'h98DB67E600C319F8FC7C3F3F4E40C3183636DFFDFDB7FF3E61FFE03FFFFFFFF8),
    .INIT_6F(256'hC9E38C31038171B6FFFFE7F6DFFFFE7EC3FFFFE01870180ED9F0F9B6C67F6D81),
    .INIT_70(256'h870300FC36CF0FCFB6DB339DF6DB606DBEDB678DB4186019B63F3F33198FE7E3),
    .INIT_71(256'hCDB3198CFCE61F0F8FCFCCE6720CC1E0F040CDFFFFFDFCDFFFFFDFC1FFFFFC01),
    .INIT_72(256'h0000080030C03030060100C0603E07E1F0F9ECE73198DECDB0180DECDB1F8FC0),
    .INIT_73(256'hC300010100606180008000201040004000000000000000000000000000006100),
    .INIT_74(256'h1C3E001800030E1E000C0000870E0006000043870003000001C38200020200E1),
    .INIT_75(256'hEDFFB7FDA6FFFDBFFFFFFF3E7FFFFFFFFFE1F87FE1FF0C3FFF0FFFFFFFE02DDC),
    .INIT_76(256'hEFE0DB0100303637FFFFFFFFFEDFB7FEDFF6BBFFF6FFFFFFFDFDFFFFFFFFFFB7),
    .INIT_77(256'hFCCD3F1E1B36D3CCED3B2F8D3967BF3969B1861E40D0300186078360C00860D8),
    .INIT_78(256'h736CDB36CE736CCC67DBEC6663333305F8CCFCDB198671FCE731F1BEF9F18FCF),
    .INIT_79(256'hDB36CC0671BE066633333198C780CC336CDB30CDB31F9E6F9F998CCCCFC60032),
    .INIT_7A(256'hDBE7C69F3033F0F8CDECFE39CE736CE7331996FB198FCCCCC67F307B39CDB36C),
    .INIT_7B(256'hFFFFFFF03E001C0300860C0840430FC0430C1E001809E7B3727E1F8DB3F8C7C6),
    .INIT_7C(256'hFFFFFFFFFFFEDC7FFFFFFFFFFEDFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFFFFFB7),
    .INIT_7D(256'hFFE637FFFFFFFFFFEDFFFFFFFFFFFFFFFFFFFFFB75FFFFFFFFFFFB7FFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9FFFFFFFFFFF87FFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'h7F7FEDFFFFFCFDF6FFFF6FEFFC3FFFFFC03E1FFFE001FFFFFFFFFFFFFF80FFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hE67E3C7E9E67971BEDCCECC0D023181E06E37D83C0001BFF6FFFFFCFEFB7FFFB),
    .INIT_01(256'h36CDEC79B6DB36D737DB66198181861B66DA7EFB6CE733F333F198661FDF730F),
    .INIT_02(256'h010C03C0F36CFC3F196F9F8DB37B336DB9CE73ADF739B66F660DB6D9B631BEDB),
    .INIT_03(256'h7DBEDF6FB7DBEDF6F87C1FCEF9CF1807FFFFFE300CE7F9DFE0F038700C02187E),
    .INIT_04(256'h80040200000000000007C001F0187C061F0187C061F0187C061F018001FCFE03),
    .INIT_05(256'hEB6C7F5B671ADB38D6D8FEB6D3F5B6C021840200000000001806018060180601),
    .INIT_06(256'h000000000000000000000000000000000000061805969F8EB5FE31AE75CD61A7),
    .INIT_07(256'hF1CCC39680003FF87FF1FFF1FFC3FF800000000001FFF0000000000000000000),
    .INIT_08(256'hCCC39680003FF87FF1FFF1CCC39680003FF87FF1FFF1CCC39680003FF87FF1FF),
    .INIT_09(256'hC21680003FF87FF1FFF1CCC39680003FF87FF1FFF1CCC39680003FF87FF1FFF1),
    .INIT_0A(256'h0000003FF87FF1FFF1FFC3FF80003FF87FF1FFF1C0C21080003FF87FF1FFF1C0),
    .INIT_0B(256'hC0000000000000000000000000000000000000000000000000000001FFF00000),
    .INIT_0C(256'h003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC000000000000003FFE7FF),
    .INIT_0D(256'h3FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0),
    .INIT_0E(256'hF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC000),
    .INIT_0F(256'h00000003FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003F),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'hFFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF000000),
    .INIT_12(256'hE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0),
    .INIT_13(256'hFFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FF),
    .INIT_14(256'h0000000000000000000000000000003FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1),
    .INIT_15(256'hF87FE187FFFF87FE18077330FBE0000000000000000000000000000000000000),
    .INIT_16(256'h00000000180000180000000001840100840018601818600187FFFF87FE187FFF),
    .INIT_17(256'hFFFFFFFFFFFF0086100806100860000060000600000600006018006000000180),
    .INIT_18(256'h0E06007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFF),
    .INIT_19(256'h00000000000000000001F8000040101802018000040218408060183C0303C040),
    .INIT_1A(256'hC03000000060000061800000003000000060180000000000003000000061F800),
    .INIT_1B(256'h8403008061860000C00080000000000061860000C00000000000000061860000),
    .INIT_1C(256'hFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFC0E1861010C201C007),
    .INIT_1D(256'hFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFF),
    .INIT_1E(256'hF8007E3F1F8FC3F000FC7E3F1F80000000000000000000000000007FFFFFFFFF),
    .INIT_1F(256'h000000001F8007E3F1F8FC3F000FC7E3F1F87E001F8FC7E3F0FC003F1F8FC7E1),
    .INIT_20(256'hF7FCFC003F1FBFEFF9F8007E3F7FDFF000000000FFBFE000000001FFFFC00000),
    .INIT_21(256'h00000001FF7FCFC003F1FBFEFF9F8007E3F7FDFF3F000FC7EFFBFE7E001F8FDF),
    .INIT_22(256'h07EFFBFE7E00000FDFF7FCFC00001FBFEFF8000000007FDFF000000000800020),
    .INIT_23(256'h3FF000000000FFBFE7E00000FDFF7FCFC00001FBFEFF9F800003F7FDFF3F0000),
    .INIT_24(256'h8FDFF7FBFEFC3F1FBFEFF7FDF87E3F7FDFEFFBF00000FFBFDFF0000001FFFFC0),
    .INIT_25(256'hFFFFF0000001FF7FBFE003F1FBFEFF7FDF87E3F7FDFEFFBF0FC7EFFBFDFF7E1F),
    .INIT_26(256'h3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F8000000000000000000FF),
    .INIT_27(256'h00000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E),
    .INIT_28(256'h0180061830081807800C3FF87FF0FFFE187FF0FFE1FFFC30FFE1FFC3FFF86000),
    .INIT_29(256'h000061800300000000C300060000000000010C00018000000200000308080004),
    .INIT_2A(256'hFFFFFFFC3FFFFFFFFFFFF87FF01C300C038080401860000200000030C0000000),
    .INIT_2B(256'hFC3FFE1803FF0FFF8701FFFFFFFFFF87FFFFFFFFFFFF0FFFFFFFFFFFFE1FFFFF),
    .INIT_2C(256'h00C30061800000002000000000080000000002000081008180003FF0FFF8600F),
    .INIT_2D(256'h000000000000000000000081C300E1C04030C01860000C30061800030C018600),
    .INIT_2E(256'hE3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F000FF0),
    .INIT_2F(256'h07F80000FF7F80000000000000001FE0000000003F3FCFC7E3F1F87E7F9F8FC7),
    .INIT_30(256'hC7E7FBFC7E7F9F8FCFF7F8FCFF3F1F9FEFF1F9FE7E3F3FDFE3F3FCFC7E7FBFC0),
    .INIT_31(256'hDFE003FDFE007FBFC0000000000000000FF00001FEFF1F9FE7E3F3FDFE3F3FCF),
    .INIT_32(256'h9FEFF3F3FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF1F9FEFF3F3F),
    .INIT_33(256'hBFDFE7E00000FF7FBFC0000000000000000007FBFC00FF7F8FCFF7F9F9FEFF1F),
    .INIT_34(256'h3F0FC7E7FBFDFE7E1F8FCFF7FBFCFC3F1F9FEFF7F9F87E3F3FDFEFF3F0FC7E7F),
    .INIT_35(256'h3F1F8FC7E3F000000000000000000000000000000001FEFF7F8007E3F3FDFEFF),
    .INIT_36(256'h7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E),
    .INIT_37(256'hB7CCF7BBF4B46D9324C8B4EDFB7EDC0000000000000000000000000003F1F8FC),
    .INIT_38(256'h08186001801FFFFFFFFFFFC3F003FFFFFFFFFFF87F00FFFFFFFFFFFF0FF03EDF),
    .INIT_39(256'h000180000018000010C030000000000002180000040403000043000400C1C0F0),
    .INIT_3A(256'h00860000006000804000C000000C00000000180006018000000C030007C00000),
    .INIT_3B(256'hFFFE00FFFC3FFFFFFFFFFFFFFFE00FFFC3FFFFFFFFFFFFFFFE0080C043000E07),
    .INIT_3C(256'h0001C0180203C04000020100FFFC03C0307E0E006070000FFFC3FFFFFFFFFFFF),
    .INIT_3D(256'h3000001800000000100001C3000001800000020100001C000000180000002010),
    .INIT_3E(256'h0180000001E1F0001C000C00180000001E1F0001C300C00180000001E1F0FFFC),
    .INIT_3F(256'h0080400000000C0300C0300000000201FFFE010C203C043C003E1F0001C000C0),
    .INIT_40(256'h000001C00200001C00000001C00000FFFC00000FFFF0C000FFFF0C200FFFF0C3),
    .INIT_41(256'h9B62D2FDDEF33EDFB70EE6FFFF0C300001F0C200001F0C000001F0C000FFFF0C),
    .INIT_42(256'h6FFFFEDB33FBFFFFB6CCFEFFFFE180001BB801DD8000000003B7EDFB72D1324C),
    .INIT_43(256'hF6F6036DB37D818FDB6CD064E630C335F9F8F8FCCD7E369CBF3341A030630C00),
    .INIT_44(256'h33B1E583C0206DFFFFFF6FFFFFF87FFFFFFC2038601F0F63E6DB37DBD98DB6CD),
    .INIT_45(256'hFFFE00FFFC02010C0027E36CFC739B66336CDB319B6619F8DB39CC1730FE66B7),
    .INIT_46(256'h8F87F33F1F0FE9CCECC313971B078006DE0DC6FFFFEC37FF3FBFFFFB39FFE7EF),
    .INIT_47(256'h303E36CDB67C6598CDB36DB19D60336CDB606318FCC336D9FAE66339CC30C69F),
    .INIT_48(256'hFFF66FFFFFFFFF3FBFFFFD9BFFFFFFFFE7EFFFFF00FFFFFFFFFC020218061C04),
    .INIT_49(256'hD9B69F9CE3F99CC3F9B6330FE5F27666E6766DA7971801C00183C0030C0DC6FF),
    .INIT_4A(256'hD99CE6D9FC739FE6D9B666D9B6739B6719B66199B6619866D8C66D9CE66D9CE6),
    .INIT_4B(256'hFFFFF6FFFFFFFFFFFFFFFFFD810C02010C003807007F1B663F1B66E4FC9F9CE6),
    .INIT_4C(256'hFFFFFFFFFFFFFCC6FFFFFFFFFFFFFFFF6EBFFFFFFFFFFFFFFFDB8FFFFFFFFFFF),
    .INIT_4D(256'h0FE6DA7971878C0DC6FFFFF3FBFFFFE7EFFFFFC0301FFFFFFFFFFFFFFFF9F3FF),
    .INIT_4E(256'h70000000000000078807006D8FC9FACD739FEDEDB671BB76D8C6DEDB69FACD33),
    .INIT_4F(256'h08018000000000007F87F87F87F87F87F87F87F87F87FC7FE3F10F8C007007C0),
    .INIT_50(256'hC7F11FE07FC1FF87FF1FF800000000FF1FE3FC7F8FF00600C018FF1FE3FC7F80),
    .INIT_51(256'hFFF03FFF07FFF0FFFF8FFF1FFE3FFC7FF8FFF1FF0000000000071F1E3C7C71F8),
    .INIT_52(256'h000000000000000070FF0F0FE1F0FC3F0F87F0F0FF0E1FF0C3FF087FF00FFF01),
    .INIT_53(256'h3FE1C3FE1C3801C3001C3001C3803C30FFFF0FFFF0FFFF0FFFF0FFFF0FFFC000),
    .INIT_54(256'h001C0411C03E1C03E1C03E1C03E1C0001C0001C1FF1C2001C3FE1C3FE1C3FE1C),
    .INIT_55(256'h07FE000FFC03FFF807FFF00FFFE01FF80000600000C00801C03802003C0001C0),
    .INIT_56(256'h800002000000001080001E01FC3C03F87807F0F00FE0001FC00001BFC0038000),
    .INIT_57(256'hBFC425800827FE108FFC213FF8447FF081FFE103F8020FE0043FC008FFC03003),
    .INIT_58(256'hFFFF87F0030FC0021F80043F10887E1E10FC3C2008780000F000000100400210),
    .INIT_59(256'hFFFFFFFFFFFFFFFFFFFF03FF0F03FF0FC0FF03C0FF03FFFFFFFFFFFFFFFFFFFF),
    .INIT_5A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFC0FFFFC0FFFFF03FFFF03FFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFC3FFFFF03FFFFC0FFFFFFFFFFFF),
    .INIT_5D(256'hFFFF03FFFFC0FFFFFFFFFFFFFFF0FFFFFC3FFFFFC3FFFFF0FFFFFFFFFFFFFFFF),
    .INIT_5E(256'hFFFFFFFFFFFFFC0FF03F03FC0FF03FC0FC0FF03FFFFFFFFFFFFFFFFFFFFFFC3F),
    .INIT_5F(256'hFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0FFFFFF03FFFFF03FFFFFFFFFFFFFFFFF),
    .INIT_60(256'hFFFF03FFFFF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'h0FC0FF00FF03FC03F03FC03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0FF),
    .INIT_62(256'hFFFFFF0FFFFFF0FFFFFF03FFFFF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FF0),
    .INIT_63(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFF00FFFFFC03FFFFC03F),
    .INIT_64(256'h0003F0FFFFFF0FFFFFFC3FFFF3C3FFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_65(256'hFFC3FFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFF0000FFFC0003FFC),
    .INIT_66(256'hFFF0FFFFFC3FFFFFC3FFFFF0FFFF0FFFFFC3FFFFFC3FFFFF0FFFF0FFFFFC3FFF),
    .INIT_67(256'hFFFFFFFFFFFFFFFF3FFFFFCFFFFFFF3FFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_68(256'h00007FF0000E000001F80001F807FC0700000000FF03C03FC0FF03FC0FC0FF03),
    .INIT_69(256'hFF7EFFFF7EFDFDFDDFFFFF9FFFFFBFF7FFF77FFFFEFDFFFEFDFBFDFBBFFFFF00),
    .INIT_6A(256'h77FFFFE7FFFFEFF7FFFDDFFFFFB87FFF877EFDFEEFFFFFCFFFFFDFF7FFFBBFFF),
    .INIT_6B(256'hFBDF77FFFFEEFDFEFDDFBDFFB803F003FFFFF7F7F83EEFFFFFDDF801FBBF7DFF),
    .INIT_6C(256'hBF77EDFFEFFEFDFFFEFDFFF7FBEFB80003F77EFF7EEFDDFFDFFDFBFC01F803F7),
    .INIT_6D(256'hFFBF7FF7FBFBEFFFFEFDFFFFDFBBF5FFF7FF7EFFFF7EFFF7FBF7DFFFFDFB807F),
    .INIT_6E(256'h003F7EFFFF0EFFFFFDFFDFBFFFDFBFFBFEFDF7FFFF7EFC000FDDF9FFFBFFBF7F),
    .INIT_6F(256'hFF7FF7EFFFF7EFFFBFEF7DFEFFFFBF7FFFBF7FFFFEFFEFDFFFEFDFFEFFBEFBFC),
    .INIT_70(256'hFBFFFF7FBFFFEEFC000FDFFFFFBFFBF7FFFBF7FFEFF83EFF7FFFDC3FFFDFBFFF),
    .INIT_71(256'h7FFFF7FFFFEFFEFDFFFEFDFFFEFFFFBFDFFFF77EFFFFEFFFFFDFFDFBFFFDFBFF),
    .INIT_72(256'h7FFFBF7FFFEFFFEFFFFEFDDFBFFFFBFFF9F7FF7EFFFF7EFFFFBFFFDFE001FBBF),
    .INIT_73(256'hFFFFBF77EFF00EFFFB7DFFDFBFFFDFBFFFF781F7FFFF7EEFDFFFFDFFFAFBFFBF),
    .INIT_74(256'hFBDF7007E00FF7EFFFF7DF7DFFFFFFBBF7FBF77FFBBEFFEFDFFFEFDFFFF7DEFB),
    .INIT_75(256'hFFF7DFDF7FFFFFEEFC00FDDFFBEFBBFFFFF7FBF7FFF7DFBEFFFFFFDDFBFDFBBF),
    .INIT_76(256'hF7FFFBF7FBFBEEFFFFFDFEFDFFF7DFEFBFFFFFF70FFFF0EFFBF7DDFFFFFBFDFB),
    .INIT_77(256'h00007FBF7FF7DFFBEFFFFFFDFBFFFDFBFBFDF77FFFFEFF7EFFF7DFF7DFFFFFFB),
    .INIT_78(256'hFDC03FE038000007E00007FC0001FFC03FF81FFC07000000FC0000FC03FE0380),
    .INIT_79(256'hF70FFFF0E1FFFC1FBFBFBBFFFFF7EFFFF7FDFFFDDFBFDFBBFFFFF7EFFFF7FDFF),
    .INIT_7A(256'h9FBDFFB803F0077FFFFEEFFFFF9FBEFFBBFFFFF77FFFFEEFFFFF9FBF7FBBFFFF),
    .INIT_7B(256'h7F7EFEEFDFDF9FB7FFBFFBF7FF7F00FEEFC01F9FBBFFBFFBF7FF7FFFFEEFFFFF),
    .INIT_7C(256'hFFFFBFFBF7FF7F7EFEE01FDF9F9FFFBFFBF7FF7F7EFEEFDFDF9FAFFFBFFBF7FF),
    .INIT_7D(256'h7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9F),
    .INIT_7E(256'hFFBFFBF7FF7F7EFEE01FDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F),
    .INIT_7F(256'hFEEFC01F9FFFAFBFFBF7FF7F7EFEEFDFDF9FFFCFBFFBF7FF7F7EFEEFDFDF9FFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized3
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hB803F0077FFFFEEFFFFF9FFEEFBFFBF7FF7FFFFEEFFFFF9FFF6FBFFBF7FF7F00),
    .INIT_01(256'hFDFFFDDFF7EFBBFFFFF70FFFF0E1FFFC1FFBEFBBFFFFF77FFFFEEFFFFF9FFDEF),
    .INIT_02(256'h000007E00007FC0001DFDFEFBBFFFFF7EFFFF7FDFFFDDFEFEFBBFFFFF7EFFFF7),
    .INIT_03(256'hF0FC003F1F8FC7E1F8007E3F1F8FC000000000000000000000000000003FE038),
    .INIT_04(256'h00000000000FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F87E001F8FC7E3),
    .INIT_05(256'hE8FC027E001F8FD03004FC003F1FA040080000000040001000000000FFFFE000),
    .INIT_06(256'h10000000008C0027E001F8FD1A004FC003F1FA36009F8007E3F47E013F000FC7),
    .INIT_07(256'h0003F460013F000007E8C0027E00000FD1800400000000230008000000004600),
    .INIT_08(256'hE31FF800000000460013F000007E8C0027E00000FD18004FC00001FA30009F80),
    .INIT_09(256'h0FC7E7FFFC317E1F8FCFFFF862FC3F1F9FFFF0C5F800003FFFE188000000007F),
    .INIT_0A(256'h003FFFF80000007FFFC01001F8FCFFFF802FC3F1F9FFFF3C5F87E3F3FFFE78BF),
    .INIT_0B(256'h3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E),
    .INIT_0D(256'h7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0000000000000000000000000000),
    .INIT_0E(256'h0000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC),
    .INIT_0F(256'hFC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F800000000000000000000000),
    .INIT_10(256'h00000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0),
    .INIT_11(256'hF1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC0000000000000000000),
    .INIT_12(256'h000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3),
    .INIT_13(256'h93F1F8FC3F1F9A27E3F1F87E3F354FC7E3F0FC7E409F8FC7E00000FF00000000),
    .INIT_14(256'h0000000000000000000001FE00000007E3F354FC7E3F0FC7E6A9F8FC7E1F8FCD),
    .INIT_15(256'hC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F00000000000),
    .INIT_16(256'h000000000000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0F),
    .INIT_17(256'h1F87E001F8FC7E3F0FC003F1F8FC7E1F8007E3F1F8FC00000000000000000000),
    .INIT_18(256'h0000000FFFFE00000000000000FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F),
    .INIT_19(256'h3F7FDB33F000FC7EFFB467E001F8FDFF6ACFC003F1FBFE818000000007FDFF00),
    .INIT_1A(256'hFF80000000040001000000000FFBFE7E001F8FDFF6ACFC003F1FBFED59F8007E),
    .INIT_1B(256'h00001FBFEFF9F800003F7FDFF3F000007EFFBFE7E00000FDFF7FC000000003FE),
    .INIT_1C(256'hFEFF8000000AABFE01FF8000000007FDFF3F000007EFFBFE7E00000FDFF7FCFC),
    .INIT_1D(256'hF87E3F3FDFEFFBF0FC7EFFBFDFF7E1F8FCFF7FBFEFC3F1FBFEFF7FDF800003FD),
    .INIT_1E(256'h0000000000000002A9FFFF8000000FFBFDFF001F8FCFF7FBFEFC3F1FBFEFF7FD),
    .INIT_1F(256'hF1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000),
    .INIT_20(256'h0001550000000000000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3),
    .INIT_21(256'h03F1F8FC7E1F8017E3F1F8FC3F400FC7E3F1F87E005F8FC7E3F0010000000000),
    .INIT_22(256'h1FF7FC010000003FFFF800010000000003F400FC7E3F1F87E005F8FC7E3F0FD0),
    .INIT_23(256'h67E005F8FDFF6CCFD003F1FBFED19F8017E3F7FDAB3F400FC7EFFA0600004000),
    .INIT_24(256'h00100FFBFE00005540100004010000003FEFF9F8017E3F7FDAB3F400FC7EFFB5),
    .INIT_25(256'h7FDFF3F400017EFFBFE7E00000FDFF7FCFD00005FBFEFF9F800003F7FDFF0040),
    .INIT_26(256'h00001FF7FBFE000055401FF807FE000000001FF7FCFD00005FBFEFF9F800003F),
    .INIT_27(256'hFFBFDFF7E1F8FDFF7FBFEFC3F1FBFEFF7FDF87E3F7FDFEFFBF0FC7EFFBFDFF7E),
    .INIT_28(256'h7E3F0000000000000000001FFFFFFE0000003FEFF7FC007E3F7FDFEFFBF0FC7E),
    .INIT_29(256'h7E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC),
    .INIT_2A(256'h00000000000FFC0000000000000000000000000000000000003F1F8FC7E3F1F8),
    .INIT_2B(256'hF8FC3F7FEFC7E3F1F87EFFDF8FC7E3F0FDFFBF1F8FC7E1FBFF7E3F1F8FC007FE),
    .INIT_2C(256'h03FF00007FDFF004020000FFFFE00FFC000000000FDFFBF1F8FC7E1FBFF7E3F1),
    .INIT_2D(256'hF1FBFED59FBFF7E3F7FDB33F7FEFC7EFFB467EFFDF8FDFF6ACFDFFBF1FBFE818),
    .INIT_2E(256'hF7FC01FF7FC03FEFF80201FF8040001007FE0000FFBFE7EFFDF8FDFF6ACFDFFB),
    .INIT_2F(256'hEFFBFEFDFF7FCFDFF7FDFBFEFF9FBFEFFBF7FDFF3F7FDFF7EFFBFE7EFFBFEFDF),
    .INIT_30(256'hEFF7FDF800007FDFEFF80001FF807FE01FF803FEFF807FDFF3F7FDFF7EFFBFE7),
    .INIT_31(256'hEFC3F1FBFEFF7FDF87E3F7FDFEFFBF0FC7EFFBFDFF7E1F8FDFF7FBFEFC3F1FBF),
    .INIT_32(256'h8FC7E3F1F8FC0000000000000000007FFFFFF8000000FFBFDFF001F8FDFF7FBF),
    .INIT_33(256'h1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F),
    .INIT_34(256'hB9DDDDDDDDDDDDDC000000000000000000000000000000000000000000FC7E3F),
    .INIT_35(256'hBFBBBFBB9FDFDDDFDDDFDDC1FF0001FFFF000777777777777773BBBBBBBBBBBB),
    .INIT_36(256'hF3FFBBBBBBBFFC79FFDDDDDDDFFE3C11F0001FFF11F07F7F777F777F773FBFBB),
    .INIT_37(256'h777777773BBBFFBBBBBBBB9DDDFFDDDDDDDDC1F01F00001F1F07FF7777777FF8),
    .INIT_38(256'h07777FF7F7F77773BBBFFBFBFBBBB9DDDFFDFDFDDDDC0001101FF000007777FF),
    .INIT_39(256'hF1F001F08F77F7FF7F777747BBFBFFBFBBBBA3DDFDFFDFDDDDDF0011F1010000),
    .INIT_3A(256'hDFF001FFF00011080F77F77F777FF407BBFBBFBBBFFA03DDFDDFDDDFFD1F01F1),
    .INIT_3B(256'hDDDDDFFC01F01F00000110777777777777FF3BBBBBBBBBBBFF9DDDDDDDDDDDFF),
    .INIT_3C(256'h9DE3DE0003DDDDC011011FFF001F0778F78F77777FF3BC7BC7BBBBBFF9DE3DE3),
    .INIT_3D(256'hBBBBBBB9DDDDDDDDDDDDDC01F01FFFF00000778F78000F77773BC7BC0007BBBB),
    .INIT_3E(256'h3BBBBBBBBBBBBB80000000000000000000000000000777777777777773BBBBBB),
    .INIT_3F(256'h77777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE77777777777777),
    .INIT_40(256'h777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE7777777),
    .INIT_41(256'hEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE),
    .INIT_42(256'hEEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000EEEEEEE),
    .INIT_43(256'h0000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000),
    .INIT_44(256'h00000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB80000000),
    .INIT_45(256'hBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB8),
    .INIT_46(256'hBBBB80003BBBB800000000000000EEEEE0EEEEEEEE777770777777773BBBB83B),
    .INIT_47(256'h7777773BBBBBBBBBBBBB800000000000000EEEEE0000EEEEE777770000777773),
    .INIT_48(256'h777777777777700000000000000000000000000000EEEEEEEEEEEEEE77777777),
    .INIT_49(256'hEEFEEE7777777F777F7700000007FFFC001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7),
    .INIT_4A(256'hEEEEEEEEFFEEE7777777777FF7700000007FFC4001DDDDDDFDDDFDDCEEEEEEFE),
    .INIT_4B(256'hDDDDDCEEEFFEEEEEEEEE7777FF7777777700007C00007C001DDDDDDDDDFFDDCE),
    .INIT_4C(256'hDDFFDFDFDDDDCEEEFFEFEFEEEEE7777FF7F7F777700004407FC00001DDDFFDDD),
    .INIT_4D(256'hC07FC1DDDFDFFDFDDDDCEEEFEFFEFEEEEE7777F7FF7F7777000047C40400001D),
    .INIT_4E(256'h0007FFC004041DDDDFDDFDDFDFCEEEEFEEFEEFEFE77777F77F77F7F00007C7C7),
    .INIT_4F(256'h77777000007C00007FC1DDDDDDDDDDFDFCEEEEEEEEEEFEFE77777777777F7F00),
    .INIT_50(256'h7778000F77770000047FFC00001DDDDE3DDDDDDDCEEEEF1EEEEEEEE777778F77),
    .INIT_51(256'hEEEEE77777777777777000007FFFC00001DDDDE0003DDDDCEEEEF0001EEEEE77),
    .INIT_52(256'hEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_53(256'hDFDDCEEEEEEFEEEFEEE0000000FFFF8003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEE),
    .INIT_54(256'hDDDDFDDDFDDCEEEEEEFEEEFEEE000000080008003BBBBBBFBBBFBB9DDDDDDFDD),
    .INIT_55(256'hBBBB9DDDFDDDDFDDDDCEEEFEEEEFEEEEE0000FFFFFFF8003BBBBBBFBBBFBB9DD),
    .INIT_56(256'hBFBBBBFBBBB9DDDFDDDDFDDDDCEEEFEEEEFEEEEE000080000800003BBBFBBBBF),
    .INIT_57(256'h0FF83BBBFBBBBFBBBB9DDDFDDDDFDDDDCEEEFEEEEFEEEEE000080000800003BB),
    .INIT_58(256'h0FFFFF808083BBBFBBBBFBFBF9DDDFDDDDFDFDFCEEEFEEEEFEFEFE0000800008),
    .INIT_59(256'hEEEE00000FFFF80FF83BBBBBBBBBBFBF9DDDDDDDDDDFDFCEEEEEEEEEEFEFE000),
    .INIT_5A(256'hEF0001EEEEE000008000800003BBBBC3BBFBBBB9DDDDE1DDFDDDDCEEEEF0EEFE),
    .INIT_5B(256'hDDDCEEEEEEEEEEEEEE00000FFFF800003BBBBC0007BBBB9DDDDE0003DDDDCEEE),
    .INIT_5C(256'h018004010C204000801840E03000000000000003BBBBBBBBBBBBB9DDDDDDDDDD),
    .INIT_5D(256'h0000000010800018000000000000000180000008000000001800000080000000),
    .INIT_5E(256'h0006000000240C00000001080000000000000010800018000000000108000180),
    .INIT_5F(256'hFFFFFFFFFFFFF0C06000081808C0010C06000000000C0000406000000000C000),
    .INIT_60(256'h0F0007FFFFFFFC0030F0007FFFFFFFE0030F0807FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF8003),
    .INIT_62(256'hFFFFF8200000007FFFFFFF8004800007FFFFFFFC0000F0007FFFFFFFC0030F00),
    .INIT_63(256'h000080000000000C00C2040200001E0FFFF8610000807FFFFFFF8200000007FF),
    .INIT_64(256'h0108610000000001086100000000010821000000000000000000008000000000),
    .INIT_65(256'h003F00C0600000003F0040600000002100006000000021000001082100210000),
    .INIT_66(256'hC00000080000FFE00000080000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C0600200),
    .INIT_67(256'h784300FF801018784300FF801018784300FF800000080000FF800000080000FF),
    .INIT_68(256'hFF8200180000F0FF8200180000F0FF8000180000F0FFC01018784300FFC01018),
    .INIT_69(256'hBC100000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8600180000F0),
    .INIT_6A(256'h7927BDD0924920BDD09248A0BDD39249E3BDD0924920BDD0924920BDD78E79E7),
    .INIT_6B(256'h1FFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDD00000003DD78E),
    .INIT_6C(256'h003C100000003C100000003C100000003C1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC),
    .INIT_6D(256'hFFFFFFFC100000003C100000003C100000003C100000003C100000003C100000),
    .INIT_6E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6F(256'h00003C100000003C100000003C100000003C100000003C100000003FFFFFFFFF),
    .INIT_70(256'h1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC100000003C100000003C100000003C1000),
    .INIT_71(256'hA3BDD00000003DDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFC1FFFFFFFFC),
    .INIT_72(256'h8897A3BDD08890A4BDD08890A8BDD388F0A8BDD08890A8BDD08890A4BDD7BE60),
    .INIT_73(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC100000003DD7),
    .INIT_74(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_75(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_76(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_77(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_78(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_79(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_01(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_02(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_03(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_04(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_05(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_06(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_07(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_08(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_09(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_0F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_10(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_11(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_12(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_13(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_14(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_15(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_16(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_17(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_18(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_19(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_1F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_20(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_21(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_22(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_23(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_24(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_25(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_26(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_27(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_28(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_29(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_30(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_31(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_32(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_33(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_34(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_35(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_36(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_37(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_38(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_39(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_40(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_41(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_42(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_43(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_58(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_59(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_60(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_62(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_63(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_64(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_65(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_66(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_67(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_68(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_69(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_70(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_71(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_72(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_73(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_74(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_75(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_76(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_77(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_78(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_79(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized4
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'hFC0FF81FF0FFF1FFFFFFFFFC018018F9CF9E01C018F98F9C01E01FFF00000000),
    .INIT_02(256'hFFFC00003F0FFFF0FFFFFFFE0001FFFFFFDFFE5FFB7FEEFFBBFEEFFBBFCEFF8B),
    .INIT_03(256'h08080401E1E0186078040E0E03000000FC3FFFC3FFFFFFF800007E1FFFE1FFFF),
    .INIT_04(256'h00000000000F0F0C003000000000000787800000000000000003C3C010806000),
    .INIT_05(256'h0000C00001E0187878000000600000F00C3C3C3000C030000078061E1E180060),
    .INIT_06(256'h0400F87840C00FFFFFFC00FFFFFFE00FFFFFFF00F0084021840C07C030F0F000),
    .INIT_07(256'h80430F80000010F80000010F80000000F80000200F80000600F80000400F8780),
    .INIT_08(256'hFFFFC001FFFFFC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00),
    .INIT_09(256'h800001E018000000018000000000000000000C06020001E0F04001FFFFFC001F),
    .INIT_0A(256'h60000000000000000000604020003C181C0300C0603E00000001E00000001E01),
    .INIT_0B(256'h80610087E01800010806000042018000108000180000007E0000001F80000000),
    .INIT_0C(256'hFFF9FDFFFFEDFFFFFFFFFFFFFFFFFFFCFDFFFFE1FFFFFFFFFFFFFFFFFFFE001F),
    .INIT_0D(256'hCF26D369C9B38C00E00103038381E070180C1C038DFFFFEDFFFFFFFFFFFFFFFF),
    .INIT_0E(256'h0C0CC61B36C9CC663274FCE71FCCCCCC7C66198FC7E3E3F1FCBE4ECC7879393C),
    .INIT_0F(256'hECDB36CCC0C0061B36DECC6037B7ECDB30CC78787EFB36C0CC63F0360CDB39CC),
    .INIT_10(256'h18680F87E0FE36CC78787C3E1F9ED3E3E7B7ECE736CCCCCCC66739DEC7E637B7),
    .INIT_11(256'hFFFFFFFFFF6FFFFFFEDFFFFFFFFFFFFFFFFFFF6FFFFFFEC0860103030180C03E),
    .INIT_12(256'h7FFFFFFFFFFFFFFFFF6FFFFFFEDD7FFFFFFFFFFFFFFFFF6FFFFFFEDC7FFFFFFF),
    .INIT_13(256'hFFFFFF80FFFFFFFFFFFFFFFFFFFFFFFFFF3E7FFFFFFFFFFFFFFFFF0FFFFFFE63),
    .INIT_14(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_15(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_16(256'hFFBBFFBFFFFFFFFFFFFFFFFFFFFFFFC1FE00F800E000C001C007C01FE0FFFFFF),
    .INIT_17(256'hFE1FFFFFFFC0003FFFFC03F0FFFF0FFFFFFFE0001FFFFFFFF7F7F7DF70771F1E),
    .INIT_18(256'h00E0000186078040E0E0300000FFFFF00FC3FFFC3FFFFFFF80007FFFF807E1FF),
    .INIT_19(256'h00000000787800000000000000000000003C3C00800001080600008080401E1E),
    .INIT_1A(256'hC003000C030000078061E1E18000018006000000000000F0F0C00000C0030000),
    .INIT_1B(256'h7C030F0F0003000000000C00001E0187878001800000000600000F00C3C3C300),
    .INIT_1C(256'hFFFFFFFFFFFFFFFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFE0086010084021840C0),
    .INIT_1D(256'hFFFFE007FFFFFFFFFFFFFFFFFFFFFFF0E3FFFFFFFFFFFFFFFFFFFFFFF871FFFF),
    .INIT_1E(256'h6018183C00000180603FFFFFFFFFFFFFFFFFFFFFFFE00FFFFFFFFFFFFFFFFFFF),
    .INIT_1F(256'h000000001C3F0E00000000000000000000000000000000004010081800000100),
    .INIT_20(256'h7E0180421C380000600000421C3F0F00400000001C3F0F00000000001C3F0E00),
    .INIT_21(256'h0FFFF0FFFFFFE0F07E01807E1C3801807E01807E1C3801007E0180421C380000),
    .INIT_22(256'h080C0DF3EFFFFFFFDBFFFDBFFFFFFBC3DFFFFFFFB7FFFB7FFFFFF733BFFFFFFF),
    .INIT_23(256'h8CDB39C6631987F1F9F8CC6799B65F27969E6769B1B4F2DFB06000E06D81E0D8),
    .INIT_24(256'hB666D9B6637B36CD6B36CDB36CCDB30CC6066D9AD66D9B66D99B67398C9CDB31),
    .INIT_25(256'h186F08043F07F1FC3F18FC6DA7DEC7E37ECE739CE7339CDB1FBD9CE6859B66D9),
    .INIT_26(256'hFFFEDC371FFFFFFFFFDBFFFFFFFDBF6FFFFFFFFFFFB7FFFFFFFB02C0C0210086),
    .INIT_27(256'hF3FFFFFFFFF87FFFFFFF98C637FFFFFFFFF6FFFFFFFF6E9BAFFFFFFFFFEDFFFF),
    .INIT_28(256'hFF0FFFFF87F0003FFFFFF87FFFFC3F8403FFF80E03FFFFFFFFFFFFFFFFFFE7C9),
    .INIT_29(256'hC3FFFFFE0001808100061FFFFFF0081E0C0C0000FFFFFFE1FFFFF0FE0007FFFF),
    .INIT_2A(256'h00618001FFFFFFC3F800030C030FFFFFF800C0000060187FFFFFC00000000000),
    .INIT_2B(256'hFC380C04380601FFFFFFE1800001800007FFFFFF0C00000C00003FFFFFF86300),
    .INIT_2C(256'hFFFFFFFFFFFFFE18FFFFFFFFFFFFFFFFF0C7FFFFFFFFFFFFFFFF87FFFFFFFFFF),
    .INIT_2D(256'hFFFF0FFF007FFFF861FFC0F87FFC03FFFFFFFFFC03FFFFFFFFFFFFFFFFC01FFF),
    .INIT_2E(256'h0080000602010104300C0C002078300C1801FFFFE187FFFFE1FFC00FFFFF0C3F),
    .INIT_2F(256'h0000000C030FE000C30002000060000300000000300000000000000000018401),
    .INIT_30(256'h301C380E0018000186000061802000C0000C3000030C0000060180618C001860),
    .INIT_31(256'h184003000021000C000000003000000000C001000003080E00000C03080430E0),
    .INIT_32(256'hFF00203807C10100401F000000007C00000001F012000084000000061000C000),
    .INIT_33(256'hFFFC01FFFFFFFFFFF003FFE1FFFFC300FFFFFF87FFFFFFFFFFFFE01FFFFFFFFF),
    .INIT_34(256'hFFFF87FFFFFFFFFFFF801FFFFFFFFFFF003FFE1FFFFC200FFFFFF87FFFFFFFFF),
    .INIT_35(256'hE062103C0C000F80380040C0E0E0781C0001FC180303800003FFE1FFFFC000FF),
    .INIT_36(256'h01F0000001000E1C022001804000F8010000000404030080001F8080001000E1),
    .INIT_37(256'h00000000601800401F0006001000E1C020000000000F80000000000000000000),
    .INIT_38(256'h1F00C0200F8600000000003E01800601F0006000000E1C0200300C0200F86000),
    .INIT_39(256'h0000000000000200300C0000F86018000000006018787E1F0006000000000030),
    .INIT_3A(256'h00000000787E1F00000000F0000002000000000F80018000000000000787E1F0),
    .INIT_3B(256'h04300F80218040C0C060300F87E1F80802010F0000002000000200F800180000),
    .INIT_3C(256'hFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFE0421018),
    .INIT_3D(256'hFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFFF871),
    .INIT_3E(256'hFF801FFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFF),
    .INIT_40(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE03FFFFFFFFFFFFFFFFFFFFFFE03FFFF),
    .INIT_41(256'hFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000001FFF),
    .INIT_42(256'hFFFFFFFFFFFC0000000000000000000000000000000000000000001FFFFFFFFF),
    .INIT_43(256'hFFFFF80000000000000000000000000000000000000000003FFFFFFFFFFFFFFF),
    .INIT_44(256'h000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000007FFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007FFFFFFFFFFFFFFFFFFFFFFFFFF0),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFE000000FFFFFFFFFFFFFFFFFFFFFFFFFFC0000001),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFC0FC001FFFFFFFFFFFFFFFFFFFFFFFFFF80000003FFFFFF),
    .INIT_48(256'hFFFFFFFFFFF83FC001FFFFFFFFFFFFFFFFFFFFFFFFFF00000007FFFFFFFFFFFF),
    .INIT_49(256'hFFFFF0E1C003FFFFFFFFFFFFFFFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hDBE007FFFFFFFFFFFFFFFFFFFFFFFFF80000001FFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFF00000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFE00000007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7C00F),
    .INIT_4D(256'hFFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0F801FFFFFFF),
    .INIT_4E(256'hFFFFFF80000001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDF003FFFFFFFFFFFFF),
    .INIT_4F(256'h00000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7DBE007FFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'h07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7C00FFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF9F6F801FFFFFFFFFFFFFFFFFFFFFFFFFE000000),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF3EDF003FFFFFFFFFFFFFFFFFFFFFFFFFC0000000FFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE7DBE007FFFFFFFFFFFFFFFFFFFFFFFFF80000001FFFFFFFFFFF),
    .INIT_54(256'hFFFFFFCFB7C00FFFFFFFFFFFFFFFFFFFFFFFFFF00000003FFFFFFFFFFFFFFFFF),
    .INIT_55(256'h8F0F001FFFFFFFFFFFFFFFFFFFFFFFFFE00000007FFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFF80000001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF07F800),
    .INIT_58(256'hFFFFFFFFFFFFFF00000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0000007FFFFF),
    .INIT_59(256'hFFFFFFFE00000007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFC000000FFFFFFFFFFFF),
    .INIT_5A(256'hFC0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000001FFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'h001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000003FFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFE0000000000000000000000000000000000000),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFC0000000000000000000000000000000000000003FFF),
    .INIT_5E(256'h00187FFFFC3F800187FFFFC3F800187FFFFC3F84020000000000007FFFFFFFFF),
    .INIT_5F(256'h0187F00006180600030000018060000000000006000018081000600103C18180),
    .INIT_60(256'hFFFFFFF87FFFFF8701808700C038600000600001860000060000186300006180),
    .INIT_61(256'hFFFFFFE07FFFFFFFFFFC03FFFFFFFFFF803FFFFFFFFFF863FFFFFFFFFF863FFF),
    .INIT_62(256'hFFFFFFF861FFFFF87FF8003FFFC003FFFFF0FFC30FFFFFFFFC30FFFFFC3FFE01),
    .INIT_63(256'h00FFFF000FFFFFC3FF0C3FFFFFFFF0C3FFFFF0FFE0007FFF8007FFFFE1FF861F),
    .INIT_64(256'hFFFE008040000301008082001E00001E01818600187FFF8060600103C18060C0),
    .INIT_65(256'h1800000000600000000061801800000000000000000C00180000380201080030),
    .INIT_66(256'h0600600060187F00061800100C000000C000C00000C300300030000180000000),
    .INIT_67(256'h0000300C03C30C03000C000C00C300C030C6000C300000180000018001800000),
    .INIT_68(256'h003FFF0C0000C3000030C010000018078618000018001FFF8600006180001860),
    .INIT_69(256'hF8601008601E186100806100FFFE184021870180E1C0700000300F0C30000030),
    .INIT_6A(256'h02000002001800606040800187FF87FF0FF800187FF87FF0FF840187FF87FF0F),
    .INIT_6B(256'h1800601800001860000601800020000000600000060000000000000060010004),
    .INIT_6C(256'hFFFFFFFFFE1FFFFFF861804021C0860186180000180040186180000180000186),
    .INIT_6D(256'h1FFFFFFFFFFFFF00FFFFFFFFFFFFE00FFFFFFFFFFFFE18FFFFFFFFFFFFE18FFF),
    .INIT_6E(256'h0018600000000000000000004040001830061FFC0187FF0061FFE03FFFFFFFF8),
    .INIT_6F(256'hC9E38C31038171B6FFFFE7F6DFFFFE7EC3FFFFE01870180E1800018600006180),
    .INIT_70(256'h870300FC36CF0FCFB6DB339DF6DB606DBEDB678DB4186019B63F3F33198FE7E3),
    .INIT_71(256'hCDB3198CFCE61F0F8FCFCCE6720CC1E0F040CDFFFFFDFCDFFFFFDFC1FFFFFC01),
    .INIT_72(256'h0000080030C03030060100C0603E07E1F0F9ECE73198DECDB0180DECDB1F8FC0),
    .INIT_73(256'hC300010100606180008000201040004000000000000000000000000000006100),
    .INIT_74(256'h1C3E001800030E1E000C0000870E0006000043870003000001C38200020200E1),
    .INIT_75(256'hE1FF87FC20FFFC3FFFFFFF007FFFFFFFFFE1F87FE1FF0C3FFF0FFFFFFFE02DDC),
    .INIT_76(256'h0FE0C30100303007FFFFFFFFFE1F87FE1FF083FFF0FFFFFFFC01FFFFFFFFFF87),
    .INIT_77(256'h000100000006100C0100000101003F01080000004010300186078060000860C0),
    .INIT_78(256'h00601806000060000003E00000000004000000180000000000000000F8000000),
    .INIT_79(256'h18060000003E00000000000000000000601800018000000F8000000000000000),
    .INIT_7A(256'hC3E000800000000001E0000000006000000010F8000000000000007800018060),
    .INIT_7B(256'hFFFFFFF03E001C030086000840430FC043001E00180807800200000180000000),
    .INIT_7C(256'hFFFFFFFFFFFE1C7FFFFFFFFFFE1FFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFF87),
    .INIT_7D(256'hFFE007FFFFFFFFFFE1FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFFF87FFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC01FFFFFFFFFFF87FFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'h007FE1FFFFFC01F0FFFF000FFC3FFFFFC03E1FFFE001FFFFFFFFFFFFFF80FFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000080601003E00C00001020181E06007C03C00003FF0FFFFFC00F87FFF8),
    .INIT_01(256'h0601E0018618061007C300000000000300C200F86000000000000000001F0000),
    .INIT_02(256'h010C03C0030C0000010F80018078006180000021F000300F000C30C030003E18),
    .INIT_03(256'h7DBEDF6FB7DBEDF6F87C1FCEF9CF1807FFFFFE300CE7F9DFE0F038700C02187E),
    .INIT_04(256'h800402FE7E3FBFC06E77DB0DF6DB7DB6DF6DB7DB6DF6DB7DB6DF018001FCFE03),
    .INIT_05(256'h086000430002180010C00086100430C02184027E3FCE730CDB36CDB36CDB36C1),
    .INIT_06(256'h0000000000000000000000000000000000000618041080008400002004010020),
    .INIT_07(256'hA3FFE7FFC0003FF87FF0FFE3FFE7FFC000000000000003FFE7FFC00000000000),
    .INIT_08(256'hFFE7FFC0003FF87FF0DAA3FFE7FFC0003FF87FF0DAA3FFE7FFC0003FF87FF0C2),
    .INIT_09(256'hE7FFC0003FF87FF0DAA3FFE7FFC0003FF87FF0EAA3FFE7FFC0003FF87FF0C2A3),
    .INIT_0A(256'hFFC0003FF87FF0FFE3FFE7FFC0003FF87FF0DA23FFE7FFC0003FF87FF0DAA3FF),
    .INIT_0B(256'hC00000000000000000000000000000000000000000000000000000000003FFE7),
    .INIT_0C(256'h003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC000000000000003FFE7FF),
    .INIT_0D(256'h3FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0),
    .INIT_0E(256'hF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC000),
    .INIT_0F(256'h00000003FFE7FFC0003FF87FF0FFE3FFE7FFC0003FF87FF0FFE3FFE7FFC0003F),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'hFFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF000000),
    .INIT_12(256'hE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0),
    .INIT_13(256'hFFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FF),
    .INIT_14(256'h0000000000000000000000000000003FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1),
    .INIT_15(256'hF87FE187FFFF87FE18077330FBE0000000000000000000000000000000000000),
    .INIT_16(256'h00000000180000180000000001840100840018601818600187FFFF87FE187FFF),
    .INIT_17(256'hFFFFFFFFFFFF0086100806100860000060000600000600006018006000000180),
    .INIT_18(256'h0E06007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFFFFFFFFFFFFFE007FE1FFFFFF),
    .INIT_19(256'h00000000000000000001F8000040101802018000040218408060183C0303C040),
    .INIT_1A(256'hC03000000060000061800000003000000060180000000000003000000061F800),
    .INIT_1B(256'h8403008061860000C00080000000000061860000C00000000000000061860000),
    .INIT_1C(256'hFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFC0E1861010C201C007),
    .INIT_1D(256'hFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFF),
    .INIT_1E(256'hF9FE7E3F1F8FC3F3FCFC7E3F1F8007F800000000000000000000007FFFFFFFFF),
    .INIT_1F(256'h000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1),
    .INIT_20(256'hF7F8FCFF3F1F9FEFF1F9FE7E3F3FDFE003FC00007FBFC0000000000000000FF0),
    .INIT_21(256'h07F80000FF7F8FCFF3F1F9FEFF1F9FE7E3F3FDFE3F3FCFC7E7FBFC7E7F9F8FCF),
    .INIT_22(256'hE7E7FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF001FEFF003FDFE000000000000000),
    .INIT_23(256'h000003FDFE007FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF1F9FEFF3F3FDFE3F3FDF),
    .INIT_24(256'h8FCFF7FBFCFC3F1F9FEFF7F9F87E3F3FDFEFF3F000007FBFDFE0000000000000),
    .INIT_25(256'h000000000000FF7FBFC003F1F9FEFF7F9F87E3F3FDFEFF3F0FC7E7FBFDFE7E1F),
    .INIT_26(256'h3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F800000000000000000000),
    .INIT_27(256'h00000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E),
    .INIT_28(256'hB99B36D831881B07806DBFFB7FF6FFFEDB7FF6FFEDFFFDB6FFE1FFC3FFF86000),
    .INIT_29(256'hFE036DB19B66339C7EDB7E36CC66198C30C16D98CDB1F1F99AE61F9B69CBF1E5),
    .INIT_2A(256'hFFFFFFFDBFFFFFFFFFFFFB7FF01C300C0386804F9B6FC3F27C7E31B6D8CE71F9),
    .INIT_2B(256'hFDBFFED9F3FF0FFF8701FFFFFFFFFF87FFFFFFFFFFFF6FFFFFFFFFFFFEDFFFFF),
    .INIT_2C(256'h3CDB7E6DB0018618230FC667E66BF1F8F1F8F2FC068118818C31BFF6FFFB6FEF),
    .INIT_2D(256'h000000000000000000000081C300E1C04F36DF9B67C66DB636DBF9836D8DB6C6),
    .INIT_2E(256'hE3F0FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F87E001F8FC7E3F000000),
    .INIT_2F(256'h00000000000000000000000000000000000000003F000FC7E3F1F87E001F8FC7),
    .INIT_30(256'hC7E000007E001F8FC00000FC003F1F800001F8007E3F000003F000FC7E000000),
    .INIT_31(256'h000000000000000000000000000000000000000000001F8007E3F000003F000F),
    .INIT_32(256'h800003F000003F000007E000007E00000FC00000FC00001F800001F800003F00),
    .INIT_33(256'h000007E000000000000000000000000000000000000000000FC00001F800001F),
    .INIT_34(256'h3F0FC7E00000007E1F8FC0000000FC3F1F80000001F87E3F00000003F0FC7E00),
    .INIT_35(256'h3F1F8FC7E3F0000000000000000000000000000000000000000007E3F0000000),
    .INIT_36(256'h7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E),
    .INIT_37(256'hB7CCF7BBF4B46D9324C8B4EDFB7EDC0000000000000000000000000003F1F8FC),
    .INIT_38(256'h08186001801FFFFFFFFFFFC3F003FFFFFFFFFFF87F00FFFFFFFFFFFF0FF03EDF),
    .INIT_39(256'h000180000018000010C030000000000002180000040403000043000400C1C0F0),
    .INIT_3A(256'h00860000006000804000C000000C00000000180006018000000C030007C00000),
    .INIT_3B(256'hFFFE00FFFC3FFFFFFFFFFFFFFFE00FFFC3FFFFFFFFFFFFFFFE0080C043000E07),
    .INIT_3C(256'h0001C0180203C04000020100FFFC03C0307E0E006070000FFFC3FFFFFFFFFFFF),
    .INIT_3D(256'h3000001800000000100001C3000001800000020100001C000000180000002010),
    .INIT_3E(256'h0180000001E1F0001C000C00180000001E1F0001C300C00180000001E1F0FFFC),
    .INIT_3F(256'h0080400000000C0300C0300000000201FFFE010C203C043C003E1F0001C000C0),
    .INIT_40(256'h000001C00200001C00000001C00000FFFC00000FFFF0C000FFFF0C200FFFF0C3),
    .INIT_41(256'h9B62D2FDDEF33EDFB70EE6FFFF0C300001F0C200001F0C000001F0C000FFFF0C),
    .INIT_42(256'h0FFFFE180003FFFF860000FFFFE180001BB801DD8000000003B7EDFB72D1324C),
    .INIT_43(256'hF0F00061807C0000186010000000000400000000010000808000402030600000),
    .INIT_44(256'h30000403C02061FFFFFF0FFFFFF87FFFFFFC2038601F0F00061807C3C0018601),
    .INIT_45(256'hFFFE00FFFC02010C002000600000030000601800030000001800001000000080),
    .INIT_46(256'h000000000000080C00001010030780061E0C00FFFFE007FF003FFFF821FFE00F),
    .INIT_47(256'h3000060186000400018061800100006018600000000006180200000000000080),
    .INIT_48(256'hFFF00FFFFFFFFF003FFFFC03FFFFFFFFE00FFFFF00FFFFFFFFFC020218061C04),
    .INIT_49(256'hC030800000000000003000000002000006000C20100001C00003C0030C0C00FF),
    .INIT_4A(256'hC00000C000000000C03000C0300003000030000030000000C0000C00000C0000),
    .INIT_4B(256'hFFFFF0FFFFFFFFFFFFFFFFFC010C02010C003807000003000003000400800000),
    .INIT_4C(256'hFFFFFFFFFFFFFC00FFFFFFFFFFFFFFFF0E3FFFFFFFFFFFFFFFC38FFFFFFFFFFF),
    .INIT_4D(256'h0000C20100078C0C00FFFFF003FFFFE00FFFFFC0301FFFFFFFFFFFFFFFF803FF),
    .INIT_4E(256'h70000000000000078807000C0008020100000C0C30003870C000C0C308020100),
    .INIT_4F(256'h08018000000000007F87F87F87F87F87F87F87F87F87FC7FE3F10F8C007007C0),
    .INIT_50(256'hC7F11FE07FC1FF87FF1FF800000000FF1FE3FC7F8FF00600C018FF1FE3FC7F80),
    .INIT_51(256'hFFF03FFF07FFF0FFFF8FFF1FFE3FFC7FF8FFF1FF0000000000071F1E3C7C71F8),
    .INIT_52(256'h000000000000000070FF0F0FE1F0FC3F0F87F0F0FF0E1FF0C3FF087FF00FFF01),
    .INIT_53(256'h3FE1C3FE1C3801C3001C3001C3803C30FFFF0FFFF0FFFF0FFFF0FFFF0FFFC000),
    .INIT_54(256'h001C0411C03E1C03E1C03E1C03E1C0001C0001C1FF1C2001C3FE1C3FE1C3FE1C),
    .INIT_55(256'h07FE000FFC03FFF807FFF00FFFE01FF80000600000C00801C03802003C0001C0),
    .INIT_56(256'h800002000000001080001E01FC3C03F87807F0F00FE0001FC00001BFC0038000),
    .INIT_57(256'hBFC425800827FE108FFC213FF8447FF081FFE103F8020FE0043FC008FFC03003),
    .INIT_58(256'h000087F0030FC0021F80043F10887E1E10FC3C2008780000F000000100400210),
    .INIT_59(256'hFFFC3CFFFC3CFFFC3CFF003C0F003C0F003C03003C03CFFFFCCFFFFCF00000F0),
    .INIT_5A(256'hFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3CFFFC3C),
    .INIT_5B(256'hFFCFF00003FC0000FC0FFFFC0FFFFC03FFFC03FFFC3CFFFC3CFFFC3CFFFC3CFF),
    .INIT_5C(256'h3C0FCF0F03F3C3C0FCF0F03F3C3CCFC00F33F003CF3F00F3CFC03CFCFFFF3F3F),
    .INIT_5D(256'hCF3F00F3CFC03CFCFFFF3F3FFFC00C03F00300FC00CF0F0033C3C0FCF0F03F3C),
    .INIT_5E(256'hF0000FFF0000FC0FF03F03FC0FC03F00F00FC03C3CF0F30F3C3CC3CF0F30F003),
    .INIT_5F(256'h0FCF0FD0FCF0FD0FCF0FDCFC00FDCFC00FDF3F00C1F3F00C1FCFFFCFFCFFFCFF),
    .INIT_60(256'hD0FF00FD0FF00FD0FFFFFD0FFFFFD0FC03FD0FC03FD0FCF0FD0FCF0FD0FCF0FD),
    .INIT_61(256'h0F00FF00F003F003003F0030FCF0FD0FCF0FD0FCF0FD0FCF0FD0FC00FD0FC00F),
    .INIT_62(256'h0FDCFC00FDCFC00FDF3F00C1F3F00C1FCFFFCFFCFFFCFFF0000FFF0000F00FF0),
    .INIT_63(256'hF0FDFFFF0FDFFFF0FDFFFF0FDFFFF0FDFFFF0FD00FF0FD00FF0FD003F0FD003F),
    .INIT_64(256'h0003F00FFFCF00FFFCF00C03F300C03F3CFCF0FDCFCF0FDFFFF0FDFFFF0FDFFF),
    .INIT_65(256'h3D00C00F403003DCFCFCF73F3F3DF00FF07C03FC1F0000FFF0000FFF00003FF0),
    .INIT_66(256'hDFF00FF7FC03FDFF00FF7FC03FDF00FFF7C03FFDF00C3F7C030FD00FC0F403F0),
    .INIT_67(256'hF3FF0F7CFFC3DFCF30F7F3CC3DFF3F0F7FCFC3DFFCFFF7FF3FFDFFF3FF7FFCFF),
    .INIT_68(256'h00007FF0000E000001F80001F807FC0700000000FF03C03FC0F003F00C00FC03),
    .INIT_69(256'h007E00007E01FC01C000000000003FF00007000000FC0000FC03FC0380000000),
    .INIT_6A(256'h7000000000000FF00001C000003800000700FC00E000000000001FF000038000),
    .INIT_6B(256'h03C07000000E01FE01C03C0038000000000007F00000E000001C000003807C00),
    .INIT_6C(256'h80700C000FFE01FFFE01FFF003E03800000700FF00E01C001FFC03FC000003F0),
    .INIT_6D(256'hFF807FF003F80FFFFE01FFFFC038040007FF00FFFF00FFF003F01FFFFC03807F),
    .INIT_6E(256'h00007E00000E000001FFC03FFFC03FF800FC07FFFF00FC00001C000003FF807F),
    .INIT_6F(256'h007FF00FFFF00FFF800F01FE00003F00003F000000FFE01FFFE01FFE003E03FC),
    .INIT_70(256'hF800007F80000E00000FC000003FF807FFF807FFE00000FF00001C00001F8000),
    .INIT_71(256'h7FFFF000000FFE01FFFE01FFFE00003FC0000700FFFFE000001FFC03FFFC03FF),
    .INIT_72(256'h7FFF807FFFE0000FFFFE01C03FFFF8000007FF00FFFF00FFFF80001FE0000380),
    .INIT_73(256'hFFFF80700FF00E000301FFC03FFFC03FFFF00007FFFF00E01FFFFC000203FF80),
    .INIT_74(256'h03C07000000FF00FFFF01F01FFFFE03807F807000380FFE01FFFE01FFFF01E03),
    .INIT_75(256'hFFF01FC07800000E000001C003E038000007F807FFF01F80F000001C03FC0380),
    .INIT_76(256'hF00003F003F80E000001FE01FFF01FE03C000007000000E003F01C000003FC03),
    .INIT_77(256'h00007F807FF01FF80F000001F80001F803FC07000000FF00FFF01FF01E000003),
    .INIT_78(256'h01C03FE038000007E00007FC0001FFC03FF81FFC07000000FC0000FC03FE0380),
    .INIT_79(256'h07000000E00000003F8038000007E00007FC0001C03FC038000007E00007FC00),
    .INIT_7A(256'h003C0038000007000000E00000003E0038000007000000E00000003F00380000),
    .INIT_7B(256'h007E00E01FC00030003FF807FF000000E000000038003FF807FF000000E00000),
    .INIT_7C(256'h00003FF807FF007E00E01FC00000003FF807FF007E00E01FC00020003FF807FF),
    .INIT_7D(256'h7E00FFFFC00000003FF807FF007E00FFFFC00000003FF807FF007E00FFFFC000),
    .INIT_7E(256'h003FF807FF007E00E01FC00000003FF807FF007E00FFFFC00000003FF807FF00),
    .INIT_7F(256'h00E000000000203FF807FF007E00E01FC00000003FF807FF007E00E01FC00000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized5
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h38000007000000E000000000E03FF807FF000000E000000000603FF807FF0000),
    .INIT_01(256'hFC0001C007E038000007000000E000000003E038000007000000E000000001E0),
    .INIT_02(256'h000007E00007FC0001C01FE038000007E00007FC0001C00FE038000007E00007),
    .INIT_03(256'hF0FCFF3F1F8FC7E1F9FE7E3F1F8FC003FC0000000000000000000000003FE038),
    .INIT_04(256'hF8000000000FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3),
    .INIT_05(256'hE8FC027E7F9F8FD03004FCFF3F1FA0400801FE000040001000000000FFFFE007),
    .INIT_06(256'h1003FC00008C0027E7F9F8FD1A004FCFF3F1FA36009F9FE7E3F47E013F3FCFC7),
    .INIT_07(256'hEFF3F460013F3FDFE7E8C0027E7FBFCFD1800400FF7F80230008000000004600),
    .INIT_08(256'hE31FF801FEFF00460013F3FDFE7E8C0027E7FBFCFD18004FCFF7F9FA30009F9F),
    .INIT_09(256'h0FC7E7FFFC317E1F8FCFFFF862FC3F1F9FFFF0C5F800003FFFE188000000007F),
    .INIT_0A(256'h003FFFF80000007FFFC01001F8FCFFFF802FC3F1F9FFFF3C5F87E3F3FFFE78BF),
    .INIT_0B(256'h3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E),
    .INIT_0D(256'h7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0000000000000000000000000000),
    .INIT_0E(256'h0000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC),
    .INIT_0F(256'hFC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F800000000000000000000000),
    .INIT_10(256'h00000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0),
    .INIT_11(256'hF1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC0000000000000000000),
    .INIT_12(256'h000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3),
    .INIT_13(256'h93F1F8FC3F1F9A27E3F1F87E3F354FC7E3F0FC7E409F8FC7E00000FF00000000),
    .INIT_14(256'h0000000000000000000001FE00000007E3F354FC7E3F0FC7E6A9F8FC7E1F8FCD),
    .INIT_15(256'hC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F00000000000),
    .INIT_16(256'h000000000000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0F),
    .INIT_17(256'h1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC003FC000000000000000),
    .INIT_18(256'h000000000000007F8000000000FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F),
    .INIT_19(256'h3F3FDB23F3FCFC7E7FB447E7F9F8FCFF6A8FCFF3F1F9FE81001FE00003FDFE00),
    .INIT_1A(256'hFF00000000000000003FC00007FBFC7E7F9F8FCFF6A8FCFF3F1F9FED51F9FE7E),
    .INIT_1B(256'hFF7F9F9FEFF1F9FEFF3F3FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F800FF7F801FE),
    .INIT_1C(256'hFEFF0000000000000000001FEFF003FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F8FC),
    .INIT_1D(256'hF87E3F3FDFEFF3F0FC7E7FBFDFE7E1F8FCFF7FBFCFC3F1F9FEFF7F9F800003FD),
    .INIT_1E(256'h000000000000000000000000000007FBFDFE001F8FCFF7FBFCFC3F1F9FEFF7F9),
    .INIT_1F(256'hF1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000),
    .INIT_20(256'h0000000000000000000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3),
    .INIT_21(256'hF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F000FF00000000),
    .INIT_22(256'h0FF7F80000000000000001FE0000000003F3FCFC7E3F1F87E7F9F8FC7E3F0FCF),
    .INIT_23(256'h47E7F9F8FCFF6C8FCFF3F1F9FED11F9FE7E3F3FDAA3F3FCFC7E7FA04007F8000),
    .INIT_24(256'hDFE007FBFC0000000000000000FF00001FEFF1F9FE7E3F3FDAA3F3FCFC7E7FB5),
    .INIT_25(256'h3FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF1F9FEFF3F3FDFE003F),
    .INIT_26(256'h00000FF7FBFC0000000000000000007FBFC00FF7F8FCFF7F9F9FEFF1F9FEFF3F),
    .INIT_27(256'h7FBFDFE7E1F8FCFF7FBFCFC3F1F9FEFF7F9F87E3F3FDFEFF3F0FC7E7FBFDFE7E),
    .INIT_28(256'h7E3F000000000000000000000000000000001FEFF7F8007E3F3FDFEFF3F0FC7E),
    .INIT_29(256'h7E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC),
    .INIT_2A(256'h000000000000000000000000000000000000000000000000003F1F8FC7E3F1F8),
    .INIT_2B(256'hF8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC003FC),
    .INIT_2C(256'h01FE00003FDFE00000000000000007F8000000000FCFF3F1F8FC7E1F9FE7E3F1),
    .INIT_2D(256'hF1F9FED51F9FE7E3F3FDB23F3FCFC7E7FB447E7F9F8FCFF6A8FCFF3F1F9FE810),
    .INIT_2E(256'hF7F800FF7F801FEFF00000000000000003FC00007FBFC7E7F9F8FCFF6A8FCFF3),
    .INIT_2F(256'hE7FBFCFCFF7F8FCFF7F9F9FEFF1F9FEFF3F3FDFE3F3FDFE7E7FBFC7E7FBFCFCF),
    .INIT_30(256'hEFF7F9F800003FDFEFF0000000000000000001FEFF003FDFE3F3FDFE7E7FBFC7),
    .INIT_31(256'hCFC3F1F9FEFF7F9F87E3F3FDFEFF3F0FC7E7FBFDFE7E1F8FCFF7FBFCFC3F1F9F),
    .INIT_32(256'h8FC7E3F1F8FC000000000000000000000000000000007FBFDFE001F8FCFF7FBF),
    .INIT_33(256'h1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F),
    .INIT_34(256'hB9DDDDDDDDDDDDDC000000000000000000000000000000000000000000FC7E3F),
    .INIT_35(256'hB80003BB9C01DDDC0001DDC00000000000000777777777777773BBBBBBBBBBBB),
    .INIT_36(256'h7383BBBBBBB83BB9C1DDDDDDDC1DDC00000000000000700777700007773803BB),
    .INIT_37(256'h777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC000000000000007077777777077),
    .INIT_38(256'h0777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777),
    .INIT_39(256'h00000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC0000000000000),
    .INIT_3A(256'hC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC000000),
    .INIT_3B(256'hDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDD),
    .INIT_3C(256'h9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDD),
    .INIT_3D(256'hBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB),
    .INIT_3E(256'h3BBBBBBBBBBBBB80000000000000000000000000000777777777777773BBBBBB),
    .INIT_3F(256'h00007773BBBBBB80003BB800000000000000EEEEEEEEEEEEEE77777777777777),
    .INIT_40(256'h777777777707773BBBBBBBBB83BB800000000000000EEEEEEE0000EEE7777777),
    .INIT_41(256'hEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEE0EEE),
    .INIT_42(256'hEEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000EEEEEEE),
    .INIT_43(256'h0000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000),
    .INIT_44(256'h00000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB80000000),
    .INIT_45(256'hBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB8),
    .INIT_46(256'hBBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBB),
    .INIT_47(256'h7777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773),
    .INIT_48(256'h777777777777700000000000000000000000000000EEEEEEEEEEEEEE77777777),
    .INIT_49(256'h000EEE77777770000777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7),
    .INIT_4A(256'hEEEEEEEEE0EEE77777777770777000000000000001DDDDDDC0001DDCEEEEEEE0),
    .INIT_4B(256'hDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDC1DDCE),
    .INIT_4C(256'hDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDD),
    .INIT_4D(256'h000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001D),
    .INIT_4E(256'h0000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000),
    .INIT_4F(256'h77777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7777777777777700),
    .INIT_50(256'h777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE777777777),
    .INIT_51(256'hEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77),
    .INIT_52(256'hEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_53(256'h01DDCEEEEEEE0000EEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEE),
    .INIT_54(256'hDDDDDDDC1DDCEEEEEEEEEE0EEE000000000000003BBBBBB80003BB9DDDDDDC00),
    .INIT_55(256'hBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBB83BB9DD),
    .INIT_56(256'hBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBB),
    .INIT_57(256'h00003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BB),
    .INIT_58(256'h000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE0000000000),
    .INIT_59(256'hEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000),
    .INIT_5A(256'hEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEE),
    .INIT_5B(256'hDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEE),
    .INIT_5C(256'h018004010C204000801840E03000000000000003BBBBBBBBBBBBB9DDDDDDDDDD),
    .INIT_5D(256'h0000000010800018000000000000000180000008000000001800000080000000),
    .INIT_5E(256'h0006000000240C00000001080000000000000010800018000000000108000180),
    .INIT_5F(256'hFFFFFFFFFFFFF0C06000081808C0010C06000000000C0000406000000000C000),
    .INIT_60(256'h0F0007FFFFFFFC0030F0007FFFFFFFE0030F0807FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF8003),
    .INIT_62(256'hFFFFF8200000007FFFFFFF8004800007FFFFFFFC0000F0007FFFFFFFC0030F00),
    .INIT_63(256'h000080000000000C00C2040200001E0FFFF8610000807FFFFFFF8200000007FF),
    .INIT_64(256'h0108610000000001086100000000010821000000000000000000008000000000),
    .INIT_65(256'h003F00C0600000003F0040600000002100006000000021000001082100210000),
    .INIT_66(256'hC00000080000FFE00000080000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C0600200),
    .INIT_67(256'h784300FF801018784300FF801018784300FF800000080000FF800000080000FF),
    .INIT_68(256'hFF8200180000F0FF8200180000F0FF8000180000F0FFC01018784300FFC01018),
    .INIT_69(256'hBC100000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8600180000F0),
    .INIT_6A(256'h7927BDD0924920BDD09248A0BDD39249E3BDD0924920BDD0924920BDD78E79E7),
    .INIT_6B(256'h1FFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDD00000003DD78E),
    .INIT_6C(256'h003C100000003C100000003C100000003C1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC),
    .INIT_6D(256'hFFFFFFFC100000003C100000003C100000003C100000003C100000003C100000),
    .INIT_6E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6F(256'h00003C100000003C100000003C100000003C100000003C100000003FFFFFFFFF),
    .INIT_70(256'h1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC100000003C100000003C100000003C1000),
    .INIT_71(256'hA3BDD00000003DDFFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFFFFFFFC1FFFFFFFFC),
    .INIT_72(256'h8897A3BDD08890A4BDD08890A8BDD388F0A8BDD08890A8BDD08890A4BDD7BE60),
    .INIT_73(256'h00000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC100000003DD7),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized6
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'hFC0FF81FF0FFF1FFFFFF00000000000000000000000000000000000000000000),
    .INIT_02(256'hFFFC00003F0FFFF0FFFFFFFE0001FFFFFFDFFE5FFB7FEEFFBBFEEFFBBFCEFF8B),
    .INIT_03(256'h08080401E1E0186078040E0E03000000FC3FFFC3FFFFFFF800007E1FFFE1FFFF),
    .INIT_04(256'h00000000000F0F0C003000000000000787800000000000000003C3C010806000),
    .INIT_05(256'h0000C00001E0187878000000600000F00C3C3C3000C030000078061E1E180060),
    .INIT_06(256'h0400F87840C00FFFFFFC00FFFFFFE00FFFFFFF00F0084021840C07C030F0F000),
    .INIT_07(256'h80430F80000010F80000010F80000000F80000200F80000600F80000400F8780),
    .INIT_08(256'hFFFFC001FFFFFC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC00),
    .INIT_09(256'h800001E018000000018000000000000000000C06020001E0F04001FFFFFC001F),
    .INIT_0A(256'h60000000000000000000604020003C181C0300C0603E00000001E00000001E01),
    .INIT_0B(256'h80610087E01800010806000042018000108000180000007E0000001F80000000),
    .INIT_0C(256'hFFF801FFFFE1FFFFFFFFFFFFFFFFFFFC01FFFFE1FFFFFFFFFFFFFFFFFFFE001F),
    .INIT_0D(256'hC020100808000000E00103038381E070180C1C0001FFFFE1FFFFFFFFFFFFFFFF),
    .INIT_0E(256'h0000001806000000000400000000000000000000000000000000400000010100),
    .INIT_0F(256'hE018060000000018061E00000787E0180000000000F806000000000600180000),
    .INIT_10(256'h18080F87E000060000000000001E10000787E000060000000000001E00000787),
    .INIT_11(256'hFFFFFFFFFF0FFFFFFE1FFFFFFFFFFFFFFFFFFF0FFFFFFE00860103030180C03E),
    .INIT_12(256'h7FFFFFFFFFFFFFFFFF0FFFFFFE1C7FFFFFFFFFFFFFFFFF0FFFFFFE1C7FFFFFFF),
    .INIT_13(256'hFFFFFF80FFFFFFFFFFFFFFFFFFFFFFFFFF007FFFFFFFFFFFFFFFFF0FFFFFFE00),
    .INIT_14(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_15(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_16(256'hFFBBFFBFFFFFFFFFFFFFFFFFFFFFFFC1FE00F800E000C001C007C01FE0FFFFFF),
    .INIT_17(256'hFE1FFFFFFFC0003FFFFC03F0FFFF0FFFFFFFE0001FFFFFFFF7F7F7DF70771F1E),
    .INIT_18(256'h00E0000186078040E0E0300000FFFFF00FC3FFFC3FFFFFFF80007FFFF807E1FF),
    .INIT_19(256'h00000000787800000000000000000000003C3C00800001080600008080401E1E),
    .INIT_1A(256'hC003000C030000078061E1E18000018006000000000000F0F0C00000C0030000),
    .INIT_1B(256'h7C030F0F0003000000000C00001E0187878001800000000600000F00C3C3C300),
    .INIT_1C(256'hFFFFFFFFFFFFFFFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFE0086010084021840C0),
    .INIT_1D(256'hFFFFE007FFFFFFFFFFFFFFFFFFFFFFF0E3FFFFFFFFFFFFFFFFFFFFFFF871FFFF),
    .INIT_1E(256'h6018183C00000180603FFFFFFFFFFFFFFFFFFFFFFFE00FFFFFFFFFFFFFFFFFFF),
    .INIT_1F(256'h000000001C3F0E00000000000000000000000000000000004010081800000100),
    .INIT_20(256'h7E0180421C380000600000421C3F0F00400000001C3F0F00000000001C3F0E00),
    .INIT_21(256'h0FFFF0FFFFFFE0F07E01807E1C3801807E01807E1C3801007E0180421C380000),
    .INIT_22(256'h080C0C000FFFFFFFC3FFFC3FFFFFF8001FFFFFFF87FFF87FFFFFF0303FFFFFFF),
    .INIT_23(256'h001800000000000000000000003000201080600800040200006000E06181E018),
    .INIT_24(256'h3000C03000780601080601806001800000000C02100C0300C003000000001800),
    .INIT_25(256'h180F08043F0000000000000C201E00007E00000000000018003C0000840300C0),
    .INIT_26(256'hFFFE1C071FFFFFFFFFC3FFFFFFFC3F0FFFFFFFFFFF87FFFFFFF80200C0210086),
    .INIT_27(256'h03FFFFFFFFF87FFFFFFF800007FFFFFFFFF0FFFFFFFF0E038FFFFFFFFFE1FFFF),
    .INIT_28(256'hFF0FFFFF87F0003FFFFFF87FFFFC3F8403FFF80E03FFFFFFFFFFFFFFFFFFE008),
    .INIT_29(256'hC3FFFFFE0001808100061FFFFFF0081E0C0C0000FFFFFFE1FFFFF0FE0007FFFF),
    .INIT_2A(256'h00618001FFFFFFC3F800030C030FFFFFF800C0000060187FFFFFC00000000000),
    .INIT_2B(256'hFC380C04380601FFFFFFE1800001800007FFFFFF0C00000C00003FFFFFF86300),
    .INIT_2C(256'hFFFFFFFFFFFFFE18FFFFFFFFFFFFFFFFF0C7FFFFFFFFFFFFFFFF87FFFFFFFFFF),
    .INIT_2D(256'hFFFF0FFF007FFFF861FFC0F87FFC03FFFFFFFFFC03FFFFFFFFFFFFFFFFC01FFF),
    .INIT_2E(256'h0080000602010104300C0C002078300C1801FFFFE187FFFFE1FFC00FFFFF0C3F),
    .INIT_2F(256'h0000000C030FE000C30002000060000300000000300000000000000000018401),
    .INIT_30(256'h301C380E0018000186000061802000C0000C3000030C0000060180618C001860),
    .INIT_31(256'h184003000021000C000000003000000000C001000003080E00000C03080430E0),
    .INIT_32(256'hFF00203807C10100401F000000007C00000001F012000084000000061000C000),
    .INIT_33(256'hFFFC01FFFFFFFFFFF003FFE1FFFFC300FFFFFF87FFFFFFFFFFFFE01FFFFFFFFF),
    .INIT_34(256'hFFFF87FFFFFFFFFFFF801FFFFFFFFFFF003FFE1FFFFC200FFFFFF87FFFFFFFFF),
    .INIT_35(256'hE062103C0C000F80380040C0E0E0781C0001FC180303800003FFE1FFFFC000FF),
    .INIT_36(256'h01F0000001000E1C022001804000F8010000000404030080001F8080001000E1),
    .INIT_37(256'h00000000601800401F0006001000E1C020000000000F80000000000000000000),
    .INIT_38(256'h1F00C0200F8600000000003E01800601F0006000000E1C0200300C0200F86000),
    .INIT_39(256'h0000000000000200300C0000F86018000000006018787E1F0006000000000030),
    .INIT_3A(256'h00000000787E1F00000000F0000002000000000F80018000000000000787E1F0),
    .INIT_3B(256'h04300F80218040C0C060300F87E1F80802010F0000002000000200F800180000),
    .INIT_3C(256'hFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFE0421018),
    .INIT_3D(256'hFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFFFFFFFFFFFFFF871),
    .INIT_3E(256'hFF801FFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFF871FFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFF),
    .INIT_40(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE03FFFFFFFFFFFFFFFFFFFFFFE03FFFF),
    .INIT_41(256'hFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000001FFF),
    .INIT_42(256'hFFFFFFFFFFFC0000000000000000000000000000000000000000001FFFFFFFFF),
    .INIT_43(256'hFFFFF80000000000000000000000000000000000000000003FFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FF07FFFFFFFFFFFFFFFFFFFFFFFFFF0),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007F8FFFFFFFFFFFFFFFFFFFFFFFFFFC1FFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8FC7F1FFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE3FC7E1FFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF8E1C7C3FFFFFFFFFFFFFFFFFFFFFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hDBE787FFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFE3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CF0F),
    .INIT_4D(256'hFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0F9E1FFFFFFF),
    .INIT_4E(256'hFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDF3C3FFFFFFFFFFFFF),
    .INIT_4F(256'h1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7DBE787FFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CF0FFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF9F6F9E1FFFFFFFFFFFFFFFFFFFFFFFFFE3FFFFF),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF3EDF3C3FFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE7DBE787FFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFCFB7CF0FFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hCF0F3E1FFFFFFFFFFFFFFFFFFFFFFFFFE3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFF8FFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7F8FC),
    .INIT_58(256'hFFFFFFFFFFFFFF1FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003F87FFFFF),
    .INIT_59(256'hFFFFFFFE3FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FF0FFFFFFFFFFFF),
    .INIT_5A(256'hFC7FFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000000000000000000003FFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000000000000000000000000000FFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000001FFFFFFFFFF),
    .INIT_5E(256'h00187FFFFC3F800187FFFFC3F800187FFFFC3F8402000003FFFFFFFFFFFFFFFF),
    .INIT_5F(256'h0187F00006180600030000018060000000000006000018081000600103C18180),
    .INIT_60(256'hFFFFFFF87FFFFF8701808700C038600000600001860000060000186300006180),
    .INIT_61(256'hFFFFFFE07FFFFFFFFFFC03FFFFFFFFFF803FFFFFFFFFF863FFFFFFFFFF863FFF),
    .INIT_62(256'hFFFFFFF861FFFFF87FF8003FFFC003FFFFF0FFC30FFFFFFFFC30FFFFFC3FFE01),
    .INIT_63(256'h00FFFF000FFFFFC3FF0C3FFFFFFFF0C3FFFFF0FFE0007FFF8007FFFFE1FF861F),
    .INIT_64(256'hFFFE008040000301008082001E00001E01818600187FFF8060600103C18060C0),
    .INIT_65(256'h1800000000600000000061801800000000000000000C00180000380201080030),
    .INIT_66(256'h0600600060187F00061800100C000000C000C00000C300300030000180000000),
    .INIT_67(256'h0000300C03C30C03000C000C00C300C030C6000C300000180000018001800000),
    .INIT_68(256'h003FFF0C0000C3000030C010000018078618000018001FFF8600006180001860),
    .INIT_69(256'hF8601008601E186100806100FFFE184021870180E1C0700000300F0C30000030),
    .INIT_6A(256'h02000002001800606040800187FF87FF0FF800187FF87FF0FF840187FF87FF0F),
    .INIT_6B(256'h1800601800001860000601800020000000600000060000000000000060010004),
    .INIT_6C(256'hFFFFFFFFFE1FFFFFF861804021C0860186180000180040186180000180000186),
    .INIT_6D(256'h1FFFFFFFFFFFFF00FFFFFFFFFFFFE00FFFFFFFFFFFFE18FFFFFFFFFFFFE18FFF),
    .INIT_6E(256'h0018600000000000000000004040001830061FFC0187FF0061FFE03FFFFFFFF8),
    .INIT_6F(256'h0800000103810030FFFFE0061FFFFE00C3FFFFE01870180E1800018600006180),
    .INIT_70(256'h870300FC30C0000F86180001F0C3000C3E186001840000003000000000000000),
    .INIT_71(256'h018000000000000000000C06020001E0F04001FFFFFC001FFFFFC001FFFFFC01),
    .INIT_72(256'h0000080030C03030060100C0603E00000001E00000001E01800001E018000000),
    .INIT_73(256'hC300010100606180008000201040004000000000000000000000000000006100),
    .INIT_74(256'h1C3E001800030E1E000C0000870E0006000043870003000001C38200020200E1),
    .INIT_75(256'hEDFFB7FDA6FFFDBFFFFFFF3E7FFFFFFFFFE1F87FE1FF0C3FFF0FFFFFFFE02DDC),
    .INIT_76(256'hEFE0DB0100303637FFFFFFFFFEDFB7FEDFF6BBFFF6FFFFFFFDFDFFFFFFFFFFB7),
    .INIT_77(256'hFCCD3F1E1B36D3CCED3B2F8D3967BF3969B1861E40D0300186078360C00860D8),
    .INIT_78(256'h736CDB36CE736CCC67DBEC6663333305F8CCFCDB198671FCE731F1BEF9F18FCF),
    .INIT_79(256'hDB36CC0671BE066633333198C780CC336CDB30CDB31F9E6F9F998CCCCFC60032),
    .INIT_7A(256'hDBE7C69F3033F0F8CDECFE39CE736CE7331996FB198FCCCCC67F307B39CDB36C),
    .INIT_7B(256'hFFFFFFF03E001C0300860C0840430FC0430C1E001809E7B3727E1F8DB3F8C7C6),
    .INIT_7C(256'hFFFFFFFFFFFEDC7FFFFFFFFFFEDFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFFFFFB7),
    .INIT_7D(256'hFFE637FFFFFFFFFFEDFFFFFFFFFFFFFFFFFFFFFB75FFFFFFFFFFFB7FFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9FFFFFFFFFFF87FFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'h7F7FEDFFFFFCFDF6FFFF6FEFFC3FFFFFC03E1FFFE001FFFFFFFFFFFFFF80FFFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hE67E3C7E9E67971BEDCCECC0D023181E06E37D83C0001BFF6FFFFFCFEFB7FFFB),
    .INIT_01(256'h36CDEC79B6DB36D737DB66198181861B66DA7EFB6CE733F333F198661FDF730F),
    .INIT_02(256'h010C03C0F36CFC3F196F9F8DB37B336DB9CE73ADF739B66F660DB6D9B631BEDB),
    .INIT_03(256'h7C3E1F0F87C3E1F0F87C1FCEF9CF1807FFFFFE300CE7F9DFE0F038700C02187E),
    .INIT_04(256'h80040200000000000007C001F0187C061F0187C061F0187C061F018000000000),
    .INIT_05(256'h086000430002180010C00086100430C02184027E3FCE730CDB36CDB36CDB36C1),
    .INIT_06(256'h0000000000000000000000000000000000000618041080008400002004010020),
    .INIT_07(256'hA3FFE39680003FF87FF0FFE3FFE3FF8000000000000003FFE000000000000000),
    .INIT_08(256'hFFE39680003FF87FF0DAA3FFE39680003FF87FF0DAA3FFE39680003FF87FF0C2),
    .INIT_09(256'hE21680003FF87FF0DAA3FFE39680003FF87FF0EAA3FFE39680003FF87FF0C2A3),
    .INIT_0A(256'h0000003FF87FF0FFE3FFE3FF80003FF87FF0DA23FFE21080003FF87FF0DAA3FF),
    .INIT_0B(256'h000000000000000000000000000000000000000000000000000000000003FFE0),
    .INIT_0C(256'h003FF87FF0FFE3FFE3F380003FF87FF0FFE3FFE3FF8000000000000003FFE000),
    .INIT_0D(256'h3FF87FF0FFE3FFE3F380003FF87FF0FFE3FFE3F380003FF87FF0FFE3FFE3F380),
    .INIT_0E(256'hF87FF0FFE3FFE38380003FF87FF0FFE3FFE3F380003FF87FF0FFE3FFE3F38000),
    .INIT_0F(256'h00000003FFE00000003FF87FF0FFE3FFE3FF80003FF87FF0FFE3FFE38380003F),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'hFFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF000000),
    .INIT_12(256'hE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0),
    .INIT_13(256'hFFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1FFC3FF87FF3FF87FF0FF),
    .INIT_14(256'h0000000000000000000000000000003FF87FF0FFE1FFC3FF87FF3FF87FF0FFE1),
    .INIT_15(256'hFB7FEDB7FFFF87FE18077330FBE0000000000000000000000000000000000000),
    .INIT_16(256'h30CC339CDB339CDB1FC6631FCDB4ED3CB4ECDB601818600DB7FFFFB7FEDB7FFF),
    .INIT_17(256'hFFFFFFFFFFFF0086100806100B6C7E336C7E36CE7336CFF36CDB336CE730CDB3),
    .INIT_18(256'h0E06C37FEDFFFFFFFFFFFFFFFFFEFF7FEDFFFFFFFFFFFFFFFFFE7E7FE1FFFFFF),
    .INIT_19(256'h3F1FC7C3F8CC3F3FF199FB1E3F4ED399DA799B1864F21B408C60183C0303C040),
    .INIT_1A(256'hD9B66333336CC31E6DB0C7E619B66333336C1B030C39CC6739B66333336DFB33),
    .INIT_1B(256'h8403009E6DB6C7C6D8FC9F3031F87E336DB6CC66D9CE3F33339CFF306DB6C066),
    .INIT_1C(256'hFFFFFFFFFFFFFB7FFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFC0E1861010C201C307),
    .INIT_1D(256'hFFFFF87FFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFFFFFFFFFFFFFFFB7FFFFFFFFF),
    .INIT_1E(256'hF9FE7E3F1F8FC3F3FCFC7E3F1F8007F800000000000000000000007FFFFFFFFF),
    .INIT_1F(256'h000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1),
    .INIT_20(256'h0000FCFF3F1F800001F9FE7E3F00000003FC0000000000000000000000000FF0),
    .INIT_21(256'h07F8000000000FCFF3F1F800001F9FE7E3F000003F3FCFC7E000007E7F9F8FC0),
    .INIT_22(256'hE7E000007E7FBFCFC00000FCFF7F9F80000001FEFF0000000000000000000000),
    .INIT_23(256'h000003FDFE00000007E7FBFCFC00000FCFF7F9F800001F9FEFF3F000003F3FDF),
    .INIT_24(256'h8FCFF00000FC3F1F9FE00001F87E3F3FC00003F000007F800000000000000000),
    .INIT_25(256'h000000000000FF00000003F1F9FE00001F87E3F3FC00003F0FC7E7F800007E1F),
    .INIT_26(256'h3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F800000000000000000000),
    .INIT_27(256'h00000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E),
    .INIT_28(256'hB99B36D831881B07806DBFFB7FF6FFFEDB7FF6FFEDFFFDB6FFE1FFC3FFF86000),
    .INIT_29(256'hFE036DB19B66339C7EDB7E36CC66198C30C16D98CDB1F1F99AE61F9B69CBF1E5),
    .INIT_2A(256'hFFFFFFFDBFFFFFFFFFFFFB7FF01C300C0386804F9B6FC3F27C7E31B6D8CE71F9),
    .INIT_2B(256'hFDBFFED9F3FF0FFF8701FFFFFFFFFF87FFFFFFFFFFFF6FFFFFFFFFFFFEDFFFFF),
    .INIT_2C(256'h3CDB7E6DB0018618230FC667E66BF1F8F1F8F2FC068118818C31BFF6FFFB6FEF),
    .INIT_2D(256'h000000000000000000000081C300E1C04F36DF9B67C66DB636DBF9836D8DB6C6),
    .INIT_2E(256'hE3F0FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F87E001F8FC7E3F000000),
    .INIT_2F(256'h00000000000000000000000000000000000000003F000FC7E3F1F87E001F8FC7),
    .INIT_30(256'hC7E000007E001F8FC00000FC003F1F800001F8007E3F000003F000FC7E000000),
    .INIT_31(256'h000000000000000000000000000000000000000000001F8007E3F000003F000F),
    .INIT_32(256'h800003F000003F000007E000007E00000FC00000FC00001F800001F800003F00),
    .INIT_33(256'h000007E000000000000000000000000000000000000000000FC00001F800001F),
    .INIT_34(256'h3F0FC7E00000007E1F8FC0000000FC3F1F80000001F87E3F00000003F0FC7E00),
    .INIT_35(256'h3F1F8FC7E3F0000000000000000000000000000000000000000007E3F0000000),
    .INIT_36(256'h7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E),
    .INIT_37(256'hB7CCF7BBF4B46D9324C8B4EDFB7EDC0000000000000000000000000003F1F8FC),
    .INIT_38(256'h08186001801FFFFFFFFFFFC3F003FFFFFFFFFFF87F00FFFFFFFFFFFF0FF03EDF),
    .INIT_39(256'h000180000018000010C030000000000002180000040403000043000400C1C0F0),
    .INIT_3A(256'h00860000006000804000C000000C00000000180006018000000C030007C00000),
    .INIT_3B(256'hFFFE00FFFC3FFFFFFFFFFFFFFFE00FFFC3FFFFFFFFFFFFFFFE0080C043000E07),
    .INIT_3C(256'h0001C0180203C04000020100FFFC03C0307E0E006070000FFFC3FFFFFFFFFFFF),
    .INIT_3D(256'h3000001800000000100001C3000001800000020100001C000000180000002010),
    .INIT_3E(256'h0180000001E1F0001C000C00180000001E1F0001C300C00180000001E1F0FFFC),
    .INIT_3F(256'h0080400000000C0300C0300000000201FFFE010C203C043C003E1F0001C000C0),
    .INIT_40(256'h000001C00200001C00000001C00000FFFC00000FFFF0C000FFFF0C200FFFF0C3),
    .INIT_41(256'h9B62D2FDDEF33EDFB70EE6FFFF0C300001F0C200001F0C000001F0C000FFFF0C),
    .INIT_42(256'h6FFFFEDB33FBFFFFB6CCFEFFFFE180001BB801DD8000000003B7EDFB72D1324C),
    .INIT_43(256'hF6F6036DB37D818FDB6CD064E630C335F9F8F8FCCD7E369CBF3341A030630C00),
    .INIT_44(256'h33B1E583C0206DFFFFFF6FFFFFF87FFFFFFC2038601F0F63E6DB37DBD98DB6CD),
    .INIT_45(256'hFFFE00FFFC02010C0027E36CFC739B66336CDB319B6619F8DB39CC1730FE66B7),
    .INIT_46(256'h8F87F33F1F0FE9CCECC313971B078006DE0DC6FFFFEC37FF3FBFFFFB39FFE7EF),
    .INIT_47(256'h303E36CDB67C6598CDB36DB19D60336CDB606318FCC336D9FAE66339CC30C69F),
    .INIT_48(256'hFFF00FFFFFFFFF003FFFFC03FFFFFFFFE00FFFFF00FFFFFFFFFC020218061C04),
    .INIT_49(256'hC030800000000000003000000002000006000C20100001C00003C0030C0C00FF),
    .INIT_4A(256'hC00000C000000000C03000C0300003000030000030000000C0000C00000C0000),
    .INIT_4B(256'hFFFFF0FFFFFFFFFFFFFFFFFC010C02010C003807000003000003000400800000),
    .INIT_4C(256'hFFFFFFFFFFFFFC00FFFFFFFFFFFFFFFF0E3FFFFFFFFFFFFFFFC38FFFFFFFFFFF),
    .INIT_4D(256'h0000C20100078C0C00FFFFF003FFFFE00FFFFFC0301FFFFFFFFFFFFFFFF803FF),
    .INIT_4E(256'h70000000000000078807000C0008020100000C0C30003870C000C0C308020100),
    .INIT_4F(256'h08018000000000007F87F87F87F87F87F87F87F87F87FC7FE3F10F8C007007C0),
    .INIT_50(256'hC7F11FE07FC1FF87FF1FF800000000FF1FE3FC7F8FF00600C018FF1FE3FC7F80),
    .INIT_51(256'hFFF03FFF07FFF0FFFF8FFF1FFE3FFC7FF8FFF1FF0000000000071F1E3C7C71F8),
    .INIT_52(256'h000000000000000070FF0F0FE1F0FC3F0F87F0F0FF0E1FF0C3FF087FF00FFF01),
    .INIT_53(256'h3FE1C3FE1C3801C3001C3001C3803C30FFFF0FFFF0FFFF0FFFF0FFFF0FFFC000),
    .INIT_54(256'h001C0411C03E1C03E1C03E1C03E1C0001C0001C1FF1C2001C3FE1C3FE1C3FE1C),
    .INIT_55(256'h07FE000FFC03FFF807FFF00FFFE01FF80000600000C00801C03802003C0001C0),
    .INIT_56(256'h800002000000001080001E01FC3C03F87807F0F00FE0001FC00001BFC0038000),
    .INIT_57(256'hBFC425800827FE108FFC213FF8447FF081FFE103F8020FE0043FC008FFC03003),
    .INIT_58(256'hFFFF87F0030FC0021F80043F10887E1E10FC3C2008780000F000000100400210),
    .INIT_59(256'hFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFF3F3FFF3F3FFFCFFFFFCFFFFFFFFFFFFF),
    .INIT_5A(256'hFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3FFFFC3F),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFCFFFFFC3FFFFC3FFFFC3FFFFC3FFF),
    .INIT_5C(256'h3F0FFF0FC3FFC3F0FFF0FC3FFC3FCFFF0FF3FFC3FFFFFCFFFFFF3FFCFFFFFF3F),
    .INIT_5D(256'hFF3FFCFFCFFF3FFFFFFFFFFFFFFF0FFFFFC3FFFF3CFF0FCF3FC3F0FFF0FC3FFC),
    .INIT_5E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFCFFF3FF3FFCFFC3FF0FF0FFC3FC3FF0FF0FFC3),
    .INIT_5F(256'h0FFF0FF0FFF0FF0FFF0FFCFFF0FFCFFF0FFFFFFCFFFFFFCFFFCFFFFFFCFFFFFF),
    .INIT_60(256'hF0FFFCFF0FFFCFF0FFFFFF0FFFFFF0FFFFFF0FFFFFF0FFF0FF0FFF0FF0FFF0FF),
    .INIT_61(256'hFF3FFFFFF0FFF3FF0FFF3FF0FFF0FF0FFF0FF0FFF0FF0FFF0FF0FFF0FF0FFF0F),
    .INIT_62(256'h0FFCFFF0FFCFFF0FFFFFFCFFFFFFCFFFCFFFFFFCFFFFFFFFFFFFFFFFFFF3FFFF),
    .INIT_63(256'hF0FFFFFF0FFFFFF0FFFFFF0FFFFFF0FFFFFF0FFFFFF0FFFFFF0FF3FFF0FF3FFF),
    .INIT_64(256'hFFFFFF0FFFFFF0FFFFF3CFFFFF3CFFFFFCFFF0FFCFFF0FFFFFF0FFFFFF0FFFFF),
    .INIT_65(256'h3F3CFF0FCF3FC3FCFFFCFF3FFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFF3),
    .INIT_66(256'hFFFF0FFFFFC3FFFF3CFFFFCF3FFFF0FFFFFC3FFFF3CFFFFCF3FFFF0FF0FFC3FC),
    .INIT_67(256'hFFFF0FFFFFC3FFCFF0FFF3FC3FFFFFCFFFFFF3FFFCFFFFFF3FFFFFFFFFFFFFFF),
    .INIT_68(256'h00007FF0000E000001F80001F807FC07000000FFFFFFFFFFFFF0FFF3FC3FFCFF),
    .INIT_69(256'hFF7EFFFF7EFDFDFDDFFFFF9FFFFFBFF7FFF77FFFFEFDFFFEFDFBFDFBBFFFFF00),
    .INIT_6A(256'h77FFFFE7FFFFEFF7FFFDDFFFFFB87FFF877EFDFEEFFFFFCFFFFFDFF7FFFBBFFF),
    .INIT_6B(256'hFBDF77FFFFEEFDFEFDDFBDFFB803F003FFFFF7F7F83EEFFFFFDDF801FBBF7DFF),
    .INIT_6C(256'hBF77EDFFEFFEFDFFFEFDFFF7FBEFB80003F77EFF7EEFDDFFDFFDFBFC01F803F7),
    .INIT_6D(256'hFFBF7FF7FBFBEFFFFEFDFFFFDFBBF5FFF7FF7EFFFF7EFFF7FBF7DFFFFDFB807F),
    .INIT_6E(256'h003F7EFFFF0EFFFFFDFFDFBFFFDFBFFBFEFDF7FFFF7EFC000FDDF9FFFBFFBF7F),
    .INIT_6F(256'hFF7FF7EFFFF7EFFFBFEF7DFEFFFFBF7FFFBF7FFFFEFFEFDFFFEFDFFEFFBEFBFC),
    .INIT_70(256'hFBFFFF7FBFFFEEFC000FDFFFFFBFFBF7FFFBF7FFEFF83EFF7FFFDC3FFFDFBFFF),
    .INIT_71(256'h7FFFF7FFFFEFFEFDFFFEFDFFFEFFFFBFDFFFF77EFFFFEFFFFFDFFDFBFFFDFBFF),
    .INIT_72(256'h7FFFBF7FFFEFFFEFFFFEFDDFBFFFFBFFF9F7FF7EFFFF7EFFFFBFFFDFE001FBBF),
    .INIT_73(256'hFFFFBF77EFF00EFFFB7DFFDFBFFFDFBFFFF781F7FFFF7EEFDFFFFDFFFAFBFFBF),
    .INIT_74(256'hFBDF7007E00FF7EFFFF7DF7DFFFFFFBBF7FBF77FFBBEFFEFDFFFEFDFFFF7DEFB),
    .INIT_75(256'hFFF7DFDF7FFFFFEEFC00FDDFFBEFBBFFFFF7FBF7FFF7DFBEFFFFFFDDFBFDFBBF),
    .INIT_76(256'hF7FFFBF7FBFBEEFFFFFDFEFDFFF7DFEFBFFFFFF70FFFF0EFFBF7DDFFFFFBFDFB),
    .INIT_77(256'h00007FBF7FF7DFFBEFFFFFFDFBFFFDFBFBFDF77FFFFEFF7EFFF7DFF7DFFFFFFB),
    .INIT_78(256'hFDC03FE038000007E00007FC0001FFC03FF81FFC07000000FC0000FC03FE0380),
    .INIT_79(256'hF70FFFF0E1FFFC1FBFBFBBFFFFF7EFFFF7FDFFFDDFBFDFBBFFFFF7EFFFF7FDFF),
    .INIT_7A(256'h9FBDFFB803F0077FFFFEEFFFFF9FBEFFBBFFFFF77FFFFEEFFFFF9FBF7FBBFFFF),
    .INIT_7B(256'h7F7EFEEFDFDF9FB7FFBFFBF7FF7F00FEEFC01F9FBBFFBFFBF7FF7FFFFEEFFFFF),
    .INIT_7C(256'hFFFFBFFBF7FF7F7EFEE01FDF9F9FFFBFFBF7FF7F7EFEEFDFDF9FAFFFBFFBF7FF),
    .INIT_7D(256'h7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F7EFEFFFFDF9F),
    .INIT_7E(256'hFFBFFBF7FF7F7EFEE01FDF9FFFFFBFFBF7FF7F7EFEFFFFDF9FFFFFBFFBF7FF7F),
    .INIT_7F(256'hFEEFC01F9FFFAFBFFBF7FF7F7EFEEFDFDF9FFFCFBFFBF7FF7F7EFEEFDFDF9FFF),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized7
   (DOUTA,
    clka,
    ENA,
    addra);
  output [0:0]DOUTA;
  input clka;
  input ENA;
  input [15:0]addra;

  wire CASCADEINA;
  wire CASCADEINB;
  wire [0:0]DOUTA;
  wire ENA;
  wire [15:0]addra;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hB803F0077FFFFEEFFFFF9FFEEFBFFBF7FF7FFFFEEFFFFF9FFF6FBFFBF7FF7F00),
    .INIT_01(256'hFDFFFDDFF7EFBBFFFFF70FFFF0E1FFFC1FFBEFBBFFFFF77FFFFEEFFFFF9FFDEF),
    .INIT_02(256'h000007E00007FC0001DFDFEFBBFFFFF7EFFFF7FDFFFDDFEFEFBBFFFFF7EFFFF7),
    .INIT_03(256'hF0FCFF3F1F8FC7E1F9FE7E3F1F8FC003FC0000000000000000000000003FE038),
    .INIT_04(256'hF8000000000FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3),
    .INIT_05(256'hE000007E7F9F8FC00000FCFF3F1F80000001FE00000000000000000000000007),
    .INIT_06(256'h0003FC0000000007E7F9F8FC00000FCFF3F1F800001F9FE7E3F000003F3FCFC7),
    .INIT_07(256'hEFF3F000003F3FDFE7E000007E7FBFCFC0000000FF7F80000000000000000000),
    .INIT_08(256'h00000001FEFF00000003F3FDFE7E000007E7FBFCFC00000FCFF7F9F800001F9F),
    .INIT_09(256'h0FC7E7F9D8007E1F8FCFF3B000FC3F1F9FE7E001F800003FC000000000000000),
    .INIT_0A(256'h000000000000007F80000001F8FCFF3F000FC3F1F9FE66001F87E3F3FCEC003F),
    .INIT_0B(256'h3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E),
    .INIT_0D(256'h7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0000000000000000000000000000),
    .INIT_0E(256'h0000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC),
    .INIT_0F(256'hFC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F800000000000000000000000),
    .INIT_10(256'h00000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0),
    .INIT_11(256'hF1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC0000000000000000000),
    .INIT_12(256'h000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3),
    .INIT_13(256'h93F1F8FC3F1F9A27E3F1F87E3F354FC7E3F0FC7E409F8FC7E00000FF00000000),
    .INIT_14(256'h0000000000000000000001FE00000007E3F354FC7E3F0FC7E6A9F8FC7E1F8FCD),
    .INIT_15(256'hC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F00000000000),
    .INIT_16(256'h000000000000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0F),
    .INIT_17(256'h1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC003FC000000000000000),
    .INIT_18(256'h000000000000007F8000000000FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F),
    .INIT_19(256'h3F000003F3FCFC7E000007E7F9F8FC00000FCFF3F1F80000001FE00000000000),
    .INIT_1A(256'h0000000000000000003FC0000000007E7F9F8FC00000FCFF3F1F800001F9FE7E),
    .INIT_1B(256'hFF7F9F800001F9FEFF3F000003F3FDFE7E000007E7FBFCFC0000000FF7F80000),
    .INIT_1C(256'h00000000000000000000001FEFF00000003F3FDFE7E000007E7FBFCFC00000FC),
    .INIT_1D(256'hF87E3F3FC00003F0FC7E7F800007E1F8FCFF00000FC3F1F9FE00001F800003FC),
    .INIT_1E(256'h000000000000000000000000000007F80000001F8FCFF00000FC3F1F9FE00001),
    .INIT_1F(256'hF1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC000),
    .INIT_20(256'h0000000000000000000000000000000000000000000FC7E3F1F8FC7E1F8FC7E3),
    .INIT_21(256'hF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F000FF00000000),
    .INIT_22(256'h0000000000000000000001FE0000000003F3FCFC7E3F1F87E7F9F8FC7E3F0FCF),
    .INIT_23(256'h07E7F9F8FC00000FCFF3F1F800001F9FE7E3F000003F3FCFC7E00000007F8000),
    .INIT_24(256'hDFE00000000000000000000000FF0000000001F9FE7E3F000003F3FCFC7E0000),
    .INIT_25(256'h000003F3FDFE7E000007E7FBFCFC00000FCFF7F9F800001F9FEFF3F00000003F),
    .INIT_26(256'h0000000000000000000000000000007FBFC0000000FCFF7F9F800001F9FEFF3F),
    .INIT_27(256'h00000007E1F8FC0000000FC3F1F80000001F87E3F00000003F0FC7E00000007E),
    .INIT_28(256'h7E3F0000000000000000000000000000000000000000007E3F00000003F0FC7E),
    .INIT_29(256'h7E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC),
    .INIT_2A(256'h000000000000000000000000000000000000000000000000003F1F8FC7E3F1F8),
    .INIT_2B(256'hF8FC3F000FC7E3F1F87E001F8FC7E3F0FC003F1F8FC7E1F8007E3F1F8FC00000),
    .INIT_2C(256'h00000000000000000000000000000000000000000FC003F1F8FC7E1F8007E3F1),
    .INIT_2D(256'hF1F800001F8007E3F000003F000FC7E000007E001F8FC00000FC003F1F800000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000007E001F8FC00000FC003),
    .INIT_2F(256'hE00000FC00000FC00001F800001F800003F000003F000007E000007E00000FC0),
    .INIT_30(256'h000001F8000000000000000000000000000000000000000003F000007E000007),
    .INIT_31(256'h0FC3F1F80000001F87E3F00000003F0FC7E00000007E1F8FC0000000FC3F1F80),
    .INIT_32(256'h8FC7E3F1F8FC000000000000000000000000000000000000000001F8FC000000),
    .INIT_33(256'h1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F),
    .INIT_34(256'hB9DDDDDDDDDDDDDC000000000000000000000000000000000000000000FC7E3F),
    .INIT_35(256'hBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBBB),
    .INIT_36(256'h73BBBBBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBB),
    .INIT_37(256'h777777773BBB83BBBBBBBB9DDDC1DDDDDDDDC000000000000007777777777777),
    .INIT_38(256'h0777707700777773BBB83B803BBBB9DDDC1DC01DDDDC00000000000000777707),
    .INIT_39(256'h000000000777007007777703BB803803BBBB81DDC01C01DDDDC0000000000000),
    .INIT_3A(256'hC0000000000000000777000777777003BB8003BBBBB801DDC001DDDDDC000000),
    .INIT_3B(256'hDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDD),
    .INIT_3C(256'h9DDDDC0001DDDDC00000000000000777770777777773BBBB83BBBBBBB9DDDDC1),
    .INIT_3D(256'hBBBBBBB9DDDDDDDDDDDDDC00000000000000777770000777773BBBB80003BBBB),
    .INIT_3E(256'h3BBBBBBBBBBBBB80000000000000000000000000000777777777777773BBBBBB),
    .INIT_3F(256'h77777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE77777777777777),
    .INIT_40(256'h777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE7777777),
    .INIT_41(256'hEEEEEEE777707777777773BBB83BBBBBBBB800000000000000EEEEEEEEEEEEEE),
    .INIT_42(256'hEEEE0EE00EEEEE777707700777773BBB83B803BBBB800000000000000EEEE0EE),
    .INIT_43(256'h0000000EEEE00E00EEEEE777700700777773BBB803803BBBB800000000000000),
    .INIT_44(256'h00000000000000EEEEE000EEEEEE777770007777773BBBB8003BBBBB80000000),
    .INIT_45(256'hBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB8),
    .INIT_46(256'hBBBB80003BBBB800000000000000EEEEE0EEEEEEEE777770777777773BBBB83B),
    .INIT_47(256'h7777773BBBBBBBBBBBBB800000000000000EEEEE0000EEEEE777770000777773),
    .INIT_48(256'h777777777777700000000000000000000000000000EEEEEEEEEEEEEE77777777),
    .INIT_49(256'hEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7),
    .INIT_4A(256'hEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEE),
    .INIT_4B(256'hDDDDDCEEEE0EEEEEEEEE77770777777777000000000000001DDDDDDDDDDDDDCE),
    .INIT_4C(256'hDDC1DC01DDDDCEEEE0EE00EEEEE77770770077777000000000000001DDDC1DDD),
    .INIT_4D(256'h000001DDDC01C01DDDDCEEEE00E00EEEEE77770070077777000000000000001D),
    .INIT_4E(256'h0000000000001DDDDC001DDDDDCEEEEE000EEEEEE77777000777777000000000),
    .INIT_4F(256'h77777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7777777777777700),
    .INIT_50(256'h777000077777000000000000001DDDDC1DDDDDDDCEEEEE0EEEEEEEE777770777),
    .INIT_51(256'hEEEEE77777777777777000000000000001DDDDC0001DDDDCEEEEE0000EEEEE77),
    .INIT_52(256'hEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_53(256'hDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEE),
    .INIT_54(256'hDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDD),
    .INIT_55(256'hBBBB9DDDC1DDDDDDDDCEEEE0EEEEEEEEE000000000000003BBBBBBBBBBBBB9DD),
    .INIT_56(256'hB83B803BBBB9DDDC1DC01DDDDCEEEE0EE00EEEEE000000000000003BBB83BBBB),
    .INIT_57(256'h00003BBB803803BBBB9DDDC01C01DDDDCEEEE00E00EEEEE000000000000003BB),
    .INIT_58(256'h000000000003BBBB8003BBBBB9DDDDC001DDDDDCEEEEE000EEEEEE0000000000),
    .INIT_59(256'hEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000),
    .INIT_5A(256'hEE0000EEEEE000000000000003BBBB83BBBBBBB9DDDDC1DDDDDDDCEEEEE0EEEE),
    .INIT_5B(256'hDDDCEEEEEEEEEEEEEE000000000000003BBBB80003BBBB9DDDDC0001DDDDCEEE),
    .INIT_5C(256'h018004010C204000801840E03000000000000003BBBBBBBBBBBBB9DDDDDDDDDD),
    .INIT_5D(256'h0000000010800018000000000000000180000008000000001800000080000000),
    .INIT_5E(256'h0006000000240C00000001080000000000000010800018000000000108000180),
    .INIT_5F(256'hFFFFFFFFFFFFF0C06000081808C0010C06000000000C0000406000000000C000),
    .INIT_60(256'h0F0007FFFFFFFC0030F0007FFFFFFFE0030F0807FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_61(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFF8003),
    .INIT_62(256'hFFFFF8200000007FFFFFFF8004800007FFFFFFFC0000F0007FFFFFFFC0030F00),
    .INIT_63(256'h000080000000000C00C2040200001E0FFFF8610000807FFFFFFF8200000007FF),
    .INIT_64(256'h0108610000000001086100000000010821000000000000000000008000000000),
    .INIT_65(256'h003F00C0600000003F0040600000002100006000000021000001082100210000),
    .INIT_66(256'hC00000080000FFE00000080000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C0600200),
    .INIT_67(256'h784300FF801018784300FF801018784300FF800000080000FF800000080000FF),
    .INIT_68(256'hFF8200180000F0FF8200180000F0FF8000180000F0FFC01018784300FFC01018),
    .INIT_69(256'h000000000000000000000000000000000000000000000000000F8600180000F0),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("LOWER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(CASCADEINA),
        .CASCADEOUTB(CASCADEINB),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOADO_UNCONNECTED [31:0]),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_B_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("UPPER"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(CASCADEINA),
        .CASCADEINB(CASCADEINB),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOADO_UNCONNECTED [31:1],DOUTA}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ENA),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module overlay_mem_blk_mem_gen_top
   (douta,
    clka,
    addra);
  output [3:0]douta;
  input clka;
  input [17:0]addra;

  wire [17:0]addra;
  wire clka;
  wire [3:0]douta;

  overlay_mem_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .douta(douta));
endmodule

(* C_ADDRA_WIDTH = "18" *) (* C_ADDRB_WIDTH = "18" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "17" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "2" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.370774 mW" *) 
(* C_FAMILY = "artix7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "0" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "overlay_mem.mem" *) 
(* C_INIT_FILE_NAME = "overlay_mem.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "3" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "136000" *) (* C_READ_DEPTH_B = "136000" *) (* C_READ_WIDTH_A = "4" *) 
(* C_READ_WIDTH_B = "4" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "1" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "136000" *) (* C_WRITE_DEPTH_B = "136000" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
(* C_WRITE_MODE_B = "WRITE_FIRST" *) (* C_WRITE_WIDTH_A = "4" *) (* C_WRITE_WIDTH_B = "4" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "blk_mem_gen_v8_4_1" *) (* downgradeipidentifiedwarnings = "yes" *) 
module overlay_mem_blk_mem_gen_v8_4_1
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [17:0]addra;
  input [3:0]dina;
  output [3:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [17:0]addrb;
  input [3:0]dinb;
  output [3:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [17:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [3:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [3:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [17:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [17:0]addra;
  wire clka;
  wire [3:0]douta;

  assign dbiterr = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign rdaddrecc[17] = \<const0> ;
  assign rdaddrecc[16] = \<const0> ;
  assign rdaddrecc[15] = \<const0> ;
  assign rdaddrecc[14] = \<const0> ;
  assign rdaddrecc[13] = \<const0> ;
  assign rdaddrecc[12] = \<const0> ;
  assign rdaddrecc[11] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[17] = \<const0> ;
  assign s_axi_rdaddrecc[16] = \<const0> ;
  assign s_axi_rdaddrecc[15] = \<const0> ;
  assign s_axi_rdaddrecc[14] = \<const0> ;
  assign s_axi_rdaddrecc[13] = \<const0> ;
  assign s_axi_rdaddrecc[12] = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  overlay_mem_blk_mem_gen_v8_4_1_synth inst_blk_mem_gen
       (.addra(addra),
        .clka(clka),
        .douta(douta));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_1_synth" *) 
module overlay_mem_blk_mem_gen_v8_4_1_synth
   (douta,
    clka,
    addra);
  output [3:0]douta;
  input clka;
  input [17:0]addra;

  wire [17:0]addra;
  wire clka;
  wire [3:0]douta;

  overlay_mem_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .clka(clka),
        .douta(douta));
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
