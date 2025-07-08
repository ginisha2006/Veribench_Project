module tb_param_divider;

parameter WIDTH = 8;

input [WIDTH-1:0] dividend;
input [WIDTH-1:0] divisor;
output [WIDTH-1:0] quotient;
output [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

always @(*) begin assert (@(posedge clk) ($rose(divisor) |=> $distinct0(quotient[WIDTH-1:0]))); end
always @(*) begin assert (@(posedge clk) ($rose(divisor) |=> $distinct0(remainder[WIDTH-1:0]))); end
always @(*) begin assert (@(posedge clk) ($rose(divisor) |=> (quotient * divisor + remainder == dividend))); end
always @(*) begin assert (@(posedge clk) ($fell(divisor) |=> ($onehot0(quotient[WIDTH-1])) |-> $onehot0(remainder[WIDTH-1]))); end
always @(*) begin assert (@(posedge clk) ($fell(divisor) |=> ($onehot0(quotient[WIDTH-1]) & $onehot0(remainder[WIDTH-1])))); end
always @(*) begin assert (@(posedge clk) (!$rose(divisor) |=>!($stable(quotient) & $stable(remainder)))); end

endmodule