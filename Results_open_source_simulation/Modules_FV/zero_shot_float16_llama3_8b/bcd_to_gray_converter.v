module tb_bcd_to_gray;
    // Input and output signals declaration
    logic [3:0] bcd_in;
    logic [3:0] gray_out;

    // Instantiate the DUT
    bcd_to_gray dut (
       .bcd(bcd_in),
       .gray(gray_out)
    );

    // Clock signal generation
    always #10 clk = ~clk; // 10 ns period

    // Property for functional correctness
    property p_correct_conversion;
        @(posedge clk) ($onehotb(bcd_in) && $onehotb(gray_out));
    endproperty

    // Property for overflow/underflow detection
    property p_overflow_underflow;
        @(posedge clk) ((bcd_in >= 9'd1000) | (bcd_in < 9'd0000)) =>!($onehotb(gray_out));
    endproperty

    // Property for illegal transition
    property p_illegal_transition;
        @(posedge clk) ((bcd_in!= bcd_in) => $onehotb(gray_out));
    endproperty

    // Assert properties
    assert property (p_correct_conversion);
    assert property (p_overflow_underflow);
    assert property (p_illegal_transition);

endmodule