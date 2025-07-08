module tb_param_subtractor;

parameter WIDTH = 8;

input [WIDTH-1:0] a, b;

output [WIDTH-1:0] diff;

output borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.diff(diff),.borrow(borrow));

property p_diff_range;
    @(posedge clk) ($rose(borrow) |=> $distance(diff, {WIDTH{1'b0})) |-> $less_than($value(diff), $value(a));
endproperty

property p_borrow_set;
    @(posedge clk) ($fell(borrow) |=> $equal($value(diff), $value(a)));
endproperty

property p_overflow;
    @(posedge clk) ($rose(borrow) & $greater($value(a), $value(b)) |=> $overflow(diff));
endproperty

property p_underflow;
    @(posedge clk) ($fell(borrow) & $less($value(a), $value(b)) |=> $underflow(diff));
endproperty

assert property (p_diff_range);
assert property (p_borrow_set);
assert property (p_overflow);
assert property (p_underflow);

endmodule