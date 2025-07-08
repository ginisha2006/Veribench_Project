module tb_param_divider(
    input [7:0] dividend,
    input [7:0] divisor,
    output reg clk
);
    wire [7:0] quotient;
    wire [7:0] remainder;

    param_divider #(.WIDTH(8)) dut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end

    // Functional correctness
    property p_func_correctness;
        @(posedge clk) disable iff (!divisor)
            ($unsigned(dividend) == $unsigned(divisor * quotient + remainder));
    endproperty
    assert property(p_func_correctness);

    // Divisor cannot be zero
    property p_no_zero_divisor;
        @(posedge clk) !(!divisor & (quotient !== 'bx | remainder !== 'bx));
    endproperty
    assert property(p_no_zero_divisor);

    // Quotient and Remainder within bounds
    property p_within_bounds;
        @(posedge clk) (quotient >= 0) && (quotient < 256) &&
                       (remainder >= 0) && (remainder < 256);
    endproperty
    assert property(p_within_bounds);

    // Edge case when dividend is zero
    property p_edge_case_zero_dividend;
        @(posedge clk) (dividend === 0) |-> (quotient === 0) && (remainder === 0);
    endproperty
    assert property(p_edge_case_zero_dividend);

    // Edge case when divisor is one
    property p_edge_case_one_divisor;
        @(posedge clk) (divisor === 1) |-> (quotient === dividend) && (remainder === 0);
    endproperty
    assert property(p_edge_case_one_divisor);

    // Edge case when divisor equals dividend
    property p_edge_case_equal_dividend_divisor;
        @(posedge clk) (dividend === divisor) |-> (quotient === 1) && (remainder === 0);
    endproperty
    assert property(p_edge_case_equal_dividend_divisor);

    // Illegal transition detection
    property p_illegal_transition_quotient;
        @(posedge clk) !(nextval'(quotient) != quotient);
    endproperty
    assert property(p_illegal_transition_quotient);

    property p_illegal_transition_remainder;
        @(posedge clk) !(nextval'(remainder) != remainder);
    endproperty
    assert property(p_illegal_transition_remainder);
endmodule