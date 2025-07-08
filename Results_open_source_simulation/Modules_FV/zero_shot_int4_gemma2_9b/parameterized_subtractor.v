module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH) dut (a, b, diff, borrow);

  property p_diff;
    @(posedge clk) diff == a - b;
  endproperty

  property p_overflow;
    @(posedge clk) (a > b) && (diff[WIDTH-1] == 1'b1);
  endproperty

  property p_underflow;
    @(posedge clk) (b > a) && (diff[WIDTH-1] == 1'b0);
  endproperty

  assert property(p_diff);
  assert property(p_overflow);
  assert property(p_underflow);

endmodule