package riscv_pkg;

    localparam XLEN = 32;

    localparam VIRT_ADDR_SIZE = 32;
    localparam PHY_ADDR_SIZE = 32;

    typedef struct packed {
        logic [31:25] funct7;
        logic [24:20] rs2;
        logic [19:15] rs1;
        logic [14:12] funct3;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } rinstr_t;
    typedef struct packed {
        logic [31:20] imm;
        logic [19:15] rs1;
        logic [14:12] func3;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } iinstr_t;
    typedef struct packed {
        logic [31:25] imm_1;
        logic [24:20] rs2;
        logic [19:15] rs1;
        logic [14:12] funct3;
        logic [11:7]  imm_2;
        logic [6:0]   opcode;
    } sinstr_t;
    typedef struct packed {
        logic [31:12] imm;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } uinstr_t;
    typedef struct packed {
        logic [31:31] imm_1;
        logic [30:25] imm_3;
        logic [24:20] rs2;
        logic [19:15] rs1;
        logic [14:12] funct3;
        logic [11:8]  imm_4;
        logic [7:7]   imm_2;
        logic [6:0]   opcode;
    } binstr_t;
    typedef struct packed {
        logic [31:31] imm_1;
        logic [30:21] imm_4;
        logic [20:20] imm_3;
        logic [19:12] imm_2;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } jinstr_t;
    typedef union packed {
        logic [31:0] raw;
        rinstr_t     rtype;
        iinstr_t     itype;
        sinstr_t     stype;
        uinstr_t     utype;
        binstr_t     btype;
        jinstr_t     jtype;
    } instruction_t;

endpackage
