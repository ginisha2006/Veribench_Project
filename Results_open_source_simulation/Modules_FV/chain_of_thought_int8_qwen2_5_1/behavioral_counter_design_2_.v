module tb_behav_counter (
    input [7:0] d,
    input clk,
    input clear,
    input load,
    input up_down,
    output reg [7:0] qd
);
    
wire [7:0] cnt;
behav_counter dut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
);

reg clk_signal = 0;
always #5 clk_signal = ~clk_signal;
assign clk = clk_signal;

property reset_assertion;
    @(posedge clk) disable iff (!reset)
    !clear |=> (cnt == 8'b0);
endproperty
assert property(reset_assertion);

property load_assertion;
    @(posedge clk) disable iff (!reset)
    load ##1 !load |-> (cnt == d);
endproperty
assert property(load_assertion);

property increment_decrement;
    @(posedge clk) disable iff (!reset)
    up_down && !load && !clear |-> (cnt[7:0] == (cnt[7:0] + 1)[7:0]);
    @(posedge clk) disable iff (!reset)
    !up_down && !load && !clear |-> (cnt[7:0] == (cnt[7:0] - 1)[7:0]);
endproperty
assert property(increment_decrement);

property overflow_underflow;
    @(posedge clk) disable iff (!reset)
    up_down && cnt == 8'hFF |-> (cnt == 8'h00);
    @(posedge clk) disable iff (!reset)
    !up_down && cnt == 8'h00 |-> (cnt == 8'hFF);
endproperty
assert property(overflow_underflow);

property transition_check;
    @(posedge clk) disable iff (!reset)
    !clear && !load && up_down |-> (cnt != cnt - 1);
    @(posedge clk) disable iff (!reset)
    !clear && !load && !up_down |-> (cnt != cnt + 1);
endproperty
assert property(transition_check);

endmodule