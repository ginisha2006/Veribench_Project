module tb_half_adder (
    input a,
    input b,
    output sum,
    output carry
);

half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

logic clk;
always begin
    #5 clk = ~clk;
end

property correct_sum;
    @(posedge clk) disable iff (!reset)
    a && b |-> sum == a ^ b;
endproperty

assert property(correct_sum);

property correct_carry;
    @(posedge clk) disable iff (!reset)
    a && b |-> carry == a & b;
endproperty

assert property(correct_carry);

property no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    !overflow_no_underflow;
endproperty

assert property(no_overflow_underflow);

property illegal_transitions;
    @(posedge clk) disable iff (!reset)
    !illegal_transition;
endproperty

assert property(illegal_transitions);

endmodule