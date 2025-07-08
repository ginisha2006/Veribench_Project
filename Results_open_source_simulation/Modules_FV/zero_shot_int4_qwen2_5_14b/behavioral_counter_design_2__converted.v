module tb_behav_counter(
    input [7:0] d,
    input clk,
    input clear,
    input load,
    input up_down,
    output reg [7:0] qd
);
    
reg [7:0] cnt;

behav_counter dut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
);

always #5 clk = ~clk;

assert (@(posedge clk) disable iff (!reset)
 !clear |-> (cnt == 8'b0));

assert (@(posedge clk) disable iff (!reset)
 load ##1 !load |-> (cnt == d));

assert (@(posedge clk) disable iff (!reset)
 up_down & !load & !clear |-> (cnt === cnt[6:0] ? cnt : cnt + 1));

assert (@(posedge clk) disable iff (!reset)
 !up_down & !load & !clear |-> (cnt === 8'b00000001 ? cnt : cnt - 1));

endmodule