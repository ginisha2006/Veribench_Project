module tb_ternary_adder_tree (
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input CLK,
    output reg [15:0] OUT
);

wire [15:0] sum1, sum2;
reg [15:0] sumreg1, sumreg2;

assert property(p_clk_non_zero)

assert property(p_sum1_calculation)

assert property(p_sumreg1_update)

assert property(p_sum2_calculation)

assert property(p_sumreg2_update)

assert property(p_out_correctness)

assert property(p_no_overflow_underflow)

assert property(p_illegal_transitions)

endmodule