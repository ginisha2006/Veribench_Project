module tb_param_divider;

// Parameters
localparam WIDTH = 8;

// Input/Output signals
input [WIDTH-1:0] dividend;
input [WIDTH-1:0] divisor;
output [WIDTH-1:0] quotient;
output [WIDTH-1:0] remainder;

// DUT instantiation
param_divider #(.WIDTH(WIDTH)) dut (.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));

// Clock signal generation
reg clk;
always #5 clk = ~clk; // 10ns period

// Properties
always @(*) begin assert (@(posedge clk) ((dividend >= divisor) |=> ($rose(dividend) == $rose(divisor)))); end
always @(*) begin assert (@(posedge clk) ((dividend >= divisor) |=> (quotient < (1 << WIDTH)))); end
always @(*) begin assert (@(posedge clk) ((dividend >= divisor) |=> (remainder < divisor))); end
always @(*) begin assert (@(posedge clk) ((dividend > (1 << WIDTH - 1) && divisor!= 1) |-> ($fell(dividend) == $fell(divisor)))); end
always @(*) begin assert (@(posedge clk) (divisor == 0 |-> ##1 $error("Divisor cannot be zero"))); end

endmodule