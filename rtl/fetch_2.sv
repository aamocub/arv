module fetch_2
    import riscv_pkg::*;
    import arv_pkg::*;
#(
) (
    input  logic          clk_i,
    input  logic          rst_ni,
    input  fetch_2_ctrl_t ctrl_i,
    input  fetch_1_t      fetch_1_i,
    output fetch_2_t      fetch_2_o
);

    logic [PHY_ADDR_SIZE-1:0] pc;

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
        end else begin
            if (!ctrl_i.stall) begin
            end
        end
    end

endmodule
