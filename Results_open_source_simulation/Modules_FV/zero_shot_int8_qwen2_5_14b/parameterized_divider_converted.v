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
    assert (@(posedge clk) disable iff (!divisor)
            ($unsigned(dividend) == $unsigned(divisor * quotient + remainder)));

    // Divisor cannot be zero
    always @(*) begin assert (@(posedge clk) !(!divisor & (quotient !== 'bx | remainder !== 'bx))); end

    // Quotient and Remainder within bounds
    assert (@(posedge clk) (quotient >= 0) && (quotient < 256) &&
                       (remainder >= 0) && (remainder < 256));

    // Edge case when dividend is zero
    always @(*) begin assert (@(posedge clk) (dividend === 0) |-> (quotient === 0) && (remainder === 0)); end

    // Edge case when divisor is one
    always @(*) begin assert (@(posedge clk) (divisor === 1) |-> (quotient === dividend) && (remainder === 0)); end

    // Edge case when divisor equals dividend
    always @(*) begin assert (@(posedge clk) (dividend === divisor) |-> (quotient === 1) && (remainder === 0)); end

    // Illegal transition detection
    always @(*) begin assert (@(posedge clk) !(nextval'(quotient) != quotient)); end

    always @(*) begin assert (@(posedge clk) !(nextval'(remainder) != remainder)); end
endmodule