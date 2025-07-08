module tb_fibonacci_gen;

parameter WIDTH = 8;

reg clk;
reg rst;
reg start;
reg [WIDTH-1:0] n;
wire [WIDTH-1:0] fib;

fibonacci_gen #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .n(n),
   .fib(fib)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst) fib == 0); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((start && n > 0) |-> fib == 0)); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((start && n > 0) |=> ($rose(start) |=> fib == (a + b)))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((start && n >= WIDTH) |-> ##[1:$] fib!= {(WIDTH{1'b1})}); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((start && n < 0) |-> ##[1:$] fib!= {WIDTH{1'b0}}); end

endmodule