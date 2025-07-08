module tb_binary_adder_tree (
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input clk,
    output logic [15:0] out
);
wire [15:0] sum1, sum2, sum3, sum4;
logic [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

binary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
);

always begin
    clk = 0; #5; clk = 1; #5;
end

property p_sum1_correct;
    @(posedge clk) disable iff (!reset)
    (sum1 == A + B);
endproperty
assert property(p_sum1_correct);

property p_sum2_correct;
    @(posedge clk) disable iff (!reset)
    (sum2 == C + D);
endproperty
assert property(p_sum2_correct);

property p_sum3_correct;
    @(posedge clk) disable iff (!reset)
    (sum3 == sumreg1 + sumreg2);
endproperty
assert property(p_sum3_correct);

property p_sum4_correct;
    @(posedge clk) disable iff (!reset)
    (sum4 == sumreg3 + E);
endproperty
assert property(p_sum4_correct);

property p_out_correct;
    @(posedge clk) disable iff (!reset)
    (out == sumreg4);
endproperty
assert property(p_out_correct);

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    (!$overflow(sum1) & !$underflow(sum1)) &&
    (!$overflow(sum2) & !$underflow(sum2)) &&
    (!$overflow(sum3) & !$underflow(sum3)) &&
    (!$overflow(sum4) & !$underflow(sum4));
endproperty
assert property(p_no_overflow_underflow);

property p_initial_state;
    @(negedge clk) disable iff (!reset)
    (sumreg1 == 0) && (sumreg2 == 0) && (sumreg2 == 0) && (sumreg3 == 0);
endproperty
assert property(p_initial_state);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    ($past((A == 0) |-> (sum1 == B))) &&
    ($past((B == 0) |-> (sum1 == A))) &&
    ($past((C == 0) |-> (sum2 == D))) &&
    ($past((D == 0) |-> (sum2 == C)));
endproperty
assert property(p_edge_cases);

endmodule