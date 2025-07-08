module tb_param_multiplier(
    parameter WIDTH = 8
);
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [2*WIDTH-1:0] product;

    param_multiplier #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .product(product)
    );

    always begin
        #5 clk = ~clk;
    end

    logic clk;
    clk = 0;

    assert (@(posedge clk) disable iff (!reset)
        (a == 0 |-> product == 0) &&
        (b == 0 |-> product == 0) &&
        (a != 0 & b != 0 |-> product == a * b));

    assert (@(posedge clk) disable iff (!reset)
        ($unsigned(a) > 2**WIDTH - 1 |-> product == {2{1'b1}} << (2*WIDTH-1)) ||
        ($unsigned(b) > 2**WIDTH - 1 |-> product == {2{1'b1}} << (2*WIDTH-1)));

    assert (@(posedge clk) disable iff (!reset)
        ($signed(a) < -(2**(WIDTH-1)) |-> product == {2{1'b0}}) ||
        ($signed(b) < -(2**(WIDTH-1)) |-> product == {2{1'b0}}));

    assert (@(posedge clk) disable iff (!reset)
        (a == 1 & b == 1 |-> product == 1) &&
        (a == 2**WIDTH - 1 & b == 2**WIDTH - 1 |-> product == 2**(2*WIDTH)-1) &&
        (a == 0 & b == 2**WIDTH - 1 |-> product == 0) &&
        (a == 2**WIDTH - 1 & b == 0 |-> product == 0));

endmodule