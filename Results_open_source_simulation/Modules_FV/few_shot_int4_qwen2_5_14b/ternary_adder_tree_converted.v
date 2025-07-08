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
  always @(*) begin assert (@(posedge clk) (UUT.sum1 === a + b + c)); end

  always @(*) begin assert (@(posedge clk) (UUT.sum2 === UUT.sumreg1 + d + e)); end

  always @(*) begin assert (@(posedge clk) (out === UUT.sumreg2)); end

endmodule