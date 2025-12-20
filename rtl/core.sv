//
// Module 'core': Describes the top level structure of the 'arv' core. Instantiating and connecting
// all the necessary modules.
//
// It's a 7-stage core: IF1, IF2, ID, EX, MM, WB, CM.
//


module core
    import riscv_pkg::*;
#(
) (
    input logic clk_i,
    input logic rst_ni,
    memory_read_if mem_rd_io,
    memory_write_if mem_wr_io
);
    // History File
    // Control Unit

    // INSTRUCTION FETCH STAGE 1
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) if12 (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // INSTRUCTION FETCH STAGE 2
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) ifid (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // INSTRUCTION DECODE STAGE
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) idex (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // EXECUTION STAGE
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) exmm (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // MEMORY STAGE
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) mmwb (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // WRITEBACK STAGE
    register #(
        .reg_t        (logic),
        .DEFAULT_VALUE(0)
    ) wbcm (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .en_i   (0),
        .flush_i(0),
        .d_i    (0),
        .q_o    ()
    );

    // COMMIT STAGE

endmodule
