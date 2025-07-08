module tb_ternary_adder_tree();

  // Inputs
  reg clk;
  reg [15:0] A, B, C, D, E;

  // Output
  wire [15:0] OUT;

  // Instantiate the DUT
  ternary_adder_tree UUT (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .CLK(clk),
   .OUT(OUT)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if OUT is correct
  property p_correct_OUT;
    @(posedge clk) (OUT == (A + B + C) + (D + E));
  endproperty
  assert property (p_correct_OUT);

  // Property: Check if sumreg1 and sumreg2 are updated correctly
  property p_correct_sumreg1;
    @(posedge clk) (sumreg1 == (A + B + C));
  endproperty
  assert property (p_correct_sumreg1);

  property p_correct_sumreg2;
    @(posedge clk) (sumreg2 == (A + B + C) + (D + E));
  endproperty
  assert property (p_correct_sumreg2);

endmodule