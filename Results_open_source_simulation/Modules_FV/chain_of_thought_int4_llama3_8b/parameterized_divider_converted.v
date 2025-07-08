module tb_param_divider;

parameter WIDTH = 8;

logic [WIDTH-1:0] dividend;
logic [WIDTH-1:0] divisor;
logic [WIDTH-1:0] quotient;
logic [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) dut (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

clocking @ (posedge clk); endclocking

initial begin
    clk = 0;
    repeat (100) #10 clk = ~clk;
end

always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    ((dividend == 0) |-> quotient == 0 && remainder == 0);
    ((dividend!= 0) & (divisor!= 0)) |-> (quotient * divisor + remainder == dividend));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (divisor == 0) |-> ($rose(dividend)));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (dividend >= (1 << WIDTH)) |-> ($fell(dividend)));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (dividend < -(1 << (WIDTH - 1))) |-> ($fell(dividend)));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (dividend >= 0) |-> (quotient >= 0 && quotient <= dividend / divisor);
    (dividend < 0) |-> (quotient >= (dividend / divisor) - 1 && quotient <= dividend / divisor));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (dividend >= 0) |-> (remainder < divisor);
    (dividend < 0) |-> (remainder > divisor));

endmodule