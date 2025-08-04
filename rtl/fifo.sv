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

    output logic full_o,
    output logic empty_o
);

  reg [        WIDTH-1:0] queue_r[DEPTH];
  reg [$clog2(DEPTH)-1:0] head_r;
  reg [$clog2(DEPTH)-1:0] tail_r;
  reg [        WIDTH-1:0] dout_r;

  assign empty_o = tail_r == head_r ? 1'b1 : 1'b0;
  assign full_o = (tail_r + 1) == head_r ? 1'b1 : 1'b0;
  assign pop_data_o = dout_r;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      head <= '0;
      tail <= '0;
      cnt  <= '0;
    end else begin
      head <= head_n;
      tail <= tail_n;
      cnt  <= cnt_n;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      mem <= '0;
    end else if (!clk_gate) begin
      mem <= mem_n;
    end
  end

endmodule
