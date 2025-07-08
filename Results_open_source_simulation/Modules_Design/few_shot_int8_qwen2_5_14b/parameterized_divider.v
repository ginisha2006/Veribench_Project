module param_divider #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);

always @* begin
    if(divisor != 0) begin
        {quotient, remainder} = dividend / divisor;
    end else begin
        quotient = 0;
        remainder = dividend;
    end
end

endmodule