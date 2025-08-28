module fifo #(
    parameter integer WIDTH = 32,
    parameter integer DEPTH = 16
) (
    input              clk_i,
    input              rstn_i,
    // --- Write ---
    input              push_i,
    input  [WIDTH-1:0] push_data_i,
    // --- Read ---
    input              pop_i,
    output [WIDTH-1:0] pop_data_o,

    output full_o,
    output empty_o
);

  reg [        WIDTH-1:0] queue_r[DEPTH];
  reg [$clog2(DEPTH)-1:0] head_r;
  reg [$clog2(DEPTH)-1:0] tail_r;
  reg [        WIDTH-1:0] dout_r;

  assign empty_o = tail_r == head_r ? 1'b1 : 1'b0;
  assign full_o = (tail_r + 1) == head_r ? 1'b1 : 1'b0;
  assign pop_data_o = dout_r;

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      // --- reset logic ---
      foreach (queue_r[i]) queue_r[i] <= '0;
      head_r <= '0;
      tail_r <= '0;
      dout_r <= '0;
    end else begin
      // --- push and pop when queue empty
      if (push_i && pop_i && empty_o) begin
        dout_r <= push_data_i;
      end else begin
        // --- write logic
        if (push_i && !full_o) begin
          queue_r[tail_r] <= push_data_i;
          tail_r <= tail_r + 1;
        end
        // --- read logic
        if (pop_i && !empty_o) begin
          dout_r <= queue_r[head_r];
          head_r <= head_r + 1;
        end
      end
    end
  end

endmodule
