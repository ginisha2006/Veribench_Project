module tb_param_adder(
    input clk,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] sum,
    output reg carry
);

param_adder #(.WIDTH(8)) dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

property p_no_underflow;
 @(posedge clk) disable iff (!reset)
 ($rose(a[7]) && !($rose(b[7])) || !($rose(a[7])) && $rose(b[7]))
 |-> !(a+b < 256'b0);
endproperty

assert property(p_no_underflow);

property p_no_overflow;
 @(posedge clk) disable iff (!reset)
 (a+b > 255)
 |-> carry == 1;
endproperty

assert property(p_no_overflow);

property p_correct_sum;
 @(posedge clk) disable iff (!reset)
 (sum == a + b);
endproperty

assert property(p_correct_sum);

endmodule