module tb_param_comparator #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B;

  // Outputs
  wire Equal;
  wire Greater;
  wire Less;

  // Instantiate the comparator
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

  // Property: Check if equal output is correct
  always @(*) begin assert (@(posedge clk) (Equal == (A == B))); end

  // Property: Check if greater output is correct
  always @(*) begin assert (@(posedge clk) (Greater == (A > B))); end

  // Property: Check if less output is correct
  always @(*) begin assert (@(posedge clk) (Less == (A < B))); end

endmodule