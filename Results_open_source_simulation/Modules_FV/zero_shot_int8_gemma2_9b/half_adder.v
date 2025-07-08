module tb_half_adder;

  logic a, b;
  logic sum, carry;

  half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  property sum_correct;
    a == 0 && b == 0  -> sum == 0;
    a == 0 && b == 1  -> sum == 1;
    a == 1 && b == 0  -> sum == 1;
    a == 1 && b == 1  -> sum == 0;
  endproperty

  property carry_correct;
    a == 0 && b == 0  -> carry == 0;
    a == 0 && b == 1  -> carry == 0;
    a == 1 && b == 0  -> carry == 0;
    a == 1 && b == 1  -> carry == 1;
  endproperty

  assert property(sum_correct);
  assert property(carry_correct);

endmodule