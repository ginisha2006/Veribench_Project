module tb_half_adder;

logic a, b, sum, carry;
logic clk;

half_adder dut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

property p_sum_correct;
    @(posedge clk) ((a == 0 && b == 0) | (a == 1 && b == 1)) => sum == 0;
    @(posedge clk) ((a == 0 && b == 1) | (a == 1 && b == 0)) => sum == 1;
    @(posedge clk) (a == 1 && b == 1) => sum == 1;
endproperty

property p_carry_correct;
    @(posedge clk) (a && b) => carry == 1;
    @(posedge clk) (!a &&!b) => carry == 0;
    @(posedge clk) (a &&!b) => carry == 1;
    @(posedge clk) (!a && b) => carry == 1;
endproperty

property p_no_overflow;
    @(posedge clk) ($onehot(a) && $onehot(b)) disable iff (!clk);
endproperty

property p_no_underflow;
    @(posedge clk) (!$onehot(a) &&!$onehot(b)) disable iff (!clk);
endproperty

property p_edge_cases;
    @(posedge clk) (a == 0 && b == 0) => $rose(carry);
    @(posedge clk) (a == 1 && b == 1) => $fell(carry);
endproperty

assert property (p_sum_correct);
assert property (p_carry_correct);
assert property (p_no_overflow);
assert property (p_no_underflow);
assert property (p_edge_cases);

always #10 clk = ~clk; // Clock generation

endmodule