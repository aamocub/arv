module memory #(
    parameter integer WIDTH = 32,   // Determines the WIDTH of WORD in memory
    parameter integer DEPTH = 1024  // Determines the NUMBER of WORDS in memory
) (
    input clk_i,
    input rst_ni,

    input                          read_word_en_i,
    input      [$clog2(DEPTH)-1:0] read_word_pos_i,
    output reg [        WIDTH-1:0] read_word_data_o,

    input                     write_word_en_i,
    input [$clog2(DEPTH)-1:0] write_word_pos_i,
    input [        WIDTH-1:0] write_word_data_i
);

  reg [WIDTH-1:0] mem_r[DEPTH];

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      foreach (mem_r[i]) mem_r[i] <= 1;
      read_word_data_o <= 0;
    end else begin
      if (read_word_en_i) read_word_data_o <= mem_r[read_word_pos_i];
      if (write_word_en_i) mem_r[write_word_pos_i] <= write_word_data_i;
      if (write_word_en_i && read_word_en_i && write_word_pos_i == read_word_pos_i)
        read_word_data_o <= write_word_data_i;
    end
  end

endmodule
