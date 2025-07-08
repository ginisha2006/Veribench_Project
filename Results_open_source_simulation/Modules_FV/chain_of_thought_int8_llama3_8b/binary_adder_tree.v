module tb_binary_adder_tree();

parameter CLOCK_PERIOD = 10;

input wire clk;

reg [15:0] A, B, C, D, E;

wire [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

property p_sum1_correct;
@(posedge clk) disable iff (!clk) ($distinctsum(A, B) == sum1);
endproperty

property p_sum2_correct;
@(posedge clk) disable iff (!clk) ($distinctsum(C, D) == sum2);
endproperty

property p_sum3_correct;
@(posedge clk) disable iff (!clk) ($distinctsum(sum1, sum2) == sum3);
endproperty

property p_sum4_correct;
@(posedge clk) disable iff (!clk) ($distinctsum(sum3, E) == sum4);
endproperty

property p_out_correct;
@(posedge clk) disable iff (!clk) ($distinctsum(sum4) == out);
endproperty

assert property (p_sum1_correct);
assert property (p_sum2_correct);
assert property (p_sum3_correct);
assert property (p_sum4_correct);
assert property (p_out_correct);

initial begin
#((CLOCK_PERIOD / 2) - 1) clk = 0;
#CLOCK_PERIOD clk = 1;
repeat(100) #CLOCK_PERIOD clk =!clk;
$stop;
end

endmodule