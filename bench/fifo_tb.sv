module fifo_tb ();

  reg clk_i;
  reg rstn_i;
  reg push_i;
  reg [31:0] push_data_i;
  reg pop_i;
  reg [31:0] pop_data_o;
  reg full_o;
  reg empty_o;

  fifo #(
      .WIDTH(32),
      .DEPTH(4)
  ) u_fifo (
      .clk_i      (clk_i),
      .rst_i      (rstn_i),
      .push_i     (push_i),
      .push_data_i(push_data_i),
      .pop_i      (pop_i),
      .pop_data_o (pop_data_o),
      .full_o     (full_o),
      .empty_o    (empty_o)
  );


  always #5 clk_i = ~clk_i;

  initial begin
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0, fifo_tb);
    clk_i  = 1;
    rstn_i = 1;
    #5 rstn_i = 0;
    #5 rstn_i = 1;
    #5;
    #5
    $display(
        "[T=%0t] clk %b push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        clk_i,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // POP when queue empty
    pop_i = 1;
    #10
    $display(
        "[T=%0t] clk %b push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        clk_i,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // PUSH when queue empty
    pop_i = 0;
    push_i = 1;
    push_data_i = 32'd10;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // Normal POP
    pop_i  = 1;
    push_i = 0;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // Queue empty
    pop_i  = 0;
    push_i = 0;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // Multiple push
    pop_i = 0;
    push_i = 1;
    push_data_i = 32'd10;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    push_data_i = 32'd12;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    push_data_i = 32'd14;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    push_data_i = 32'd16;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );

    // Multiple pop
    pop_i  = 1;
    push_i = 0;
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    #10
    $display(
        "[T=%0t] push_i %b push_din %0d pop_i %b pop_qout %0d full %b empty %b",
        $time,
        push_i,
        push_data_i,
        pop_i,
        pop_data_o,
        full_o,
        empty_o
    );
    $finish();
  end
endmodule
