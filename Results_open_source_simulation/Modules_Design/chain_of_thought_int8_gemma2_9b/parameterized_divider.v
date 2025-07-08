module param_divider (
  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output reg [WIDTH-1:0] quotient,
  output reg [WIDTH-1:0] remainder
);

  parameter WIDTH = 8;

  always @(*) begin
    quotient = dividend / divisor;
    remainder = dividend % divisor;
  end

endmodule