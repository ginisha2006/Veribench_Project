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

property p_reset_value;
@(posedge clk) disable iff (!reset);
result == 0;
endproperty

property p_ena_rise;
@(posedge clk) disable iff (!ena);
result == result_exp;
endproperty

property p_ena_fall;
@(posedge clk) disable iff (ena);
result == result_exp - 1;
endproperty

property p_overflow;
result >= 8'd128;
endproperty

property p_underflow;
result < 8'd0;
endproperty

assert property (p_reset_value);
assert property (p_ena_rise);
assert property (p_ena_fall);
assert property (p_overflow);
assert property (p_underflow);

endmodule