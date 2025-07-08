module param_multiplier #(parameter WIDTH = 8)
    (input [WIDTH-1:0] a,
     input [WIDTH-1:0] b,
     output [2*WIDTH-1:0] product);

wire [WIDTH-1:0] p;
wire [WIDTH-1:0] q;

assign p = a << 1;
assign q = b << 1;

always @(*) begin
    if (a == 0 || b == 0)
        product = 0;
    else begin
        product = p * q;
    end
end

endmodule