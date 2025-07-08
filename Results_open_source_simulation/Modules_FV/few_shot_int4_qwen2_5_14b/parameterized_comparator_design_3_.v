module tb_param_comparator #(parameter WIDTH = 8)();

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

  // Property: Equality check
  property p_equal;
    @(A,B) (Equal === (A == B));
  endproperty
  assert property (p_equal);

  // Property: Greater than check
  property p_greater;
    @(A,B) (Greater === (A > B));
  endproperty
  assert property (p_greater);

  // Property: Less than check
  property p_less;
    @(A,B) (Less === (A < B));
  endproperty
  assert property (p_less);

endmodule