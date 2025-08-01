module register #(
    parameter integer WIDTH = 32
) (
    input              clk_i,
    input              rstn_i,
    input              clk_gate_i,
    input  [WIDTH-1:0] data_i,
    output [WIDTH-1:0] data_o
);
  always_comb begin
    data_o = data_r;
  end

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      data_r <= '0;
    end else if (!clk_gate_i) begin
      data_r <= data_i;
    end
  end

endmodule
