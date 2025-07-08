module tb_param_adder;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] sum;
  wire carry;

  param_adder #(WIDTH) dut (a, b, sum, carry);

  always @(*) begin assert (@(posedge clk) sum == a + b); end
  always @(*) begin assert (@(posedge clk) !(sum[WIDTH-1] == a[WIDTH-1] ^ b[WIDTH-1])); end

endmodule