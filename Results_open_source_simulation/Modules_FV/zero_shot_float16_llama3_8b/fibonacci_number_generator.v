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

property p_initial_state;
    @(posedge clk) disable iff (!rst) fib == 0;
endproperty

property p_start_sequence;
    @(posedge clk) disable iff (!rst) ((start && n > 0) |-> fib == 0);
endproperty

property p_fibonacci_sequence;
    @(posedge clk) disable iff (!rst) ((start && n > 0) |=> ($rose(start) |=> fib == (a + b)));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst) ((start && n >= WIDTH) |-> ##[1:$] fib!= {(WIDTH{1'b1})};
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst) ((start && n < 0) |-> ##[1:$] fib!= {WIDTH{1'b0}};
endproperty

assert property (p_initial_state);
assert property (p_start_sequence);
assert property (p_fibonacci_sequence);
assert property (p_overflow);
assert property (p_underflow);

endmodule