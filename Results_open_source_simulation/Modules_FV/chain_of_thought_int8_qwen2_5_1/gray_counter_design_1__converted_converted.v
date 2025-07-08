module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
reg q [7:-1];
reg no_ones_below [7:-1];
reg q_msb;

assert (@(posedge reset) disable iff (!reset)
 reset == 1 |-> ##1 {q[-1] == 1, q[0] == 0, q[1] == 0, q[2] == 0, q[3] == 0, q[4] == 0, q[5] == 0, q[6] == 0, q[7] == 0});

assert (@(posedge clk) disable iff (!enable || reset)
 enable == 1 |-> ##1 {q[-1] !== q[-1], q[0] !== q[0], q[1] !== q[1], q[2] !== q[2], q[3] !== q[3], q[4] !== q[4], q[5] !== q[5], q[6] !== q[6], q[7] !== q[7]});

assert (@(posedge clk) disable iff (reset)
 !reset |-> q_msb inside {[0 : 1]});

assert (@(negedge clk) disable iff (reset)
 !reset |-> no_ones_below[-1] == 1);

assert (@(posedge clk) disable iff (reset)
 !reset |-> gray_count != gray_count[+1:]);

assert (@(posedge clk) disable iff (reset)
 !reset |-> gray_count < 8'b10000000);

assert (@(posedge clk) disable iff (reset)
 !reset |-> !(gray_count == 8'hFF && enable));

always #5 clk =~clk;
endmodule