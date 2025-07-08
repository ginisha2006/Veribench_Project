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
wire [7:0] sr_in;
wire [7:0] sr_out;
wire [7:0] sr_tap_one;
wire [7:0] sr_tap_two;
wire [7:0] sr_tap_three;

shift_8x64_taps dut (
    .clk(clk),
    .shift(shift),
    .sr_in(sr_in),
    .sr_out(sr_out),
    .sr_tap_one(sr_tap_one),
    .sr_tap_two(sr_tap_two),
    .sr_tap_three(sr_tap_three)
);

always #5 clk = ~clk;

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_out === sr[63]) |-> (sr_out === sr_in)); end end

always @(*) begin always @(*) begin assert (@(negedge clk) disable iff (!shift) (sr_out !== sr_in)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_one === sr[15])); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_two === sr[31])); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr_tap_three === sr[47])); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[62] === sr[63]) |=> (sr[63] === sr[62])); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[0] === sr_in)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (sr[63] === sr[62]) |=> (sr[62] === sr[61])); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!shift) (!$isunknown(sr[63]))); end end

endmodule