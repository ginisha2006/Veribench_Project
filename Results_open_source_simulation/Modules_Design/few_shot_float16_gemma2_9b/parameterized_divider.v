module param_divider #(parameter WIDTH=8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);

  always @(*) begin
    quotient = dividend / divisor;
    remainder = dividend % divisor;
  end

endmodule