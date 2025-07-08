module tb_param_comparator #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B;

  // Outputs
  wire Equal, Greater, Less;

  // Instantiate the DUT
  param_comparator #(.WIDTH(WIDTH)) UUT (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  always @(*) begin assert (@(posedge clk) (Equal == (A == B))); end

  always @(*) begin assert (@(posedge clk) ((Greater == (A > B)) && (Less == (A < B)))); end

endmodule