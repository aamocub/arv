module fifo #(
    parameter integer WIDTH = 32,
    parameter integer DEPTH = 16
) (
    input                  clk_i,
    input                  rst_i,
    output                 full_o,
    output                 empty_o,
    // --- Write ---
    input                  push_i,
    input      [WIDTH-1:0] push_data_i,
    // --- Read ---
    input                  pop_i,
    output reg [WIDTH-1:0] pop_data_o
);

  reg [        WIDTH-1:0] queue_r[DEPTH];
  reg [$clog2(DEPTH)-1:0] head_r;
  reg [$clog2(DEPTH)-1:0] tail_r;

  assign empty_o = tail_r == head_r ? 1'b1 : 1'b0;
  assign full_o  = (tail_r + 1) == head_r ? 1'b1 : 1'b0;

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
      foreach (queue_r[i]) queue_r[i] <= '0;
      head_r <= '0;
      tail_r <= '0;
      pop_data_o <= '0;
    end else begin
      // --- push and pop when queue empty
      if (push_i && pop_i && empty_o) begin
        pop_data_o <= push_data_i;
      end else begin
        // --- write logic
        if (push_i && !full_o) begin
          queue_r[tail_r] <= push_data_i;
          tail_r <= tail_r + 1;
        end
        // --- read logic
        if (pop_i && !empty_o) begin
          pop_data_o <= queue_r[head_r];
          head_r <= head_r + 1;
        end
      end
    end
  end

endmodule
