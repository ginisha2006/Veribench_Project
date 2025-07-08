module tb_binary_adder_tree();

  // Inputs
  reg [15:0] A, B, C, D, E;
  reg clk;

  // Output
  wire [15:0] out;

  // Instantiate the DUT
  binary_adder_tree UUT (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  always @(*) begin assert (@(posedge clk) (sum1 === A + B)); end

  always @(*) begin assert (@(posedge clk) (sum2 === C + D)); end

  always @(*) begin assert (@(posedge clk) (sum3 === sumreg1 + sumreg2)); end

  always @(*) begin assert (@(posedge clk) (sum4 === sumreg3 + E)); end

  always @(*) begin assert (@(posedge clk) (out === sumreg4)); end

endmodule