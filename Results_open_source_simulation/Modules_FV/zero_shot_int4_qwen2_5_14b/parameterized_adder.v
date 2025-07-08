module tb_param_adder();
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] sum;
    wire carry;

    param_adder #(.WIDTH(WIDTH)) uut (
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
    assert property (@(posedge clk) disable iff (!reset) ({carry, sum} === a + b));

    // Overflow check
    property no_overflow;
        @(posedge clk) disable iff (!reset)
        ($unsigned({{1'b0,a}, {1'b0,b}}) < $unsigned('hFFFFFFFFFFFFFFFE))
            |-> ({carry, sum} == a + b);
    endproperty
    assert property(no_overflow);

    // Underflow check
    property no_underflow;
        @(posedge clk) disable iff (!reset)
        ($signed({{1'b0,a}, {1'b0,b}}) > $signed('hFFFFFFFFFFFFFFFE))
            |-> ({carry, sum} == a + b);
    endproperty
    assert property(no_underflow);

endmodule