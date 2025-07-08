module tb_shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_out,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three
);

wire [7:0] sr [63:0];
integer n;

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

property p_sr_initial_state;
	@ (posedge clk) !$isunknown({<<{sr}}) |-> {<<{sr}} == 8'hZZZZZZZZZZZZZZZZ;
endproperty
assert property(p_sr_initial_state);

property p_shift_behavior;
	@ (posedge clk) disable iff (!shift) (sr[0] ##1 sr[1] ##1 ... ##1 sr[63])[*64] |-> ({<<{sr}} == <<{>>{sr}});
endproperty
assert property(p_shift_behavior);

property p_tap_values;
	@ (posedge clk) (sr[15] == sr_tap_one) && (sr[31] == sr_tap_two) && (sr[31] == sr_tap_three);
endproperty
assert property(p_tap_values);

property p_no_overflow_underflow;
	@ (posedge clk) !($signed(sr[0]) < -128 || $signed(sr[0]) > 127);
endproperty
assert property(p_no_overflow_underflow);

property p_illegal_transitions;
	@ (posedge clk) !(shift && $past(!shift));
endproperty
assert property(p_illegal_transitions);

endmodule