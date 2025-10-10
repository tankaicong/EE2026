-makelib ies_lib/xil_defaultlib -sv \
  "/opt/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/opt/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../ip/display_clocks/display_clocks_clk_wiz.v" \
  "../../../ip/display_clocks/display_clocks.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

