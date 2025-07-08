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

reg clk_gen;
always #5 clk_gen = ~clk_gen;
assign clk = clk_gen;

property reset_low;
 @(posedge clk) disable iff (!reset_low)
 !clear |=> (cnt == 8'b0);
endproperty
assert property(reset_low);

property load_behavior;
 @(posedge clk) disable iff (!load)
 load |-> (cnt == d);
endproperty
assert property(load_behavior);

property up_count;
 @(posedge clk) disable iff (!up_down || load || clear)
 up_down & !(cnt == 8'hFF) |-> (cnt == cnt[6:0] + 1);
endproperty
assert property(up_count);

property down_count;
 @(posedge clk) disable iff (!(!up_down) || load || clear)
 !up_down & !(cnt == 8'h00) |-> (cnt == cnt[6:0] - 1);
endproperty
assert property(down_count);

property overflow_underflow;
 @(posedge clk) disable iff (load || clear)
 (up_down && cnt == 8'hFF) |-> (cnt == 8'hFF);
 (up_down === 1'b0 && cnt == 8'h00) |-> (cnt == 8'h00);
endproperty
assert property(overflow_underflow);

endmodule