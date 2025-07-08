module param_subtractor #(parameter WIDTH = 8)
    (input [WIDTH-1:0] a,
     input [WIDTH-1:0] b,
     output [WIDTH-1:0] diff,
     output borrow);

wire [WIDTH:0] temp;

assign temp = {1'b1, a} - {1'b1, b};

assign diff = temp[WIDTH-1:0];
assign borrow = ~temp[WIDTH];

endmodule