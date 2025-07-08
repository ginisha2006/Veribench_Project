module tb_shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_out,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three
);

wire clk_wire, shift_wire, sr_in_wire;
reg [7:0] sr_in_reg;
wire [7:0] sr_out_wire, sr_tap_one_wire, sr_tap_two_wire, sr_tap_three_wire;

shift_8x64_taps dut (
    .clk(clk_wire),
    .shift(shift_wire),
    .sr_in(sr_in_wire),
    .sr_out(sr_out_wire),
    .sr_tap_one(sr_tap_one_wire),
    .sr_tap_two(sr_tap_two_wire),
    .sr_tap_three(sr_tap_three_wire)
);

assign clk_wire = clk;
assign shift_wire = shift;
assign sr_in_wire = sr_in;

always #5 clk = ~clk;

assert (@(posedge clk) disable iff (!shift)
    $past(sr_in_wire) |-> ##[0:63] sr_out_wire == $past(sr_in_wire));

assert (@(posedge clk) disable iff (!shift)
    $past(sr_in_wire) |-> ##2 sr_tap_one_wire == $past($past(sr_in_wire)));

property prop_tap_two;
 @(posedge clk) disable iff (!shift)
    $past(sr_in_wire) |-> ##32 sr_tap_two_wire == $past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($past($