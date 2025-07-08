module tb_param_subtractor;

  parameter WIDTH = 8;

  logic [WIDTH-1:0] a;
  logic [WIDTH-1:0] b;
  logic [WIDTH-1:0] diff;
  logic borrow;

  param_subtractor dut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
  );

  assert (@(posedge clk)
    $signed(diff) == $signed(a) - $signed(b));
  assert (@(posedge clk)
    borrow == (a < b));

endmodule