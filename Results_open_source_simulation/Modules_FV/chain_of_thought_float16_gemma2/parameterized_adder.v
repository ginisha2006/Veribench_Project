module tb_param_adder;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] sum;
  wire carry;

  param_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  property sum_correct;
    @(posedge clk) sum == a + b;
  endproperty

  property overflow;
    @(posedge clk) !(sum == a + b);
  endproperty

  assert property(sum_correct);
  assert property(overflow);

endmodule