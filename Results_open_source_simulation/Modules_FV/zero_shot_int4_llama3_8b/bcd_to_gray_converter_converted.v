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
    // Property for overflow detection
    // Property for underflow detection
    // Assertion for functional correctness
    always @(*) begin assert (@(posedge clk) ((|bcd) == |(gray))); end

    // Assertion for overflow detection
    assert property (p_overflow) disable iff (!$rose(|bcd));

    // Assertion for underflow detection
    assert property (p_underflow) disable iff (!$fell(|bcd));

endmodule