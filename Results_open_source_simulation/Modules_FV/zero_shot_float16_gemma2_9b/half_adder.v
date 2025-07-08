module tb_half_adder;

  reg a;
  reg b;
  wire sum;
  wire carry;

  half_adder dut (a, b, sum, carry);

  property p_sum;
    a == 0 && b == 0  -> sum == 0;
    a == 0 && b == 1  -> sum == 1;
    a == 1 && b == 0  -> sum == 1;
    a == 1 && b == 1  -> sum == 0;
  endproperty

  property p_carry;
    a == 0 && b == 0  -> carry == 0;
    a == 0 && b == 1  -> carry == 0;
    a == 1 && b == 0  -> carry == 0;
    a == 1 && b == 1  -> carry == 1;
  endproperty

  assert property (p_sum);
  assert property (p_carry);

endmodule