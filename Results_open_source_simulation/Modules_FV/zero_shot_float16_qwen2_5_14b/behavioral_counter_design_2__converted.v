module tb_behav_counter(
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
    load |-> (cnt == d));

assert (@(posedge clk) disable iff (!reset)
    up_down & !load & !clear |=> (cnt == $past(cnt) + 1));

assert (@(posedge clk) disable iff (!reset)
    !up_down & !load & !clear |=> (cnt == $past(cnt) - 1));

assert (@(posedge clk) disable iff (!reset)
    !up_down & !load & !clear & (cnt == 8'b0000_0001) |-> (cnt == 8'b1000_0000));

assert (@(posedge clk) disable iff (!reset)
    up_down & !load & !clear & (cnt == 8'b1111_1110) |-> (cnt == 8'b0000_0000));

endmodule