module tb_bcd_to_gray;
    import "DVLIB::sva";
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    // DUT instantiation
    bcd_to_gray dut (
       .bcd(bcd),
       .gray(gray)
    );

    // Input signal declaration
    logic [BCD_WIDTH-1:0] bcd;

    // Clock signal generation
    always #10 clk = ~clk; // Non-inverting clock

    // Property for functional correctness
    property p_correctness;
        @(posedge clk) ((|bcd) == |(gray));
    endproperty

    // Property for overflow detection
    property p_overflow;
        @(posedge clk) ($rose(|bcd) && |bcd > 2**BCD_WIDTH - 1);
    endproperty

    // Property for underflow detection
    property p_underflow;
        @(posedge clk) ($fell(|bcd) && |bcd < 2**BCD_WIDTH - 1);
    endproperty

    // Assertion for functional correctness
    assert property (p_correctness);

    // Assertion for overflow detection
    assert property (p_overflow) disable iff (!$rose(|bcd));

    // Assertion for underflow detection
    assert property (p_underflow) disable iff (!$fell(|bcd));

endmodule