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
  property p_correct_diff;
    @(posedge clk) (diff == (a - b));
  endproperty
  assert property (p_correct_diff);

  // Property: Check if borrow is asserted when a < b
  property p_correct_borrow;
    @(posedge clk) ((a < b) |-> borrow === 1'b1);
  endproperty
  assert property (p_correct_borrow);

  // Property: Check if borrow is deasserted when a >= b
  property p_no_borrow;
    @(posedge clk) ((a >= b) |-> borrow === 1'b0);
  endproperty
  assert property (p_no_borrow);

endmodule