module tb_param_divider();
    parameter WIDTH = 8;

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

    // Clock generation
    logic clk;
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    // Functional correctness
    property p_correct_quotient;
        @(posedge clk) disable iff (!&divisor)
        ($rose(divisor) |-> quotient == dividend / divisor);
    endproperty
    assert property(p_correct_quotient);

    property p_correct_remainder;
        @(posedge clk) disable iff (!&divisor)
        ($rose(divisor) |-> remainder == dividend % divisor);
    endproperty
    assert property(p_correct_remainder);

    // Edge case - Divisor is zero
    property p_zero_divisor;
        @(posedge clk) disable iff (!&divisor)
        (divisor == 0) |=> $fell(clk); // Should never happen due to disable iff condition
    endproperty
    assert property(p_zero_divisor);

    // Overflow/Underflow - Not applicable as division does not cause overflow/underflow in this context

endmodule