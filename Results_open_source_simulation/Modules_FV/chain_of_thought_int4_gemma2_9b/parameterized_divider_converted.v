module tb_param_divider;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] dividend;
  reg [WIDTH-1:0] divisor;
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

  param_divider #(WIDTH)(dividend, divisor, quotient, remainder);

  always @(*) begin assert (@(posedge clk) dividend / divisor == quotient); end
  always @(*) begin assert (@(posedge clk) dividend % divisor == remainder); end
  always @(*) begin assert (divisor != 0); end
  always @(*) begin assert ((dividend == 2**WIDTH - 1) && (quotient == 2**(WIDTH-1)-1)); end
  always @(*) begin assert ((dividend == 0) && (quotient == 0)); end


endmodule