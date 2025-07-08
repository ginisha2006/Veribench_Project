module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  reg CLK;
  wire [WIDTH-1:0] OUT;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  property p_sum_correctness;
    @(posedge CLK) sum1 == (A + B + C) && sum2 == (sumreg1 + D + E) && OUT == sumreg2;
  endproperty

  property p_overflow;
    @(posedge CLK) !((sum1 > 2**WIDTH - 1) || (sum2 > 2**WIDTH - 1));
  endproperty

  property p_underflow;
    @(posedge CLK) !(sum1 < 0) && !(sum2 < 0);
  endproperty

  assert property (p_sum_correctness);
  assert property (p_overflow);
  assert property (p_underflow);

  always #5 CLK = ~CLK;

endmodule