module tb_param_divider;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] dividend;
  reg [WIDTH-1:0] divisor;
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

  param_divider #(WIDTH) dut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  assert (@(posedge clk)
    integer i;
    for (i = 0; i < 2**WIDTH; i++) begin
      dividend = i;
      divisor = 1;
      #1
      always @(*) begin assert (quotient == i && remainder == 0); end
    end);
  assert (@(posedge clk)
    always @(*) begin assert (!(quotient == 0 && remainder == 0))); end
  assert (@(posedge clk)
    always @(*) begin assert (!(quotient == 0 && remainder == 0))); end

  always #5 clk = ~clk;

endmodule