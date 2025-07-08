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

  always @(*) begin assert (@(posedge clk) sum == a + b); end
  always @(*) begin assert (@(posedge clk) !(sum == a + b)); end

endmodule