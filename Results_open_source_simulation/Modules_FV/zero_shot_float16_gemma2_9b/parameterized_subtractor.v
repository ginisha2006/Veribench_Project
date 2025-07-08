module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH) dut (a, b, diff, borrow);

  property sub_correct;
    @(posedge clk)
      diff == a - b;
  endproperty

  property underflow;
    @(posedge clk)
      !((a < b) && borrow) || ((a >= b) && !borrow);
  endproperty

  property overflow;
    @(posedge clk)
      !((a > b) && borrow) || ((a <= b) && !borrow);
  endproperty

  assert property(sub_correct);
  assert property(underflow);
  assert property(overflow);

endmodule