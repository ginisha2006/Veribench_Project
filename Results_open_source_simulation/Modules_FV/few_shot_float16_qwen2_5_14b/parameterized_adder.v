module tb_param_adder #(parameter WIDTH = 8)();

  // Inputs
  reg [WIDTH-1:0] a, b;

  // Outputs
  wire [WIDTH-1:0] sum;
  wire carry;

  // Instantiate the Design Under Test (DUT)
  param_adder #(.WIDTH(WIDTH)) UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Properties for Formal Verification

  // Property: Correct Sum Calculation
  property p_correct_sum;
    @(posedge $rose($anychange(a | b))) (sum === a + b);
  endproperty
  assert property (p_correct_sum);

  // Property: Carry Output on Overflow
  property p_correct_carry;
    @(posedge $rose($anychange(a | b)))
      (carry === ((a[WIDTH-1] & b[WIDTH-1]) | (|((a[WIDTH-2:0] + b[WIDTH-2:0]) >= WIDTH))))
      || (carry === (((a + b) >> WIDTH) !== 0));
  endproperty
  assert property (p_correct_carry);

endmodule