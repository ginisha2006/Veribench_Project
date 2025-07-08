module tb_param_divider #(parameter WIDTH = 8)(
    input wire clk,
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);

property valid_input;
    @(posedge clk) disable iff (!divisor)
        divisor != 0;
endproperty

assert property(valid_input);

property correct_quotient;
    @(posedge clk) disable iff (!divisor)
        quotient == dividend / divisor;
endproperty

assert property(correct_quotient);

property correct_remainder;
    @(posedge clk) disable iff (!divisor)
        remainder == dividend % divisor;
endproperty

assert property(correct_remainder);

property non_negative_remainder;
    @(posedge clk) disable iff (!divisor)
        remainder >= 0 && remainder < divisor;
endproperty

assert property(non_negative_remainder);

property max_dividend_behavior;
    @(posededge clk) disable iff (!divisor)
        dividend == divisor - 1 -> remainder == dividend % divisor;
endproperty

assert property(max_dividend_behavior);

property zero_dividend;
    @(posedge clk) disable iff (!divisor)
        dividend == 0 -> quotient == 0 && remainder == 0;
endproperty

assert property(zero_dividend);

property zero_divisor;
    @(posedge clk) divisor == 0 |-> $stable(quotient) && $stable(remainder);
endproperty

assert property(zero_divisor);

endmodule