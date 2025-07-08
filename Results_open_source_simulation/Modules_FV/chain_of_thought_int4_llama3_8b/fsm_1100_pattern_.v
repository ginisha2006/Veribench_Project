module tb_fsm_1100();
    parameter PERIOD = 10; // period of the clock signal

    logic clk;
    logic rst;
    logic bit_in;
    logic pattern_detected;

    fsm_1100 uut (
       .clk(clk),
       .rst(rst),
       .bit_in(bit_in),
       .pattern_detected(pattern_detected)
    );

    property p_pattern_detected;
        @(posedge clk) disable iff (!rst)
            ((bit_in == 1'b0 && $rose(pattern_detected)) | (bit_in == 1'b1 && $fell(pattern_detected)));
    endproperty

    property p_edge_cases;
        @(posedge clk) disable iff (!rst)
            ($stable(state) | ($rose(state) | $fell(state)));
    endproperty

    property p_overflow_underflow;
        @(posedge clk) disable iff (!rst)
            (!(state == fsm_1100::S0 && bit_in == 1'b1) ||!(state == fsm_1100::S3 && bit_in == 1'b0));
    endproperty

    property p_illegal_transitions;
        @(posedge clk) disable iff (!rst)
            (!(state == fsm_1100::S0 && next_state!= state) ||
            !(state == fsm_1100::S1 && next_state!= state) ||
            !(state == fsm_1100::S2 && next_state!= state) ||
            !(state == fsm_1100::S3 && next_state!= state));
    endproperty

    assert property(p_pattern_detected);
    assert property(p_edge_cases);
    assert property(p_overflow_underflow);
    assert property(p_illegal_transitions);

    always #PERIOD clk = ~clk;

    initial begin
        rst = 1'b1;
        #5 rst = 1'b0;
        #20 bit_in = 1'b1;
        #40 bit_in = 1'b0;
        #60 $stop;
    end
endmodule