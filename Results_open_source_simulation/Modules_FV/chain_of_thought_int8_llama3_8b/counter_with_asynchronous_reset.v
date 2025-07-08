module tb_counter;

logic clk;
logic reset;
logic ena;
logic [7:0] result;

counter dut (.clk(clk),.reset(reset),.ena(ena),.result(result));

property p_reset_value;
	@(posedge clk) disable iff (!reset) result == 0;
endproperty

property p_enable_increments;
	@(posedge clk) disable iff (reset |!ena) result == $past(result);
endproperty

property p_overflow;
	$rose(result[7]) |-> $fell(result[7]);
endproperty

property p_underflow;
	$fell(result[7]) |-> $rose(result[7]);
endproperty

assert property (p_reset_value);
assert property (p_enable_increments);
assert property (p_overflow);
assert property (p_underflow);

endmodule