module tb_ternary_adder_tree #(parameter WIDTH = 16);

  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B, C, D, E;

  // Output
  wire [WIDTH-1:0] OUT;

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
  always @(*) begin assert (@(posedge clk) (OUT == (A + B + C + D + E))); end

  // Property: Check if sumreg1 is updated correctly
  always @(*) begin assert (@(posedge clk) (sumreg1 == (A + B + C))); end

  // Property: Check if sumreg2 is updated correctly
  always @(*) begin assert (@(posedge clk) (sumreg2 == (sumreg1 + D + E))); end

endmodule