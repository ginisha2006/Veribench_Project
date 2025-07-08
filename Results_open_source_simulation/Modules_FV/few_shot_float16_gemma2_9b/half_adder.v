module tb_half_adder();

  reg a, b;
  wire sum, carry;

  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  property p_sum_correct;
    a ^ b == sum;
  endproperty
  assert property (p_sum_correct);

  property p_carry_correct;
    a & b == carry;
  endproperty
  assert property (p_carry_correct);

endmodule