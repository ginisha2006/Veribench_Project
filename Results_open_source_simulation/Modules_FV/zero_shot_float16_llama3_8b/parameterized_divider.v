module tb_param_divider;

// Parameters
localparam WIDTH = 8;

// Input/Output signals
input [WIDTH-1:0] dividend;
input [WIDTH-1:0] divisor;
output [WIDTH-1:0] quotient;
output [WIDTH-1:0] remainder;

// DUT instantiation
param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

// Clock signal generation
reg clk;
always #5 clk = ~clk; // 10ns period

// Properties
property p_division_correctness;
    @(posedge clk) ((dividend >= divisor) |=> ($rose(dividend) == $rose(divisor)));
endproperty

property p_quotient_range;
    @(posedge clk) ((dividend >= divisor) |=> (quotient < (1 << WIDTH)));
endproperty

property p_remainder_range;
    @(posedge clk) ((dividend >= divisor) |=> (remainder < divisor));
endproperty

property p_overflow_underflow;
    @(posedge clk) ((dividend > (1 << WIDTH - 1) && divisor!= 1) |-> ($fell(dividend) == $fell(divisor)));
endproperty

property p_zero_divisor;
    @(posedge clk) (divisor == 0 |-> ##1 $error("Divisor cannot be zero"));
endproperty

assert property (p_division_correctness);
assert property (p_quotient_range);
assert property (p_remainder_range);
assert property (p_overflow_underflow);
assert property (p_zero_divisor);

endmodule