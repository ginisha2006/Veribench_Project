module tb_param_divider #(parameter WIDTH = 8)(
    input wire clk,
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output reg [WIDTH-1:0] quotient,
    output reg [WIDTH-1:0] remainder
);

assert (@(posedge clk) disable iff (!divisor)
        divisor != 0);

assert (@(posedge clk) disable iff (!divisor)
        quotient == dividend / divisor);

assert (@(posedge clk) disable iff (!divisor)
        remainder == dividend % divisor);

assert (@(posedge clk) disable iff (!divisor)
        remainder >= 0 && remainder < divisor);

assert (@(posededge clk) disable iff (!divisor)
        dividend == divisor - 1 -> remainder == dividend % divisor);

assert (@(posedge clk) disable iff (!divisor)
        dividend == 0 -> quotient == 0 && remainder == 0);

always @(*) begin assert (@(posedge clk) divisor == 0 |-> $stable(quotient) && $stable(remainder)); end

endmodule