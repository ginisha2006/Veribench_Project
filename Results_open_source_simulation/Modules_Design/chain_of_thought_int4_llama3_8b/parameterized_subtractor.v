module param_subtractor #(parameter WIDTH = 8)(input [WIDTH-1:0] a, input [WIDTH-1:0] b, output [WIDTH-1:0] diff, output borrow);

assign borrow = (a < b)? 1'b1 : 1'b0;

assign diff = a - b;

endmodule