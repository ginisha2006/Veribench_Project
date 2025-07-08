module tb_param_multiplier #(
    parameter WIDTH = 8
)(
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
    initial begin
        clk = 0;
    end

    // Functional correctness
    assert property (@(posedge clk) disable iff (!reset) product == a * b);

    // Edge case - overflow
    property prop_overflow;
        @(posedge clk) disable iff (!reset)
        ($signed({{WIDTH{a[WIDTH-1]}}, a}) * $signed({{WIDTH{b[WIDTH-1]}}, b})) > {{WIDTH{a[WIDTH-1]}}, a} * {{WIDTH{b[WIDTH-1]}}, b};
    endproperty
    assert property(prop_overflow);

    // Illegal transition - negative values should not cause unexpected results
    property prop_illegal_transition;
        @(posedge clk) disable iff (!reset)
        !($signed({{WIDTH{a[WIDTH-1]}}, a}) < 0 && $signed({{WIDTH{b[WIDTH-1]}}, b}) < 0 || 
           $signed({{WIDTH{a[WIDTH-1]}}, a}) >= 0 && $signed({{WIDTH{b[WIDTH-1]}}, b}) <= 0 ||
           $signed({{WIDTH{a[WIDTH-1]}}, a}) <= 0 && $signed({{WIDTH{b[WIDTH-1]}}, b}) >= 0);
    endproperty
    assert property(prop_illegal_transition);

endmodule