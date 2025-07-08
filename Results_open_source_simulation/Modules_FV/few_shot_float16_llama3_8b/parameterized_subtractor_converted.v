module tb_param_subtractor #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b;

  // Outputs
  wire [WIDTH-1:0] diff;
  wire borrow;

  // Instantiate the DUT
  param_subtractor #(.WIDTH(WIDTH)) UUT (
   .a(a),
   .b(b),
   .diff(diff),
   .borrow(borrow)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if difference is correct
  always @(*) begin assert (@(posedge clk) (diff == ({1'b0, a} - b))); end

  // Property: Check if borrow is asserted on underflow
  assert (@(posedge clk)
      ($unsigned(a) < $unsigned(b)) &&!borrow);

  // Property: Check if borrow is deasserted on non-underflow
  assert (@(posedge clk)
      (!$unsigned(a) >= $unsigned(b)) |!borrow);

endmodule