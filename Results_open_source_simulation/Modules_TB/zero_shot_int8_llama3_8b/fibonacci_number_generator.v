module fibonacci_tb;

reg clk;

reg rst;

reg start;

integer n;

wire [7:0] fib;

initial begin

#10 rst = 1;

#20 rst = 0;

#10 start = 1;

n = 5;

repeat(100) #1 clk = ~clk;

clk = 1;

$monitor($time,"fib=%b",fib);

end

always #5 clk = ~clk;

endmodule