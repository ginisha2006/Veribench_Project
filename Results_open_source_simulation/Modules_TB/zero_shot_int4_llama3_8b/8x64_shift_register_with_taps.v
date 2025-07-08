module shift_8x64_taps_tb();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

integer i;
localparam N = 4'd64;

initial begin
	shift = 0;
	sr_in = 8'h12;
	
	#10
	shift = 1;
	
	for (i = 0; i < N; i = i + 1) begin
		#20;
	end
	
	shift = 0;
	
	#10
	sr_in = 8'h34;
	
	#20
	shift = 1;
	
	for (i = 0; i < N; i = i + 1) begin
		#20;
	end
	
	shift = 0;
	
	$monitor ($time, "sr_in: %h", sr_in, "sr_tap_one: %h", sr_tap_one, "sr_tap_two: %h", sr_tap_two, "sr_tap_three: %h", sr_tap_three, "sr_out: %h", sr_out);
end

endmodule