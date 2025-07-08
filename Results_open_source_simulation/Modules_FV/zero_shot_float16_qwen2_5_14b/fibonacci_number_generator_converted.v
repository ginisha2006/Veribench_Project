module tb_fibonacci_gen();
    parameter WIDTH = 8;
    
    logic clk;
    logic rst;
    logic start;
    logic [WIDTH-1:0] n;
    logic [WIDTH-1:0] fib;
    
    fibonacci_gen #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );
    
    // Clock generation
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    // Functional correctness
    assert (@(posedge clk) disable iff (!rst)
        (dut.count == 0 |-> dut.fib == 0) &&
        (dut.count == 1 |-> dut.fib == 1) &&
        (dut.count > 1 && dut.start === 1 |-> 
         ($past(dut.fib) == $past(dut.a) + $past(dut.b))));

    // Edge case when n is 0
    assert (@(posedge clk) disable iff (!rst)
        (n == 0 & start === 1 |-> fib == 0));

    // Edge case when n is 1
    assert (@(posedge clk) disable iff (!rst)
        (n == 1 & start === 1 |-> fib == 1));

    // Overflow check
    assert (@(posedge clk) disable iff (!rst)
        (dut.count >= n - 2 & start === 1 |-> 
         $rose(dut.fib[WIDTH-1]) |-> $stable(dut.fib)));

    // Illegal transition
    assert (@(posedge clk) disable iff (!rst)
        (start !== 1 |-> !($changed(dut.fib))));
endmodule