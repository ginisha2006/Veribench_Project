module tb_param_divider;

parameter WIDTH = 8;

logic [WIDTH-1:0] dividend;
logic [WIDTH-1:0] divisor;
logic [WIDTH-1:0] quotient;
logic [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) dut (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

property p_division_correctness;
    @(posedge clk) disable iff (!clk);
    ((dividend == 0) |-> quotient == 0 && remainder == 0);
    ((dividend!= 0) & (divisor!= 0)) |-> (quotient * divisor + remainder == dividend);
endproperty

property p_division_by_zero_error;
    @(posedge clk) disable iff (!clk);
    (divisor == 0) |-> ($rose(dividend));
endproperty

property p_dividend_overflow;
    @(posedge clk) disable iff (!clk);
    (dividend >= (1 << WIDTH)) |-> ($fell(dividend));
endproperty

property p_dividend_underflow;
    @(posedge clk) disable iff (!clk);
    (dividend < -(1 << (WIDTH - 1))) |-> ($fell(dividend));
endproperty

property p_quotient_range;
    @(posedge clk) disable iff (!clk);
    (dividend >= 0) |-> (quotient >= 0 && quotient <= dividend / divisor);
    (dividend < 0) |-> (quotient >= (dividend / divisor) - 1 && quotient <= dividend / divisor);
endproperty

property p_remainder_range;
    @(posedge clk) disable iff (!clk);
    (dividend >= 0) |-> (remainder < divisor);
    (dividend < 0) |-> (remainder > divisor);
endproperty

clocking @ (posedge clk); endclocking

initial begin
    clk = 0;
    repeat (100) #10 clk = ~clk;
end

assert property (p_division_correctness);
assert property (p_division_by_zero_error);
assert property (p_dividend_overflow);
assert property (p_dividend_underflow);
assert property (p_quotient_range);
assert property (p_remainder_range);

endmodule