module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  wire [WIDTH-1:0] OUT;
  reg CLK;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  property p_add_correctness;
    @(posedge CLK)
      OUT == (A + B + C + D + E);
  endproperty

  property p_overflow;
    @(posedge CLK)
      !((A + B + C + D + E) > 2**WIDTH - 1);
  endproperty

  property p_underflow;
    @(posedge CLK)
      !(A + B + C + D + E) < 0;
  endproperty

  assert property (p_add_correctness);
  assert property (p_overflow);
  assert property (p_underflow);

  always #5 CLK = ~CLK;

endmodule