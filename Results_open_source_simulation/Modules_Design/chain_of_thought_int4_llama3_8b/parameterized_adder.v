module param_adder #(parameter WIDTH = 8)(input [WIDTH-1:0] a, input [WIDTH-1:0] b, output [WIDTH-1:0] sum, output carry);

always @* begin

assign sum = a + b;

assign carry = a[WIDTH-1] & b[WIDTH-1] | ~a[WIDTH-1] & ~b[WIDTH-1] & a[WIDTH-2] & b[WIDTH-2];

end

endmodule