module tb_param_comparator;
    // Parameters
    localparam WIDTH = 8;

    // Input/Output signals
    logic [WIDTH-1:0] A, B;
    logic Equal, Greater, Less;

    // DUT instantiation
    param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

    // Clock generation
    always #10 clk = ~clk; // Assuming a 10ns period clock

    // Property 1: Functional correctness
    property p_func_correctness;
        @(posedge clk) ((A == B) => Equal) |-> (A == B);
        @(posedge clk) ((A > B) => Greater) |-> (A > B);
        @(posedge clk) ((A < B) => Less) |-> (A < B);
    endproperty

    // Property 2: Overflow/Underflow detection
    property p_overflow_underflow;
        @(posedge clk) ($fell(clk) && (|A[WIDTH-1]) && (!|B[WIDTH-1])) |=> ($past(|A[WIDTH-1]) &&!|B[WIDTH-1]);
        @(posedge clk) ($fell(clk) && (!|A[WIDTH-1]) && (|B[WIDTH-1])) |=> (!$past(|A[WIDTH-1]) && |B[WIDTH-1]);
    endproperty

    // Assert properties
    assert property (p_func_correctness);
    assert property (p_overflow_underflow);

endmodule