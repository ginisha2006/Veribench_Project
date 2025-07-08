module tb_shift_8x64_taps();

logic clk;
logic shift;
logic [7:0] sr_in;
logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

reg [7:0] sr [63:0];
integer n;

property p_clk_posedge;
 @(posedge clk) disable iff (!clk) enable;

property p_shift_enable;
 property(p_clk_posedge) shift |=> ($onehot(sr));

property p_sr_in_valid;
 property(p_clk_posedge)!shift |=> (sr_in!= 8'hff);

property p_sr_tap_one_correct;
 property(p_clk_posedge) shift |=> (sr_tap_one == sr[15]);

property p_sr_tap_two_correct;
 property(p_clk_posedge) shift |=> (sr_tap_two == sr[31]);

property p_sr_tap_three_correct;
 property(p_clk_posedge) shift |=> (sr_tap_three == sr[47]);

property p_sr_out_correct;
 property(p_clk_posedge) shift |=> (sr_out == sr[63]);

property p_overflow;
 property(p_clk_posedge) shift & (sr_in == 8'hff) |=> ($rose(sr[0]));

property p_underflow;
 property(p_clk_posedge) shift & (sr_in == 8'bx) |=> ($fell(sr[0]));

assert property (p_clk_posedge) p_shift_enable;
assert property (p_clk_posedge) p_sr_in_valid;
assert property (p_clk_posedge) p_sr_tap_one_correct;
assert property (p_clk_posedge) p_sr_tap_two_correct;
assert property (p_clk_posedge) p_sr_tap_three_correct;
assert property (p_clk_posedge) p_sr_out_correct;
assert property (p_clk_posedge) p_overflow;
assert property (p_clk_posedge) p_underflow;

shift_8x64_taps uut (
   .clk(clk),
   .shift(shift),
   .sr_in(sr_in),
   .sr_out(sr_out),
   .sr_tap_one(sr_tap_one),
   .sr_tap_two(sr_tap_two),
   .sr_tap_three(sr_tap_three)
);

endmodule