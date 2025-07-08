module param_divider #(parameter WIDTH = 8);
input [WIDTH-1:0] dividend;
input [WIDTH-1:0] divisor;
output reg [WIDTH-1:0] quotient;
output reg [WIDTH-1:0] remainder;

reg [WIDTH-1:0] q;
reg [WIDTH-1:0] r;

always @(posedge clock)
begin
q <= dividend;
r <= dividend;
for (int i = WIDTH - 1; i >= 0; i = i - 1)
begin
if (r >= divisor)
begin
r <= r - divisor;
q <= {q[WIDTH-2:0], 1'b1};
end
else
begin
r <= r;
q <= {q[WIDTH-2:0], 1'b0};
end
end
end

assign quotient = q;
assign remainder = r;
endmodule