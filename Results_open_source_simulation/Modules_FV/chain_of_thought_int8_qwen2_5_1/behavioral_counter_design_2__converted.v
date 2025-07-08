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

assert (@(posedge clk) disable iff (!reset)
    !clear |=> (cnt == 8'b0));

assert (@(posedge clk) disable iff (!reset)
    load ##1 !load |-> (cnt == d));

assert (@(posedge clk) disable iff (!reset)
    up_down && !load && !clear |-> (cnt[7:0] == (cnt[7:0] + 1)[7:0]);
    @(posedge clk) disable iff (!reset)
    !up_down && !load && !clear |-> (cnt[7:0] == (cnt[7:0] - 1)[7:0]));

assert (@(posedge clk) disable iff (!reset)
    up_down && cnt == 8'hFF |-> (cnt == 8'h00);
    @(posedge clk) disable iff (!reset)
    !up_down && cnt == 8'h00 |-> (cnt == 8'hFF));

assert (@(posedge clk) disable iff (!reset)
    !clear && !load && up_down |-> (cnt != cnt - 1);
    @(posedge clk) disable iff (!reset)
    !clear && !load && !up_down |-> (cnt != cnt + 1));

endmodule