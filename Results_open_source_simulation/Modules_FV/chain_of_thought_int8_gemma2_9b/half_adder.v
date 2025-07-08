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
    a |-> sum;
  endproperty

  property carry_correct;
    (a & b) |-> carry;
  endproperty

  assert property (sum_correct);
  assert property (carry_correct);

endmodule