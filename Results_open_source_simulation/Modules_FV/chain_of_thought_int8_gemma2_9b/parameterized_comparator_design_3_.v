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

  property equal_relation;
    @(posedge clk)
    $past(Equal) |-> (A == B);
  endproperty

  property greater_relation;
    @(posedge clk)
    $past(Greater) |-> (A > B);
  endproperty

  property less_relation;
    @(posedge clk)
    $past(Less) |-> (A < B);
  endproperty

  assert property(equal_relation);
  assert property(greater_relation);
  assert property(less_relation);

endmodule