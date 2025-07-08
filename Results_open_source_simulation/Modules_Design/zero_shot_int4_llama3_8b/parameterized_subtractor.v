module param_subtractor #(parameter WIDTH = 8);
input [WIDTH-1:0] a;
input [WIDTH-1:0] b;
output [WIDTH-1:0] diff;
output borrow;

wire [WIDTH-1:0] temp;
assign temp = a - b;
assign diff = temp[WIDHT-1:0];
assign borrow = ~&temp[WIDHT];

endmodule