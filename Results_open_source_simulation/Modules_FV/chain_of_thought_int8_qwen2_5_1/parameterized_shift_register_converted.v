module tb_param_shift_reg (
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

param_shift_reg #(.WIDTH(8)) dut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
);

assert (@(posedge clk) disable iff (!rst)
    rst |-> (data_out == 8'b0));

assert (@(posedge clk) disable iff (!load)
    load ##1 data_out == data_in);

assert (@(posedge clk) disable iff (!load)
    !load |=> data_out != data_in);

assert (@(posedge clk) disable iff (!rst)
    rst ##1 data_out == 8'b0);

endmodule