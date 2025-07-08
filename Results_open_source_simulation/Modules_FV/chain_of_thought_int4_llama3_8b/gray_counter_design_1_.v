module tb_gray_count();
    parameter CLOCK_PERIOD = 10;

    logic clk;
    logic enable;
    logic reset;
    logic [7:0] gray_count_exp;

    gray_count dut (
       .clk(clk),
       .enable(enable),
       .reset(reset),
       .gray_count(gray_count_exp)
    );

    property p_reset_value;
       !reset -> ($rose(reset) | $fell(reset));
    endproperty

    property p_enable_transition;
        enable == 1 -> (!$stable(enable));
    endproperty

    property p_gray_count_reset;
        reset -> gray_count == 0;
    endproperty

    property p_gray_count_enable;
        enable &&!reset -> gray_count!= gray_count_exp;
    endproperty

    property p_no_ones_below;
        always (posedge clk) disable iff (!reset) $stable(no_ones_below);
    endproperty

    property p_q_msb;
        always (posedge clk) disable iff (!reset) $stable(q_msb);
    endproperty

    property p_gray_count_update;
        enable &&!reset -> $rise(gray_count) == gray_count_exp;
    endproperty

    assert property (p_reset_value);
    assert property (p_enable_transition);
    assert property (p_gray_count_reset);
    assert property (p_gray_count_enable);
    assert property (p_no_ones_below);
    assert property (p_q_msb);
    assert property (p_gray_count_update);

    always #CLOCK_PERIOD clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        repeat (5) @(posedge clk);
        reset = 0;
        enable = 1;
        repeat (20) @(posedge clk);
        enable = 0;
        repeat (5) @(posedge clk);
        reset = 1;
        enable = 0;
        repeat (5) @(posedge clk);
    end
endmodule