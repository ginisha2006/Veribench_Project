module param_divider #(parameter WIDTH = 8)
    (input [WIDTH-1:0] dividend,
     input [WIDTH-1:0] divisor,
     output [WIDTH-1:0] quotient,
     output [WIDTH-1:0] remainder);

wire [WIDTH-1:0] temp;
reg [WIDTH-1:0] q;

always @(posedge clock)
begin
    if (divisor!= 0)
        begin
            temp <= dividend - {1'b1, divisor};
            q <= q + 1;
        end
    else
        begin
            temp <= dividend;
            q <= q;
        end
end

assign quotient = q;
assign remainder = temp;

endmodule