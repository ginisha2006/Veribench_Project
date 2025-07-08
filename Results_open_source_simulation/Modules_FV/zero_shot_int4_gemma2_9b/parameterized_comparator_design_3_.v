module tb_param_comparator;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] A;
  reg [WIDTH-1:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #(WIDTH) dut (A, B, Equal, Greater, Less);

  property p_equal;
    @(posedge clk) A == B implies Equal;
  endproperty

  property p_greater;
    @(posedge clk) A > B implies Greater;
  endproperty

  property p_less;
    @(posedge clk) A < B implies Less;
  endproperty

  property p_exclusive;
    @(posedge clk) (Equal | Greater | Less);
  endproperty

  assert property (p_equal);
  assert property (p_greater);
  assert property (p_less);
  assert property (p_exclusive);

  always #5 clk = ~clk;
  reg clk;

endmodule