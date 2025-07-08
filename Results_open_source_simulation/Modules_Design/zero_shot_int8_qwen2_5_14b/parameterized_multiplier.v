module param_multiplier #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [2*WIDTH-1:0] product
);
    initial begin
        product = {{2*WIDTH{1'b0}}};
    end
    always @(a,b)
    begin
        product = a * b;
    end
endmodule