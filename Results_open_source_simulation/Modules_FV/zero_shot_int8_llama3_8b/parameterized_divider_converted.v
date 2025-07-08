module tb_param_divider;

parameter WIDTH = 8;

logic [WIDTH-1:0] dividend, divisor, quotient, remainder;

param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

property p_quotient_range;
@(posedge clk) disable iff (!rst_n) ($isunknown(dividend[WIDTH-1:0]) |-> $distinct0(quotient[WIDTH-1:0]));

property p_remainder_range;
@(posedge clk) disable iff (!rst_n) ($isunknown(dividend[WIDTH-1:0]) |-> $distinct0(remainder[WIDTH-1:0]));

property p_division_result;
@(posedge clk) disable iff (!rst_n) ((dividend >= divisor) |=> (quotient * divisor + remainder == dividend));

property p_overflow;
@(posedge clk) disable iff (!rst_n) ((dividend > (1 << WIDTH - 1) && divisor == 1) |-> $fell(remainder[WIDTH-1]));

property p_underflow;
@(posedge clk) disable iff (!rst_n) ((dividend < -(1 << WIDTH - 1) && divisor == 1) |-> $rose(remainder[WIDTH-1]));

property p_invalid_input;
@(posedge clk) disable iff (!rst_n) (!$isunknown(dividend[WIDTH-1:0]) &!$isunknown(divisor[WIDTH-1:0]) |->!($distinct0(quotient[WIDTH-1:0]) | $distinct0(remainder[WIDTH-1:0])));

logic rst_n;

initial begin
#10 rst_n = 1'b0;
#20 rst_n = 1'b1;
end

always #5 clk = ~clk;

initial begin
#100 $finish;
end

endmodule