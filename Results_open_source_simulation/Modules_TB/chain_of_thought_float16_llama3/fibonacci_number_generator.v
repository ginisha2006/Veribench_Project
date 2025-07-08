module fibonacci_gen_tb();

reg clk;
reg rst;
reg start;
reg [7:0] n;
wire [7:0] fib;

initial begin
    #10 clk = 0; rst = 1; start = 0; n = 5;
    #20 rst = 0;
    #100 start = 1;
    #200 start = 0;
    #1000 $finish;
end

always #5 clk = ~clk;

fibonacci_gen #(.WIDTH(8)) uut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .n(n),
   .fib(fib)
);

initial begin
    $monitor($time, "clk=%b, rst=%b, start=%b, n=%h, fib=%h", clk, rst, start, n, fib);
end

endmodule