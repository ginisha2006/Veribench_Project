module tb_param_divider;

parameter WIDTH = 8;

input [WIDTH-1:0] dividend;
input [WIDTH-1:0] divisor;
output [WIDTH-1:0] quotient;
output [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

property p_quotient_range;
    @(posedge clk) ($rose(divisor) |=> $distinct0(quotient[WIDTH-1:0]));
endproperty

property p_remainder_range;
    @(posedge clk) ($rose(divisor) |=> $distinct0(remainder[WIDTH-1:0]));
endproperty

property p_division_result;
    @(posedge clk) ($rose(divisor) |=> (quotient * divisor + remainder == dividend));
endproperty

property p_overflow;
    @(posedge clk) ($fell(divisor) |=> ($onehot0(quotient[WIDTH-1])) |-> $onehot0(remainder[WIDTH-1]));
endproperty

property p_underflow;
    @(posedge clk) ($fell(divisor) |=> ($onehot0(quotient[WIDTH-1]) & $onehot0(remainder[WIDTH-1])));
endproperty

property p_illegal_transition;
    @(posedge clk) (!$rose(divisor) |=>!($stable(quotient) & $stable(remainder)));
endproperty

assert property (p_quotient_range);
assert property (p_remainder_range);
assert property (p_division_result);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_illegal_transition);

endmodule