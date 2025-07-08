module tb_param_adder #(
    parameter WIDTH = 8
)(
);
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [WIDTH-1:0] sum;
    logic carry;

    param_adder #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    always begin
        #5 clk = ~clk;
    end

    logic clk;
    initial begin
        clk = 0;
    end

    property prop_no_overflow_underflow;
        @(posedge clk) disable iff (!reset)
        ($unsigned({{WIDTH{a[WIDTH-1]}}, a}) + $unsigned({{WIDTH{b[WIDTH-1]}}, b})) < (2**WIDTH);
    endproperty
    assert property(prop_no_overflow_underflow);

    property prop_carry_behavior;
        @(posedge clk) disable iff (!reset)
        ({WIDTH{a[WIDTH-1]}} + {WIDTH{b[WIDTH-1]}} == 1 |-> carry === 1);
    endproperty
    assert property(prop_carry_behavior);

    property prop_sum_correctness;
        @(posedge clk) disable iff (!reset)
        sum === a + b;
    endproperty
    assert property(prop_sum_correctness);

endmodule