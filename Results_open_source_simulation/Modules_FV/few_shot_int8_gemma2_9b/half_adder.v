module tb_half_adder();

  reg a, b;
  reg clk;
  wire sum, carry;

  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  property p_sum_correct;
    @(posedge clk) (sum == (a ^ b));
  endproperty
  assert property (p_sum_correct);

  property p_carry_correct;
    @(posedge clk) (carry == (a & b));
  endproperty
  assert property (p_carry_correct);

endmodule