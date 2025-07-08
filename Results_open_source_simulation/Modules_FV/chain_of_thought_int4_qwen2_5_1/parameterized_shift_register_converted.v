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

reg clk;
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

assert (@(posedge rst) disable iff (!rst)
    data_out == 0);

assert (@(posedge clk) disable iff (!rst && !load)
    $rose(load) |-> data_out === data_in);

endmodule