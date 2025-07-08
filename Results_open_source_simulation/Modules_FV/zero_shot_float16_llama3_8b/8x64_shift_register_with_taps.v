module tb_shift_8x64_taps();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

shift_8x64_taps dut (
   .clk(clk),
   .shift(shift),
   .sr_in(sr_in),
   .sr_out(sr_out),
   .sr_tap_one(sr_tap_one),
   .sr_tap_two(sr_tap_two),
   .sr_tap_three(sr_tap_three)
);

property p_shift_enable;
    @(posedge clk) disable iff (!shift) ((sr[63] == sr_in) && (sr[62:0] == 8'd0));
endproperty

property p_shift_disable;
    @(posedge clk) disable iff (shift) ((sr[63] == sr[62]) && (sr[61:0] == 8'd0));
endproperty

property p_tap_one;
    @(posedge clk) disable iff (!shift) (sr_tap_one == sr[15]);
endproperty

property p_tap_two;
    @(posedge clk) disable iff (!shift) (sr_tap_two == sr[31]);
endproperty

property p_tap_three;
    @(posedge clk) disable iff (!shift) (sr_tap_three == sr[47]);
endproperty

property p_sr_out;
    @(posedge clk) disable iff (!shift) (sr_out == sr[63]);
endproperty

property p_overflow;
    @(posedge clk) disable iff (!shift) ($fell(sr[63]) | $rose(sr[63]));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!shift) ($fell(sr[0]) | $rose(sr[0]));
endproperty

assert property (p_shift_enable);
assert property (p_shift_disable);
assert property (p_tap_one);
assert property (p_tap_two);
assert property (p_tap_three);
assert property (p_sr_out);
assert property (p_overflow);
assert property (p_underflow);

endmodule