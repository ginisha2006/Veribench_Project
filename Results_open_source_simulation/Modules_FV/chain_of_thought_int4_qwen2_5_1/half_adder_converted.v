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

assert (@(posedge clk) disable iff (!reset)
    a && b |-> sum == a ^ b);

assert (@(posedge clk) disable iff (!reset)
    a && b |-> carry == a & b);

assert (@(posedge clk) disable iff (!reset)
    !overflow_no_underflow);

assert (@(posedge clk) disable iff (!reset)
    !illegal_transition);

endmodule