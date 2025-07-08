module tb_param_comparator;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] A;
  reg [WIDTH-1:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #(WIDTH) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  assert (@(posedge clk)
    $past(Equal) |-> (A == B));
  assert (@(posedge clk)
    $past(Greater) |-> (A > B));
  assert (@(posedge clk)
    $past(Less) |-> (A < B));

  // Clock Generation
  localparam CLK_PERIOD = 10;
  reg clk;
  always # (CLK_PERIOD/2) clk = ~clk;

endmodule