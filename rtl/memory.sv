module memory #(
    parameter integer WIDTH = 32,   // Determines the WIDTH of BYTE in memory
    parameter integer DEPTH = 1024  // Determines the NUMBER of WORDS in memory
) (
    input                          clk_i,
    input                          rst_ni,
    input                          read_en_i,
    input      [$clog2(DEPTH)-1:0] read_pos_i,
    output reg [        WIDTH-1:0] read_data_o,
    output                         read_valid_o,
    input                          write_en_i,
    input      [$clog2(DEPTH)-1:0] write_pos_i,
    input      [        WIDTH-1:0] write_data_i
);

  reg [WIDTH-1:0] mem_r[DEPTH];

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      foreach (mem_r[i]) mem_r[i] <= 1;
      read_data_o <= 0;
    end else begin
      // Write to MEMORY
      if (write_en_i) begin
        mem_r[write_pos_i] <= write_data_i;
      end

      // Read from MEMORY
      if (read_en_i) begin
        read_data_o  <= mem_r[read_pos_i];
        read_valid_o <= 1'b1;
      end

      // Read AND Write to/from the same position in MEMORY
      if (write_en_i && read_en_i && write_pos_i == read_pos_i) begin
        read_data_o  <= write_data_i;
        read_valid_o <= 1'b1;
      end
    end
  end

endmodule
