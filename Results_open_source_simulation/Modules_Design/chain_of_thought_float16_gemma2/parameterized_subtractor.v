module param_subtractor (
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output reg [WIDTH-1:0] diff,
  output reg borrow
);

  parameter WIDTH = 8;

  always @(*) begin
    diff = a - b;
    borrow = (a < b);
  end

endmodule