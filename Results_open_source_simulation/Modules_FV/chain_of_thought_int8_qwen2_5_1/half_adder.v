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

property p_no_overflow;
    @(posedge clk) a[*1] |-> !($overflow(a + b));
endproperty

assert property(p_no_overflow);

property p_sum_behavior;
    @(posedge clk) (a && !b) |=> sum == 1'b1;
    @(posedge clk) (!a && b) |=> sum == 1'b1;
    @(posedge clk) (!a && !b) |=> sum == 1'b0;
    @(posedge clk) (a && b) |=> sum == 1'b0;
endproperty

assert property(p_sum_behavior);

property p_carry_behavior;
    @(posedge clk) (a && b) |=> carry == 1'b1;
    @(posedge clk) (!a || !b) |=> carry == 1'b0;
endproperty

assert property(p_carry_behavior);

property p_initial_conditions;
    @(negedge clk) $rose(clk) |-> sum === 1'b0 && carry === 1'b0;
endproperty

assert property(p_initial_conditions);

endmodule