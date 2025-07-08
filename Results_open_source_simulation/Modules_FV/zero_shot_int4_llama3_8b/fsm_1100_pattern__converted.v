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
    // Property for edge case: reset
    // Property for edge case: invalid transition from S3 to S1
    // Property for overflow/underflow
    // Assert properties
    always @(*) begin assert (!!($rose(clk) |-> ##[1:$] pattern_detected == 1'b1)); end
    always @(*) begin assert (!rst |=>!pattern_detected); end
    always @(*) begin assert (($rose(clk) & pattern_detected & bit_in) |=>!pattern_detected); end
    always @(*) begin assert ((!$rose(clk) | $fell(clk)) |=> pattern_detected == 1'b0); end

endmodule