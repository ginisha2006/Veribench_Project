module tb_param_comparator #(parameter WIDTH = 8) ();

  // Inputs
  reg [WIDTH-1:0] A, B;

  // Outputs
  wire Equal, Greater, Less;

  // Instantiate the comparator
  param_comparator #(.WIDTH(WIDTH)) UUT (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  // Assertions

  // Property: Check if Equal is true when A equals B
  property p_equal_true;
    (A == B |-> Equal === 1'b1);
  endproperty
  assert property (p_equal_true);

  // Property: Check if Equal is false when A does not equal B
  property p_equal_false;
    ((A != B) |-> Equal === 1'b0);
  endproperty
  assert property (p_equal_false);

  // Property: Check if Greater is true when A is greater than B
  property p_greater_true;
    (A > B |-> Greater === 1'b1);
  endproperty
  assert property (p_greater_true);

  // Property: Check if Greater is false when A is less than or equal to B
  property p_greater_false;
    (!(A > B) |-> !(Greater));
  endproperty
  assert property (p_greater_false);

  // Property: Check if Less is true when A is less than B
  property p_less_true;
    (A < B |-> Less === 1'b1);
  endproperty
  assert property (p_less_true);

  // Property: Check if Less is false when A is greater than or equal to B
  property p_less_false;
    (!(A < B) |-> !(Less));
  endproperty
  assert property (p_less_false);

endmodule