module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH)(a, b, diff, borrow);

  property p_diff_correct;
    @(posedge clk)
    (diff == a - b);
  endproperty

  property p_borrow_correct;
    @(posedge clk)
    (borrow == (a < b));
  endproperty

  assert property (p_diff_correct);
  assert property (p_borrow_correct);

endmodule