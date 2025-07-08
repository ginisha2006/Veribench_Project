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

property p_clk_non_zero; @(posedge CLK) disable iff (!CLK) (sumreg1 !== 'x); endproperty
assert property(p_clk_non_zero)

property p_sum1_calculation; @(posedge CLK) (sum1 === A + B + C); endproperty
assert property(p_sum1_calculation)

property p_sumreg1_update; @(posedge CLK) (sumreg1 == sum1); endproperty
assert property(p_sumreg1_update)

property p_sum2_calculation; @(posedge CLK) (sum2 === sumreg1 + D + E); endproperty
assert property(p_sum2_calculation)

property p_sumreg2_update; @(posedge CLK) (sumreg2 == sum2); endproperty
assert property(p_sumreg2_update)

property p_out_correctness; @(posedge CLK) (OUT === sumreg2); endproperty
assert property(p_out_correctness)

property p_no_overflow_underflow; @(posedge CLK) (A + B + C < 2**16 && sumreg1 + D + E < 2**16); endproperty
assert property(p_no_overflow_underflow)

property p_illegal_transitions; @(posedge CLK) !(A + B + C > 2**16 || sumreg1 + D + E > 2**16); endproperty
assert property(p_illegal_transitions)

endmodule