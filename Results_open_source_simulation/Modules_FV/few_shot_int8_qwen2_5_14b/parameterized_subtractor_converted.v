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
  always @(*) begin assert (@(posedge clk) (diff == (a - b))); end

  // Property: Check if borrow is asserted when a < b
  always @(*) begin assert (@(posedge clk) ((a < b) |-> borrow === 1'b1)); end

endmodule