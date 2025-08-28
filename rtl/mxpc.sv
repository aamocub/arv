module mxpc #(
    parameter integer WIDTH = 32
) (
    input  [WIDTH-1:0] pc4_i,
    input  [WIDTH-1:0] jaddr_i,
    input  [      1:0] sel_i,
    output [WIDTH-1:0] addr_o
);

  // verilog_format: off
  assign addr_o = (sel_i == 2'b00) ? pc4_i   :
                  (sel_i == 2'b01) ? jaddr_i :
                                     0;

endmodule
