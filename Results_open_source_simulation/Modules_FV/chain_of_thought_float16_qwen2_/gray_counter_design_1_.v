module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
reg q [7:-1];
reg no_ones_below [7:-1];
reg q_msb;

property reset_behavior;
 @(posedge reset) disable iff (!reset)
 reset == 1'b1 |-> ##1 {q[-1] === 1'b1, q[0] === 1'b0, q[1] === 1'b0, q[2] === 1'b0, q[3] === 1'b0, q[4] === 1'b0, q[5] === 1'b0, q[6] === 1'b0, q[7] === 1'b0};
endproperty
assert property(reset_behavior);

property enable_behavior;
 @(posedge clk) disable iff (!enable || reset)
 enable == 1'b1 |-> ##1 q[-1] !== q[-1];
endproperty
assert property(enable_behavior);

property no_ones_below_calculation;
 @(posedge clk) disable iff (reset)
 !no_ones_below[0] |-> no_ones_below[0] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[1] && q[0] === 1'b0 |-> no_ones_below[1] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[2] && q[0] === 1'b0 && q[1] === 1'b0 |-> no_ones_below[2] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[3] && q[0] === 1'b0 && q[1] === 1'b0 && q[2] === 1'b0 |-> no_ones_below[3] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[4] && q[0] === 1'b0 && q[1] === 1'b0 && q[2] === 1'b0 && q[3] === 1'b0 |-> no_ones_below[4] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[5] && q[0] === 1'b0 && q[1] === 1'b0 && q[2] === 1'b0 && q[3] === 1'b0 && q[4] === 1'b0 |-> no_ones_below[5] === 1'b1;
 @(posedge clk) disable iff (reset)
 !no_ones_below[6] && q[0] === 1'b0 && q[1] === 1'b0 && q[2] === 1'b0 && q[3] === 1'b0 && q[4] === 1'b0 && q[5] === 1'b0 |-> no_ones_below[6] === 1'b1;
endproperty
assert property(no_ones_below_calculation);

property msb_calculation;
 @(posedge clk) disable iff (reset)
 q_msb === q[7] | q[6];
endproperty
assert property(msb_calculation);

property gray_count_calculation;
 @(posedge clk) disable iff (reset)
 gray_count === {q[7], q[6], q[5], q[4], q[3], q[2], q[1], q[0]};
endproperty
assert property(gray_count_calculation);

property no_overflow_underflow;
 @(posedge clk) disable iff (reset)
 !(q[-1] !== q[-1]) |-> gray_count inside {[0 : 255]};
endproperty
assert property(no_overflow_underflow);

property legal_transitions;
 @(posedge clk) disable iff (reset)
 enable == 1'b1 |-> ##1 {q[-1] !== q[-1], q[0] !== q[0], q[1] !== q[1], q[2] !== q[2], q[3] !== q[3], q[4] !== q[4], q[5] !== q[5], q[6] !== q[6], q[7] !== q[7]};
endproperty
assert property(legal_transitions);
endmodule