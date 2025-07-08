module tb_fsm_1100();

    // Input/Output signals declaration
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

    // Clock generation
    always #10 clk = ~clk; // 10ns period

    // Property 1: Functional correctness
    property p_func_correctness;
        @(posedge clk) ((rst) |=> ($onehot(dut.state)) );
    endproperty

    assert property (p_func_correctness);

    // Property 2: Edge case - Reset
    property p_reset_edge;
        @(negedge rst)!dut.bit_in |-> (dut.state == fsm_1100::S0);
    endproperty

    assert property (p_reset_edge);

    // Property 3: Pattern detection
    property p_pattern_detection;
        @(posedge clk) (dut.pattern_detected == (dut.state == fsm_1100::S3 && dut.bit_in == 0));
    endproperty

    assert property (p_pattern_detection);

    // Property 4: Overflow/Underflow
    property p_overflow_underflow;
        @(posedge clk) (!rst && dut.bit_in!= dut.bit_in) |-> ##[0:9] dut.bit_in;
    endproperty

    assert property (p_overflow_underflow);

endmodule