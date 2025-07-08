module param_multiplier #(parameter WIDTH = 8);
input [WIDTH-1:0] a;
input [WIDTH-1:0] b;
output [2*WIDTH-1:0] product;

wire [WIDTH-1:0] p1;
wire [WIDTH-1:0] p2;
wire [2*WIDTH-1:0] result;

assign p1 = a << 1;
assign p2 = b << 1;
assign {product[2*WIDTH-1 downto WIDTH], product[WIDTH-1 downto 0]} = result;

always @(*) begin
    assign result = p1 * p2;
end

endmodule