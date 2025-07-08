module tb_param_adder #(parameter WIDTH = 8)();

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
  always @(*) begin assert (@(posedge clk) (sum == a + b)); end

  // Property: Check if carry is correct
  always @(*) begin assert (@(posedge clk) ((a[WIDTH-1] && b[WIDTH-1]) || (!a[WIDTH-1] &&!b[WIDTH-1] && (a + b)[WIDTH-1])) == carry); end

  // Property: Check if sum does not exceed maximum value
  always @(*) begin assert (@(posedge clk) ($unsigned(sum) < (1 << WIDTH))); end

endmodule