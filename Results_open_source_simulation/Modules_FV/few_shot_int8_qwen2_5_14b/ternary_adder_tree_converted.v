module tb_ternary_adder_tree();

  // Inputs
  reg [15:0] A, B, C, D, E;
  reg CLK;

  // Output
  wire [15:0] OUT;

  // Instantiate the DUT
  ternary_adder_tree UUT (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .CLK(CLK),
    .OUT(OUT)
  );

  // Clock generation for properties
  initial CLK = 0;
  always #5 CLK = ~CLK;

  // Properties
  always @(*) begin assert (@(posedge CLK) (A + B + C === sum1)); end

  always @(*) begin assert (@(posedge CLK) (sum1 + D + E === sum2)); end

  always @(*) begin assert (@(posedge CLK) (sumreg2 === OUT)); end

endmodule