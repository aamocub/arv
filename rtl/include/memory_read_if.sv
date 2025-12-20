`ifndef MEMORY_READ_IF_SV
`define MEMORY_READ_IF_SV

interface memory_read_if;
    import arv_pkg::*;

    logic                     rd_en;
    logic [PHY_ADDR_SIZE-1:0] rd_addr;
    logic [         XLEN-1:0] rd_data;
    logic                     rd_valid;

    modport REQ(output rd_en, rd_addr, input rd_data, rd_valid);
    modport RESP(input rd_en, rd_addr, output rd_data, rd_valid);

endinterface : memory_read_if

`endif  // MEMORY_READ_IF_SV
