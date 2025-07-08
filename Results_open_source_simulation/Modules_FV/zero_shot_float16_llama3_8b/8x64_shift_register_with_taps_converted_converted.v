module tb_shift_8x64_taps();

reg clk;
reg shift;
wire [7:0] sr_in;
wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

shift_8x64_taps dut (
   .clk(clk),
   .shift(shift),
   .sr_in(sr_in),
   .sr_out(sr_out),
   .sr_tap_one(sr_tap_one),
   .sr_tap_two(sr_tap_two),
   .sr_tap_three(sr_tap_three)
);

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) ((sr[63] == sr_in) && (sr[62:0] == 8'd0))); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (shift) ((sr[63] == sr[62]) && (sr[61:0] == 8'd0))); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_one == sr[15])); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_two == sr[31])); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_three == sr[47])); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_out == sr[63])); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) ($fell(sr[63]) | $rose(sr[63]))); end end
always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) ($fell(sr[0]) | $rose(sr[0]))); end end

endmodule