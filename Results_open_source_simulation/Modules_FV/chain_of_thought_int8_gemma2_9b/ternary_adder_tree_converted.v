module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  wire [WIDTH-1:0] OUT;
  reg CLK;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  assert (@(posedge CLK)
      OUT == (A + B + C + D + E));
  assert (@(posedge CLK)
      !((A + B + C + D + E) > 2**WIDTH - 1));
  assert (@(posedge CLK)
      !(A + B + C + D + E) < 0);

  always #5 CLK = ~CLK;

endmodule