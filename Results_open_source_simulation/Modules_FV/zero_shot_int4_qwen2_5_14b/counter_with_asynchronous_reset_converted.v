module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);

counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
);

reg clk_signal;
always #5 clk_signal = ~clk_signal;
assign clk = clk_signal;

assert (@(posedge clk) disable iff (!reset)
	(!reset | !ena) |=> ($rose(result) |-> result < 8'd256));

assert (@(posedge clk) disable iff (!reset)
	(!reset | !ena) |=> ($fell(result) |-> result >= 8'd0));

assert (@(posedge clk) disable iff (!reset)
	reset ##1 !$stable(result) |-> result == 8'd0);

assert (@(posedge clk) disable iff (!reset)
	ena |-> $rose(result) |-> result == result[7:0] + 1);

endmodule