module tb_fibonacci_gen();
    parameter WIDTH = 8;
    
    wire clk;
    wire rst;
    wire start;
    wire [WIDTH-1:0] n;
    wire [WIDTH-1:0] fib;
    
    fibonacci_gen #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );
    
    // Clock generation
    reg clk;
    always #5 clk = ~clk;
    
    // Properties
    property reset_assertion;
        @(posedge rst) disable iff (!rst)
        rst |-> (fib == 0 && n == 0 && start == 0);
    endproperty
    
    assert property(reset_assertion);
    
    property start_sequence;
        @(posedge clk) disable iff (!rst)
        start ##1 start[*]
        |-> (fib[WIDTH-1] !== fib[WIDTH-2]);
    endproperty
    
    assert property(start_sequence);
    
    property correct_fibonacci;
        @(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> ($past(fib) == $past(a) + $past(b));
    endproperty
    
    assert property(correct_fibonacci);
    
    property no_overflow_underflow;
        @(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> !(a > fib || b > fib || a < fib || b < fib);
    endproperty
    
    assert property(no_overflow_underflow);
    
    property final_value;
        @(posedge clk) disable iff (!rst)
        start[*] ##1 start[*]
        |-> (fib == $past($past(a) + $past(b)));
    endproperty
    
    assert property(final_value);
endmodule