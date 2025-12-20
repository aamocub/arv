`ifndef MEMORY_WRITE_IF_SV
`define MEMORY_WRITE_IF_SV

interface memory_write_if;
    import arv_pkg::*;

    logic                     wr_en;
    logic [PHY_ADDR_SIZE-1:0] wr_addr;
    logic [         XLEN-1:0] wr_data;
    logic                     wr_valid;

    modport REQ(output wr_en, wr_addr, input wr_data, wr_valid);
    modport RESP(input wr_en, wr_addr, output wr_data, wr_valid);

endinterface : memory_write_if

`endif  // MEMORY_WRITE_IF_SV
