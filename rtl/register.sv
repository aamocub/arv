module register #(
    parameter integer WIDTH = 32
) (
    input                  clk_i,
    input                  rst_i,
    input                  clk_gate_i,
    input      [WIDTH-1:0] d_i,
    output reg [WIDTH-1:0] q_o
);

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
      q_o <= '0;
    end else if (!clk_gate_i) begin
      q_o <= d_i;
    end
  end

endmodule
