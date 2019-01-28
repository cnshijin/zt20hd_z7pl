/*!
 * @file zt20hd_z7pl.v
 * @brief Z-Turn HDMI 输出顶层文件
 * @author 石进
 * @date 2017-09-08
 *
 * \todo None
 * \note None
 * \warning None
 * \bug None
 */

`timescale 1ns/1ps

module zt20hd_z7pl (/*AUTOARG*/
                    // Outputs
                    hdmi_clk, hdmi_out_active, hdmi_out_data, hdmi_out_hsync, hdmi_out_vsync,
                    // Inouts
                    DDR_addr, DDR_ba, DDR_cas_n, DDR_ck_n, DDR_ck_p, DDR_cke, DDR_cs_n, DDR_dm,
                    DDR_dq, DDR_dqs_n, DDR_dqs_p, DDR_odt, DDR_ras_n, DDR_reset_n, DDR_we_n,
                    FIXED_IO_ddr_vrn, FIXED_IO_ddr_vrp, FIXED_IO_mio, FIXED_IO_ps_clk,
                    FIXED_IO_ps_porb, FIXED_IO_ps_srstb, iic_0_scl_io, iic_0_sda_io
                    );

   inout [14:0]   DDR_addr;
   inout [2:0]    DDR_ba;
   inout          DDR_cas_n;
   inout          DDR_ck_n;
   inout          DDR_ck_p;
   inout          DDR_cke;
   inout          DDR_cs_n;
   inout [3:0]    DDR_dm;
   inout [31:0]   DDR_dq;
   inout [3:0]    DDR_dqs_n;
   inout [3:0]    DDR_dqs_p;
   inout          DDR_odt;
   inout          DDR_ras_n;
   inout          DDR_reset_n;
   inout          DDR_we_n;
   inout          FIXED_IO_ddr_vrn;
   inout          FIXED_IO_ddr_vrp;
   inout [53:0]   FIXED_IO_mio;
   inout          FIXED_IO_ps_clk;
   inout          FIXED_IO_ps_porb;
   inout          FIXED_IO_ps_srstb;
   output         hdmi_clk;
   output         hdmi_out_active;
   output [15:0]  hdmi_out_data;
   output         hdmi_out_hsync;
   output         hdmi_out_vsync;
   inout          iic_0_scl_io;
   inout          iic_0_sda_io;

   zynq_sys_wrapper zynq_sys_inst (// Outputs
                                   .hdmi_clk            (hdmi_clk),
                                   .hdmi_out_active_video(hdmi_out_active),
                                   .hdmi_out_data       (hdmi_out_data[15:0]),
                                   .hdmi_out_field      (),
                                   .hdmi_out_hblank     (),
                                   .hdmi_out_vblank     (),
                                   .hdmi_out_hsync      (hdmi_out_hsync),
                                   .hdmi_out_vsync      (hdmi_out_vsync),
                                   // Inouts
                                   .DDR_addr            (DDR_addr[14:0]),
                                   .DDR_ba              (DDR_ba[2:0]),
                                   .DDR_cas_n           (DDR_cas_n),
                                   .DDR_ck_n            (DDR_ck_n),
                                   .DDR_ck_p            (DDR_ck_p),
                                   .DDR_cke             (DDR_cke),
                                   .DDR_cs_n            (DDR_cs_n),
                                   .DDR_dm              (DDR_dm[3:0]),
                                   .DDR_dq              (DDR_dq[31:0]),
                                   .DDR_dqs_n           (DDR_dqs_n[3:0]),
                                   .DDR_dqs_p           (DDR_dqs_p[3:0]),
                                   .DDR_odt             (DDR_odt),
                                   .DDR_ras_n           (DDR_ras_n),
                                   .DDR_reset_n         (DDR_reset_n),
                                   .DDR_we_n            (DDR_we_n),
                                   .FIXED_IO_ddr_vrn    (FIXED_IO_ddr_vrn),
                                   .FIXED_IO_ddr_vrp    (FIXED_IO_ddr_vrp),
                                   .FIXED_IO_mio        (FIXED_IO_mio[53:0]),
                                   .FIXED_IO_ps_clk     (FIXED_IO_ps_clk),
                                   .FIXED_IO_ps_porb    (FIXED_IO_ps_porb),
                                   .FIXED_IO_ps_srstb   (FIXED_IO_ps_srstb),
                                   .IIC_0_scl_io        (iic_0_scl_io),
                                   .IIC_0_sda_io        (iic_0_sda_io));

endmodule

// Local Variables:
// verilog-library-directories:("." "./bd/zynq_sys/hdl")
// End:
