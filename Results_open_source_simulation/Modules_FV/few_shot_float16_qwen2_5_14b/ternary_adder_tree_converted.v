module tb_ternary_adder_tree();

  // Inputs
  reg [16-1:0] A, B, C, D, E;
  reg CLK;

  // Output
  wire [16-1:0] OUT;

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
  always @(*) begin assert (@(posedge CLK) (sum1 === A + B + C)); end

  always @(*) begin assert (@(posedge CLK) (sum2 === sumreg1 + D + E)); end

  always @(*) begin assert (@(posedge CLK) (OUT === sumreg2)); end

  // Edge case: Overflow check
  assert (@(posedge CLK) disable iff (!($unsigned(A+B+C) < 2**WIDTH))
        sum1 !== A + B + C |-> $unsigned(sumreg1+D+E) >= 2**WIDTH);

endmodule