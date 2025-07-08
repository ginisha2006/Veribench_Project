module tb_param_divider (
    parameter WIDTH = 8
);
    logic [WIDTH-1:0] dividend;
    logic [WIDTH-1:0] divisor;
    logic [WIDTH-1:0] quotient;
    logic [WIDTH-1:0] remainder;

    param_divider #(.WIDTH(WIDTH)) dut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    always begin
        #5 clk = ~clk;
    end

    logic clk;
    clk = 0;

    assert (@(posedge clk) disable iff (!reset)
        divisor != 0);

    assert (@(posedge clk) disable iff (!reset)
        quotient == dividend / divisor);

    assert (@(posedge clk) disable iff (!reset)
        remainder == dividend % divisor);

    assert (@(posedge clk) disable iff (!reset)
        (dividend == 'hFF && divisor == 1) |-> (quotient == 'hFF && remainder == 0));

    assert (@(posedge clk) disable iff (!reset)
        (dividend < divisor) |-> (quotient == 0 && remainder == dividend));

endmodule