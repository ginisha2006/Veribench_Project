module tb_ternary_adder_tree();

  parameter WIDTH = 16;

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b, c, d, e;

  // Output
  wire [WIDTH-1:0] out;

  // Instantiate the DUT
  ternary_adder_tree UUT (
    .A(a),
    .B(b),
    .C(c),
    .D(d),
    .E(e),
    .CLK(clk),
    .OUT(out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  property p_sum1_correct;
    @(posedge clk) (UUT.sum1 === a + b + c);
  endproperty
  assert property (p_sum1_correct);

  property p_sum2_correct;
    @(posedge clk) (UUT.sum2 === UUT.sumreg1 + d + e);
  endproperty
  assert property (p_sum2_correct);

  property p_out_correct;
    @(posedge clk) (out === UUT.sumreg2);
  endproperty
  assert property (p_out_correct);

endmodule