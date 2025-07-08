module fibonacci_gen_tb;

parameter WIDTH = 8;

reg clk;
reg rst;
reg start;
reg [WIDTH-1:0] n;
wire [WIDTH-1:0] fib;

fibonacci_gen #(.WIDTH(WIDTH)) uut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .n(n),
   .fib(fib)
);

initial begin
    #100 clk = 1'b0; rst = 1'b1; start = 1'b0; n = 4'd5;
    repeat (2) @(posedge clk); rst = 1'b0;
    #100 start = 1'b1;
    repeat (6) @(posedge clk);
    start = 1'b0;
    #1000 $display("Expected value: %d, Actual value: %d", 5, fib);
    $monitor($time, " clk=%b, rst=%b, start=%b, n=%d, fib=%d", clk, rst, start, n, fib);
    #10000 $finish;
end

always #5 clk = ~clk;

endmodule