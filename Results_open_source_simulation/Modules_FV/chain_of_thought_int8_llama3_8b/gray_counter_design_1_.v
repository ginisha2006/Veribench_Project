module tb_gray_count;

logic clk, enable, reset;
logic [7:0] gray_count;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

property p_reset_default_value;
@(posedge reset) disable iff (!reset) gray_count == 8'h00;
endproperty

property p_enable_clock_transition;
@(posedge clk) disable iff (!enable) gray_count === gray_count;
@(posedge clk) disable iff (enable) gray_count!= gray_count;
endproperty

property p_gray_code_property;
@(posedge clk) disable iff (!reset) ($onehot(gray_count));
endproperty

property p_overflow_underflow;
@(posedge clk) disable iff (reset) gray_count >= 8'hff || gray_count < 8'h00;
endproperty

property p_illegal_transition;
@(posedge clk) disable iff (reset) gray_count!== gray_count;
@(posedge clk) disable iff (enable) gray_count!== gray_count;
endproperty

assert property (p_reset_default_value);
assert property (p_enable_clock_transition);
assert property (p_gray_code_property);
assert property (p_overflow_underflow);
assert property (p_illegal_transition);

endmodule