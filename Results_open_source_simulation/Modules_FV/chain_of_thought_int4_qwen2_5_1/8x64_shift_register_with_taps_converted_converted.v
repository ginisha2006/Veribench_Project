module tb_shift_8x64_taps (
    input clk,
    input shift,
    input [7:0] sr_in,
    output reg [7:0] sr_out,
    output reg [7:0] sr_tap_one,
    output reg [7:0] sr_tap_two,
    output reg [7:0] sr_tap_three
);

reg [7:0] sr [63:0];
integer n;

always #(1) clk = ~clk;

assert (@(posedge clk) disable iff (!shift)
        $rose(shift) |-> ##[1:64] sr[63] === sr_in);

assert (@(posedge clk) disable iff (!shift)
        $rose(shift) |-> ##1 sr_tap_one === sr[15]);

assert (@(posedge clk) disable iff (!shift)
        $rose(shift) |-> ##1 sr_tap_two === sr[31]);

assert (@(posedge clk) disable iff (!shift)
        $rose(shift) |-> ##1 sr_tap_three === sr[47]);

assert (@(posedge clk) disable iff (!shift)
        !($fell(shift)) |-> ($past(sr[63]) !== 'bx & $stable(sr[63])));

endmodule