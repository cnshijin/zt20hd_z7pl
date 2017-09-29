set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] -group [get_clocks clk_fpga_2]
set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] -group [get_clocks -of_objects [get_pins zynq_sys_inst/zynq_sys_i/axi_dynclk_0/U0/Inst_mmcme2_drp/mmcm_adv_inst/CLKOUT0]]
