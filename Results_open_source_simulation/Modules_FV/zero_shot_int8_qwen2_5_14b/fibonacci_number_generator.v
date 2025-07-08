module tb_fibonacci_gen();
    parameter WIDTH = 8;
    
    wire clk;
    wire rst;
    wire start;
    wire [WIDTH-1:0] n;
    reg [WIDTH-1:0] fib;
    
    fibonacci_gen uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Functional correctness
    property p_correctness;
        @(posedge clk) disable iff (rst)
        (start && !($past(start))) |-> ##[2:$] (fib == $shift_left(1, n));
    endproperty
    
    assert property(p_correctness);

    // Edge case when n is 0
    property p_edge_case_n_zero;
        @(posedge clk) disable iff (rst)
        (start && n == 0) |-> ##1 fib == 0;
    endproperty
    
    assert property(p_edge_case_n_zero);

    // Edge case when n is 1
    property p_edge_case_n_one;
        @(posedge clk) disable iff (rst)
        (start && n == 1) |-> ##1 fib == 1;
    endproperty
    
    assert property(p_edge_case_n_one);

    // Overflow check
    property p_overflow_check;
        @(posedge clk) disable iff (rst)
        (start && n > WIDTH - 2) |-> ##[2:$] fib == {WIDTH{1'b1}};
    endproperty
    
    assert property(p_overflow_check);

    // Illegal transition from reset state
    property p_illegal_transition;
        @(posedge clk) disable iff (rst)
        (!rst && $past(rst)) |-> !(start && n != 0);
    endproperty
    
    assert property(p_illegal_transition);
endmodule