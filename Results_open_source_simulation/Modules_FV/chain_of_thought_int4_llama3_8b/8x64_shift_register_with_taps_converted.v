module tb_shift_8x64_taps();

logic clk;
logic shift;
logic [7:0] sr_in;
logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

always @(*) begin assert (@ (posedge clk) disable iff (!shift) ((sr_out == sr[63]) && (sr_tap_one == sr[15]) && (sr_tap_two == sr[31]) && (sr_tap_three == sr[47]))); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63] == sr_in)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) ($rose(shift) | $fell(shift))); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (~$stable(shift))); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) ($stable(clk))); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63] == 8'h0)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_out == 8'h0)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_one == 8'h0) && (sr_tap_two == 8'h0) && (sr_tap_three == 8'h0)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_one == sr_tap_two) && (sr_tap_two == sr_tap_three)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_out == sr_tap_three)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63] == sr_in)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63] == sr[62])); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63]!= sr[62])); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_one!= sr_tap_two) || (sr_tap_two!= sr_tap_three)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_out!= sr_tap_three)); end
always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63]!= sr_in)); end

always #10 clk = ~clk;

initial begin
	#50 clk = 1'b0;
	forever #20 clk = ~clk;
end

endmodule