module tb_half_adder (
    input a,
    input b,
    output sum,
    output carry
);

wire clk;

always begin
    #5 clk = ~clk;
end

half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

property prop_sum_correct;
    @(posedge clk) a && b |-> sum == a ^ b;
endproperty

assert property(prop_sum_correct);

property prop_carry_correct;
    @(posedge clk) a && b |-> carry == a & b;
endproperty

assert property(prop_carry_correct);

property prop_no_overflow_underflow;
    @(posedge clk) !overflow && !underflow;
endproperty

assert property(prop_no_overflow_underflow);

endmodule