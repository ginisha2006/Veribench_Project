module tb_shift_8x64_taps;

logic clk;
logic shift;
logic [7:0] sr_in;
logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

reg [7:0] sr [63:0];
integer n;

property p_clk_posedge;
 @(posedge clk) disable iff (!clk);
endproperty

property p_shift_enable;
 shift |=> ($onehot(sr_in));
endproperty

property p_shift_disable;
!shift |=> (!$onehot(sr_in));
endproperty

property p_sr_tap_one_correct;
 sr_tap_one === sr[15];
endproperty

property p_sr_tap_two_correct;
 sr_tap_two === sr[31];
endproperty

property p_sr_tap_three_correct;
 sr_tap_three === sr[47];
endproperty

property p_sr_out_correct;
 sr_out === sr[63];
endproperty

property p_overflow;
 $fell(shift) && $rose(shift) |=> $observerb(sr[0]);
endproperty

property p_underflow;
 $rose(shift) && $fell(shift) |=> $observerb(sr[63]);
endproperty

property p_illegal_transition;
 shift &&!shift |=> $observerb(sr);
endproperty

assert property (p_clk_posedge);
assert property (p_shift_enable);
assert property (p_shift_disable);
assert property (p_sr_tap_one_correct);
assert property (p_sr_tap_two_correct);
assert property (p_sr_tap_three_correct);
assert property (p_sr_out_correct);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_illegal_transition);

initial begin
 clk = 0;
 forever #5 clk = ~clk;
end

endmodule