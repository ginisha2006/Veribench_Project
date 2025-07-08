module tb_param_adder #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b;

  // Outputs
  wire [WIDTH-1:0] sum;
  wire carry;

  // Instantiate the DUT
  param_adder #(.WIDTH(WIDTH)) UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if sum is correct
  always @(*) begin assert (@(posedge clk) (sum == a + b)); end

  // Property: Check if carry is asserted on overflow
  assert (@(posedge clk)
      ($unsigned(a) + $unsigned(b) > $unsigned({1'b0, {(WIDTH-1){1'b1}}})) == carry);

endmodule