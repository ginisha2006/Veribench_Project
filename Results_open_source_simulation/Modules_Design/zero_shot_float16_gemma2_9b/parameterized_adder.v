module param_adder #(parameter WIDTH = 8) (
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output reg [WIDTH-1:0] sum,
  output reg carry
);
  assign sum = a + b;
  always @(*) begin
    carry = sum[WIDTH];
  end
endmodule