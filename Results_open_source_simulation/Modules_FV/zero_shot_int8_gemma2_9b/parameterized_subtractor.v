module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH) dut (a, b, diff, borrow);

  property p_correct_subtraction;
    @(posedge clk)
    $signed(diff) == $signed(a) - $signed(b);
  endproperty

  property p_overflow;
    @(posedge clk)
    !((diff[WIDTH-1] == a[WIDTH-1]) && (borrow == 1)) &&
    !((diff[WIDTH-1] != a[WIDTH-1]) && (borrow == 0));
  endproperty

  property p_underflow;
    @(posedge clk)
    !((diff[WIDTH-1] != a[WIDTH-1]) && (borrow == 1)) &&
    !((diff[WIDTH-1] == a[WIDTH-1]) && (borrow == 0));
  endproperty

  always #5 clk = ~clk;
  reg clk = 1'b0;

  assert property(p_correct_subtraction);
  assert property(p_overflow);
  assert property(p_underflow);

endmodule