module param_subtractor #(parameter WIDTH = 8)
    (input [WIDTH-1:0] a,
     input [WIDTH-1:0] b,
     output [WIDTH-1:0] diff,
     output borrow);

wire [WIDTH:0] sum;
assign {borrow, diff} = {~(a[WIDTH-1]^b[WIDTH-1]) & (a >= b), a - b};

endmodule