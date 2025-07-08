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

property reset_clear;
    @(posedge clk) disable iff (!reset)
    !clear |=> (cnt == 8'b0);
endproperty
assert property(reset_clear);

property load_value;
    @(posedge clk) disable iff (!reset)
    load |-> (cnt == d);
endproperty
assert property(load_value);

property increment;
    @(posedge clk) disable iff (!reset)
    up_down & !load & !clear |=> (cnt == $past(cnt) + 1);
endproperty
assert property(increment);

property decrement;
    @(posedge clk) disable iff (!reset)
    !up_down & !load & !clear |=> (cnt == $past(cnt) - 1);
endproperty
assert property(decrement);

property underflow;
    @(posedge clk) disable iff (!reset)
    !up_down & !load & !clear & (cnt == 8'b0000_0001) |-> (cnt == 8'b1000_0000);
endproperty
assert property(underflow);

property overflow;
    @(posedge clk) disable iff (!reset)
    up_down & !load & !clear & (cnt == 8'b1111_1110) |-> (cnt == 8'b0000_0000);
endproperty
assert property(overflow);

endmodule