module tb_shift_8x64_taps();

parameter CLK_PERIOD = 10;

input wire clk;

input wire shift;

input wire [7:0] sr_in;

output reg [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

reg [7:0] sr [63:0];

integer n;

always #CLK_PERIOD/2 clk = ~clk;

shift_8x64_taps dut (.clk(clk),.shift(shift),.sr_in(sr_in),.sr_out(sr_out),.sr_tap_one(sr_tap_one),.sr_tap_two(sr_tap_two),.sr_tap_three(sr_tap_three));

property p_shift_register_functionality;

@ (posedge clk) disable iff (!shift)

((sr[0] === sr_in) &&

(forall (int i; i < 63; i++) sr[i+1] === sr[i])

) |-> (sr[63] === sr_in);

property p_tap_outputs_correct;

@ (posedge clk) disable iff (!shift)

(sr[15] === sr_tap_one && sr[31] === sr_tap_two && sr[47] === sr_tap_three);

property p_overflow_underflow;

@ (posedge clk) disable iff (!shift)

(sr[63] === sr_in) |=> (~sr[62] === sr[61]);

property p_edge_cases;

@ (posedge clk) disable iff (!shift)

(shift === 1'b1) |=> ($rose(shift));

property p_illegal_transition;

@ (posedge clk) disable iff (!shift)

(shift === 1'b0 && sr[0]!== sr_in) |=> ($fell(shift));

assert property (p_shift_register_functionality);

assert property (p_tap_outputs_correct);

assert property (p_overflow_underflow);

assert property (p_edge_cases);

assert property (p_illegal_transition);

endmodule