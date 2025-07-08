module tb_shift_8x64_taps;

logic clk;
logic shift;
logic [7:0] sr_in;
logic [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

reg [7:0] sr [63:0];
integer n;

always @(*) begin assert (@(posedge clk) disable iff (!clk)); end
always @(*) begin assert (shift |=> ($onehot(sr_in))); end
always @(*) begin assert (!shift |=> (!$onehot(sr_in))); end
always @(*) begin assert (sr_tap_one === sr[15]); end
always @(*) begin assert (sr_tap_two === sr[31]); end
always @(*) begin assert (sr_tap_three === sr[47]); end
always @(*) begin assert (sr_out === sr[63]); end
always @(*) begin assert ($fell(shift) && $rose(shift) |=> $observerb(sr[0])); end
always @(*) begin assert ($rose(shift) && $fell(shift) |=> $observerb(sr[63])); end
always @(*) begin assert (shift &&!shift |=> $observerb(sr)); end

initial begin
 clk = 0;
 forever #5 clk = ~clk;
end

endmodule