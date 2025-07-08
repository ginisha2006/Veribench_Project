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
    // Property 2: Overflow detection
    // Property 3: Underflow detection
    // Property 4: Illegal transition detection
    // Assert properties
    always @(*) begin assert (@(posedge clk) disable iff (!rst) fib_actual == (n > 0)? (n <= WIDTH)? fib_expected : $unsigned'(0) : $unsigned'(0)); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst) ($signed'(fib_actual) > $signed'(1 << WIDTH)) |-> $fatal(1, "Overflow detected")); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst) ($signed'(fib_actual) < $signed'(0)) |-> $fatal(1, "Underflow detected")); end
    assert property(p_ilegal_transition);

endmodule