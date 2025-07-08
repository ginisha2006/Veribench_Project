module tb_param_shift_reg (
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

param_shift_reg #(.WIDTH(8)) DUT (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
);

reg clk_signal;

always #5 clk_signal = ~clk_signal;
assign clk = clk_signal;

assert (@(posedge rst) disable iff (!rst)
    rst |-> ##[0:1] data_out == 8'b0);

assert (@(posedge clk) disable iff (!rst)
    load && !rst |=> ##1 data_out == data_in);

endmodule