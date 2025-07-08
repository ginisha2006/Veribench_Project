module fibonacci_gen_tb;

reg clk;
reg rst;
reg start;
reg [7:0] n;
wire [7:0] fib;

initial begin
    #10 clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    rst = 1;
    #20 rst = 0;
    #10 start = 1;
    #50 start = 0;
    #100 $display("fibonacci_gen_tb: Done");
    $finish;
end

fibonacci_gen #(
   .WIDTH(8)
) uut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .n(n),
   .fib(fib)
);

integer i;
initial begin
    for (i = 0; i < 8; i++) begin
        n = i;
        #100 $monitor($time, "n:", n, "fib:", fib);
    end
end

endmodule