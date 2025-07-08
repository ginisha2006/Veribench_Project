module param_divider #(parameter WIDTH = 8)
    (input [WIDTH-1:0] dividend,
     input [WIDTH-1:0] divisor,
     output [WIDTH-1:0] quotient,
     output [WIDTH-1:0] remainder);

reg [WIDTH-1:0] q;
reg [WIDTH-1:0] r;

always @(posedge clock)
begin
    if (divisor!= 0)
        begin
            q <= dividend >= divisor? dividend - divisor : dividend;
            r <= dividend < divisor? 1'b1 : 1'b0;
        end
    else
        begin
            q <= dividend;
            r <= dividend;
        end
end

assign quotient = q;
assign remainder = r;

endmodule