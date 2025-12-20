//
// Module 'register': Describes a basic FF register.
//


module register #(
    parameter type reg_t = logic,
    parameter reg_t DEFAULT_VALUE = 0
) (
    input  logic clk_i,
    input  logic rst_ni,
    input  logic en_i,
    input  logic flush_i,
    input  reg_t d_i,
    output reg_t q_o
);

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (~rst_ni || flush_i) begin
            q_o <= DEFAULT_VALUE;
        end else if (en_i) begin
            q_o <= d_i;
        end
    end

endmodule
