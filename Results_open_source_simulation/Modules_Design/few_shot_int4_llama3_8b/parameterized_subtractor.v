module param_subtractor #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] diff,
    output borrow
);
    wire [WIDTH:0] temp;
    assign temp = {1'b0, a};
    assign diff = temp - b;
    assign borrow = ~temp[WIDHT] & (temp >= b);
endmodule