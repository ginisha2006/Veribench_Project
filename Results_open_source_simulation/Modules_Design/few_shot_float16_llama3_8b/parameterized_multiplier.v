module param_multiplier #(parameter WIDTH=8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [2*WIDTH-1:0] product
);
    wire [WIDTH-1:0] p;
    wire [WIDTH:0] q;
    assign {p,q} = a * b;
    assign product = {q,p};
endmodule