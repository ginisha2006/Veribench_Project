module param_multiplier #(parameter WIDTH = 8)(input [WIDTH-1:0] a, input [WIDTH-1:0] b, output [2*WIDTH-1:0] product);

wire [WIDTH-1:0] a_shifted;
wire [WIDTH-1:0] b_shifted;

assign a_shifted = {a[W-1:0], 1'b0};
assign b_shifted = {b[W-1:0], 1'b0};

wire [2*WIDTH-1:0] partial_product;
wire [WIDTH-1:0] sum;

always @(*) begin
    partial_product = a_shifted * b_shifted;
    sum = partial_product[2*WIDTH-1:WIDTH];
end

assign product = sum + partial_product[WIDTH-1:0];

endmodule