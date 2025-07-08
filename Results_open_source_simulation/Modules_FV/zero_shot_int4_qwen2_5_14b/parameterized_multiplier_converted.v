module tb_param_multiplier();
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [2*WIDTH-1:0] product;

    param_multiplier #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .product(product)
    );

    // Clock generation
    reg clk;
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // Functional correctness
    assert property (@(posedge clk) disable iff (!reset) product == a * b);

    // Overflow check
    assert (@(posedge clk) disable iff (!reset)
            ($signed({{WIDTH{b[WIDTH-1]}}, b}) > 0 && $signed({{WIDTH{a[WIDTH-1]}}, a}) > 0 |-> 
             product >= {{WIDTH{b[WIDTH-1]}}, b} * {{WIDTH{a[WIDTH-1]}}, a})
            &&
            ($signed({{WIDTH{b[WIDTH-1]}}, b}) < 0 && $signed({{WIDTH{a[WIDTH-1]}}, a}) < 0 |-> 
             product <= {{WIDTH{b[WIDTH-1]}}, b} * {{WIDTH{a[WIDTH-1]}}, a}));

endmodule