package arv_pkg;
    import riscv_pkg::*;

    localparam PC_RESET_ADDR = 'h1000;  // PC address to jump on reset
    localparam PC_EXCEP_ADDR = 'h8000;  // PC address to jump on exception/interrupt

    typedef struct packed {
        logic [1:0] pc_sel;
        logic flush;
        logic stall;
    } fetch_1_ctrl_t;
    typedef struct packed {logic [PHY_ADDR_SIZE-1:0] pc;} fetch_1_t;
    typedef struct packed {
        logic flush;
        logic stall;
    } fetch_2_ctrl_t;
    typedef struct packed {logic [PHY_ADDR_SIZE-1:0] pc;} fetch_2_t;

endpackage
