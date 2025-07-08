module tb_shift_8x64_taps();

logic clk;
logic shift;
logic [7:0] sr_in;
logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

property p_shift_register_correctness;
	@ (posedge clk) disable iff (!shift) ((sr_out == sr[63]) && (sr_tap_one == sr[15]) && (sr_tap_two == sr[31]) && (sr_tap_three == sr[47]));
endproperty

property p_edge_cases;
	 @(posedge clk) disable iff (!shift) (sr[63] == sr_in);
endproperty

property p_overflow_underflow;
	@(posedge clk) disable iff (!shift) ($rose(shift) | $fell(shift));
endproperty

property p_illegal_transition;
	@(posedge clk) disable iff (!shift) (~$stable(shift));
endproperty

property p_clock_domain_crossing;
	@(posedge clk) disable iff (!shift) ($stable(clk));
endproperty

property p_sr_in_reset;
	@(posedge clk) disable iff (!shift) (sr[63] == 8'h0);
endproperty

property p_sr_out_reset;
	@(posedge clk) disable iff (!shift) (sr_out == 8'h0);
endproperty

property p_sr_tap_reset;
	@(posedge clk) disable iff (!shift) (sr_tap_one == 8'h0) && (sr_tap_two == 8'h0) && (sr_tap_three == 8'h0);
endproperty

property p_sr_tap_hold;
	@(posedge clk) disable iff (!shift) (sr_tap_one == sr_tap_two) && (sr_tap_two == sr_tap_three);
endproperty

property p_sr_out_hold;
	@(posedge clk) disable iff (!shift) (sr_out == sr_tap_three);
endproperty

property p_sr_in_hold;
	@(posedge clk) disable iff (!shift) (sr[63] == sr_in);
endproperty

property p_sr_hold;
	@(posedge clk) disable iff (!shift) (sr[63] == sr[62]);
endproperty

property p_sr_edge_cases;
	@(posedge clk) disable iff (!shift) (sr[63]!= sr[62]);
endproperty

property p_sr_tap_edge_cases;
	@(posedge clk) disable iff (!shift) (sr_tap_one!= sr_tap_two) || (sr_tap_two!= sr_tap_three);
endproperty

property p_sr_out_edge_cases;
	@(posedge clk) disable iff (!shift) (sr_out!= sr_tap_three);
endproperty

property p_sr_in_edge_cases;
	@(posedge clk) disable iff (!shift) (sr[63]!= sr_in);
endproperty

assert property (p_shift_register_correctness);
assert property (p_edge_cases);
assert property (p_overflow_underflow);
assert property (p_illegal_transition);
assert property (p_clock_domain_crossing);
assert property (p_sr_in_reset);
assert property (p_sr_out_reset);
assert property (p_sr_tap_reset);
assert property (p_sr_tap_hold);
assert property (p_sr_out_hold);
assert property (p_sr_in_hold);
assert property (p_sr_hold);
assert property (p_sr_edge_cases);
assert property (p_sr_tap_edge_cases);
assert property (p_sr_out_edge_cases);
assert property (p_sr_in_edge_cases);

always #10 clk = ~clk;

initial begin
	#50 clk = 1'b0;
	forever #20 clk = ~clk;
end

endmodule