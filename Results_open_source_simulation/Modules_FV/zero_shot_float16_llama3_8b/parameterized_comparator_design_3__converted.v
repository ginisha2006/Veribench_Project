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
    // Property 2: Overflow/Underflow detection
    // Assert properties
    always @(*) begin assert (@(posedge clk) ((A == B) => Equal) |-> (A == B); end
        @(posedge clk) ((A > B) => Greater) |-> (A > B);
        @(posedge clk) ((A < B) => Less) |-> (A < B));
    always @(*) begin assert (@(posedge clk) ($fell(clk) && (|A[WIDTH-1]) && (!|B[WIDTH-1])) |=> ($past(|A[WIDTH-1]) &&!|B[WIDTH-1]); end
        @(posedge clk) ($fell(clk) && (!|A[WIDTH-1]) && (|B[WIDTH-1])) |=> (!$past(|A[WIDTH-1]) && |B[WIDTH-1]));

endmodule