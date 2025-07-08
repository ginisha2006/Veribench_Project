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
    property p_fibonacci_correctness;
        @(posedge clk) disable iff (!rst)
        (dut.count == 0 |-> dut.fib == 0) &&
        (dut.count == 1 |-> dut.fib == 1) &&
        (dut.count > 1 && dut.start === 1 |-> 
         ($past(dut.fib) == $past(dut.a) + $past(dut.b)));
    endproperty
    assert property(p_fibonacci_correctness);

    // Edge case when n is 0
    property p_edge_case_n_is_zero;
        @(posedge clk) disable iff (!rst)
        (n == 0 & start === 1 |-> fib == 0);
    endproperty
    assert property(p_edge_case_n_is_zero);

    // Edge case when n is 1
    property p_edge_case_n_is_one;
        @(posedge clk) disable iff (!rst)
        (n == 1 & start === 1 |-> fib == 1);
    endproperty
    assert property(p_edge_case_n_is_one);

    // Overflow check
    property p_overflow_check;
        @(posedge clk) disable iff (!rst)
        (dut.count >= n - 2 & start === 1 |-> 
         $rose(dut.fib[WIDTH-1]) |-> $stable(dut.fib));
    endproperty
    assert property(p_overflow_check);

    // Illegal transition
    property p_illegal_transition;
        @(posedge clk) disable iff (!rst)
        (start !== 1 |-> !($changed(dut.fib)));
    endproperty
    assert property(p_illegal_transition);
endmodule