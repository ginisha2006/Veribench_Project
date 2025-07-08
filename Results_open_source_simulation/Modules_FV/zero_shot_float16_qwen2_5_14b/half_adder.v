module tb_half_adder (
    input a,
    input b,
    output sum,
    output carry
);

wire clk;

half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

always begin
    #5 clk = ~clk;
end

property p_no_overflow_underflow;
 @(posedge clk) disable iff (!($isunknown({a,b})))
 ($rose(a) |-> !($past((a == 1'b1 && b == 1'b1), 1))) &&
 ($rose(b) |-> !($past((a == 1'b1 && b == 1'b1), 1)));
endproperty

assert property(p_no_overflow_underflow);

property p_sum_correct;
 @(posedge clk) disable iff (!($isunknown({a,b})))
 (sum === (a ^ b));
endproperty

assert property(p_sum_correct);

property p_carry_correct;
 @(posedge clk) disable iff (!($isunknown({a,b})))
 (carry === (a & b));
endproperty

assert property(p_carry_correct);

endmodule