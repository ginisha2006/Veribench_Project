module tb_param_divider;

parameter WIDTH = 8;

logic [WIDTH-1:0] dividend, divisor, quotient, remainder;

param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

property p_division_correctness;

@(posedge clk) ((dividend >= divisor) => ($size(dut.quotient) == $size(dut.dividend) && dut.remainder < divisor));

property p_zero_divisor;

@(posedge clk) (!dut.divisor[0]) |-> ($onehot(dut.remainder));

property p_overflow;

@(posedge clk) ((dut.dividend >= (1 << WIDTH)) | (dut.divisor == 1)) |-> ($past(dut.quotient)!= dut.quotient);

property p_underflow;

@(posedge clk) ((dut.dividend < (1 << WIDTH)) & (dut.divisor > 1)) |-> ($past(dut.remainder)!= dut.remainder);

property p_invalid_transition;

@(posedge clk) ((dut.dividend == 0) & (dut.divisor > 1)) |-> ($past(dut.remainder)!= dut.remainder);

assert property (p_division_correctness);

assert property (p_zero_divisor);

assert property (p_overflow);

assert property (p_underflow);

assert property (p_invalid_transition);

endmodule