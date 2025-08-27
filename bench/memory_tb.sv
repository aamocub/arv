module memory_tb ();

  reg clk_i;
  reg rst_ni;

  localparam W = 32;
  localparam D = 16;

  reg                 read_word_en_i;
  reg [$clog2(D)-1:0] read_word_pos_i;
  reg [        W-1:0] read_word_data_o;
  reg                 write_word_en_i;
  reg [$clog2(D)-1:0] write_word_pos_i;
  reg [        W-1:0] write_word_data_i;

  memory #(
      .WIDTH(W),
      .DEPTH(D)
  ) dut (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .read_word_en_i(read_word_en_i),
      .read_word_pos_i(read_word_pos_i),
      .read_word_data_o(read_word_data_o),
      .write_word_en_i(write_word_en_i),
      .write_word_pos_i(write_word_pos_i),
      .write_word_data_i(write_word_data_i)
  );

  always #5 clk_i = ~clk_i;

  initial begin
    $dumpfile("memory_tb.vcd");
    $dumpvars(0, memory_tb);
    clk_i = 1;
    rst_ni = 0;
    read_word_en_i = 0;
    read_word_pos_i = 0;
    read_word_data_o = 0;
    write_word_en_i = 0;
    write_word_pos_i = 0;
    write_word_data_i = 0;

    #10 rst_ni = 1;

    write_word_en_i   = 1;
    write_word_pos_i  = 5;
    write_word_data_i = 69;

    #10;

    write_word_en_i = 0;

    #10;

    read_word_en_i  = 1;
    read_word_pos_i = 5;

    #10;

    $finish();
  end
endmodule
