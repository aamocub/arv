module memory
    import arv_pkg::*;
#(
    parameter longint unsigned SIZE  = 4096,
    parameter integer unsigned DELAY = 5
) (
    input logic clk_i,
    input logic rst_ni
);

    logic [7:0] mem[SIZE];

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (~rst_ni) begin
            mem <= '0;
        end else begin
        end
    end

endmodule
