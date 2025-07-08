module tb_half_adder;

  logic a, b;
  logic sum, carry;

  half_adder dut (a, b, sum, carry);

  property sum_prop;
    @(posedge clk) sum == a ^ b;
  endproperty

  property carry_prop;
    @(posedge clk) carry == a & b;
  endproperty

  assert property (sum_prop);
  assert property (carry_prop);

endmodule