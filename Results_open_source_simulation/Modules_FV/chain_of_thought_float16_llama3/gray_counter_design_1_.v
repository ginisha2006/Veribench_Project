module tb_gray_count;

logic clk, enable, reset;
logic [7:0] gray_count;

reg [7:0] q;
reg [7:0] no_ones_below;
reg q_msb;

property p_reset_value;
	@(posedge reset) disable iff (!reset) ($onehot(q));
endproperty

property p_enable_transition;
	@(posedge clk) disable iff (!enable) ((q == 0) => (q[-1] == 1));
endproperty

property p_gray_code_generation;
	@(posedge clk) disable iff (!enable) ((q[i] == q[i-1] ^ (no_ones_below[i-1])) for (i=1 to 7));
endproperty

property p_q_msb_set;
	@(posedge clk) disable iff (!enable) (q_msb == (q[7] | q[6]));
endproperty

property p_gray_count_update;
	@(posedge clk) disable iff (!enable) (gray_count == q);
endproperty

property p_overflow;
	@(posedge clk) disable iff (!enable) (~$onehot(gray_count));
endproperty

property p_underflow;
	@(posedge clk) disable iff (!enable) ($onehot(gray_count));
endproperty

property p_invalid_transition;
	@(posedge clk) disable iff (!enable) ((q!= 0) && (q[-1] == 1));
endproperty

assert property (p_reset_value);
assert property (p_enable_transition);
assert property (p_gray_code_generation);
assert property (p_q_msb_set);
assert property (p_gray_count_update);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_invalid_transition);

endmodule