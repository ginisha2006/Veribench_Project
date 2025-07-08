module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH)(a, b, diff, borrow);

  assert (@(posedge clk)
    (diff == a - b));
  assert (@(posedge clk)
    (borrow == (a < b)));

endmodule