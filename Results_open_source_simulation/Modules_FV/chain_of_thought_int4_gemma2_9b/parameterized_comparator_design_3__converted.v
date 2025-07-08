module tb_param_comparator;

  parameter WIDTH = 8;
  reg [WIDTH-1:0] A;
  reg [WIDTH-1:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #(WIDTH)(
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  assert property equal_relation;
  assert property greater_relation;
  assert property less_relation;

endmodule