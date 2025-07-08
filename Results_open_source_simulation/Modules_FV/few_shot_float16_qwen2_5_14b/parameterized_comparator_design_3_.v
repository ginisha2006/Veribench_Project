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

  // Properties for formal verification

  // Property: Check if Equal is correctly asserted when A equals B
  property p_equal;
    (A == B) |-> (Equal === 1'b1);
  endproperty
  assert property (p_equal);

  // Property: Check if Greater is correctly asserted when A is greater than B
  property p_greater;
    (A > B) |-> (Greater === 1'b1);
  endproperty
  assert property (p_greater);

  // Property: Check if Less is correctly asserted when A is less than B
  property p_less;
    (A < B) |-> (Less === 1'b1);
  endproperty
  assert property (p_less);

  // Property: Ensure that at most one of Equal, Greater, or Less can be true simultaneously
  property p_exclusive_outputs;
    !(Equal && Greater || Equal && Less || Greater && Less);
  endproperty
  assert property (@(posedge $rose(A) || posedge $rose(B)) p_exclusive_outputs);

endmodule