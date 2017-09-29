
################################################################
# This is a generated script based on design: zynq_sys
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source zynq_sys_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg400-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name zynq_sys

# This script was generated for a remote BD.
set str_bd_folder E:/h_zturn/zt20hd_z7pl/hw/syn/bd
set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

# Check if remote design exists on disk
if { [file exists $str_bd_filepath ] == 1 } {
   puts "ERROR: The remote BD file path <$str_bd_filepath> already exists!\n"

   puts "INFO: Please modify the variable <str_bd_folder> to another path or modify the variable <design_name>."

   return 1
}

# Check if design exists in memory
set list_existing_designs [get_bd_designs -quiet $design_name]
if { $list_existing_designs ne "" } {
   puts "ERROR: The design <$design_name> already exists in this project!"
   puts "ERROR: Will not create the remote BD <$design_name> at the folder <$str_bd_folder>.\n"

   puts "INFO: Please modify the variable <design_name>."

   return 1
}

# Check if design exists on disk within project
set list_existing_designs [get_files */${design_name}.bd]
if { $list_existing_designs ne "" } {
   puts "ERROR: The design <$design_name> already exists in this project at location:"
   puts "   $list_existing_designs"
   puts "ERROR: Will not create the remote BD <$design_name> at the folder <$str_bd_folder>.\n"

   puts "INFO: Please modify the variable <design_name>."

   return 1
}

# Now can create the remote BD
create_bd_design -dir $str_bd_folder $design_name
current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: sysrst_hier
proc create_hier_cell_sysrst_hier { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_sysrst_hier() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk axis_clk
  create_bd_pin -dir O -from 0 -to 0 -type rst axis_inter_rstn
  create_bd_pin -dir O -from 0 -to 0 -type rst axis_peri_rstn
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir I -type clk io_clk
  create_bd_pin -dir I io_locked
  create_bd_pin -dir O -from 0 -to 0 -type rst io_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst io_rstn
  create_bd_pin -dir I -type clk slite_clk
  create_bd_pin -dir O -from 0 -to 0 -type rst slite_inter_rstn
  create_bd_pin -dir O -from 0 -to 0 -type rst slite_peri_rstn

  # Create instance: axis_reset_0, and set properties
  set axis_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 axis_reset_0 ]

  # Create instance: io_reset_0, and set properties
  set io_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 io_reset_0 ]

  # Create instance: slite_reset_0, and set properties
  set slite_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 slite_reset_0 ]

  # Create port connections
  connect_bd_net -net axi_clkgen_0_clk_0 [get_bd_pins axis_clk] [get_bd_pins axis_reset_0/slowest_sync_clk]
  connect_bd_net -net axis_reset_0_interconnect_aresetn [get_bd_pins axis_inter_rstn] [get_bd_pins axis_reset_0/interconnect_aresetn]
  connect_bd_net -net axis_reset_0_peripheral_aresetn [get_bd_pins axis_peri_rstn] [get_bd_pins axis_reset_0/peripheral_aresetn]
  connect_bd_net -net io_locked_1 [get_bd_pins io_locked] [get_bd_pins io_reset_0/dcm_locked]
  connect_bd_net -net io_reset_0_peripheral_aresetn [get_bd_pins io_rstn] [get_bd_pins io_reset_0/peripheral_aresetn]
  connect_bd_net -net io_reset_0_peripheral_reset [get_bd_pins io_rst] [get_bd_pins io_reset_0/peripheral_reset]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins slite_clk] [get_bd_pins slite_reset_0/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins ext_reset_in] [get_bd_pins axis_reset_0/ext_reset_in] [get_bd_pins io_reset_0/ext_reset_in] [get_bd_pins slite_reset_0/ext_reset_in]
  connect_bd_net -net slite_reset_0_interconnect_aresetn [get_bd_pins slite_inter_rstn] [get_bd_pins slite_reset_0/interconnect_aresetn]
  connect_bd_net -net slite_reset_0_peripheral_aresetn [get_bd_pins slite_peri_rstn] [get_bd_pins slite_reset_0/peripheral_aresetn]
  connect_bd_net -net slowest_sync_clk_1 [get_bd_pins io_clk] [get_bd_pins io_reset_0/slowest_sync_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set GPIO_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO_0 ]
  set IIC_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0 ]
  set hdmi_out [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:vid_io_rtl:1.0 hdmi_out ]

  # Create ports
  set hdmi_clk [ create_bd_port -dir O -type clk hdmi_clk ]

  # Create instance: axi_dynclk_0, and set properties
  set axi_dynclk_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:axi_dynclk:1.0 axi_dynclk_0 ]

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_num_fstores {1} \
CONFIG.c_use_mm2s_fsync {0} \
 ] $axi_vdma_0

  # Create instance: aximm_interconnect_0, and set properties
  set aximm_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 aximm_interconnect_0 ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {0} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
CONFIG.S00_HAS_DATA_FIFO {2} \
CONFIG.STRATEGY {0} \
 ] $aximm_interconnect_0

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
CONFIG.M_TDATA_NUM_BYTES {3} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.TDATA_REMAP {tdata[23:0]} \
CONFIG.TKEEP_REMAP {tkeep[2:0]} \
CONFIG.TUSER_REMAP {tuser[0:0]} \
 ] $axis_subset_converter_0

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_CAN0_CAN0_IO {MIO 14 .. 15} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_IO {MIO 51} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_IO {<Select>} \
CONFIG.PCW_I2C1_I2C1_IO {MIO 12 .. 13} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_UART0_IO {MIO 10 .. 11} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.271} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.259} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.219} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.207} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.229} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.250} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.121} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.146} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_RESET_ENABLE {0} \
CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_GP0 {0} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
 ] $processing_system7_0

  # Create instance: slite_interconnect_0, and set properties
  set slite_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 slite_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {6} \
CONFIG.STRATEGY {1} \
 ] $slite_interconnect_0

  # Create instance: sysrst_hier
  create_hier_cell_sysrst_hier [current_bd_instance .] sysrst_hier

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_cresample_0, and set properties
  set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample:4.0 v_cresample_0 ]
  set_property -dict [ list \
CONFIG.has_axi4_lite {true} \
CONFIG.m_axis_video_format {2} \
CONFIG.s_axis_video_format {3} \
 ] $v_cresample_0

  # Create instance: v_rgb2ycrcb_0, and set properties
  set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb:7.1 v_rgb2ycrcb_0 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4_LITE {true} \
CONFIG.HAS_DEBUG {false} \
CONFIG.HAS_INTC_IF {false} \
 ] $v_rgb2ycrcb_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.VIDEO_MODE {1080p} \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_1

  # Create interface connections
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports IIC_0] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins slite_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins slite_interconnect_0/M02_AXI] [get_bd_intf_pins v_rgb2ycrcb_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins slite_interconnect_0/M03_AXI] [get_bd_intf_pins v_cresample_0/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins slite_interconnect_0/M04_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_intf_nets axi_vdma_0_M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S] [get_bd_intf_pins aximm_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net aximm_interconnect_0_M00_AXI [get_bd_intf_pins aximm_interconnect_0/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_intf_nets axis_subset_converter_0_M_AXIS]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_GPIO_0 [get_bd_intf_ports GPIO_0] [get_bd_intf_pins processing_system7_0/GPIO_0]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins slite_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net slite_interconnect_0_M00_AXI [get_bd_intf_pins axi_dynclk_0/s00_axi] [get_bd_intf_pins slite_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net slite_interconnect_0_M05_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins slite_interconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_ports hdmi_out] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_intf_nets v_axi4s_vid_out_0_vid_io_out]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_cresample_0/video_out]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_intf_nets v_cresample_0_video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_intf_nets v_rgb2ycrcb_0_video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_intf_nets v_tc_0_vtiming_out]

  # Create port connections
  connect_bd_net -net axi_clkgen_0_clk_0 [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins aximm_interconnect_0/ACLK] [get_bd_pins aximm_interconnect_0/M00_ACLK] [get_bd_pins aximm_interconnect_0/S00_ACLK] [get_bd_pins aximm_interconnect_0/S01_ACLK] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins processing_system7_0/FCLK_CLK2] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins sysrst_hier/axis_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk]
  connect_bd_net -net axi_clkgen_0_clk_1 [get_bd_ports hdmi_clk] [get_bd_pins axi_dynclk_0/PXL_CLK_O] [get_bd_pins sysrst_hier/io_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net axi_dynclk_0_LOCKED_O [get_bd_pins axi_dynclk_0/LOCKED_O] [get_bd_pins sysrst_hier/io_locked]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
HDL_ATTRIBUTE.DEBUG_IN_BD {true} \
 ] [get_bd_nets axi_dynclk_0_LOCKED_O]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins axi_vdma_0/mm2s_introut] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axis_reset_0_interconnect_aresetn [get_bd_pins aximm_interconnect_0/ARESETN] [get_bd_pins sysrst_hier/axis_inter_rstn]
  connect_bd_net -net axis_reset_0_peripheral_aresetn [get_bd_pins aximm_interconnect_0/M00_ARESETN] [get_bd_pins aximm_interconnect_0/S00_ARESETN] [get_bd_pins aximm_interconnect_0/S01_ARESETN] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins sysrst_hier/axis_peri_rstn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_dynclk_0/REF_CLK_I] [get_bd_pins axi_dynclk_0/s00_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins slite_interconnect_0/ACLK] [get_bd_pins slite_interconnect_0/M00_ACLK] [get_bd_pins slite_interconnect_0/M01_ACLK] [get_bd_pins slite_interconnect_0/M02_ACLK] [get_bd_pins slite_interconnect_0/M03_ACLK] [get_bd_pins slite_interconnect_0/M04_ACLK] [get_bd_pins slite_interconnect_0/M05_ACLK] [get_bd_pins slite_interconnect_0/S00_ACLK] [get_bd_pins sysrst_hier/slite_clk] [get_bd_pins v_cresample_0/s_axi_aclk] [get_bd_pins v_rgb2ycrcb_0/s_axi_aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins sysrst_hier/ext_reset_in]
  connect_bd_net -net slite_reset_0_interconnect_aresetn [get_bd_pins slite_interconnect_0/ARESETN] [get_bd_pins sysrst_hier/slite_inter_rstn]
  connect_bd_net -net slite_reset_0_peripheral_aresetn [get_bd_pins axi_dynclk_0/s00_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins slite_interconnect_0/M00_ARESETN] [get_bd_pins slite_interconnect_0/M01_ARESETN] [get_bd_pins slite_interconnect_0/M02_ARESETN] [get_bd_pins slite_interconnect_0/M03_ARESETN] [get_bd_pins slite_interconnect_0/M04_ARESETN] [get_bd_pins slite_interconnect_0/M05_ARESETN] [get_bd_pins slite_interconnect_0/S00_ARESETN] [get_bd_pins sysrst_hier/slite_peri_rstn] [get_bd_pins v_cresample_0/s_axi_aresetn] [get_bd_pins v_rgb2ycrcb_0/s_axi_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net sysrst_hier_io_rstn [get_bd_pins sysrst_hier/io_rst] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
  connect_bd_net -net sysrst_hier_io_rstn1 [get_bd_pins sysrst_hier/io_rstn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_tc_0_irq [get_bd_pins v_tc_0/irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_cresample_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_rgb2ycrcb_0/s_axi_aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/s_axi_aclken] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins v_axi4s_vid_out_0/fid] [get_bd_pins v_tc_0/fsync_in] [get_bd_pins xlconstant_1/dout]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dynclk_0/s00_axi/reg0] SEG_axi_dynclk_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cresample_0/ctrl/Reg] SEG_v_cresample_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_rgb2ycrcb_0/ctrl/Reg] SEG_v_rgb2ycrcb_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 680 -defaultsOSRD
preplace port GPIO_0 -pg 1 -y 660 -defaultsOSRD
preplace port hdmi_clk -pg 1 -y 340 -defaultsOSRD
preplace port IIC_0 -pg 1 -y 560 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 700 -defaultsOSRD
preplace port hdmi_out -pg 1 -y 160 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 9 -y 210 -defaultsOSRD
preplace inst axi_iic_0 -pg 1 -lvl 9 -y 580 -defaultsOSRD
preplace inst sysrst_hier -pg 1 -lvl 1 -y 1000 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 8 -y 480 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 5 -y 210 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 6 -y 100 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 7 -y 560 -defaultsOSRD
preplace inst aximm_interconnect_0 -pg 1 -lvl 2 -y 750 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 2 -y 1130 -defaultsOSRD
preplace inst v_cresample_0 -pg 1 -lvl 8 -y 140 -defaultsOSRD
preplace inst axi_dynclk_0 -pg 1 -lvl 9 -y 420 -defaultsOSRD
preplace inst axis_subset_converter_0 -pg 1 -lvl 6 -y 220 -defaultsOSRD
preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 7 -y 110 -defaultsOSRD
preplace inst slite_interconnect_0 -pg 1 -lvl 4 -y 360 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 3 -y 770 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 3 7 NJ 680 NJ 680 NJ 680 NJ 680 NJ 680 NJ 680 NJ
preplace netloc xlconstant_1_dout 1 7 2 2480 290 NJ
preplace netloc axis_subset_converter_0_M_AXIS 1 6 1 2150
preplace netloc slite_reset_0_peripheral_aresetn 1 1 8 NJ 520 NJ 520 1170 130 1510 20 NJ 20 2140 280 2450 300 2840
preplace netloc axi_iic_0_iic2intc_irpt 1 1 9 410 10 NJ 10 NJ 10 NJ 10 NJ 10 NJ 230 NJ 20 NJ 20 3160
preplace netloc v_axi4s_vid_out_0_vid_io_out 1 9 1 NJ
preplace netloc axi_vdma_0_M_AXI_MM2S 1 1 5 420 60 NJ 60 NJ 60 NJ 60 1840
preplace netloc processing_system7_0_M_AXI_GP0 1 3 1 1160
preplace netloc axi_dynclk_0_LOCKED_O 1 0 10 40 600 NJ 600 NJ 600 NJ 600 NJ 600 NJ 600 NJ 610 NJ 610 NJ 650 3150
preplace netloc axis_reset_0_peripheral_aresetn 1 1 8 340 110 NJ 110 NJ 110 NJ 110 1860 150 2190 260 2510 270 NJ
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 5 1 N
preplace netloc axi_interconnect_0_M02_AXI 1 4 3 1450 40 NJ 40 NJ
preplace netloc v_tc_0_irq 1 1 8 440 140 NJ 140 NJ 140 NJ 320 NJ 320 NJ 320 NJ 320 2800
preplace netloc axis_reset_0_interconnect_aresetn 1 1 1 370
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 4 20 1120 NJ 1050 NJ 1050 1140
preplace netloc v_cresample_0_video_out 1 8 1 N
preplace netloc slite_interconnect_0_M00_AXI 1 4 5 NJ 310 NJ 310 NJ 310 NJ 310 2850
preplace netloc axi_interconnect_0_M04_AXI 1 4 4 NJ 390 NJ 390 NJ 390 2440
preplace netloc v_axi4s_vid_out_0_vtg_ce 1 7 3 2530 10 NJ 10 3170
preplace netloc xlconcat_0_dout 1 2 1 740
preplace netloc xlconstant_0_dout 1 6 3 2170 250 2470 280 2840
preplace netloc processing_system7_0_FIXED_IO 1 3 7 NJ 700 NJ 700 NJ 700 NJ 700 NJ 700 NJ 700 NJ
preplace netloc sysrst_hier_io_rstn 1 1 8 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 NJ 1030 2860
preplace netloc axi_vdma_0_mm2s_introut 1 1 5 430 80 NJ 80 NJ 80 NJ 80 1830
preplace netloc axi_clkgen_0_clk_0 1 0 9 50 1100 380 900 720 610 1140 90 1500 90 1870 30 2160 240 2520 260 NJ
preplace netloc axi_iic_0_IIC 1 9 1 NJ
preplace netloc sysrst_hier_io_rstn1 1 1 7 NJ 590 NJ 590 NJ 590 NJ 510 NJ 510 NJ 510 2440
preplace netloc axi_clkgen_0_clk_1 1 0 10 30 580 NJ 580 NJ 580 NJ 580 NJ 420 NJ 420 NJ 420 2490 330 2870 340 3170
preplace netloc processing_system7_0_GPIO_0 1 3 7 NJ 660 NJ 660 NJ 660 NJ 660 NJ 660 NJ 660 NJ
preplace netloc slite_interconnect_0_M05_AXI 1 4 5 NJ 350 NJ 350 NJ 350 NJ 350 2820
preplace netloc axi_interconnect_0_M01_AXI 1 4 1 1480
preplace netloc v_rgb2ycrcb_0_video_out 1 7 1 2450
preplace netloc processing_system7_0_FCLK_CLK0 1 0 9 10 1110 NJ 930 730 930 1150 120 1460 100 NJ 50 2130 270 2500 340 2830
preplace netloc aximm_interconnect_0_M00_AXI 1 2 1 N
preplace netloc v_tc_0_vtiming_out 1 8 1 2810
preplace netloc axi_interconnect_0_M03_AXI 1 4 4 NJ 120 NJ 290 NJ 290 2460
preplace netloc slite_reset_0_interconnect_aresetn 1 1 3 NJ 240 NJ 240 N
levelinfo -pg 1 -10 190 580 940 1310 1670 2000 2330 2680 3030 3210 -top 0 -bot 1200
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


