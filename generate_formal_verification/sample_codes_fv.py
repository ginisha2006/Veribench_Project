half_adder_prompt = '''module half_adder(
    input a,
    input b,
    output sum,
    output carry
);
assign sum = a ^ b;
assign carry = a & b;
endmodule '''

half_adder_fv = '''module tb_half_adder();

  // Inputs
  reg a, b;
  reg clk;

  // Outputs
  wire sum, carry;

  // Instantiate the half adder
  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Generate a clock for property evaluation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_correct_sum;
    @(posedge clk) (sum == (a ^ b));
  endproperty
  assert property (p_correct_sum);

  property p_correct_carry;
    @(posedge clk) (carry == (a & b));
  endproperty
  assert property (p_correct_carry);

endmodule'''



param_adder_prompt = '''module param_adder #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum,
    output carry
);
assign {carry, sum} = a + b;
endmodule'''

param_adder_fv = '''module tb_param_adder #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] a, b;

  // Outputs
  wire [WIDTH-1:0] sum;
  wire carry;

  // Instantiate the DUT
  param_adder #(.WIDTH(WIDTH)) UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  
  // Property: Check if sum is correct
  property p_correct_sum;
    @(posedge clk) (sum == a + b);
  endproperty
  assert property (p_correct_sum);

  // Property: Check if carry is asserted on overflow
  property p_correct_carry;
    @(posedge clk)
      ($unsigned(a) + $unsigned(b) > $unsigned({1'b0, {(WIDTH-1){1'b1}}})) == carry;
  endproperty
  assert property (p_correct_carry);

endmodule'''
