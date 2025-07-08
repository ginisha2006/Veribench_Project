module tb_half_adder;

  reg a;
  reg b;
  wire sum;
  wire carry;

  half_adder dut (a, b, sum, carry);

  property p_sum;
    @(posedge clk) sum == a ^ b;
  endproperty

  property p_carry;
    @(posedge clk) carry == a & b;
  endproperty

  assert property (p_sum);
  assert property (p_carry);

endmodule