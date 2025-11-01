module fetch_1
    import riscv_pkg::*;
    import arv_pkg::*;
#(
) (
    input  logic          clk_i,
    input  logic          rst_ni,
    input  fetch_1_ctrl_t ctrl_i,
    output fetch_1_t      fetch_1_o
);

    logic [PHY_ADDR_SIZE-1:0] pc;

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni | ctrl_i.flush) begin
            pc <= PC_RESET_ADDR;
        end else begin
            if (!ctrl_i.stall) begin
                fetch_1_o.pc <= pc;
                priority case (ctrl_i.pc_sel)
                    0: pc <= pc + 4;
                    default: pc <= pc + 4;
                endcase
            end
        end
    end

endmodule
