module tb_gray_count();

reg clk;
reg enable;
reg reset;

logic [7:0] gray_count;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

property p_reset_value;
    @(posedge reset) disable iff (!reset) ($onehot(gray_count));
endproperty

property p_enable_transition;
    @(posedge clk) disable iff (!enable) ((gray_count == 0) | (gray_count == 255));
endproperty

property p_gray_code_property;
    @(posedge clk) disable iff (!enable) ($onehot(gray_count) && $onehot(gray_count - 1'b1));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!enable) (gray_count == 255);
endproperty

property p_underflow;
    @(posedge clk) disable iff (!enable) (gray_count == 0);
endproperty

assert property (p_reset_value);
assert property (p_enable_transition);
assert property (p_gray_code_property);
assert property (p_overflow);
assert property (p_underflow);

endmodule