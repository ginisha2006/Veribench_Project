module param_divider #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);
    always @(dividend, divisor) begin
        if(divisor != 0) begin
            {quotient, remainder} = $signed(dividend) / $signed(divisor);
        end else begin
            quotient = 0;
            remainder = dividend;
        end
    end
endmodule