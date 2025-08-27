module register #(
    parameter integer WIDTH = 32
) (
    input              clk_i,
    input              rst_ni,
    input              clk_gate_i,
    input  [WIDTH-1:0] data_i,
    output [WIDTH-1:0] data_o
);

  reg [WIDTH-1:0] data_r;

  assign data_o = data_r;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      data_r <= '0;
    end else if (!clk_gate_i) begin
      data_r <= data_i;
    end
  end

endmodule
