module tb_param_adder(
  );

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] sum;
  wire carry;

  param_adder #(WIDTH) dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  property add_correctness;
    @(posedge clk)
    $past(a) != a && $past(b) != b  
      => sum == a + b;
  endproperty

  property overflow;
    @(posedge clk)
    (a == $max(WIDTH-1{1'b1}) && b == $max(WIDTH-1{1'b1})) |
    (a == $min(WIDTH-1{1'b0}) && b == $min(WIDTH-1{1'b0}))
      => sum != $max(WIDTH-1{1'b1}) && sum != $min(WIDTH-1{1'b0});
  endproperty

  assert property(add_correctness);
  assert property(overflow);


endmodule