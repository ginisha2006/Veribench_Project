module tb_shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_out,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three
);

reg clk;
wire shift;
reg [7:0] sr_in;
wire [7:0] sr_out, sr_tap_one, sr_tap_two, sr_tap_three;

shift_8x64_taps dut (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
);

always #5 clk =~clk;

property posedge_clk;
 @(posedge clk) disable iff (!shift)
   ##1 $past(sr_in) === sr[0]
 |-> ##16 $past(sr[0]) === sr[16]
 |-> ##32 $past(sr[16]) === sr[48]
 |-> ##48 $past(sr[48]) === sr_out;
endproperty

assert property(posedge_clk);

property negedge_clk;
 @(negedge clk) disable iff (!shift)
   !($past(sr_in) === sr[0])
 |-> !($past(sr[0]) === sr[16])
 |-> !($past(sr[16]) === sr[48])
 |-> !($past(sr[48]) === sr_out);
endproperty

assert property(negedge_clk);

property shift_not_active;
 @(posedge clk) disable iff (shift)
   !$stable(sr_in)
 |-> !$changed(sr_out)
 |-> !$changed(sr_tap_one)
 |-> !$changed(sr_tap_two)
 |-> !$changed(sr_tap_three);
endproperty

assert property(shift_not_active);

property tap_values;
 @(posedge clk) disable iff (!shift)
   sr_tap_one === sr[15]
 & sr_tap_two === sr[31]
 & sr_tap_three === sr[47];
endproperty

assert property(tap_values);

endmodule