module tb_shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three,
    output reg [7:0] sr_out
);

reg [7:0] sr [63:0];
integer n;

always @(posedge clk) begin
    if (shift == 1'b1) begin
        for (n = 63; n > 0; n = n - 1) begin
            sr[n] <= sr[n - 1];
        end
        sr[0] <= sr_in;
    end
end

assign sr_tap_one = sr[15];
assign sr_tap_two = sr[31];
assign sr_tap_three = sr[47];
assign sr_out = sr[63];

assert (@(posedge clk) disable iff (!shift) !sr[63:0]
        |-> ##1 $stable(sr[63:0]));

assert property(p_shift_operation) foreach(i inside {0:62});

assert (@(posedge clk) disable iff (!shift)
        sr[15] |-> ##1 sr_tap_one == sr[15];
    @(posedge clk) disable iff (!shift)
        sr[31] |-> ##1 sr_tap_two == sr[31];
    @(posedge clk) disable iff (!shift)
        sr[47] |-> ##1 sr_tap_three == sr[47]);

assert (@(posedge clk) disable iff (!shift)
        sr[63] |-> ##1 sr_out == sr[63]);

assert (@(posedge clk) disable iff (!shift)
        !$isunknown(sr[63:0]));

endmodule