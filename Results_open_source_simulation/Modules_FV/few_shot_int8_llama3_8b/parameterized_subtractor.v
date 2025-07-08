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
    @(posedge clk) (diff == ({1'b0, a} - b));
  endproperty
  assert property (p_correct_diff);

  // Property: Check if borrow is asserted on underflow
  property p_correct_borrow;
    @(posedge clk)
      ($unsigned(a) < $unsigned(b)) && (borrow == 1'b1);
  endproperty
  assert property (p_correct_borrow);

  // Property: Check if borrow is de-asserted on non-underflow
  property p_correct_borrow_deassertion;
    @(posedge clk)
      (~($unsigned(a) < $unsigned(b))) |-> (!borrow);
  endproperty
  assert property (p_correct_borrow_deassertion);

endmodule