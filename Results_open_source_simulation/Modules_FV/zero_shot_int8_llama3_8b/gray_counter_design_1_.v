module tb_gray_count;

reg clk;
reg enable;
reg reset;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count()
);

property p_reset_value;
    @(posedge clk) disable iff (!reset);
    $(gray_count == 8'h00);
endproperty

property p_enable_transition;
    @(posedge clk) disable iff (!enable);
    $(|gray_count[7:0]) == 1'b1;
endproperty

property p_disable_transition;
    @(posedge clk) disable iff (enable);
    $(|gray_count[7:0]) == 1'b0;
endproperty

property p_overflow;
    @(posedge clk) disable iff (!reset &&!enable);
    $(gray_count[7:0] >= 8'h80);
endproperty

property p_underflow;
    @(posedge clk) disable iff (!reset &&!enable);
    $(gray_count[7:0] < 8'h00);
endproperty

assert property (p_reset_value);
assert property (p_enable_transition);
assert property (p_disable_transition);
assert property (p_overflow);
assert property (p_underflow);

endmodule