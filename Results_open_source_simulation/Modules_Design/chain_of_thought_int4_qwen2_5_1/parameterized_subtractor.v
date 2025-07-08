module param_subtractor #(
    parameter WIDTH = 8
)(
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    output reg [WIDTH-1:0] diff,
    output reg borrow
);

assign {borrow,diff} = a - b;

endmodule