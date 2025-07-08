module param_divider #(parameter WIDTH=8) (
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);

    reg [WIDTH*2-1:0] temp;

    always @(*) begin
        temp = {divisor, dividend};
        quotient = temp / divisor;
        remainder = temp % divisor;
    end

endmodule