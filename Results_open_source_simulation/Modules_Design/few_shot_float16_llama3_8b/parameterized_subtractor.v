module param_subtractor #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] diff,
    output borrow
);
    assign {borrow,diff} = ~a + b + 1'b1;
endmodule