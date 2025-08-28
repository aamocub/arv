module counter #(
    parameter integer N = 10
) (
    input clk_i,
    input rst_i,
    output reg [$clog2(N):0] count_o
);

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
      count_o <= 0;
    end else begin
      if (count_o == N) begin
        count_o <= 0;
      end else begin
        count_o <= count_o + 1;
      end
    end
  end
endmodule
