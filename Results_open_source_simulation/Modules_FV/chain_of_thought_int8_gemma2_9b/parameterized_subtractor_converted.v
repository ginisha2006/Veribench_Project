module tb_param_subtractor(
  );

  parameter WIDTH = 8;
  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH)(a, b, diff, borrow);

  assert (@(posedge clk)
      diff == a - b);
  assert (@(posedge clk)
      !((a == 0 && b == 0) || (a == {WIDTH{1'b1}} && b == {WIDTH{1'b1}})));
  assert (@(posedge clk)
      !((a == 0 && b == {WIDTH{1'b1}}) || (a == {WIDTH{1'b1}} && b == 0)));

endmodule