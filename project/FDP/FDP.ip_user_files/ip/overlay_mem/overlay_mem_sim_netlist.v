// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Sun Nov  9 20:59:57 2025
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [16:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [3:0]douta;

  wire [16:0]addra;
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
  wire [16:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [16:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "17" *) 
  (* C_ADDRB_WIDTH = "17" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "12" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "4" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.558189 mW" *) 
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
  (* C_READ_DEPTH_A = "100000" *) 
  (* C_READ_DEPTH_B = "100000" *) 
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
  (* C_WRITE_DEPTH_A = "100000" *) 
  (* C_WRITE_DEPTH_B = "100000" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "4" *) 
  (* C_WRITE_WIDTH_B = "4" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  overlay_mem_blk_mem_gen_v8_4_1 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[16:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[16:0]),
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
    .INIT(32'h01000000)) 
    ENOUT
       (.I0(addra[2]),
        .I1(addra[1]),
        .I2(addra[0]),
        .I3(addra[4]),
        .I4(addra[3]),
        .O(ena_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module overlay_mem_blk_mem_gen_generic_cstr
   (douta,
    clka,
    addra);
  output [3:0]douta;
  input clka;
  input [16:0]addra;

  wire [16:0]addra;
  wire clka;
  wire [3:0]douta;
  wire [24:24]ena_array;
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
       (.addra(addra[16:12]),
        .ena_array(ena_array));
  overlay_mem_blk_mem_gen_mux \has_mux_a.A 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T (\ramloop[3].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 (\ramloop[5].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 (\ramloop[7].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram (\ramloop[4].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[6].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[8].ram.r_n_0 ),
        .DOADO(\ramloop[1].ram.r_n_0 ),
        .DOUTA(ram_douta),
        .addra(addra[16:12]),
        .clka(clka),
        .douta(douta));
  LUT1 #(
    .INIT(2'h1)) 
    ram_ena
       (.I0(addra[16]),
        .O(ram_ena_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \ram_ena_inferred__0/i_ 
       (.I0(addra[16]),
        .I1(addra[15]),
        .O(\ram_ena_inferred__0/i__n_0 ));
  overlay_mem_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.DOUTA(ram_douta),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.DOADO(\ramloop[1].ram.r_n_0 ),
        .addra(addra[14:0]),
        .\addra[15] (\ram_ena_inferred__0/i__n_0 ),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .\douta[3] ({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 }),
        .ena_array(ena_array));
  overlay_mem_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.DOUTA(\ramloop[3].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.addra(addra[14:0]),
        .\addra[15] (\ram_ena_inferred__0/i__n_0 ),
        .clka(clka),
        .\douta[1] (\ramloop[4].ram.r_n_0 ));
  overlay_mem_blk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.DOUTA(\ramloop[5].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.addra(addra[14:0]),
        .\addra[15] (\ram_ena_inferred__0/i__n_0 ),
        .clka(clka),
        .\douta[2] (\ramloop[6].ram.r_n_0 ));
  overlay_mem_blk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.DOUTA(\ramloop[7].ram.r_n_0 ),
        .ENA(ram_ena_n_0),
        .addra(addra[15:0]),
        .clka(clka));
  overlay_mem_blk_mem_gen_prim_width__parameterized7 \ramloop[8].ram.r 
       (.addra(addra[14:0]),
        .\addra[15] (\ram_ena_inferred__0/i__n_0 ),
        .clka(clka),
        .\douta[3] (\ramloop[8].ram.r_n_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module overlay_mem_blk_mem_gen_mux
   (douta,
    addra,
    clka,
    DOADO,
    DOUTA,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 );
  output [3:0]douta;
  input [4:0]addra;
  input clka;
  input [0:0]DOADO;
  input [0:0]DOUTA;
  input [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ;
  wire [3:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [0:0]DOADO;
  wire [0:0]DOUTA;
  wire [4:0]addra;
  wire clka;
  wire [3:0]douta;
  wire \douta[3]_INST_0_i_1_n_0 ;
  wire [4:0]sel_pipe;
  wire [4:0]sel_pipe_d1;

  LUT6 #(
    .INIT(64'hFFFF734073407340)) 
    \douta[0]_INST_0 
       (.I0(sel_pipe_d1[3]),
        .I1(sel_pipe_d1[4]),
        .I2(DOADO),
        .I3(DOUTA),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram [0]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[0]));
  LUT6 #(
    .INIT(64'hFFFF734073407340)) 
    \douta[1]_INST_0 
       (.I0(sel_pipe_d1[3]),
        .I1(sel_pipe_d1[4]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T ),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram [1]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[1]));
  LUT6 #(
    .INIT(64'hFFFF734073407340)) 
    \douta[2]_INST_0 
       (.I0(sel_pipe_d1[3]),
        .I1(sel_pipe_d1[4]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_0 ),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram [2]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[2]));
  LUT6 #(
    .INIT(64'hFFFF734073407340)) 
    \douta[3]_INST_0 
       (.I0(sel_pipe_d1[3]),
        .I1(sel_pipe_d1[4]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SP.CASCADED_PRIM36.ram_T_1 ),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram [3]),
        .I5(\douta[3]_INST_0_i_1_n_0 ),
        .O(douta[3]));
  LUT5 #(
    .INIT(32'h00100000)) 
    \douta[3]_INST_0_i_1 
       (.I0(sel_pipe_d1[0]),
        .I1(sel_pipe_d1[1]),
        .I2(sel_pipe_d1[3]),
        .I3(sel_pipe_d1[2]),
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
   (DOADO,
    clka,
    \addra[15] ,
    addra);
  output [0:0]DOADO;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [0:0]DOADO;
  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.DOADO(DOADO),
        .addra(addra),
        .\addra[15] (\addra[15] ),
        .clka(clka));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module overlay_mem_blk_mem_gen_prim_width__parameterized1
   (\douta[3] ,
    clka,
    ena_array,
    addra);
  output [3:0]\douta[3] ;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [3:0]\douta[3] ;
  wire [0:0]ena_array;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .\douta[3] (\douta[3] ),
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
   (\douta[1] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[1] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[1] ;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.addra(addra),
        .\addra[15] (\addra[15] ),
        .clka(clka),
        .\douta[1] (\douta[1] ));
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
   (\douta[2] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[2] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[2] ;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized5 \prim_init.ram 
       (.addra(addra),
        .\addra[15] (\addra[15] ),
        .clka(clka),
        .\douta[2] (\douta[2] ));
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
   (\douta[3] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[3] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[3] ;

  overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized7 \prim_init.ram 
       (.addra(addra),
        .\addra[15] (\addra[15] ),
        .clka(clka),
        .\douta[3] (\douta[3] ));
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
    .INIT_41(256'hFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000001FFF),
    .INIT_42(256'hFFFFFFFFFFFC0000000000000000000000000000000000000000001FFFFFFFFF),
    .INIT_43(256'hFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3FFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFE7FFFFFFFFFFFFFFFFFFFFFFFFFF1),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007FCFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8FC7F9FFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE3FC7F9FFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF8E1C7F3FFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hDBE7E7FFFFFFFFFFFFFFFFFFFFFFFFF9FFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFF3FFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFE7FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CFCF),
    .INIT_4D(256'hFFFFFFFFFFFFCFFFE4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0F9F9FFFFFFF),
    .INIT_4E(256'hFFFFFF9FFF88FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDF3F3FFFFFFFFFFFFF),
    .INIT_4F(256'h3FFF39FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7DBE7E7FFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CFCFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF9F6F9F9FFFFFFFFFFFFFFFFFFFFFFFFFE7FFCD9),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF3EDF3F3FFFFFFFFFFFFFFFFFFFFFFFFFCFFF1B1FFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE7DBE7E7FFFFFFFFFFFFFFFFFFFFFFFFF9FFE633FFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFCFB7CFCFFFFFFFFFFFFFFFFFFFFFFFFFF3FF9933FFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hCF0F3F9FFFFFFFFFFFFFFFFFFFFFFFFFE7FE3263FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFCFFCCE67FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFF9FF33E67FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7F8FF),
    .INIT_58(256'hFFFFFFFFFFFFFF3FC67CC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FE7FFFFF),
    .INIT_59(256'hFFFFFFFE7F99FCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFCFFFFFFFFFFFF),
    .INIT_5A(256'hFCFE67FCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000FFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE000000000000000000000800001FFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9000003FFFFFFFFFF),
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
    .INIT_58(256'hFFFE87F0036FDFFADFBFF5BF70EB7EDED6FDBDAC0B7B3FE6F67FCE1D635FFAD6),
    .INIT_59(256'hF77FFFFEFDFFFEFDFBFBFBBFFFFF3FFFFF7FEFFFEEFFFFFDFBFFFDFBF7FBF77F),
    .INIT_5A(256'h7EFBFEEFFFFFCFFFFFDFEFFFFBBFFFFF70FFFF0EFDFBFDDFFFFF9FFFFFBFEFFF),
    .INIT_5B(256'hF007EFF7BEEFFFFFDDFBFDFBBF7BFF7007E007FFFFEFEFF07DDFFFFFBBF003F7),
    .INIT_5C(256'hF700FF7EEFDBFFDFFDFBFFFDFBFFEFF7DF700007EEFDFEFDDFBBFFBFFBF7F803),
    .INIT_5D(256'hFF7EFFFF7EFFEFF7F7DFFFFDFBFFFFBF77EBFFEFFEFDFFFEFDFFEFF7EFBFFFFB),
    .INIT_5E(256'h7DF7F8007EFDFFFE1DFFFFFBFFBF7FFFBF7FF7FDFBEFFFFEFDF8001FBBF3FFF7),
    .INIT_5F(256'hBF7FFFFEFFEFDFFFEFDFFF7FDEFBFDFFFF7EFFFF7EFFFFFDFFDFBFFFDFBFFDFF),
    .INIT_60(256'hFBF7FFF7FFFEFF7FFFDDF8001FBFFFFF7FF7EFFFF7EFFFDFF07DFEFFFFB87FFF),
    .INIT_61(256'h03F77EFFFFEFFFFFDFFDFBFFFDFBFFFDFFFF7FBFFFEEFDFFFFDFFFFFBFFBF7FF),
    .INIT_62(256'hF7FF7EFFFF7EFFFFDFFFDFFFFDFBBF7FFFF7FFF3EFFEFDFFFEFDFFFF7FFFBFC0),
    .INIT_63(256'hEFBDF7FFFF7EEFDFE01DFFF6FBFFBF7FFFBF7FFFEF03EFFFFEFDDFBFFFFBFFF5),
    .INIT_64(256'hFBF77FF7BEE00FC01FEFDFFFEFBEFBFFFFFF77EFF7EEFFF77DFFDFBFFFDFBFFF),
    .INIT_65(256'hF7FBF7FFEFBFBEFFFFFFDDF801FBBFF7DF77FFFFEFF7EFFFEFBF7DFFFFFFBBF7),
    .INIT_66(256'hFFFFF7EFFFF7EFF7F7DDFFFFFBFDFBFFEFBFDF7FFFFFEE1FFFE1DFF7EFBBFFFF),
    .INIT_67(256'hFC07000000FF7EFFEFBFF7DFFFFFFBF7FFFBF7F7FBEEFFFFFDFEFDFFEFBFEFBF),
    .INIT_68(256'hEFFBFFFB807FC07000000FC0000FF80003FF807FF03FF80E000001F80001F807),
    .INIT_69(256'h77FFFFEE1FFFE1C3FFF83F7F7F77FFFFEFDFFFEFFBFFFBBF7FBF77FFFFEFDFFF),
    .INIT_6A(256'hDFFFFF3F7BFF7007E00EFFFFFDDFFFFF3F7DFF77FFFFEEFFFFFDDFFFFF3F7EFF),
    .INIT_6B(256'hF7EFFEFEFDFDDFBFBF3F6FFF7FF7EFFEFE01FDDF803F3F77FF7FF7EFFEFFFFFD),
    .INIT_6C(256'hFFBF3FFFFF7FF7EFFEFEFDFDC03FBF3F3FFF7FF7EFFEFEFDFDDFBFBF3F5FFF7F),
    .INIT_6D(256'hEFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFF),
    .INIT_6E(256'hBF3FFFFF7FF7EFFEFEFDFDC03FBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7),
    .INIT_6F(256'hFEFE01FDDF803F3FFF5F7FF7EFFEFEFDFDDFBFBF3FFF9F7FF7EFFEFEFDFDDFBF),
    .INIT_70(256'h3FFBDF7007E00EFFFFFDDFFFFF3FFDDF7FF7EFFEFFFFFDDFFFFF3FFEDF7FF7EF),
    .INIT_71(256'hDFFFEFFBFFFBBFEFDF77FFFFEE1FFFE1C3FFF83FF7DF77FFFFEEFFFFFDDFFFFF),
    .INIT_72(256'h7FC07000000FC0000FF80003BFBFDF77FFFFEFDFFFEFFBFFFBBFDFDF77FFFFEF),
    .INIT_73(256'hBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F8000000000000000),
    .INIT_74(256'h001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7F),
    .INIT_75(256'h7FBFDFEE0689FEFF7FBFDF8D53FDFEFF7FBF5027FBFDFEFF7FBFC00000000000),
    .INIT_76(256'h0000000FF7FBFDFEE77F9FEFF7FBFDCAD53FDFEFF7FB91AA7FBFDFEFF70364FF),
    .INIT_77(256'hFE7FBFDFEFF73BFCFF7FBFDFEE77F9FEFF7FBFDCEFF3FDFEFF7FB9DFE0000000),
    .INIT_78(256'h000000000007FBFDFEFF73BFCFF7FBFDFEE77F9FEFF7FBFDCEFF3FDFEFF7FB9D),
    .INIT_79(256'hD90EFF3FDFE003B39DFE7FBFC007673BFCFF7F800FCE77F9FEFF00001CEFF000),
    .INIT_7A(256'hF800000000000003FDFE00003FDFE7FBFC007E7FBFCFF7F800CC877F9FEFF001),
    .INIT_7B(256'hFBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7),
    .INIT_7C(256'h00000000000000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7),
    .INIT_7D(256'hE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE00000000),
    .INIT_7E(256'h00000000007FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDF),
    .INIT_7F(256'hDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF0000),
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
   (DOADO,
    clka,
    \addra[15] ,
    addra);
  output [0:0]DOADO;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [0:0]DOADO;
  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
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
    .INIT_00(256'h800000000000003FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBF),
    .INIT_01(256'hBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F),
    .INIT_02(256'h7FBFC00000000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7F),
    .INIT_03(256'h7FBFC00FF7FBFCFF7F801FEFF7F9FEFF003FDFEFF3FDFE007FBFDFE7FBFC00FF),
    .INIT_04(256'hFF7FBFDFE00000000000000FF7F801FEFF7F9FEFF003FDFEFF3FDFE007FBFDFE),
    .INIT_05(256'hFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFE),
    .INIT_06(256'h0000000000000000000000000007FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFD),
    .INIT_07(256'hFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F8),
    .INIT_08(256'h0002000000001FFFFDFEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FB),
    .INIT_09(256'hFBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC00017FBFDFEFF8),
    .INIT_0A(256'hF7FC000100000000080002FF7FBFDFF00005FEFF7FBFE0000BFDFEFF7FC00017),
    .INIT_0B(256'h000BFDFEFF7FC00017FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0000BFDFEF),
    .INIT_0C(256'hEFF0000001FF00001557FC03FF7FBFDFEFF80002FF7FBFDFF00005FEFF7FBFE0),
    .INIT_0D(256'h00000FF9FEFF0000001FF3FDFF0000003FE7FBFC0000007FCFF7FC000000FF9F),
    .INIT_0E(256'hBFCFF7FBFDFEFF7F80000553FFFF003FDFF0000003FE7FBFC0000007FCFF7FC0),
    .INIT_0F(256'hBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7F),
    .INIT_10(256'h7FBFDFE002AA00000000000000000000001FEFF7FBFDFEFF3FDFEFF7FBFDFE7F),
    .INIT_11(256'hFF3FFFEFF7FBFDFE7FBFFFEFF7FBFCFFFFBFDFEFF7F9FEFFFFBFDFEFF3FFFEFF),
    .INIT_12(256'hFFFFBFE00008020000007FFFF7FBFFFEFF7FBFCFFFFBFDFEFF7F9FEFFFFBFDFE),
    .INIT_13(256'hFF00005FEFFFFBFE0000BFFFEFF7FC00017FBFFFEFF80002FFFFBFDFF00005FE),
    .INIT_14(256'h02FFFFBFFFF000040000AA8020000BFFFEFF7FC00017FBFFFEFF80002FFFFBFD),
    .INIT_15(256'hFDFEFF80002FFFFBFFFF00005FEFF7FBFE0000BFFFEFFFFC00017FBFDFEFF800),
    .INIT_16(256'h0003FE7FBFE0000007FC00AA803FF00FFDFEFF7FBFE0000BFFFEFFFFC00017FB),
    .INIT_17(256'hF3FDFF0000003FE7FBFE0000007FCFF7FC000000FF9FEFF8000001FF3FDFF000),
    .INIT_18(256'hF7FBFDFEFF3FDFEFF7FBFDFE00003FFFFFFC00FF7FC000000FF9FEFF8000001F),
    .INIT_19(256'hEFF7F9FEFF7FBFDFEFF3FDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEF),
    .INIT_1A(256'hCFF807FDFEFF7F801FF800000000000000000000007FBFDFEFF7FBFCFF7FBFDF),
    .INIT_1B(256'h3FEFF7FBFCFF807FDFEFF7F9FF00FFBFDFEFF3FE01FF7FBFDFE7FC03FEFF7FBF),
    .INIT_1C(256'hC00017FC03FEFF80002008040001FFFFDFF00FFBFDFEFF3FE01FF7FBFDFE7FC0),
    .INIT_1D(256'hBFE01FF7FC00017FC03FEFF80002FF807FDFF00005FF00FFBFE0000BFE01FF7F),
    .INIT_1E(256'h007FE0000BFE0000FFC000100403FF0080002FF807FDFF00005FF00FFBFE0000),
    .INIT_1F(256'h00005FF00007FE0000BFE0000FFC00017FC0001FF80002FF80003FF00005FF00),
    .INIT_20(256'hFF7FC000000FF9FEFF8000001FF003FF00FFC03FF7FC0001FF80002FF80003FF),
    .INIT_21(256'h0000007FCFF7FC000000FF9FEFF8000001FF3FDFF0000003FE7FBFE0000007FC),
    .INIT_22(256'hFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F80000FFFFFFF003FDFF0000003FE7FBFE),
    .INIT_23(256'hFDFEFF7FBFDFE7FBFDFEFF7FBFCFF7FBFDFEFF7F9FEFF7FBFDFEFF3FDFEFF7FB),
    .INIT_24(256'h77777773BBBBBBBBBBBBB80000000000000000000000000001FEFF7FBFDFEFF3),
    .INIT_25(256'h77777778000F773BBBBBBC0007BB80000003FFFE000EEEEEEEEEEEEEE7777777),
    .INIT_26(256'hEEF1EEE77777777778F773BBBBBBBBBC7BB80000003FFE2000EEEEEEF0001EEE),
    .INIT_27(256'hEEEF1EEEEEEEEE77778F777777773BBBC7BBBBBBBB80003E00003E000EEEEEEE),
    .INIT_28(256'h0200000EEEF1EF01EEEEE77778F780F77773BBBC7BC07BBBB80002203FE00000),
    .INIT_29(256'h0003E3E3E00000EEEF01F01EEEEE777780F80F77773BBBC07C07BBBB800023E2),
    .INIT_2A(256'hBBBB83800003FFE000000EEEEF001EEEE0E77777800F777073BBBBC007BBB838),
    .INIT_2B(256'hBBBBFFBBBBB83800003E00000000EEEEEEEEEEEE0E777777777777073BBBBBBB),
    .INIT_2C(256'h7F77773BBBBFBBBFBBBB8000023FFE00000EEEEFFEEEEEE0E77777FF77777073),
    .INIT_2D(256'h77777777777773BBBBBBBBBBBBB800003FFFE00000EEEEFEEEFEEEEE77777F77),
    .INIT_2E(256'hEEEEEE7777777777777700000000000000000000000000000EEEEEEEEEEEEEE7),
    .INIT_2F(256'hEEEEEE0000EEE77777770000777000000000000001DDDDDDDDDDDDDCEEEEEEEE),
    .INIT_30(256'hDC1DDCEEEEEEEEEE0EEE77777777770777000000000000001DDDDDDC0001DDCE),
    .INIT_31(256'hDDC1DDDDDDDDCEEEE0EEEEEEEEE77770777777777000000000000001DDDDDDDD),
    .INIT_32(256'h000001DDDC1DC01DDDDCEEEE0EE00EEEEE77770770077777000000000000001D),
    .INIT_33(256'h0000000000001DDDC01C01DDDDCEEEE00E00EEEEE77770070077777000000000),
    .INIT_34(256'h77777000000000000001DDDDC001DDDDDCEEEEE000EEEEEE7777700077777700),
    .INIT_35(256'h777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE777777777),
    .INIT_36(256'hEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77),
    .INIT_37(256'hEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_38(256'hDDDDCEEEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEE),
    .INIT_39(256'hDDDDE0003DDCEEEEEEF0001EEE0000000FFFF8003BBBBBBBBBBBBB9DDDDDDDDD),
    .INIT_3A(256'hC7BB9DDDDDDDDDE3DDCEEEEEEEEEF1EEE0000000FFF88003BBBBBBC0007BB9DD),
    .INIT_3B(256'hBC7BBBBBBBB9DDDE3DDDDDDDDCEEEF1EEEEEEEEE0000F80000F8003BBBBBBBBB),
    .INIT_3C(256'h00003BBBC7BC07BBBB9DDDE3DE03DDDDCEEEF1EF01EEEEE0000880FF800003BB),
    .INIT_3D(256'h0F8F8F80FF83BBBC07C07BBBB9DDDE03E03DDDDCEEEF01F01EEEEE00008F8808),
    .INIT_3E(256'hF01E00000FFF8008083BBBBC007BBC079DDDDE003DDE03CEEEEF001EEF01E000),
    .INIT_3F(256'hEFFEEEEEEEE00000F80000FF83BBBBBBBBBBC079DDDDDDDDDDE03CEEEEEEEEEE),
    .INIT_40(256'hDDDCEEEEFEEEFEEEEE000008FFF800003BBBBFFBBBBBBB9DDDDFFDDDDDDDCEEE),
    .INIT_41(256'hDDDDDDDDDDCEEEEEEEEEEEEEE00000FFFF800003BBBBFBBBFBBBB9DDDDFDDDFD),
    .INIT_42(256'hBBB9DDDDDDDDDDDDDC00000000000000000000000000003BBBBBBBBBBBBB9DDD),
    .INIT_43(256'hBBBC0007BB9DDDDDDE0003DDC0000001FFFF000777777777777773BBBBBBBBBB),
    .INIT_44(256'hF773BBBBBBFBB87BB9DDDDDDFDDC3DDC0000001000100077777778000F773BBB),
    .INIT_45(256'h87777F77773BBBC3BBBFBBBB9DDDE1DDDFDDDDC0001FFFFFFF0007777777F770),
    .INIT_46(256'h000777787700F77773BBBC3B807BBBB9DDDE1DC03DDDDC000100001000007777),
    .INIT_47(256'h0000101FF0777780700F77773BBBC03807BBBB9DDDE01C03DDDDC00010000100),
    .INIT_48(256'h03C0001FFFFF010107777F0007F780F3BBBF8003FBC079DDDFC001FDE03C0001),
    .INIT_49(256'hFDDDFDDDDC00001FFFF01FF07777777777780F3BBBBBBBBBBC079DDDDDDDDDDE),
    .INIT_4A(256'hBB9DDDDFDDDFDDDDC0000100010000077777F777F77773BBBBFBBBFBBBB9DDDD),
    .INIT_4B(256'hBBBBBBBBB9DDDDDDDDDDDDDC00001FFFF0000077777F777F77773BBBBFBBBFBB),
    .INIT_4C(256'h0001C000003F00003F00FF80E00000000000000000000777777777777773BBBB),
    .INIT_4D(256'h3B8E6B9F9FBF7EDB3F1FC698F1F9E3CDB1E4F90C204000801840E03000000FFE),
    .INIT_4E(256'h7DBFD6BE7CDB7FBE66FB0D69F3EDB619E667B0D68306DB6180663B9C63366DB7),
    .INIT_4F(256'hDF9E3C7E6D9FC65B6DFBF7EFF6DBFE71B6C63366E76DB0E79B0D6B060C361B06),
    .INIT_50(256'h0F0807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C06000081808C0016DB6),
    .INIT_51(256'h37FFFFFFFB8DB6F6E37FFFFFFF9FDB6F67F7FFFFFFFCFDB6F63F7FFFFFFFE003),
    .INIT_52(256'hFFFFFDCD86F6637FFFFFFFCFDB6F63F7FFFFFFF9FDB6F67F7FFFFFFFB8DB6F6E),
    .INIT_53(256'hF8610000807FFFFFFFB2CFCFE3F7FFFFFFFBADFEFEFF7FFFFFFF98DCE06E37FF),
    .INIT_54(256'h0DBF663B9C638C0DF3E6B9F9F9FDFDE1E698F1F8FDFDCCE0C2040200001E0FFF),
    .INIT_55(256'h1B6C638C0DAD679B0D6B2D0DAD67DBFD6B6D7D8C66FB0D6B6D7D9E667B0D6B2D),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFF0C0600200003F06DB6DF8FDFDBF665B6DF9FDFDA167),
    .INIT_57(256'hFFB8C0C30B1806FF9FDFDFEB7EFEFFCFDFDFEB7EFEFFE00000080000FFFFFFFF),
    .INIT_58(256'hDB0318F6FFDCD0DB7B5B06FFCFD7DB7B5B7EFF9FD7DB7B5B7EFFB8D0DB7B5B06),
    .INIT_59(256'hFFFFFFE0000000000F8600180000F0FFB2DFDB7F7EF6FFBADFDB7F7EF6FF98C0),
    .INIT_5A(256'hA5D0924920A5D0924920A5D78E79E7A41000000027FFFFFFFFE7FFFFFFFFE7FF),
    .INIT_5B(256'hFFFFE5DFFFFFFFE5D000000025D78E7927A5D0924920A5D09248A0A5D39249E3),
    .INIT_5C(256'hC000000001C000000001C000000001C000000005DFFFFFFFE5DFFFFFFFE5DFFF),
    .INIT_5D(256'hA481C08890A881C388F0A881C08890A881C08890A481C7BE60A381C000000001),
    .INIT_5E(256'h000000000000000000000000000000000000000000000001C78897A381C08890),
    .INIT_5F(256'h81C78E79E7800000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h000001C78E792781C092492081C09248A081C39249E381C092492081C0924920),
    .INIT_61(256'hDFFFFFFFE5DFFFFFFFE1C000000001C000000001C000000001C000000001C000),
    .INIT_62(256'hA8A5D08890A8A5D08890A4A5D7BE60A3A5D000000025DFFFFFFFE5DFFFFFFFE5),
    .INIT_63(256'hFFFFFFE7FFFFFFFFE41000000025D78897A3A5D08890A4A5D08890A8A5D388F0),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000007FFFFFFFFE7FF),
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
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
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
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],DOADO}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\addra[15] ),
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
module overlay_mem_blk_mem_gen_prim_wrapper_init__parameterized1
   (\douta[3] ,
    clka,
    ena_array,
    addra);
  output [3:0]\douta[3] ;
  input clka;
  input [0:0]ena_array;
  input [11:0]addra;

  wire [11:0]addra;
  wire clka;
  wire [3:0]\douta[3] ;
  wire [0:0]ena_array;
  wire [15:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_01(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_02(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_03(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_04(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_05(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_06(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_07(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_08(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_09(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0A(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0B(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0C(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0D(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0E(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_0F(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_10(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_11(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_12(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_13(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_14(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_15(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_16(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_17(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_18(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_19(256'h4444444444444444444444444444444444444444444444444444444444444444),
    .INIT_1A(256'h0000000000000000000000000000000044444444444444444444444444444444),
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
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(4),
    .READ_WIDTH_B(4),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(4),
    .WRITE_WIDTH_B(4)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR({addra,1'b0,1'b0}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:4],\douta[3] }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
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
    .INIT_41(256'hFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000001FFF),
    .INIT_42(256'hFFFFFFFFFFFC0000000000000000000000000000000000000000001FFFFFFFFF),
    .INIT_43(256'hFFFFF80000000000000000000000000000000000000000003FFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87FFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FF07FFFFFFFFFFFFFFFFFFFFFFFFFF0),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007F8FFFFFFFFFFFFFFFFFFFFFFFFFFC1FFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8FC7F1FFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE3FC7E1FFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF8E1C7C3FFFFFFFFFFFFFFFFFFFFFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'hDBE787FFFFFFFFFFFFFFFFFFFFFFFFF8FFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFF1FFFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFE3FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CF0F),
    .INIT_4D(256'hFFFFFFFFFFFFC7FFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0F9E1FFFFFFF),
    .INIT_4E(256'hFFFFFF8FFF80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDF3C3FFFFFFFFFFFFF),
    .INIT_4F(256'h1FFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7DBE787FFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFB7CF0FFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF9F6F9E1FFFFFFFFFFFFFFFFFFFFFFFFFE3FFC21),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF3EDF3C3FFFFFFFFFFFFFFFFFFFFFFFFFC7FF041FFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE7DBE787FFFFFFFFFFFFFFFFFFFFFFFFF8FFE1C3FFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFCFB7CF0FFFFFFFFFFFFFFFFFFFFFFFFFF1FF87C3FFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hCF0F3E1FFFFFFFFFFFFFFFFFFFFFFFFFE3FE0F83FFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'h3FFFFFFFFFFFFFFFFFFFFFFFFFC7FC3F87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFF8FF0F787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7F8FC),
    .INIT_58(256'hFFFFFFFFFFFFFF1FC1EF07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003F87FFFFF),
    .INIT_59(256'hFFFFFFFE3F878F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FF0FFFFFFFFFFFF),
    .INIT_5A(256'hFC7E1E0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000000000000000000003FFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000000000000000000000000000FFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000001FFFFFFFFFF),
    .INIT_5E(256'h30DB7FFFFDBFB3FDB7FFFFDBFB1F987FFFFC3F8402000003FFFFFFFFFFFFFFFF),
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
    .INIT_58(256'hFFFE87F0030FC0021F80043F10887E1E10FC3C2008780000F000000100400210),
    .INIT_59(256'hF77FFFFEFDFFFEFDFBFBFBBFFFFF3FFFFF7FEFFFEEFFFFFDFBFFFDFBF7FBF77F),
    .INIT_5A(256'h7EFBFEEFFFFFCFFFFFDFEFFFFBBFFFFF70FFFF0EFDFBFDDFFFFF9FFFFFBFEFFF),
    .INIT_5B(256'hF007EFF7BEEFFFFFDDFBFDFBBF7BFF7007E007FFFFEFEFF07DDFFFFFBBF003F7),
    .INIT_5C(256'hF700FF7EEFDBFFDFFDFBFFFDFBFFEFF7DF700007EEFDFEFDDFBBFFBFFBF7F803),
    .INIT_5D(256'hFF7EFFFF7EFFEFF7F7DFFFFDFBFFFFBF77EBFFEFFEFDFFFEFDFFEFF7EFBFFFFB),
    .INIT_5E(256'h7DF7F8007EFDFFFE1DFFFFFBFFBF7FFFBF7FF7FDFBEFFFFEFDF8001FBBF3FFF7),
    .INIT_5F(256'hBF7FFFFEFFEFDFFFEFDFFF7FDEFBFDFFFF7EFFFF7EFFFFFDFFDFBFFFDFBFFDFF),
    .INIT_60(256'hFBF7FFF7FFFEFF7FFFDDF8001FBFFFFF7FF7EFFFF7EFFFDFF07DFEFFFFB87FFF),
    .INIT_61(256'h03F77EFFFFEFFFFFDFFDFBFFFDFBFFFDFFFF7FBFFFEEFDFFFFDFFFFFBFFBF7FF),
    .INIT_62(256'hF7FF7EFFFF7EFFFFDFFFDFFFFDFBBF7FFFF7FFF3EFFEFDFFFEFDFFFF7FFFBFC0),
    .INIT_63(256'hEFBDF7FFFF7EEFDFE01DFFF6FBFFBF7FFFBF7FFFEF03EFFFFEFDDFBFFFFBFFF5),
    .INIT_64(256'hFBF77FF7BEE00FC01FEFDFFFEFBEFBFFFFFF77EFF7EEFFF77DFFDFBFFFDFBFFF),
    .INIT_65(256'hF7FBF7FFEFBFBEFFFFFFDDF801FBBFF7DF77FFFFEFF7EFFFEFBF7DFFFFFFBBF7),
    .INIT_66(256'hFFFFF7EFFFF7EFF7F7DDFFFFFBFDFBFFEFBFDF7FFFFFEE1FFFE1DFF7EFBBFFFF),
    .INIT_67(256'hFC07000000FF7EFFEFBFF7DFFFFFFBF7FFFBF7F7FBEEFFFFFDFEFDFFEFBFEFBF),
    .INIT_68(256'hEFFBFFFB807FC07000000FC0000FF80003FF807FF03FF80E000001F80001F807),
    .INIT_69(256'h77FFFFEE1FFFE1C3FFF83F7F7F77FFFFEFDFFFEFFBFFFBBF7FBF77FFFFEFDFFF),
    .INIT_6A(256'hDFFFFF3F7BFF7007E00EFFFFFDDFFFFF3F7DFF77FFFFEEFFFFFDDFFFFF3F7EFF),
    .INIT_6B(256'hF7EFFEFEFDFDDFBFBF3F6FFF7FF7EFFEFE01FDDF803F3F77FF7FF7EFFEFFFFFD),
    .INIT_6C(256'hFFBF3FFFFF7FF7EFFEFEFDFDC03FBF3F3FFF7FF7EFFEFEFDFDDFBFBF3F5FFF7F),
    .INIT_6D(256'hEFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFF),
    .INIT_6E(256'hBF3FFFFF7FF7EFFEFEFDFDC03FBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7),
    .INIT_6F(256'hFEFE01FDDF803F3FFF5F7FF7EFFEFEFDFDDFBFBF3FFF9F7FF7EFFEFEFDFDDFBF),
    .INIT_70(256'h3FFBDF7007E00EFFFFFDDFFFFF3FFDDF7FF7EFFEFFFFFDDFFFFF3FFEDF7FF7EF),
    .INIT_71(256'hDFFFEFFBFFFBBFEFDF77FFFFEE1FFFE1C3FFF83FF7DF77FFFFEEFFFFFDDFFFFF),
    .INIT_72(256'h7FC07000000FC0000FF80003BFBFDF77FFFFEFDFFFEFFBFFFBBFDFDF77FFFFEF),
    .INIT_73(256'h1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F800000000000000000000000000000),
    .INIT_74(256'hFFC00000000000001F8007E3F1F8FC3F000FC7E3F1F87E001F8FC7E3F0FC003F),
    .INIT_75(256'h001F8FD1F804FC003F1FA06009F8007E3F4080100000000080002000000001FF),
    .INIT_76(256'h008C00200000000118004FC003F1FA34009F8007E3F46C013F000FC7E8FC027E),
    .INIT_77(256'h013F000007E8C0027E00000FD18004FC00001FA3000800000000460010000000),
    .INIT_78(256'h0000FFC63FF0000000008C0027E00000FD18004FC00001FA30009F800003F460),
    .INIT_79(256'hFCF17E1F8FCFFFF862FC3F1F9FFFF0C5F87E3F3FFFE18BF000007FFFC3100000),
    .INIT_7A(256'h000000007FFFF0000000FFFF802003F1F9FFFF005F87E3F3FFFE78BF0FC7E7FF),
    .INIT_7B(256'hF1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F8000000000000),
    .INIT_7C(256'h0000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3),
    .INIT_7D(256'hC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E0000000000000000000000),
    .INIT_7E(256'h0000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8F),
    .INIT_7F(256'h8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F000000000000000000),
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
   (\douta[1] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[1] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[1] ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
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
    .INIT_00(256'h00000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F),
    .INIT_01(256'h1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F80000000000000),
    .INIT_02(256'h000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F),
    .INIT_03(256'h3F1F9B27E3F1F87E3F344FC7E3F0FC7E6A9F8FC7E1F8FC813F1F8FC00001FE00),
    .INIT_04(256'h0000000000000000000000000003FC0000000FC7E6A9F8FC7E1F8FCD53F1F8FC),
    .INIT_05(256'hFC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E00000),
    .INIT_06(256'h000000000000000000000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8),
    .INIT_07(256'hF8FC7E3F0FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F800000000000000),
    .INIT_08(256'hFBFE000000001FFFFC00000000000001F8007E3F1F8FC3F000FC7E3F1F87E001),
    .INIT_09(256'hF000FC7EFFB667E001F8FDFF68CFC003F1FBFED59F8007E3F7FD03000000000F),
    .INIT_0A(256'h0007FDFF00000000080002000000001FF7FCFC003F1FBFED59F8007E3F7FDAB3),
    .INIT_0B(256'hEFF9F800003F7FDFF3F000007EFFBFE7E00000FDFF7FCFC00001FBFEFF800000),
    .INIT_0C(256'h0007FBFDFF0000001557FC03FF000000000FFBFE7E00000FDFF7FCFC00001FBF),
    .INIT_0D(256'hDFEFFBF0FC7E7FBFDFF7E1F8FDFF7FBFEFC3F1F9FEFF7FDF87E3F7FDFEFFBF00),
    .INIT_0E(256'h1F8000000000000000000553FFFF0000001FF7FBFE003F1F9FEFF7FDF87E3F7F),
    .INIT_0F(256'h1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F),
    .INIT_10(256'h0000000002AA0000000000000000000000000000000000001F8FC7E3F1F8FC3F),
    .INIT_11(256'h7E1FA007E3F1F8FC3F002FC7E3F1F87E801F8FC7E3F0FC00BF1F8FC7E0020000),
    .INIT_12(256'h0080003FEFF8020000007FFFF000020000000007E801F8FC7E3F0FC00BF1F8FC),
    .INIT_13(256'hFDFF6ACFC00BF1FBFED99FA007E3F7FDA33F002FC7EFFB567E801F8FDFF40C00),
    .INIT_14(256'hFE008000201FF7FC0000AA80200008020000007FDFF3F002FC7EFFB567E801F8),
    .INIT_15(256'h00007EFFBFE7E80002FDFF7FCFC00001FBFEFF9FA0000BF7FDFF3F000007EFFB),
    .INIT_16(256'hFBFEFC00003FEFF7FC0000AA803FF00FFC000000003FEFF9FA0000BF7FDFF3F0),
    .INIT_17(256'hE1F8FDFF7FBFEFC3F1FBFEFF7FDF87E3F7FDFEFFBF0FC7EFFBFDFF7E1F8FDFF7),
    .INIT_18(256'hE3F1F8FC7E0000000000000000003FFFFFFC0000007FDFEFF800FC7EFFBFDFF7),
    .INIT_19(256'hC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7),
    .INIT_1A(256'h800FFC00000000001FF80000000000000000000000000000000000007E3F1F8F),
    .INIT_1B(256'hEFC7E3F1F87EFFDF8FC7E3F0FDFFBF1F8FC7E1FBFF7E3F1F8FC3F7FEFC7E3F1F),
    .INIT_1C(256'h7FD03007FE0000FFBFE008040001FFFFC01FF8000000001FBFF7E3F1F8FC3F7F),
    .INIT_1D(256'h9FBFF7E3F7FDAB3F7FEFC7EFFB667EFFDF8FDFF68CFDFFBF1FBFED59FBFF7E3F),
    .INIT_1E(256'h7FDFBFEFF803FEFF807FDFF00403FF008000200FFC0001FF7FCFDFFBF1FBFED5),
    .INIT_1F(256'hFF7FCFDFF7FDFBFEFF9FBFEFFBF7FDFF3F7FDFF7EFFBFE7EFFBFEFDFF7FCFDFF),
    .INIT_20(256'h7E3F7FDFEFFBF00000FFBFDFF00003FF00FFC03FF007FDFF00FFBFE7EFFBFEFD),
    .INIT_21(256'hFEFF7FDF87E3F7FDFEFFBF0FC7EFFBFDFF7E1F8FDFF7FBFEFC3F1FBFEFF7FDF8),
    .INIT_22(256'hF8FC3F1F8FC7E3F1F8000000000000000000FFFFFFF0000001FF7FBFE003F1FB),
    .INIT_23(256'hF8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1),
    .INIT_24(256'h77777773BBBBBBBBBBBBB8000000000000000000000000000000000000000001),
    .INIT_25(256'h7F7F777F777F773FBFBBBFBBBFBB83FE0003FFFE000EEEEEEEEEEEEEE7777777),
    .INIT_26(256'hEEFFF1E7FF7777777FF8F3FFBBBBBBBFFC7823E0003FFE23E0FEFEEEFEEEFEEE),
    .INIT_27(256'hEEEFFEEEEEEEEE7777FF777777773BBBFFBBBBBBBB83E03E00003E3E0FFEEEEE),
    .INIT_28(256'h0200000EEEFFEFEFEEEEE7777FF7F7F77773BBBFFBFBFBBBB80002203FE00000),
    .INIT_29(256'h3E03E3E3E003E11EEFEFFEFEEEEE8F77F7FF7F777747BBFBFFBFBBBBBE0023E2),
    .INIT_2A(256'hBBBBFFBFE003FFE00022101EEFEEFEEEFFE80F77F77F777FF407BBFBBFBBBFFA),
    .INIT_2B(256'hBC7BC7BBBBBFF803E03E00000220EEEEEEEEEEEFFE777777777777FF3BBBBBBB),
    .INIT_2C(256'h0F77773BC7BC0007BBBB8022023FFE003E0EF1EF1EEEEEFFE778F78F77777FF3),
    .INIT_2D(256'h77777777777773BBBBBBBBBBBBB803E03FFFE00000EF1EF0001EEEEE778F7800),
    .INIT_2E(256'hEEEEEE7777777777777700000000000000000000000000000EEEEEEEEEEEEEE7),
    .INIT_2F(256'hEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEE),
    .INIT_30(256'hDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCE),
    .INIT_31(256'hDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDD),
    .INIT_32(256'h000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001D),
    .INIT_33(256'h0000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000),
    .INIT_34(256'h77777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7777777777777700),
    .INIT_35(256'h777077777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE777777777),
    .INIT_36(256'hEEEEE77777000077777000000000000001DDDDC1DDDDDDDCEEEEE0EEEEEEEE77),
    .INIT_37(256'hEEEEEEEEEEEE77777777777777000000000000001DDDDC0001DDDDCEEEEE0000),
    .INIT_38(256'hDDDDCEEEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEE),
    .INIT_39(256'hDDDDFDDDFDDCEEEEEEFEEEFEEE0000000FFFF8003BBBBBBBBBBBBB9DDDDDDDDD),
    .INIT_3A(256'hFFBB9DDDDDDDDDFFDDCEEEEEEEEEFFEEE0000000FFF88003BBBBBBFBBBFBB9DD),
    .INIT_3B(256'hBFFBBBBBBBB9DDDFFDDDDDDDDCEEEFFEEEEEEEEE0000F80000F8003BBBBBBBBB),
    .INIT_3C(256'h00003BBBFFBFBFBBBB9DDDFFDFDFDDDDCEEEFFEFEFEEEEE0000880FF800003BB),
    .INIT_3D(256'h0F8F8F80FF83BBBFBFFBFBBBB9DDDFDFFDFDDDDCEEEFEFFEFEEEEE00008F8808),
    .INIT_3E(256'hFEFE00000FFF8008083BBBBFBBFBBFBF9DDDDFDDFDDFDFCEEEEFEEFEEFEFE000),
    .INIT_3F(256'hEF1EEEEEEEE00000F80000FF83BBBBBBBBBBFBF9DDDDDDDDDDFDFCEEEEEEEEEE),
    .INIT_40(256'hDDDCEEEEF0001EEEEE000008FFF800003BBBBC7BBBBBBB9DDDDE3DDDDDDDCEEE),
    .INIT_41(256'hDDDDDDDDDDCEEEEEEEEEEEEEE00000FFFF800003BBBBC0007BBBB9DDDDE0003D),
    .INIT_42(256'hBBB9DDDDDDDDDDDDDC00000000000000000000000000003BBBBBBBBBBBBB9DDD),
    .INIT_43(256'hBBBFBBBFBB9DDDDDDFDDDFDDC0000001FFFF000777777777777773BBBBBBBBBB),
    .INIT_44(256'hF773BBBBBBFBBBFBB9DDDDDDFDDDFDDC000000100010007777777F777F773BBB),
    .INIT_45(256'hF7777F77773BBBFBBBBFBBBB9DDDFDDDDFDDDDC0001FFFFFFF0007777777F777),
    .INIT_46(256'h0007777F7777F77773BBBFBBBBFBBBB9DDDFDDDDFDDDDC000100001000007777),
    .INIT_47(256'h0000101FF07777F7777F77773BBBFBBBBFBBBB9DDDFDDDDFDDDDC00010000100),
    .INIT_48(256'hDFC0001FFFFF010107777F7777F7F7F3BBBFBBBBFBFBF9DDDFDDDDFDFDFC0001),
    .INIT_49(256'hE1DDFDDDDC00001FFFF01FF077777777777F7F3BBBBBBBBBBFBF9DDDDDDDDDDF),
    .INIT_4A(256'hBB9DDDDE0003DDDDC00001000100000777778777F77773BBBBC3BBFBBBB9DDDD),
    .INIT_4B(256'hBBBBBBBBB9DDDDDDDDDDDDDC00001FFFF00000777778000F77773BBBBC0007BB),
    .INIT_4C(256'h0001C000003F00003F00FF80E00000000000000000000777777777777773BBBB),
    .INIT_4D(256'h000008000000001800000080000000018004010C204000801840E03000000FFE),
    .INIT_4E(256'h0000108000180000000001080001800000000010800018000000000000000180),
    .INIT_4F(256'h000000000C0000406000000000C0000006000000240C00000001080000000000),
    .INIT_50(256'h0F0807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C06000081808C0010C06),
    .INIT_51(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFFC0030F0007FFFFFFFE003),
    .INIT_52(256'hFFFFFC0000F0007FFFFFFFC0030F0007FFFFFFF80030F0007FFFFFFF80030F00),
    .INIT_53(256'hF8610000807FFFFFFF8200000007FFFFFFF8200000007FFFFFFF8004800007FF),
    .INIT_54(256'h000000000000000000008000000000000080000000000C00C2040200001E0FFF),
    .INIT_55(256'h0060000000210000010821002100000108610000000001086100000000010821),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFF0C0600200003F00C0600000003F0040600000002100),
    .INIT_57(256'hFF800000080000FF800000080000FFC00000080000FFE00000080000FFFFFFFF),
    .INIT_58(256'h180000F0FFC01018784300FFC01018784300FF801018784300FF801018784300),
    .INIT_59(256'hFFFFFFFFFFFFFFFFFF8600180000F0FF8200180000F0FF8200180000F0FF8000),
    .INIT_5A(256'hBDD0924920BDD0924920BDD78E79E7BC100000003FFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFDDFFFFFFFFDD00000003DD78E7927BDD0924920BDD09248A0BDD39249E3),
    .INIT_5C(256'h1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFF),
    .INIT_5D(256'h003C100000003C100000003C100000003C100000003C100000003C100000003C),
    .INIT_5E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC100000003C100000003C100000),
    .INIT_5F(256'h3C100000003C100000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_60(256'h00003C100000003C100000003C100000003C100000003C100000003C10000000),
    .INIT_61(256'hDFFFFFFFFDDFFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1000),
    .INIT_62(256'hA8BDD08890A8BDD08890A4BDD7BE60A3BDD00000003DDFFFFFFFFDDFFFFFFFFD),
    .INIT_63(256'hFFFFFFFFFFFFFFFFFC100000003DD78897A3BDD08890A4BDD08890A8BDD388F0),
    .INIT_64(256'h00000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFF),
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
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
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
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\douta[1] }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\addra[15] ),
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
    .INIT_42(256'hFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFF),
    .INIT_43(256'hFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFFFFFFFFFFF),
    .INIT_44(256'h0000000000000000000000000000000000000000067FFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'h00000000000000000000000000000000000F7FFFFFFFFFFFFFFFFFFFFFFFFFF3),
    .INIT_46(256'h000000000000000000000000000006FFFFFFFFFFFFFFFFFFFFFFFFFFDE000000),
    .INIT_47(256'h0000000000000000000FC00DFFFFFFFFFFFFFFFFFFFFFFFFFFB0000000000000),
    .INIT_48(256'h0000000000003FC01DFFFFFFFFFFFFFFFFFFFFFFFFFF60000000000000000000),
    .INIT_49(256'h000000E1C03BFFFFFFFFFFFFFFFFFFFFFFFFFDC0000000000000000000000000),
    .INIT_4A(256'hDBE077FFFFFFFFFFFFFFFFFFFFFFFFFB00000000000000000000000000000000),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFF600000000000000000000000000000000000007),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFEC0000000000000000000000000000000000000FB7C0EF),
    .INIT_4D(256'hFFFFFFFFFFFFD80000000000000000000000000000000000001F0F81DFFFFFFF),
    .INIT_4E(256'hFFFFFFB00000000000000000000000000000000000003EDF03BFFFFFFFFFFFFF),
    .INIT_4F(256'h600000000000000000000000000000000000007DBE077FFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'h00000000000000000000000000000000FB7C0EFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'h00000000000000000000000001F6F81DFFFFFFFFFFFFFFFFFFFFFFFFFEC00000),
    .INIT_52(256'h00000000000000000003EDF03BFFFFFFFFFFFFFFFFFFFFFFFFFD800000000000),
    .INIT_53(256'h00000000000007DBE077FFFFFFFFFFFFFFFFFFFFFFFFFB000000000000000000),
    .INIT_54(256'h0000000FB7C0EFFFFFFFFFFFFFFFFFFFFFFFFFF6000000000000000000000000),
    .INIT_55(256'h0F0F01DFFFFFFFFFFFFFFFFFFFFFFFFFEC000000000000000000000000000000),
    .INIT_56(256'hBFFFFFFFFFFFFFFFFFFFFFFFFFD8000000000000000000000000000000000000),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFFB000000000000000000000000000000000000007F803),
    .INIT_58(256'hFFFFFFFFFFFFFF600000000000000000000000000000000000000000077FFFFF),
    .INIT_59(256'hFFFFFFFEC000000000000000000000000000000000000000000EFFFFFFFFFFFF),
    .INIT_5A(256'hFD8000000000000000000000000000000000000000001DFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'h000000000000000000000000000000000000003800000000000000000000FFFF),
    .INIT_5C(256'h000000000000000000000000000000007FFFFFFFFFFFFFFFFFFFFF8000030000),
    .INIT_5D(256'h00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFBFFFFFE0000000000),
    .INIT_5E(256'h00187FFFFC3F800187FFFFC3F800187FFFFC3F8403FFFFFC0000000000000000),
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
    .INIT_59(256'h07000000FC0000FC03F8038000000000007FE0000E000001F80001F807F80700),
    .INIT_5A(256'h00F800E000000000001FE000038000007000000E01F801C000000000003FE000),
    .INIT_5B(256'h0007E00780E000001C03FC038078007000000000000FE00001C0000038000007),
    .INIT_5C(256'h0700FF00E018001FFC03FFFC03FFE007C07000000E01FE01C038003FF807F800),
    .INIT_5D(256'hFF00FFFF00FFE007F01FFFFC03FFFF807008000FFE01FFFE01FFE007E03FFFF8),
    .INIT_5E(256'h7C07F80000FC00001C000003FF807FFF807FF001F80FFFFE01F8000038000007),
    .INIT_5F(256'h3F000000FFE01FFFE01FFF001E03FC00007E00007E000001FFC03FFFC03FFC00),
    .INIT_60(256'hF807FFF00000FF00001C00001F8000007FF00FFFF00FFFC00001FE0000380000),
    .INIT_61(256'h000700FFFFE000001FFC03FFFC03FFFC00007F80000E01FFFFC000003FF807FF),
    .INIT_62(256'h07FF00FFFF00FFFFC0001FFFFC03807FFFF000000FFE01FFFE01FFFF00003FC0),
    .INIT_63(256'hE03C07FFFF00E01FE01C000603FF807FFF807FFFE0000FFFFE01C03FFFF80004),
    .INIT_64(256'hF807000780E000001FE01FFFE03E03FFFFC0700FF00E000701FFC03FFFC03FFF),
    .INIT_65(256'h07F807FFE03F80F000001C0000038007C07000000FF00FFFE03F01E000003807),
    .INIT_66(256'h000007E00007E007F01C000003FC03FFE03FC07800000E000001C007E0380000),
    .INIT_67(256'hFC07000000FF00FFE03FF01E000003F00003F007F80E000001FE01FFE03FE03C),
    .INIT_68(256'h0FF80003807FC07000000FC0000FF80003FF807FF03FF80E000001F80001F807),
    .INIT_69(256'h7000000E000001C00000007F007000000FC0000FF80003807F807000000FC000),
    .INIT_6A(256'hC000000078007000000E000001C00000007C007000000E000001C00000007E00),
    .INIT_6B(256'hF00FFE00FC01C03F800060007FF00FFE000001C000000070007FF00FFE000001),
    .INIT_6C(256'hFF800000007FF00FFE00FC01C03F800000007FF00FFE00FC01C03F800040007F),
    .INIT_6D(256'h0FFE00FC01FFFF800000007FF00FFE00FC01FFFF800000007FF00FFE00FC01FF),
    .INIT_6E(256'h800000007FF00FFE00FC01C03F800000007FF00FFE00FC01FFFF800000007FF0),
    .INIT_6F(256'hFE000001C000000000407FF00FFE00FC01C03F800000007FF00FFE00FC01C03F),
    .INIT_70(256'h0003C07000000E000001C000000001C07FF00FFE000001C000000000C07FF00F),
    .INIT_71(256'hC0000FF80003800FC07000000E000001C000000007C07000000E000001C00000),
    .INIT_72(256'h7FC07000000FC0000FF80003803FC07000000FC0000FF80003801FC07000000F),
    .INIT_73(256'h1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F8007F8000000000000000000000000),
    .INIT_74(256'hFFC00FF0000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F),
    .INIT_75(256'h7F9F8FD1F804FCFF3F1FA06009F9FE7E3F40801003FC000080002000000001FF),
    .INIT_76(256'h008C002007F8000118004FCFF3F1FA34009F9FE7E3F46C013F3FCFC7E8FC027E),
    .INIT_77(256'h013F3FDFE7E8C0027E7FBFCFD18004FCFF7F9FA3000801FEFF00460010000000),
    .INIT_78(256'h0000FFC63FF003FDFE008C0027E7FBFCFD18004FCFF7F9FA30009F9FEFF3F460),
    .INIT_79(256'hFCF17E1F8FCFFFF862FC3F1F9FFFF0C5F87E3F3FFFE18BF000007FFFC3100000),
    .INIT_7A(256'h000000007FFFF0000000FFFF802003F1F9FFFF005F87E3F3FFFE78BF0FC7E7FF),
    .INIT_7B(256'hF1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F8000000000000),
    .INIT_7C(256'h0000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3),
    .INIT_7D(256'hC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E0000000000000000000000),
    .INIT_7E(256'h0000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8F),
    .INIT_7F(256'h8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F000000000000000000),
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
   (\douta[2] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[2] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[2] ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
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
    .INIT_00(256'h00000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F),
    .INIT_01(256'h1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F80000000000000),
    .INIT_02(256'h000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F),
    .INIT_03(256'h3F1F9B27E3F1F87E3F344FC7E3F0FC7E6A9F8FC7E1F8FC813F1F8FC00001FE00),
    .INIT_04(256'h0000000000000000000000000003FC0000000FC7E6A9F8FC7E1F8FCD53F1F8FC),
    .INIT_05(256'hFC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E00000),
    .INIT_06(256'h000000000000000000000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8),
    .INIT_07(256'hF8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F8007F8000000000),
    .INIT_08(256'hFBFC0000000000000000FF0000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9),
    .INIT_09(256'hF3FCFC7E7FB647E7F9F8FCFF688FCFF3F1F9FED51F9FE7E3F3FD02003FC00007),
    .INIT_0A(256'hF003FDFE00000000000000007F80000FF7F8FCFF3F1F9FED51F9FE7E3F3FDAA3),
    .INIT_0B(256'hEFF1F9FEFF3F3FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF001FEF),
    .INIT_0C(256'h0007FBFDFE0000000000000000003FDFE007FBFC7E7FBFCFCFF7F8FCFF7F9F9F),
    .INIT_0D(256'hDFEFF3F0FC7E7FBFDFE7E1F8FCFF7FBFCFC3F1F9FEFF7F9F87E3F3FDFEFF3F00),
    .INIT_0E(256'h1F800000000000000000000000000000000FF7FBFC003F1F9FEFF7F9F87E3F3F),
    .INIT_0F(256'h1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F),
    .INIT_10(256'h0000000000000000000000000000000000000000000000001F8FC7E3F1F8FC3F),
    .INIT_11(256'h7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E001FE00),
    .INIT_12(256'hFF00001FEFF00000000000000003FC0000000007E7F9F8FC7E3F0FCFF3F1F8FC),
    .INIT_13(256'hFCFF6A8FCFF3F1F9FED91F9FE7E3F3FDA23F3FCFC7E7FB547E7F9F8FCFF40800),
    .INIT_14(256'hFC007FBFC00FF7F80000000000000001FE00003FDFE3F3FCFC7E7FB547E7F9F8),
    .INIT_15(256'hFDFE7E7FBFC7E7FBFCFCFF7F8FCFF7F9F9FEFF1F9FEFF3F3FDFE3F3FDFE7E7FB),
    .INIT_16(256'hFBFCFC00001FEFF7F8000000000000000000FF7F801FEFF1F9FEFF3F3FDFE3F3),
    .INIT_17(256'hE1F8FCFF7FBFCFC3F1F9FEFF7F9F87E3F3FDFEFF3F0FC7E7FBFDFE7E1F8FCFF7),
    .INIT_18(256'hE3F1F8FC7E000000000000000000000000000000003FDFEFF000FC7E7FBFDFE7),
    .INIT_19(256'hC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7),
    .INIT_1A(256'h8007F8000000000000000000000000000000000000000000000000007E3F1F8F),
    .INIT_1B(256'hCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F),
    .INIT_1C(256'h3FD02003FC00007FBFC0000000000000000FF0000000001F9FE7E3F1F8FC3F3F),
    .INIT_1D(256'h1F9FE7E3F3FDAA3F3FCFC7E7FB647E7F9F8FCFF688FCFF3F1F9FED51F9FE7E3F),
    .INIT_1E(256'h7F9F9FEFF001FEFF003FDFE00000000000000007F80000FF7F8FCFF3F1F9FED5),
    .INIT_1F(256'hFF7F8FCFF7F9F9FEFF1F9FEFF3F3FDFE3F3FDFE7E7FBFC7E7FBFCFCFF7F8FCFF),
    .INIT_20(256'h7E3F3FDFEFF3F000007FBFDFE0000000000000000003FDFE007FBFC7E7FBFCFC),
    .INIT_21(256'hFEFF7F9F87E3F3FDFEFF3F0FC7E7FBFDFE7E1F8FCFF7FBFCFC3F1F9FEFF7F9F8),
    .INIT_22(256'hF8FC3F1F8FC7E3F1F800000000000000000000000000000000FF7FBFC003F1F9),
    .INIT_23(256'hF8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1),
    .INIT_24(256'h77777773BBBBBBBBBBBBB8000000000000000000000000000000000000000001),
    .INIT_25(256'h700777700007773803BBB80003BB800000000000000EEEEEEEEEEEEEE7777777),
    .INIT_26(256'hEEE0EEE70777777770777383BBBBBBB83BB800000000000000E00EEEE0000EEE),
    .INIT_27(256'hEEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000E0EEEEE),
    .INIT_28(256'h0000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000),
    .INIT_29(256'h00000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB80000000),
    .INIT_2A(256'hBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBBBBBBBB8),
    .INIT_2B(256'hBBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBB),
    .INIT_2C(256'h7777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773),
    .INIT_2D(256'h77777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE77777777),
    .INIT_2E(256'hEEEEEE7777777777777700000000000000000000000000000EEEEEEEEEEEEEE7),
    .INIT_2F(256'hEEEEEE0000EEE77777770000777000000000000001DDDDDDDDDDDDDCEEEEEEEE),
    .INIT_30(256'hDC1DDCEEEEEEEEEE0EEE77777777770777000000000000001DDDDDDC0001DDCE),
    .INIT_31(256'hDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDD),
    .INIT_32(256'h000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001D),
    .INIT_33(256'h0000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77777777777777000000000),
    .INIT_34(256'h77777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE7777777777777700),
    .INIT_35(256'h777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE777777777),
    .INIT_36(256'hEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE77),
    .INIT_37(256'hEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEEE),
    .INIT_38(256'hDDDDCEEEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEE),
    .INIT_39(256'hDDDDC0001DDCEEEEEEE0000EEE000000000000003BBBBBBBBBBBBB9DDDDDDDDD),
    .INIT_3A(256'h83BB9DDDDDDDDDC1DDCEEEEEEEEEE0EEE000000000000003BBBBBB80003BB9DD),
    .INIT_3B(256'hBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBB),
    .INIT_3C(256'h00003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BB),
    .INIT_3D(256'h000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE0000000000),
    .INIT_3E(256'hEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000),
    .INIT_3F(256'hEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEE),
    .INIT_40(256'hDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEE),
    .INIT_41(256'hDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDD),
    .INIT_42(256'hBBB9DDDDDDDDDDDDDC00000000000000000000000000003BBBBBBBBBBBBB9DDD),
    .INIT_43(256'hBBB80003BB9DDDDDDC0001DDC00000000000000777777777777773BBBBBBBBBB),
    .INIT_44(256'h7773BBBBBBBBB83BB9DDDDDDDDDC1DDC00000000000000777777700007773BBB),
    .INIT_45(256'h77777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC0000000000000077777777770),
    .INIT_46(256'h000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC000000000000007777),
    .INIT_47(256'h0000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC00000000000),
    .INIT_48(256'hDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDDDDC0000),
    .INIT_49(256'hDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDD),
    .INIT_4A(256'hBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDD),
    .INIT_4B(256'hBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBBB),
    .INIT_4C(256'h0001C000003F00003F00FF80E00000000000000000000777777777777773BBBB),
    .INIT_4D(256'h000008000000001800000080000000018004010C204000801840E03000000FFE),
    .INIT_4E(256'h0000108000180000000001080001800000000010800018000000000000000180),
    .INIT_4F(256'h000000000C0000406000000000C0000006000000240C00000001080000000000),
    .INIT_50(256'h0F0807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C06000081808C0010C06),
    .INIT_51(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFFC0030F0007FFFFFFFE003),
    .INIT_52(256'hFFFFFC0000F0007FFFFFFFC0030F0007FFFFFFF80030F0007FFFFFFF80030F00),
    .INIT_53(256'hF8610000807FFFFFFF8200000007FFFFFFF8200000007FFFFFFF8004800007FF),
    .INIT_54(256'h000000000000000000008000000000000080000000000C00C2040200001E0FFF),
    .INIT_55(256'h0060000000210000010821002100000108610000000001086100000000010821),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFF0C0600200003F00C0600000003F0040600000002100),
    .INIT_57(256'hFF800000080000FF800000080000FFC00000080000FFE00000080000FFFFFFFF),
    .INIT_58(256'h180000F0FFC01018784300FFC01018784300FF801018784300FF801018784300),
    .INIT_59(256'hFFFFFFFFFFFFFFFFFF8600180000F0FF8200180000F0FF8200180000F0FF8000),
    .INIT_5A(256'hBDD0924920BDD0924920BDD78E79E7BC100000003FFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFDDFFFFFFFFDD00000003DD78E7927BDD0924920BDD09248A0BDD39249E3),
    .INIT_5C(256'h1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFDDFFFFFFFFDDFFFFFFFFDDFFF),
    .INIT_5D(256'h003C100000003C100000003C100000003C100000003C100000003C100000003C),
    .INIT_5E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC100000003C100000003C100000),
    .INIT_5F(256'h3C100000003C100000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_60(256'h00003C100000003C100000003C100000003C100000003C100000003C10000000),
    .INIT_61(256'hDFFFFFFFFDDFFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1FFFFFFFFC1000),
    .INIT_62(256'hA8BDD08890A8BDD08890A4BDD7BE60A3BDD00000003DDFFFFFFFFDDFFFFFFFFD),
    .INIT_63(256'hFFFFFFFFFFFFFFFFFC100000003DD78897A3BDD08890A4BDD08890A8BDD388F0),
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
    .RAM_EXTENSION_A("NONE"),
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
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
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
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\douta[2] }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\addra[15] ),
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
    .INIT_41(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_42(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_43(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_44(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_45(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_46(256'hFFFFFFFFFFFFFFFFFFFFFFFFE007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_47(256'hFFFFFFFFFFFFFFFFFF8007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_48(256'hFFFFFFFFFFFE0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_49(256'hFFFFF80007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4A(256'h0007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_4B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0),
    .INIT_4C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000FFF),
    .INIT_4D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80001FFFFFFFFF),
    .INIT_4E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003FFFFFFFFFFFFFFF),
    .INIT_4F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE00007FFFFFFFFFFFFFFFFFFFFF),
    .INIT_50(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_51(256'hFFFFFFFFFFFFFFFFFFFFFFFFF80001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_52(256'hFFFFFFFFFFFFFFFFFFF00003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_53(256'hFFFFFFFFFFFFE00007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_54(256'hFFFFFFC0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_55(256'hC0003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_57(256'hFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC000FF),
    .INIT_58(256'hFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFFFFFF),
    .INIT_59(256'hFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFFFFFFFFFFFFFF),
    .INIT_5A(256'hFFFFFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_5E(256'h00187FFFFC3F800187FFFFC3F800187FFFFC3F8403FFFFFFFFFFFFFFFFFFFFFF),
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
    .INIT_58(256'hFFFE87F0030FC0021F80043F10887E1E10FC3C2008780000F000000100400210),
    .INIT_59(256'hF77FFFFEFDFFFEFDFBFBFBBFFFFF3FFFFF7FEFFFEEFFFFFDFBFFFDFBF7FBF77F),
    .INIT_5A(256'h7EFBFEEFFFFFCFFFFFDFEFFFFBBFFFFF70FFFF0EFDFBFDDFFFFF9FFFFFBFEFFF),
    .INIT_5B(256'hF007EFF7BEEFFFFFDDFBFDFBBF7BFF7007E007FFFFEFEFF07DDFFFFFBBF003F7),
    .INIT_5C(256'hF700FF7EEFDBFFDFFDFBFFFDFBFFEFF7DF700007EEFDFEFDDFBBFFBFFBF7F803),
    .INIT_5D(256'hFF7EFFFF7EFFEFF7F7DFFFFDFBFFFFBF77EBFFEFFEFDFFFEFDFFEFF7EFBFFFFB),
    .INIT_5E(256'h7DF7F8007EFDFFFE1DFFFFFBFFBF7FFFBF7FF7FDFBEFFFFEFDF8001FBBF3FFF7),
    .INIT_5F(256'hBF7FFFFEFFEFDFFFEFDFFF7FDEFBFDFFFF7EFFFF7EFFFFFDFFDFBFFFDFBFFDFF),
    .INIT_60(256'hFBF7FFF7FFFEFF7FFFDDF8001FBFFFFF7FF7EFFFF7EFFFDFF07DFEFFFFB87FFF),
    .INIT_61(256'h03F77EFFFFEFFFFFDFFDFBFFFDFBFFFDFFFF7FBFFFEEFDFFFFDFFFFFBFFBF7FF),
    .INIT_62(256'hF7FF7EFFFF7EFFFFDFFFDFFFFDFBBF7FFFF7FFF3EFFEFDFFFEFDFFFF7FFFBFC0),
    .INIT_63(256'hEFBDF7FFFF7EEFDFE01DFFF6FBFFBF7FFFBF7FFFEF03EFFFFEFDDFBFFFFBFFF5),
    .INIT_64(256'hFBF77FF7BEE00FC01FEFDFFFEFBEFBFFFFFF77EFF7EEFFF77DFFDFBFFFDFBFFF),
    .INIT_65(256'hF7FBF7FFEFBFBEFFFFFFDDF801FBBFF7DF77FFFFEFF7EFFFEFBF7DFFFFFFBBF7),
    .INIT_66(256'hFFFFF7EFFFF7EFF7F7DDFFFFFBFDFBFFEFBFDF7FFFFFEE1FFFE1DFF7EFBBFFFF),
    .INIT_67(256'hFC07000000FF7EFFEFBFF7DFFFFFFBF7FFFBF7F7FBEEFFFFFDFEFDFFEFBFEFBF),
    .INIT_68(256'hEFFBFFFB807FC07000000FC0000FF80003FF807FF03FF80E000001F80001F807),
    .INIT_69(256'h77FFFFEE1FFFE1C3FFF83F7F7F77FFFFEFDFFFEFFBFFFBBF7FBF77FFFFEFDFFF),
    .INIT_6A(256'hDFFFFF3F7BFF7007E00EFFFFFDDFFFFF3F7DFF77FFFFEEFFFFFDDFFFFF3F7EFF),
    .INIT_6B(256'hF7EFFEFEFDFDDFBFBF3F6FFF7FF7EFFEFE01FDDF803F3F77FF7FF7EFFEFFFFFD),
    .INIT_6C(256'hFFBF3FFFFF7FF7EFFEFEFDFDC03FBF3F3FFF7FF7EFFEFEFDFDDFBFBF3F5FFF7F),
    .INIT_6D(256'hEFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7EFFEFEFDFDFF),
    .INIT_6E(256'hBF3FFFFF7FF7EFFEFEFDFDC03FBF3FFFFF7FF7EFFEFEFDFDFFFFBF3FFFFF7FF7),
    .INIT_6F(256'hFEFE01FDDF803F3FFF5F7FF7EFFEFEFDFDDFBFBF3FFF9F7FF7EFFEFEFDFDDFBF),
    .INIT_70(256'h3FFBDF7007E00EFFFFFDDFFFFF3FFDDF7FF7EFFEFFFFFDDFFFFF3FFEDF7FF7EF),
    .INIT_71(256'hDFFFEFFBFFFBBFEFDF77FFFFEE1FFFE1C3FFF83FF7DF77FFFFEEFFFFFDDFFFFF),
    .INIT_72(256'h7FC07000000FC0000FF80003BFBFDF77FFFFEFDFFFEFFBFFFBBFDFDF77FFFFEF),
    .INIT_73(256'h1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F8007F8000000000000000000000000),
    .INIT_74(256'h00000FF0000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F),
    .INIT_75(256'h7F9F8FC00000FCFF3F1F800001F9FE7E3F00000003FC00000000000000000000),
    .INIT_76(256'h0000000007F8000000000FCFF3F1F800001F9FE7E3F000003F3FCFC7E000007E),
    .INIT_77(256'h003F3FDFE7E000007E7FBFCFC00000FCFF7F9F80000001FEFF00000000000000),
    .INIT_78(256'h00000000000003FDFE00000007E7FBFCFC00000FCFF7F9F800001F9FEFF3F000),
    .INIT_79(256'hD8007E1F8FCFF3B000FC3F1F9FE76001F87E3F3FCFC003F000007F8000000000),
    .INIT_7A(256'h00000000000000000000FF00000003F1F9FE7E001F87E3F3FCCC003F0FC7E7F9),
    .INIT_7B(256'hF1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F8000000000000),
    .INIT_7C(256'h0000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3),
    .INIT_7D(256'hC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E0000000000000000000000),
    .INIT_7E(256'h0000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8F),
    .INIT_7F(256'h8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F000000000000000000),
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
   (\douta[3] ,
    clka,
    \addra[15] ,
    addra);
  output [0:0]\douta[3] ;
  input clka;
  input \addra[15] ;
  input [14:0]addra;

  wire [14:0]addra;
  wire \addra[15] ;
  wire clka;
  wire [0:0]\douta[3] ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
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
    .INIT_00(256'h00000000000000000000000000003F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F),
    .INIT_01(256'h1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F80000000000000),
    .INIT_02(256'h000000000000000000000000000000001F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F),
    .INIT_03(256'h3F1F9B27E3F1F87E3F344FC7E3F0FC7E6A9F8FC7E1F8FC813F1F8FC00001FE00),
    .INIT_04(256'h0000000000000000000000000003FC0000000FC7E6A9F8FC7E1F8FCD53F1F8FC),
    .INIT_05(256'hFC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E00000),
    .INIT_06(256'h000000000000000000000000000000000000000007E3F1F8FC7E3F0FC7E3F1F8),
    .INIT_07(256'hF8FC7E3F0FCFF3F1F8FC7E1F9FE7E3F1F8FC3F3FCFC7E3F1F8007F8000000000),
    .INIT_08(256'h00000000000000000000FF0000000001F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9),
    .INIT_09(256'hF3FCFC7E000007E7F9F8FC00000FCFF3F1F800001F9FE7E3F00000003FC00000),
    .INIT_0A(256'hF000000000000000000000007F8000000000FCFF3F1F800001F9FE7E3F000003),
    .INIT_0B(256'h0001F9FEFF3F000003F3FDFE7E000007E7FBFCFC00000FCFF7F9F80000001FEF),
    .INIT_0C(256'h0007F800000000000000000000003FDFE00000007E7FBFCFC00000FCFF7F9F80),
    .INIT_0D(256'hC00003F0FC7E7F800007E1F8FCFF00000FC3F1F9FE00001F87E3F3FC00003F00),
    .INIT_0E(256'h1F800000000000000000000000000000000FF00000003F1F9FE00001F87E3F3F),
    .INIT_0F(256'h1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F),
    .INIT_10(256'h0000000000000000000000000000000000000000000000001F8FC7E3F1F8FC3F),
    .INIT_11(256'h7E1F9FE7E3F1F8FC3F3FCFC7E3F1F87E7F9F8FC7E3F0FCFF3F1F8FC7E001FE00),
    .INIT_12(256'hFF00000000000000000000000003FC0000000007E7F9F8FC7E3F0FCFF3F1F8FC),
    .INIT_13(256'hFC00000FCFF3F1F800001F9FE7E3F000003F3FCFC7E000007E7F9F8FC0000000),
    .INIT_14(256'h00007FBFC00000000000000000000001FE0000000003F3FCFC7E000007E7F9F8),
    .INIT_15(256'hFDFE7E000007E7FBFCFC00000FCFF7F9F800001F9FEFF3F000003F3FDFE7E000),
    .INIT_16(256'h0000FC000000000000000000000000000000FF7F80000001F9FEFF3F000003F3),
    .INIT_17(256'hE1F8FC0000000FC3F1F80000001F87E3F00000003F0FC7E00000007E1F8FC000),
    .INIT_18(256'hE3F1F8FC7E000000000000000000000000000000000000000000FC7E00000007),
    .INIT_19(256'hC7E3F0FC7E3F1F8FC7E1F8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7),
    .INIT_1A(256'h800000000000000000000000000000000000000000000000000000007E3F1F8F),
    .INIT_1B(256'h0FC7E3F1F87E001F8FC7E3F0FC003F1F8FC7E1F8007E3F1F8FC3F000FC7E3F1F),
    .INIT_1C(256'h00000000000000000000000000000000000000000000001F8007E3F1F8FC3F00),
    .INIT_1D(256'h1F8007E3F000003F000FC7E000007E001F8FC00000FC003F1F800001F8007E3F),
    .INIT_1E(256'h001F80000000000000000000000000000000000000000000000FC003F1F80000),
    .INIT_1F(256'h00000FC00001F800001F800003F000003F000007E000007E00000FC00000FC00),
    .INIT_20(256'h7E3F00000003F0000000000000000000000000000000000000000007E00000FC),
    .INIT_21(256'h0000001F87E3F00000003F0FC7E00000007E1F8FC0000000FC3F1F80000001F8),
    .INIT_22(256'hF8FC3F1F8FC7E3F1F8000000000000000000000000000000000000000003F1F8),
    .INIT_23(256'hF8FC7E3F1F8FC3F1F8FC7E3F1F87E3F1F8FC7E3F0FC7E3F1F8FC7E1F8FC7E3F1),
    .INIT_24(256'h77777773BBBBBBBBBBBBB8000000000000000000000000000000000000000001),
    .INIT_25(256'h777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE7777777),
    .INIT_26(256'hEEEEEEE777777777777773BBBBBBBBBBBBB800000000000000EEEEEEEEEEEEEE),
    .INIT_27(256'hEEEE0EEEEEEEEE777707777777773BBB83BBBBBBBB800000000000000EEEEEEE),
    .INIT_28(256'h0000000EEEE0EE00EEEEE777707700777773BBB83B803BBBB800000000000000),
    .INIT_29(256'h000000000000000EEE00E00EEEEE0777007007777703BB803803BBBB80000000),
    .INIT_2A(256'hBBBBBB80000000000000000EEE000EEEEEE00777000777777003BB8003BBBBB8),
    .INIT_2B(256'hBBBB83BBBBBBB800000000000000EEEEEEEEEEEEEE777777777777773BBBBBBB),
    .INIT_2C(256'h0777773BBBB80003BBBB800000000000000EEEEE0EEEEEEEE777770777777773),
    .INIT_2D(256'h77777777777773BBBBBBBBBBBBB800000000000000EEEEE0000EEEEE77777000),
    .INIT_2E(256'hEEEEEE7777777777777700000000000000000000000000000EEEEEEEEEEEEEE7),
    .INIT_2F(256'hEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCEEEEEEEE),
    .INIT_30(256'hDDDDDCEEEEEEEEEEEEEE77777777777777000000000000001DDDDDDDDDDDDDCE),
    .INIT_31(256'hDDC1DDDDDDDDCEEEE0EEEEEEEEE77770777777777000000000000001DDDDDDDD),
    .INIT_32(256'h000001DDDC1DC01DDDDCEEEE0EE00EEEEE77770770077777000000000000001D),
    .INIT_33(256'h0000000000001DDDC01C01DDDDCEEEE00E00EEEEE77770070077777000000000),
    .INIT_34(256'h77777000000000000001DDDDC001DDDDDCEEEEE000EEEEEE7777700077777700),
    .INIT_35(256'h777077777777000000000000001DDDDDDDDDDDDDCEEEEEEEEEEEEEE777777777),
    .INIT_36(256'hEEEEE77777000077777000000000000001DDDDC1DDDDDDDCEEEEE0EEEEEEEE77),
    .INIT_37(256'hEEEEEEEEEEEE77777777777777000000000000001DDDDC0001DDDDCEEEEE0000),
    .INIT_38(256'hDDDDCEEEEEEEEEEEEEE00000000000000000000000000001DDDDDDDDDDDDDCEE),
    .INIT_39(256'hDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDD),
    .INIT_3A(256'hBBBB9DDDDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBBBBBBBBBBB9DD),
    .INIT_3B(256'hB83BBBBBBBB9DDDC1DDDDDDDDCEEEE0EEEEEEEEE000000000000003BBBBBBBBB),
    .INIT_3C(256'h00003BBB83B803BBBB9DDDC1DC01DDDDCEEEE0EE00EEEEE000000000000003BB),
    .INIT_3D(256'h000000000003BBB803803BBBB9DDDC01C01DDDDCEEEE00E00EEEEE0000000000),
    .INIT_3E(256'hEEEE000000000000003BBBB8003BBBBB9DDDDC001DDDDDCEEEEE000EEEEEE000),
    .INIT_3F(256'hEE0EEEEEEEE000000000000003BBBBBBBBBBBBB9DDDDDDDDDDDDDCEEEEEEEEEE),
    .INIT_40(256'hDDDCEEEEE0000EEEEE000000000000003BBBB83BBBBBBB9DDDDC1DDDDDDDCEEE),
    .INIT_41(256'hDDDDDDDDDDCEEEEEEEEEEEEEE000000000000003BBBB80003BBBB9DDDDC0001D),
    .INIT_42(256'hBBB9DDDDDDDDDDDDDC00000000000000000000000000003BBBBBBBBBBBBB9DDD),
    .INIT_43(256'hBBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBBBBBBBBB),
    .INIT_44(256'h7773BBBBBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777777777777773BBB),
    .INIT_45(256'h07777777773BBB83BBBBBBBB9DDDC1DDDDDDDDC0000000000000077777777777),
    .INIT_46(256'h000777707700777773BBB83B803BBBB9DDDC1DC01DDDDC000000000000007777),
    .INIT_47(256'h0000000000777700700777773BBB803803BBBB9DDDC01C01DDDDC00000000000),
    .INIT_48(256'hDDC00000000000000777770007777773BBBB8003BBBBB9DDDDC001DDDDDC0000),
    .INIT_49(256'hC1DDDDDDDC00000000000000777777777777773BBBBBBBBBBBBB9DDDDDDDDDDD),
    .INIT_4A(256'hBB9DDDDC0001DDDDC00000000000000777770777777773BBBB83BBBBBBB9DDDD),
    .INIT_4B(256'hBBBBBBBBB9DDDDDDDDDDDDDC00000000000000777770000777773BBBB80003BB),
    .INIT_4C(256'h0001C000003F00003F00FF80E00000000000000000000777777777777773BBBB),
    .INIT_4D(256'h000008000000001800000080000000018004010C204000801840E03000000FFE),
    .INIT_4E(256'h0000108000180000000001080001800000000010800018000000000000000180),
    .INIT_4F(256'h000000000C0000406000000000C0000006000000240C00000001080000000000),
    .INIT_50(256'h0F0807FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0C06000081808C0010C06),
    .INIT_51(256'h07FFFFFFF80030F0007FFFFFFF80030F0007FFFFFFFC0030F0007FFFFFFFE003),
    .INIT_52(256'hFFFFFC0000F0007FFFFFFFC0030F0007FFFFFFF80030F0007FFFFFFF80030F00),
    .INIT_53(256'hF8610000807FFFFFFF8200000007FFFFFFF8200000007FFFFFFF8004800007FF),
    .INIT_54(256'h000000000000000000008000000000000080000000000C00C2040200001E0FFF),
    .INIT_55(256'h0060000000210000010821002100000108610000000001086100000000010821),
    .INIT_56(256'hFFFFFFFFFFFFFFFFFFFFF0C0600200003F00C0600000003F0040600000002100),
    .INIT_57(256'hFF800000080000FF800000080000FFC00000080000FFE00000080000FFFFFFFF),
    .INIT_58(256'h180000F0FFC01018784300FFC01018784300FF801018784300FF801018784300),
    .INIT_59(256'h00000000000000000F8600180000F0FF8200180000F0FF8200180000F0FF8000),
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
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
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
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],\douta[3] }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\addra[15] ),
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

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module overlay_mem_blk_mem_gen_top
   (douta,
    clka,
    addra);
  output [3:0]douta;
  input clka;
  input [16:0]addra;

  wire [16:0]addra;
  wire clka;
  wire [3:0]douta;

  overlay_mem_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .douta(douta));
endmodule

(* C_ADDRA_WIDTH = "17" *) (* C_ADDRB_WIDTH = "17" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "1" *) 
(* C_COUNT_36K_BRAM = "12" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "4" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.558189 mW" *) 
(* C_FAMILY = "artix7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "0" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "overlay_mem.mem" *) 
(* C_INIT_FILE_NAME = "overlay_mem.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "3" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "100000" *) (* C_READ_DEPTH_B = "100000" *) (* C_READ_WIDTH_A = "4" *) 
(* C_READ_WIDTH_B = "4" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "1" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "100000" *) (* C_WRITE_DEPTH_B = "100000" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
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
  input [16:0]addra;
  input [3:0]dina;
  output [3:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [16:0]addrb;
  input [3:0]dinb;
  output [3:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [16:0]rdaddrecc;
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
  output [16:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [16:0]addra;
  wire clka;
  wire [3:0]douta;

  assign dbiterr = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
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
  input [16:0]addra;

  wire [16:0]addra;
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
