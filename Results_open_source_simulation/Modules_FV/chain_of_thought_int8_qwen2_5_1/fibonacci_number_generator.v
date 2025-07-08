module tb_fibonacci_gen (
    input clk,
    input rst,
    input start,
    input [7:0] n,
    output reg [7:0] fib
);

    wire [7:0] a, b;
    wire [7:0] count;

    fibonacci_gen dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );

    always begin
        #5 clk = ~clk;
    end

    property reset_assertion;
        @(posedge rst) disable iff (!rst)
        (a == 0) |-> ##1 (b == 1 && fib == 0 && count == 0);
    endproperty
    assert property(reset_assertion);

    property start_sequence;
        @(posedge clk) disable iff (!start)
        (start && !rst) |-> ##[1:$] (count == n || fib == a + b);
    endproperty
    assert property(start_sequence);

    property overflow_check;
        @(posedge clk) disable iff (!start || rst)
        ($rose(count == n)) |-> (fib == a + b);
    endproperty
    assert property(overflow_check);

    property underflow_check;
        @(posedge clk) disable iff (!start || rst)
        (count < n) |-> (fib == a + b);
    endproperty
    assert property(underflow_check);

    property illegal_transition;
        @(posedge clk) disable iff (!start || rst)
        (count != n - 1 && count != n) |-> !(fib == a + b);
    endproperty
    assert property(illegal_transition);

endmodule