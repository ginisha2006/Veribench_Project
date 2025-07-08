module tb_param_divider;

    parameter WIDTH = 8;
    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    param_divider #(.WIDTH(WIDTH)) dut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );

    always begin
        #5 dividend <= $random;
        #5 divisor <= $random;
    end

    property p_no_zero_division;
        @(posedge $anyedge) divisor !== 0;
    endproperty
    assert property(p_no_zero_division);

    property p_quotient_calculation;
        @(posedge $anyedge) quotient == dividend / divisor;
    endproperty
    assert property(p_quotient_calculation);

    property p_remainder_calculation;
        @(posedge $anyedge) remainder == dividend % divisor;
    endproperty
    assert property(p_remainder_calculation);

endmodule