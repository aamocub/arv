module arv #(
    parameter integer XLEN     = 32,  // Standard data width for RISC-V 32-bit
    parameter integer MEMWIDTH = 32   // Memory Address Length
) (
    input clk_i,
    input rst_i,

    // --- Memory interface ---
    // - read word -
    output                mem_read_word_en_o,
    output [MEMWIDTH-1:0] mem_read_word_pos_o,
    input  [    XLEN-1:0] mem_read_word_data_i,
    // - write word -
    output                mem_write_word_en_o,
    output [MEMWIDTH-1:0] mem_write_word_pos_o,
    output [    XLEN-1:0] mem_write_word_data_i
);

  // Instruction Fetch Stage.
  // ------------------------
  // On this stage the MxPC should select the apropiate value for the PC register (usually PC+4 or the jump address
  // from a branch instruction). After that, the value of the PC register is sent to memory to fetch the next
  // instruction. This is a dead simple memory hierarchy (if it could be called one), but is as good as it gets until
  // the basic processor is up and running.

  wire                clk_gate_to_pcreg_w;
  wire [MEMWIDTH-1:0] addr_to_pcreg_w;
  wire [MEMWIDTH-1:0] pc_w;
  wire [MEMWIDTH-1:0] pc4_w;
  wire [         1:0] mxpc_sel_w;

  assign pc4_w = pc_w + 4;

  mxpc #(
      .WIDTH(MEMWIDTH)
  ) MxPC (
      .pc4_i  (pc4_w),
      .jaddr_i(0),
      .sel_i  (mxpc_sel_w),
      .addr_o (addr_to_pcreg_w)
  );
  register #(
      .WIDTH(MEMWIDTH)
  ) PC (
      .clk_i     (clk_i),
      .rst_i     (rst_i),
      .clk_gate_i(clk_gate_to_pcreg_w),
      .d_i       (addr_to_pcreg_w),
      .q_o       (pc_w)
  );

endmodule
