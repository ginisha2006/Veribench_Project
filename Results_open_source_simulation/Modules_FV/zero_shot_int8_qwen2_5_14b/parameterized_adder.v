module tb_param_adder();
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] sum;
    wire carry;

    param_adder #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    // Clock generation
    reg clk;
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // Functional correctness
    property prop_sum_correct;
        @(posedge clk) disable iff (!reset)
        (a + b == {carry,sum});
    endproperty
    assert property(prop_sum_correct);

    // Overflow check
    property prop_overflow;
        @(posedge clk) disable iff (!reset)
        ($unsigned({{1'b0,a}) + {{1'b0,b}) > 2**WIDTH - 1 |-> carry === 1;
    endproperty
    assert property(prop_overflow);

    // Underflow check
    property prop_underflow;
        @(posedge clk) disable iff (!reset)
        (a < 2**(WIDTH-1) && b < 2**(WIDTH-1) &-> carry === 0;
    endproperty
    assert property(prop_underflow);

    // Edge case when both inputs are maximum value
    property prop_max_input;
        @(posedge clk) disable iff (!reset)
        (a === {WIDTH{1'b1}} && b === {WIDTH{1'b1}} |-> carry === 1;
    endproperty
    assert property(prop_max_input);

    // Illegal transition from max value to min value without reset
    property prop_illegal_transition;
        @(posedge clk) disable iff (!reset)
        (a === {WIDTH{1'b1}} && b === {WIDTH{1'b1}} |=> !($rose(reset));
    endproperty
    assert property(prop_illegal_transition);

endmodule