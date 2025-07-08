module tb_fibonacci_gen;
    // Input/Output signals declaration
    parameter WIDTH = 8;
    logic clk;
    logic rst;
    logic start;
    logic [WIDTH-1:0] n;
    logic [WIDTH-1:0] fib_expected;
    logic [WIDTH-1:0] fib_actual;

    // DUT instantiation
    fibonacci_gen #(.WIDTH(WIDTH)) dut (.clk(clk),.rst(rst),.start(start),.n(n),.fib(fib_actual));

    // Clock generation
    always #10 clk = ~clk; // Non-inverting clock

    // Property 1: Correctness
    property p_correctness;
        @(posedge clk) disable iff (!rst) fib_actual == (n > 0)? (n <= WIDTH)? fib_expected : $unsigned'(0) : $unsigned'(0);
    endproperty

    // Property 2: Overflow detection
    property p_overflow;
        @(posedge clk) disable iff (!rst) ($signed'(fib_actual) > $signed'(1 << WIDTH)) |-> $fatal(1, "Overflow detected");
    endproperty

    // Property 3: Underflow detection
    property p_underflow;
        @(posedge clk) disable iff (!rst) ($signed'(fib_actual) < $signed'(0)) |-> $fatal(1, "Underflow detected");
    endproperty

    // Property 4: Illegal transition detection
    property p_illegal_transition;
        @(posedge clk) disable iff (!rst) ((n!= 0 &&!start) || (n == 0 && start)) |-> $fatal(1, "Illegal transition detected");
    endproperty

    // Assert properties
    assert property(p_correctness);
    assert property(p_overflow);
    assert property(p_underflow);
    assert property(p_ilegal_transition);

endmodule