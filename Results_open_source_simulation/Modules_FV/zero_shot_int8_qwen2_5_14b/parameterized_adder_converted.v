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
    assert (@(posedge clk) disable iff (!reset)
        (a + b == {carry,sum}));

    // Overflow check
    assert (@(posedge clk) disable iff (!reset)
        ($unsigned({{1'b0,a}) + {{1'b0,b}) > 2**WIDTH - 1 |-> carry === 1);

    // Underflow check
    assert (@(posedge clk) disable iff (!reset)
        (a < 2**(WIDTH-1) && b < 2**(WIDTH-1) &-> carry === 0);

    // Edge case when both inputs are maximum value
    assert (@(posedge clk) disable iff (!reset)
        (a === {WIDTH{1'b1}} && b === {WIDTH{1'b1}} |-> carry === 1);

    // Illegal transition from max value to min value without reset
    assert (@(posedge clk) disable iff (!reset)
        (a === {WIDTH{1'b1}} && b === {WIDTH{1'b1}} |=> !($rose(reset)));

endmodule