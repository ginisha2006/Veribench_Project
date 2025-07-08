module tb_counter;

parameter CLOCK_PERIOD = 10; // adjust this value according to your requirements

logic clk;
logic reset;
logic ena;
logic [7:0] result_exp;
logic [7:0] result;

counter dut (
	.clk(clk),
	.reset(reset),
	.result(result),
	.ena(ena)
);

always @(*) begin assert (@(posedge clk) disable iff (!reset); end
result == 0);
always @(*) begin assert (@(posedge clk) disable iff (!ena); end
result == result_exp);
always @(*) begin assert (@(posedge clk) disable iff (ena); end
result == result_exp - 1);
always @(*) begin assert (result >= 8'd128); end
always @(*) begin assert (result < 8'd0); end

endmodule