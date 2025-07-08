module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    wire [7:0] q;
    wire [7:0] no_ones_below;
    wire q_msb;

    gray_count dut (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .gray_count(gray_count)
    );

    always begin
        #5 clk = ~clk;
    end

    property reset_behavior;
        @(posedge reset) disable iff (!reset)
        ($rose(reset)) |-> (gray_count == 8'b0 && q[-1] === 1'b1);
    endproperty
    assert property (reset_behavior);

    property enable_behavior;
        @(posedge clk) disable iff (!enable || reset)
        enable ##1 gray_count !== gray_count;
    endproperty
    assert property (enable_behavior);

    property no_overflow_underflow;
        @(posedge clk) disable iff (reset)
        (!$isunknown(gray_count));
    endproperty
    assert property (no_overflow_underflow);

    property msb_sync;
        @(posedge clk) disable iff (reset)
        q_msb == (q[7] | q[6]);
    endproperty
    assert property (msb_sync);

    property no_ones_below_sync;
        @(posedge clk) disable iff (reset)
        no_ones_below[-1] == 1'b1 &&
        foreach(no_ones_below[i])
            no_ones_below[i] == (no_ones_below[i-1] & !q[i-1]);
    endproperty
    assert property (no_ones_below_sync);

    property gray_transition;
        @(posedge clk) disable iff (reset)
        foreach(q[i])
            q[i] == (q[i] ^ (q[i-1] & no_ones_below[i-1]));
    endproperty
    assert property (gray_transition);
endmodule