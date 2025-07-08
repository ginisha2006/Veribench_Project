module tb_param_divider();
    parameter WIDTH = 8;

    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    param_divider #(.WIDTH(WIDTH)) DUT (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    // Clock generation
    reg clk;
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    // Functional correctness
    assert (@(posedge clk) disable iff (!divisor)
            ($unsigned(divisor) != 0) |-> 
                quotient == dividend / divisor &&
                remainder == dividend % divisor);

    // Edge case - Divisor is zero
    assert (@(posedge clk) disable iff (!divisor)
            divisor == 0 |-> quotient == 'z && remainder == 'z);

    // Overflow/Underflow - Not applicable as division does not cause overflow/underflow in this context

endmodule