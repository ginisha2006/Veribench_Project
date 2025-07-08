module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  reg CLK;
  wire [WIDTH-1:0] OUT;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  property p_sum_correct;
    @(posedge CLK) sumreg2 == (A + B + C + D + E);
  endproperty

  property p_overflow;
    @(posedge CLK) OUT != {OUT[WIDTH-1], OUT[WIDTH-2:0]};
  endproperty

  property p_underflow;
    @(posedge CLK) OUT != {1'b0, OUT[WIDTH-2:0]};
  endproperty

  assert property (p_sum_correct);
  assert property (p_overflow);
  assert property (p_underflow);

  always #5 CLK = ~CLK;

endmodule