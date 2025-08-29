module memory_controller_tb ();

  localparam MW = 32;
  localparam MMD = 16;
  localparam MD = $clog2(16);

  reg          clk_i;
  reg          rst_i;
  reg          if_read_en_i;
  reg [MD-1:0] if_read_pos_i;
  reg [MW-1:0] if_read_data_o;
  reg          if_read_valid_o;
  reg          m_read_en_i;
  reg [MD-1:0] m_read_pos_i;
  reg [MW-1:0] m_read_data_o;
  reg          m_read_valid_o;
  reg          mem_read_en_o;
  reg [MD-1:0] mem_read_pos_o;
  reg [MW-1:0] mem_read_data_i;
  reg          mem_read_valid_i;
  reg          mem_write_en;
  reg [MD-1:0] mem_write_pos;
  reg [MW-1:0] mem_write_data;

  memory_controller #(
      .MEMDATAWIDTH(MW),
      .MEMDEPTH    (MMD)
  ) u_memory_controller (
      .clk_i           (clk_i),
      .rst_i           (rst_i),
      .if_read_en_i    (if_read_en_i),
      .if_read_pos_i   (if_read_pos_i),
      .if_read_data_o  (if_read_data_o),
      .if_read_valid_o (if_read_valid_o),
      .m_read_en_i     (m_read_en_i),
      .m_read_pos_i    (m_read_pos_i),
      .m_read_data_o   (m_read_data_o),
      .m_read_valid_o  (m_read_valid_o),
      .mem_read_en_o   (mem_read_en_o),
      .mem_read_pos_o  (mem_read_pos_o),
      .mem_read_data_i (mem_read_data_i),
      .mem_read_valid_i(mem_read_valid_i)
  );
  memory #(
      .WIDTH(MW),
      .DEPTH(MMD)
  ) u_memory (
      .clk_i       (clk_i),
      .rst_i       (rst_i),
      .read_en_i   (mem_read_en_o),
      .read_pos_i  (mem_read_pos_o),
      .read_data_o (mem_read_data_i),
      .read_valid_o(mem_read_valid_i),
      .write_en_i  (mem_write_en),
      .write_pos_i (mem_write_pos),
      .write_data_i(mem_write_data)
  );


  always #5 clk_i = ~clk_i;

  initial begin
    $dumpfile("memory_controller_tb.vcd");
    $dumpvars(0, memory_controller_tb);
    clk_i = 1;
    rst_i = 1;
    #10;
    rst_i = 0;
    #10;
    mem_write_en   = 1;
    mem_write_pos  = 1;
    mem_write_data = 1;
    #10;
    mem_write_en   = 1;
    mem_write_pos  = 2;
    mem_write_data = 2;
    #10;
    mem_write_en   = 1;
    mem_write_pos  = 3;
    mem_write_data = 3;
    #10;
    mem_write_en = 0;
    #10;
    if_read_en_i  = 1;
    if_read_pos_i = 1;
    #10;
    if_read_en_i = 0;
    #10;
    m_read_en_i  = 1;
    m_read_pos_i = 2;
    #10;
    m_read_en_i = 0;
    #10;
    if_read_en_i = 1;
    m_read_en_i  = 1;
    #10;
    if_read_en_i = 0;
    m_read_en_i  = 0;
    #10;
    $finish();
  end

endmodule
