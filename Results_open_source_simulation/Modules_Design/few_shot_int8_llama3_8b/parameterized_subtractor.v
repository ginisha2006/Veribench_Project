module param_subtractor #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] diff,
    output borrow
);
    assign diff = a - b;
    assign borrow = ~(&(a^b));
endmodule