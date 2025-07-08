module tb_param_comparator;

  parameter WIDTH = 8;

  logic [WIDTH-1:0] A;
  logic [WIDTH-1:0] B;
  logic Equal;
  logic Greater;
  logic Less;

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

endmodule