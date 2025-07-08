module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  reg CLK;
  wire [WIDTH-1:0] OUT;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  always @(*) begin assert (@(posedge CLK) sum1 == (A + B + C) && sum2 == (sumreg1 + D + E) && OUT == sumreg2); end
  always @(*) begin assert (@(posedge CLK) !((sum1 > 2**WIDTH - 1) || (sum2 > 2**WIDTH - 1))); end
  always @(*) begin assert (@(posedge CLK) !(sum1 < 0) && !(sum2 < 0)); end

  always #5 CLK = ~CLK;

endmodule