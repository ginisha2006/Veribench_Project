module tb_param_comparator;

  reg [7:0] A;
  reg [7:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #( .WIDTH(8) ) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  property equal_condition;
    A == B  implies (Equal && !Greater && !Less);
  endproperty

  property greater_condition;
    A > B implies (Greater && !Equal && !Less);
  endproperty

  property less_condition;
    A < B implies (!Greater && !Equal && Less);
  endproperty

  assert property(equal_condition);
  assert property(greater_condition);
  assert property(less_condition);


endmodule