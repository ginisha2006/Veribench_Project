module param_subtractor(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [WIDTH-1:0] diff,
  output borrow
);

  assign diff = a - b;
  assign borrow = (a < b);

endmodule