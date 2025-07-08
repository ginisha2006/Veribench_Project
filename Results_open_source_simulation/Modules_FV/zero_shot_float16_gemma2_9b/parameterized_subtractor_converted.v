module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH) dut (a, b, diff, borrow);

  assert (@(posedge clk)
      diff == a - b);
  assert (@(posedge clk)
      !((a < b) && borrow) || ((a >= b) && !borrow));
  assert (@(posedge clk)
      !((a > b) && borrow) || ((a <= b) && !borrow));

endmodule