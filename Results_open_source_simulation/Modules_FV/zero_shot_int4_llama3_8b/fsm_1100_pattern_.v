module tb_fsm_1100();
    // Input and output signals declaration
    logic clk;
    logic rst;
    logic bit_in;
    logic pattern_detected;

    // DUT instantiation
    fsm_1100 dut (
       .clk(clk),
       .rst(rst),
       .bit_in(bit_in),
       .pattern_detected(pattern_detected)
    );

    // Clock signal generation
    always #10 clk = ~clk; // 50% duty cycle

    // Property for functional correctness
    property p_pattern_detected;
       !!($rose(clk) |-> ##[1:$] pattern_detected == 1'b1);
    endproperty

    // Property for edge case: reset
    property p_reset;
       !rst |=>!pattern_detected;
    endproperty

    // Property for edge case: invalid transition from S3 to S1
    property p_invalid_transition;
        ($rose(clk) & pattern_detected & bit_in) |=>!pattern_detected;
    endproperty

    // Property for overflow/underflow
    property p_overflow_underflow;
        (!$rose(clk) | $fell(clk)) |=> pattern_detected == 1'b0;
    endproperty

    // Assert properties
    assert property(p_pattern_detected);
    assert property(p_reset);
    assert property(p_invalid_transition);
    assert property(p_overflow_underflow);

endmodule