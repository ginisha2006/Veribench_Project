module param_divider #(parameter WIDTH = 8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output [WIDTH-1:0] quotient,
    output [WIDTH-1:0] remainder
);

wire [WIDTH-1:0] temp;
reg [WIDTH-1:0] q, r;

always @(posedge clock)
begin
    if (divisor!= 0)
    begin
        temp = dividend << 1;
        if (temp >= divisor)
        begin
            temp = temp - divisor;
            q = q + 1;
        end
    end
end

assign quotient = q;
assign remainder = temp;

endmodule