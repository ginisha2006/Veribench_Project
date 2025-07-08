module tb_param_comparator;
    // Parameters
    localparam WIDTH = 8;

    // Input/Output signals
    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic Equal;
    logic Greater;
    logic Less;

    // DUT instantiation
    param_comparator dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

    // Clock signal generation
    always #10 clk = ~clk; // Non-inverting clock

    // Properties
    property p_equal;
        @(posedge clk) ($rose(A) && $fell(B)) |-> (Equal);
    endproperty

    property p_greater;
        @(posedge clk) ($rose(A) && $fell(B)) |-> (Greater);
    endproperty

    property p_less;
        @(posedge clk) ($rose(A) && $fell(B)) |-> (Less);
    endproperty

    property p_overflow;
        @(posedge clk) ($signed(A) > $max_value($signed(A))) |-> ($rose(Greater));
    endproperty

    property p_underflow;
        @(posedge clk) ($signed(A) < $min_value($signed(A))) |-> ($rose(Less));
    endproperty

    assert property (p_equal);
    assert property (p_greater);
    assert property (p_less);
    assert property (p_overflow);
    assert property (p_underflow);

endmodule