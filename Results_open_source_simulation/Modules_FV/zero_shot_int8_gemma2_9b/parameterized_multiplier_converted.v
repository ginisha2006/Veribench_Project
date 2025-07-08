module tb_param_multiplier;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [2*WIDTH-1:0] product;

  param_multiplier #(WIDTH) dut (a, b, product);

  always @(*) begin assert (@(posedge clk) product == a * b); end
  always @(*) begin assert (@(posedge clk) !((a == 0 && b == 0) || (a == -1 && b == -1))); end

endmodule